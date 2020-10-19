using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Reflection;
using System.Web;
using System.Drawing;
using System.Drawing.Drawing2D;
using System.Drawing.Imaging;
using System.IO;
namespace ARC_Library
{
    public class helper
    {
        public static string generateId(string lastId)
        {//generate id for all inserted data to db table
            int numberOfLetters = 0;
            foreach (char l in lastId)
            {
                if (!Char.IsDigit(l))
                    numberOfLetters++;
            }
            string letter = lastId.Substring(0, numberOfLetters);

            int letterCount = letter.Length;
            int idLength = lastId.Length;
            int id = Convert.ToInt32(lastId.Substring(numberOfLetters, idLength - numberOfLetters)) + 1;

            string tmp = "";
            for (int i = 0; i < (idLength - letterCount - id.ToString().Length); i++)
            {
                tmp += "0";
            }

            return letter + tmp + id.ToString();

        }

        internal static object getId()
        {
            throw new NotImplementedException();
        }

        public static DataTable LINQResultToDataTable<T>(IEnumerable<T> Linqlist)
        {//convert datatype from linq to datatable, use as rdlc reportsource
            DataTable dt = new DataTable();
            PropertyInfo[] columns = null;

            if (Linqlist == null) return dt;
            foreach (T Record in Linqlist)
            {
                if (columns == null)
                {
                    columns = ((Type)Record.GetType()).GetProperties();
                    foreach (PropertyInfo GetProperty in columns)
                    {
                        Type colType = GetProperty.PropertyType;

                        if ((colType.IsGenericType) && (colType.GetGenericTypeDefinition()
                        == typeof(Nullable<>)))
                        {
                            colType = colType.GetGenericArguments()[0];
                        }
                        dt.Columns.Add(new DataColumn(GetProperty.Name, colType));
                    }
                }

                DataRow dr = dt.NewRow();
                foreach (PropertyInfo pinfo in columns)
                {
                    dr[pinfo.Name] = pinfo.GetValue(Record, null) == null ? DBNull.Value : pinfo.GetValue
                    (Record, null);
                }

                dt.Rows.Add(dr);
            }
            return dt;
        }

        public static string GetCurrentId()
        {
            ARCLibraryDataContext db = new ARCLibraryDataContext();
            string username = HttpContext.Current.User.Identity.Name; // get current logged in user
            string id = db.Users.Where(p => p.Username == username).Select(r => r.Id).SingleOrDefault();
            if (id != null)
            {
                return id;
            }
            else
            {
                return null;
            }
        }
        //handle image
        public class SimpleImage
        {
            private Bitmap source;

            public SimpleImage(Stream stream)
            {
                source = new Bitmap(stream);
            }

            public SimpleImage(string filename)
            {
                source = new Bitmap(filename);
            }

            public SimpleImage(Byte[] bytes)
            {
                source = (Bitmap)new ImageConverter().ConvertFrom(bytes);
            }

            public void Square()
            {
                int size = Math.Min(source.Width, source.Height);

                Bitmap target = new Bitmap(size, size);
                using (Graphics g = Graphics.FromImage(target))
                {
                    g.CompositingQuality = CompositingQuality.HighSpeed;
                    g.InterpolationMode = InterpolationMode.HighQualityBicubic;
                    g.CompositingMode = CompositingMode.SourceCopy;
                    g.DrawImage(source, (size - source.Width) / 2, (size - source.Height) / 2, source.Width, source.Height);
                    source = target;
                }
            }

            public void Resize(int size)
            {
                int width, height;

                if (source.Width > source.Height)
                {
                    width = size;
                    height = source.Height * size / source.Width;
                }
                else
                {
                    width = source.Width * size / source.Height;
                    height = size;
                }

                Bitmap target = new Bitmap(width, height);
                using (Graphics g = Graphics.FromImage(target))
                {
                    g.CompositingQuality = CompositingQuality.HighSpeed;
                    g.InterpolationMode = InterpolationMode.HighQualityBicubic;
                    g.CompositingMode = CompositingMode.SourceCopy;
                    g.DrawImage(source, 0, 0, width, height);
                    source = target;
                }
            }

            public void SaveAs(string filename)
            {
                source.Save(filename, ImageFormat.Jpeg);
            }

           
           
        }
    }
}