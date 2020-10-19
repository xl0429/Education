using Microsoft.IdentityModel.Tokens;
using System;
using System.Collections.Generic;
using System.IdentityModel.Tokens.Jwt;
using System.Linq;
using System.Security.Claims;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Web.Configuration;

namespace ARC_Library.Account
{
    public class TokenHandler
    {
          string key = Convert.ToBase64String(new HMACSHA256().Key);
            private static string Secret = WebConfigurationManager.AppSettings["TokenSecret"];

            public static string GenerateToken(string username)
            {
                byte[] key = Convert.FromBase64String(Secret);
                SymmetricSecurityKey securityKey = new SymmetricSecurityKey(key);
                SecurityTokenDescriptor descriptor = new SecurityTokenDescriptor
                {
                    Subject = new ClaimsIdentity(new[] {
                      new Claim(ClaimTypes.Name, username)}),
                    Expires = DateTime.UtcNow.AddSeconds(10),
                    //Expires = DateTime.UtcNow.AddDays(3),
                    SigningCredentials = new SigningCredentials(securityKey,
                    SecurityAlgorithms.HmacSha256Signature)
                };

                JwtSecurityTokenHandler handler = new JwtSecurityTokenHandler();
                JwtSecurityToken token = handler.CreateJwtSecurityToken(descriptor);
                return handler.WriteToken(token);

            }

            public static ClaimsPrincipal GetPrincipal(string token)
            {
                try
                {
                    JwtSecurityTokenHandler tokenHandler = new JwtSecurityTokenHandler();
                    JwtSecurityToken jwtToken = (JwtSecurityToken)tokenHandler.ReadToken(token);
                    if (jwtToken == null)
                        return null;

                    byte[] key = Convert.FromBase64String(Secret);

                    TokenValidationParameters parameters = new TokenValidationParameters()
                    {
                        ValidateLifetime = true,
                        RequireExpirationTime = true,
                        ValidateIssuer = false,
                        ValidateAudience = false,
                        IssuerSigningKey = new SymmetricSecurityKey(key),
                        ClockSkew = TimeSpan.Zero
                    };
                    SecurityToken securityToken;

                    ClaimsPrincipal principal = tokenHandler.ValidateToken(token,
                          parameters, out securityToken);

                    return principal;
                }
                catch (Exception e)
                {
                    return null;
                }
            }

            public static bool isExpired(string token)
            {
                if (token == null || ("").Equals(token))
                {
                    return true;
                }

                int indexOfFirstPoint = token.IndexOf('.') + 1;
                String toDecode = token.Substring(indexOfFirstPoint, token.LastIndexOf('.') - indexOfFirstPoint);
                while (toDecode.Length % 4 != 0)
                {
                    toDecode += '=';
                }

                //Decode the string
                string decodedString = Encoding.ASCII.GetString(Convert.FromBase64String(toDecode));

                //Get the "exp" part of the string
                String beginning = "\"Exp\":\"";
                int startPosition = decodedString.LastIndexOf(beginning) + beginning.Length;
                decodedString = decodedString.Substring(startPosition);
                int endPosition = decodedString.IndexOf("\"");
                decodedString = decodedString.Substring(0, endPosition);
                long timestamp = Convert.ToInt64(decodedString);

                DateTime date = new DateTime(1970, 1, 1).AddMilliseconds(timestamp);
                DateTime compareTo = DateTime.Now.AddMinutes(1);

                int result = DateTime.Compare(date, compareTo);
                return result < 0;
            }

            //validate a token, when the token is valid username will be return
            public static string ValidateToken(string token)
            {
                string username = null;
                ClaimsPrincipal principal = GetPrincipal(token);
                if (principal == null)
                    return null;
                ClaimsIdentity identity = null;
                try
                {
                    identity = (ClaimsIdentity)principal.Identity;
                }
                catch (NullReferenceException)
                {
                    return null;
                }
                Claim usernameClaim = identity.FindFirst(ClaimTypes.Name);
                username = usernameClaim.Value;

                return username;
            }

        
    }
}