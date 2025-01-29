using System;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
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
            Page.Validate();

            var validatedControls = Page.Validators.Cast<BaseValidator>()
                .Select(v => v.NamingContainer.FindControl(v.ControlToValidate))
                .OfType<WebControl>()
                .ToArray();

            foreach (var control in validatedControls)
            {
                control.CssClass = control.CssClass.Replace("is-invalid", "").Trim();
                var validators = Page.Validators.Cast<BaseValidator>()
                    .Where(v => v.ControlToValidate == control.ID);
                if (validators.Any(v => !v.IsValid))
                {
                    control.CssClass += " is-invalid";
                }
            }

            if (!Page.IsValid)
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