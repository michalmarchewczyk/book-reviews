using System;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.Owin.Security;

namespace BookReviews.Auth
{
    public partial class Register : Page
    {
        public static int PasswordMinLength = 8;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Page.IsPostBack)
            {
                Submit();
            }
        }

        private void Submit()
        {
            UsernameUnavailableMessage.Visible = false;
            EmailUnavailableMessage.Visible = false;
            GenericError.Visible = false;

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
            var firstName = FirstName.Text;
            var lastName = LastName.Text;
            var email = Email.Text;
            var password = Password.Text;

            var userStore = new UserStore<AppIdentityUser>(new AppIdentityDbContext());
            var userManager = new UserManager<AppIdentityUser>(userStore);
            userManager.PasswordValidator = new MinimumLengthValidator(PasswordMinLength);

            var user = new AppIdentityUser
            {
                UserName = username,
                FirstName = firstName,
                LastName = lastName,
                Email = email
            };
            var result = userManager.Create(user, password);
            Console.WriteLine(string.Join(", ", result.Errors));

            // TODO: make email unique

            if (result.Succeeded)
            {
                var authenticationManager = HttpContext.Current.GetOwinContext().Authentication;
                var userIdentity = userManager.CreateIdentity(user, DefaultAuthenticationTypes.ApplicationCookie);
                authenticationManager.SignIn(new AuthenticationProperties { IsPersistent = false }, userIdentity);

                var returnUrl = Request.QueryString["ReturnUrl"];
                Response.Redirect(returnUrl ?? "~/");
            }
            else if (result.Errors.Any(e => Regex.IsMatch(e, @"Name (.+) is already taken.")))
            {
                UsernameUnavailableMessage.Visible = true;
            }
            else if (result.Errors.Any(e => Regex.IsMatch(e, @"Email (.+) is already taken.")))
            {
                EmailUnavailableMessage.Visible = true;
            }
            else
            {
                GenericError.Visible = true;
            }
        }
    }
}