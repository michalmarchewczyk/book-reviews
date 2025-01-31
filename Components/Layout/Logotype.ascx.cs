using System;
using System.Web.UI;
using BookReviews.Utils;

namespace BookReviews.Components.Layout
{
    public partial class Logotype : UserControl
    {
        public float Size { get; set; } = 1;

        protected void Page_Load(object sender, EventArgs e)
        {
            ContentHelper.AddCssFile("~/Components/Logotype.css", Page);
        }
    }
}