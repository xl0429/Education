using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Speech.AudioFormat;
using System.Speech.Synthesis;

namespace LearnEnglish
{
    public partial class GrammarDetails : System.Web.UI.Page
    {
        LearnEnglishDataContext db = new LearnEnglishDataContext();

        protected void Page_Load(object sender, EventArgs e)
        {
            string grammarCode = Request.QueryString["GrammarCode"];

            if (!Page.IsPostBack)
            {
                GrammarType m = db.GrammarTypes.SingleOrDefault(x => x.GrammarCode == grammarCode);

                lblTitle.Text = m.Title;
                lblDesc.Text = m.Description;
                title.InnerHtml = m.Title;
                if (m != null)
                {
                    var rate = Math.Round((double)m.Rating, 0);
                    lblCurrentRate.Text = m.Rating.ToString();
                    if (m.RateCount > 0)
                    {
                        lblRateCount.Text = m.RateCount + " Ratings";
                    }
                    else
                    {
                        lblRateCount.Text = "No enough ratings";
                    }
                    Rating2.CurrentRating = (int)rate;
                }
            }
        }

        protected void Rating1_Changed(object sender, EventArgs e)
        {
            string grammarCode = Request.QueryString["GrammarCode"];
            Label1.Text = "You Rated: " + Rating1.CurrentRating;

            decimal rate = Convert.ToDecimal(Rating1.CurrentRating);
            GrammarType m = db.GrammarTypes.SingleOrDefault(x => x.GrammarCode == grammarCode);
            if (m != null)
            {
                decimal count = (decimal)m.RateCount;
                decimal count2 = count + 1;
                m.Rating = (m.Rating * count + rate) / count2;
                m.RateCount = (int)count2;
                db.SubmitChanges();
            }
            double currentRate = (double)m.Rating;
            lblCurrentRate.Text = currentRate.ToString("0.0");
            lblRateCount.Text = m.RateCount.ToString() + " Ratings";
        }
        protected void btnSpeaker_Click(object sender, ImageClickEventArgs e)
        {
            SpeechAudioFormatInfo info = new SpeechAudioFormatInfo(6, AudioBitsPerSample.Sixteen, AudioChannel.Mono);

            using (var ss = new SpeechSynthesizer())
            {
                ss.Volume = 100;
                ss.SelectVoiceByHints(VoiceGender.Female, VoiceAge.Adult);
                ss.Speak(txtContent.Text);

            }
        }
    }
}