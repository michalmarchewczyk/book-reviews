using System;
using System.Collections;
using System.Web.UI;
using BookReviews.Utils;

namespace BookReviews.Components
{
    public partial class RatingInput : UserControl
    {
        public int MaxRating { get; set; } = 5;

        public int Value
        {
            get => ValueField.Value == string.Empty ? 0 : Convert.ToInt32(ValueField.Value);
            set => ValueField.Value = value.ToString();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            ContentHelper.AddCssFile("~/Components/RatingInput.css", Page);
            ContentHelper.AddJsFile("~/Components/RatingInput.js", Page);

            var values = new ArrayList();

            for (var i = 1; i <= MaxRating; i++)
            {
                values.Add(i);
            }

            Repeater.DataSource = values;
            Repeater.DataBind();
        }
    }
}