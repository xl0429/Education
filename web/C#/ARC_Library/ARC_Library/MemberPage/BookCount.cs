using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ARC_Library.MemberPage
{
    public class BookCount
    {

        public string memberId { get; set; }
        public string username { get; set; }
        public int noBookReserved { get; set; }
        public int noBookBorrowed { get; set; }
        public int totalBook {get;set;}
        public void updateBookCount(string m, string u, int r, int b, int t)
        {
            memberId = m;
            username = u;
            noBookReserved = r;
            noBookBorrowed = b;
            totalBook = t;
        }
        
        public static BookCount createBookCount()
        {
            ARCLibraryDataContext db = new ARCLibraryDataContext();

            string uName = HttpContext.Current.User.Identity.Name;
            string id = (from s in db.Users
                         where s.Username == uName
                         select s.Id).SingleOrDefault();
            int noBookReserve = (from s in db.Reservations
                                 where s.MemberId == id && s.ReserveDueDate > DateTime.Now
                                 select s.ReservationId).Count();
            int noBookBorrow = (from s in db.Loans
                                where s.MemberId == id && s.ReturnDate > DateTime.Now && s.Status == "NotReturned"
                                select s.LoanId).Count();
            BookCount m = new BookCount
            {
                memberId = id,
                username = uName,
                noBookReserved = noBookReserve,
                noBookBorrowed = noBookBorrow,
                totalBook = noBookReserve + noBookBorrow
            };
            return m;
        }
        public static BookCount createBookCount(string memberId)
        {
            ARCLibraryDataContext db = new ARCLibraryDataContext();

            int noBookReserve = (from s in db.Reservations
                                 where s.MemberId == memberId && s.ReserveDueDate > DateTime.Now
                                 select s.ReservationId).Count();
            int noBookBorrow = (from s in db.Loans
                                where s.MemberId == memberId && s.ReturnDate > DateTime.Now && s.Status == "NotReturned"
                                select s.LoanId).Count();
            BookCount m = new BookCount
            {
                memberId = memberId,
                username = null,
                noBookReserved = noBookReserve,
                noBookBorrowed = noBookBorrow,
                totalBook = noBookReserve + noBookBorrow
            };
            return m;
        }
    }
}