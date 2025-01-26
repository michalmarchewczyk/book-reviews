using System;
using System.Globalization;
using System.Web.UI;
using BookReviews.Utils;

namespace BookReviews.Components
{
    public partial class ReviewCounter : UserControl
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ContentHelper.AddCssFile("~/Components/ReviewCounter.css", Page);
        }

        protected static string GetCount()
        {
            var count = 1000000;
            var format = new CultureInfo("pl-PL").NumberFormat;
            format.NumberDecimalDigits = 0;
            return count.ToString("N", format);
        }
    }
}