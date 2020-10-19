using System;
using System.Collections.Generic;
using System.Linq;
using System.Net.Mail;
using System.Web;

namespace ARC_Library
{
    public class EmailHandler
    {
        public static void ExecuteHtmlSendMail(string FromAddress, string ToAddress, string BodyText, string Subject)
        {
            MailMessage mailMsg = new MailMessage();
            mailMsg.From = new MailAddress(FromAddress, "ARC Library");
            mailMsg.To.Add(new MailAddress(ToAddress));
            mailMsg.Subject = Subject;
            mailMsg.BodyEncoding = System.Text.Encoding.GetEncoding("utf-8");

            AlternateView plainView = AlternateView.CreateAlternateViewFromString
            (System.Text.RegularExpressions.Regex.Replace(BodyText, @"< (.|\n) *?>", string.Empty), null, "text/plain");
            AlternateView htmlView = AlternateView.CreateAlternateViewFromString(BodyText, null, "text/html");

            mailMsg.AlternateViews.Add(plainView);
            mailMsg.AlternateViews.Add(htmlView);

            // Smtp configuration
            SmtpClient smtp = new SmtpClient();
            smtp.Host = "smtp.gmail.com";
            smtp.Port = 587;
            smtp.Timeout = 10000;
            smtp.Credentials = new System.Net.NetworkCredential("webtesitngacc.test@gmail.com", "webtestingacc");
            smtp.EnableSsl = true;

            smtp.Send(mailMsg);
        }
    }
}