using System;
using System.Web.UI;
using BookReviews.Utils;

namespace BookReviews.Auth
{
    public partial class AuthPage : MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ContentHelper.AddCssFile("/Auth/AuthPage.css", Page);
        }
    }
}