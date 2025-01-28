using System;
using System.Web;
using System.Web.UI;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.Owin.Security;

namespace BookReviews.Auth
{
    public partial class Login : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack)
            {
                Submit();
            }
        }

        private void Submit()
        {
            var username = Username.Text;
            var password = Password.Text;

            var userStore = new UserStore<AppIdentityUser>(new AppIdentityDbContext());
            var userManager = new UserManager<AppIdentityUser>(userStore);
            var user = userManager.Find(username, password);

            if (user != null)
            {
                Console.WriteLine("User found");
                var authenticationManager = HttpContext.Current.GetOwinContext().Authentication;
                var userIdentity = userManager.CreateIdentity(user, DefaultAuthenticationTypes.ApplicationCookie);

                authenticationManager.SignIn(new AuthenticationProperties() { IsPersistent = false }, userIdentity);
                Response.Redirect("~/");
            }
            else
            {
                Console.WriteLine("Invalid username or password.");
                // StatusText.Text = "Invalid username or password.";
                // LoginStatus.Visible = true;
            }
        }
    }
}