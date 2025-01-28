using System;
using System.Web;
using System.Web.UI;

namespace BookReviews.Auth
{
    public partial class Logout : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var authenticationManager = HttpContext.Current.GetOwinContext().Authentication;
            authenticationManager.SignOut();
            Response.Redirect("~/auth/login");
        }
    }
}