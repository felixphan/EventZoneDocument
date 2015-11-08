using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;

using System.Data.Entity;
using EventZone.Models;
namespace EventZone.AdminHelpers
{
    public  static class DataHelper
    {
        static EventZoneEntities db = new EventZoneEntities();
        public static List<User> GetUsersByKeyword(string keyword)
        {
            var user = db.Users.ToList();
            user = user.FindAll(u => u.UserName.Equals(keyword));
            return user.ToList();
        }
        public static List<User> GetAllUsers()
        {

            return db.Users.ToList();
        }

        public static DbSet<Category> GetCategories()
        {

            return db.Categories;
        }
        public static void AddAdmin(User u)
        {
            db.Users.Add(u);
            db.SaveChanges();
        }
        public static DbSet<Appeal> GetAllAppeals()
        {

            return db.Appeals;
        }
        public static List<Appeal> GetAppealsByKeyword(string keyword)
        {
            var appeal = db.Appeals.Include(a => a.Event);
            appeal = appeal.Where(e => e.Event.EventName.Contains(keyword));
            return appeal.ToList();
        }
        public static Appeal GetAppealsByID(int appealID)
        {
            List<Appeal> listAppeal = db.Appeals.ToList();
            Appeal appeal = (Appeal)listAppeal.Find(u => u.AppealID == appealID);

            return appeal;
        }
        public static void AddTrackingAppeal(TrackingAppeal track)
        {
            db.TrackingAppeals.Add(track);
            db.SaveChanges();
        }
        public static long NumberEvent()
        {
            long count = 0;
            count = db.Events.Count();
            
            return count;
        }
        public static long NumberUser()
        {
            long count = 0;
            count = db.Users.Count();

            return count;
        }
        //public static  IEnumerable<DataRow> AsEnumerable(this DataTable table)
        //{
        //    return table.Rows.Cast<DataRow>();
        //}
//        public static EnumerableRowCollection<DataRow> AsEnumerable(
//    this DataTable source
//);
        public static IEnumerable<CollectionFollowUser> TopTenUser()
        {
            var user = (from b in db.PeopleFollows.AsEnumerable()
                        group b by b.FollowingUserID into g
                        // group b by b.Field<int>("FollowingUserID") into g
                        let count = g.Count()
                        orderby count descending
                        select new CollectionFollowUser
                        {
                            FollowingUserID = g.Key,
                            Count = count,
                        }
                       ).Take(10);
         
            return user.ToArray();
        }

        public static IEnumerable<CollectionLikeEvent> TopTenEvent()
        {
            var event1 = (from e in db.LikeDislikes.AsEnumerable()
                         where e.Type == 1
                         group e by e.EventID into g
                         let count = g.Count()
                         orderby count descending
                          select new CollectionLikeEvent
                         {
                             EventID = g.Key,
                             Count = count,
                         }
                         ).Take(10);
            return event1.ToArray();
        }
        public static int[] MonthThisYearToNow()
        {
          int[] month = new int[12];//= new Array();
            int year = DateTime.Now.Year;
            //int m = DateTime.Now.Month;
            int mo = 1;
            for (int i = 0; i < 12; i++)
            {
                month[i] = mo;
                mo++;
            }
                return month;
        }
        public static int NumberUserRegister(int month, int year)
        {
            int num = 0;
            var user = db.Users.ToList();
            
            foreach (var item in user)
            {
                if ((item.DataJoin.Value.Year == year) && (item.DataJoin.Value.Month == month))
                {
                    num++;
                }
            }
            return num;
        }
        public static int NumberEventRegister(int month, int year)
        {
            int num = 0;
            var listEvent = db.Events.ToList();
            foreach (var item in listEvent)
            {
                if (item.EventRegisterDate.Month == month && item.EventRegisterDate.Year == year)
                {
                    num++;
                }
            }
            return num;
        }
        public static int[] NumberUserRegisterThisYearPerMonth()
        {
            int[] numberUser = new int[12] ;
            int year = DateTime.Now.Year;
            //int m = DateTime.Now.Month;
            int m1= 1;
            for (int i = 0; i < 12; i++)
            {
                numberUser[i]= DataHelper.NumberUserRegister(m1, year);
                m1++;
            }
            return numberUser;
        }
        public static int[] NumberEventRegisterThisYearPerMonth()
        {
            int[] numberEvent = new int[12];
            int year = DateTime.Now.Year;
            int m1 = 1;
            for (int i = 0; i < 12; i++)
            {
                numberEvent[i] = DataHelper.NumberEventRegister(m1, year);
                m1++;
            }
                return numberEvent;
        }
    }
}