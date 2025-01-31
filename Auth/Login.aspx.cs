using System;
using System.Web;
using System.Web.UI;
using BookReviews.Utils;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.Owin.Security;

namespace BookReviews.Auth
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ReturnUrlInfo.Visible = !string.IsNullOrEmpty(Request.QueryString["ReturnUrl"]);
            LogoutMessage.Visible = Request.QueryString["logout"] == "true";
            if (Page.IsPostBack)
            {
                Submit();
            }
        }

        private void Submit()
        {
            InvalidCredentialsMessage.Visible = false;

            if (!FormHelper.ValidateAndHighlight(Page))
            {
                return;
            }

            var username = Username.Text;
            var password = Password.Text;

            var userStore = new UserStore<AppIdentityUser>(new AppIdentityDbContext());
            var userManager = new UserManager<AppIdentityUser>(userStore);
            var user = userManager.Find(username, password);

            if (user != null)
            {
                var authenticationManager = HttpContext.Current.GetOwinContext().Authentication;
                var userIdentity = userManager.CreateIdentity(user, DefaultAuthenticationTypes.ApplicationCookie);

                authenticationManager.SignIn(new AuthenticationProperties { IsPersistent = false }, userIdentity);

                var returnUrl = Request.QueryString["ReturnUrl"];
                Response.Redirect(returnUrl ?? "~/");
            }
            else
            {
                InvalidCredentialsMessage.Visible = true;
            }
        }
    }
}