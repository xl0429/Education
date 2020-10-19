using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Drawing;
using MessagingToolkit.QRCode.Codec;
using MessagingToolkit.QRCode.Codec.Data;
using System.Drawing.Imaging;

namespace LearnEnglish
{
    public partial class QRLogo : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void CreateCode_Onclick(object sender, EventArgs e)
        {
            string path = MapPath("~\\QR\\");
            QRCodeEncoder encoder = new QRCodeEncoder();
            Bitmap img = encoder.Encode(URL.Text);

            encoder.QRCodeErrorCorrect = QRCodeEncoder.ERROR_CORRECTION.H;
            encoder.QRCodeScale = 10;

            LogoUpload.SaveAs(path + LogoUpload.FileName);
            System.Drawing.Image logo = System.Drawing.Image.FromFile(path + LogoUpload.FileName);

            int left = (img.Width / 2) - (logo.Width / 2);
            int top = (img.Height / 2) - (logo.Height / 2);
            Graphics g = Graphics.FromImage(img);

            g.DrawImage(logo, new Point(left, top));

            img.Save(path + "qrCode.jpg", ImageFormat.Jpeg);

            imgQR.ImageUrl = "QR/qrCode.jpg";

        }
    }
}