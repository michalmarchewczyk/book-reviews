using System;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using BookReviews.Utils;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;
using Microsoft.Owin.Security;

namespace BookReviews.Auth
{
    public partial class Register : Page
    {
        protected const int PasswordMinLength = 8;

        protected void Page_Load(object sender, EventArgs e)
        {
            MinLengthValidator.MinLength = PasswordMinLength;

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

            if (!FormHelper.ValidateAndHighlight(Page))
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