using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LearnEnglish.Account
{
    public class GoogleLoginHandler
    {
        public class GoogleProfile
        {
            public string ID { get; set; }
            public string DisplayName { get; set; }
            public List<Email> Emails { get; set; }

        }
        public class Email
        {
            public string Value { get; set; }
            public string Type { get; set; }
        }
    }
}