using System;
using System.Data;
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

        protected string GetCount()
        {
            var foundRows = ReviewsCountDataSource.Select(DataSourceSelectArguments.Empty);
            if (foundRows == null)
            {
                return "0";
            }

            var count = 0;
            foreach (DataRowView rowView in foundRows)
            {
                count = Convert.ToInt32(rowView.Row["Count"]);
            }

            var nearestPow = Math.Pow(10, Math.Floor(Math.Log10(count))) / 10;
            count = (int)(Math.Floor(count / nearestPow) * nearestPow);

            var format = new CultureInfo("pl-PL").NumberFormat;
            format.NumberDecimalDigits = 0;
            return count.ToString("N", format);
        }
    }
}