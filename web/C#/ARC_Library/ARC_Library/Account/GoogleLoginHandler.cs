using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ARC_Library.Account
{
    public class GoogleLoginHandler
    {
        public class GoogleProfile
        {
            public string ID { get; set; }
            public string DisplayName { get; set; }
            public List<Email> Emails { get; set; }
            public string Phone { get; set; }

        }
        public class Email
        {
            public string Value { get; set; }
            public string Type { get; set; }
        }
    }
}