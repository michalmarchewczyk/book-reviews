using System;
using System.Linq;
using System.Text.RegularExpressions;
using System.Web.UI;
using System.Web.UI.WebControls;
using BookReviews.Auth;
using BookReviews.Utils;
using BookReviews.Utils.CustomExtensions;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;

namespace BookReviews.Account
{
    public partial class Default : Page
    {
        protected AppIdentityUser CurrentUser { get; set; }
        protected int PasswordMinLength => Register.PasswordMinLength;

        protected void Page_Load(object sender, EventArgs e)
        {
            MinLengthValidator.MinLength = PasswordMinLength;

            var userId = Page.User.Identity.GetUserId();
            if (userId == null)
            {
                return;
            }

            var userStore = new UserStore<AppIdentityUser>(new AppIdentityDbContext());
            var userManager = new UserManager<AppIdentityUser>(userStore);
            CurrentUser = userManager.FindById(userId);

            UserName.Text = CurrentUser.UserName;

            if (Page.IsPostBack)
            {
                return;
            }

            FirstName.Text = CurrentUser.FirstName;
            LastName.Text = CurrentUser.LastName;
            Email.Text = CurrentUser.Email;
        }

        protected void SubmitDetails(object sender, CommandEventArgs e)
        {
            SuccessDetails.Visible = false;
            GenericErrorDetails.Visible = false;
            EmailUnavailableMessage.Visible = false;

            if (!FormHelper.ValidateAndHighlight(Page))
            {
                return;
            }

            var userStore = new UserStore<AppIdentityUser>(new AppIdentityDbContext());
            var userManager = new UserManager<AppIdentityUser>(userStore);
            userManager.UserValidator = new UserValidator<AppIdentityUser>(userManager)
            {
                RequireUniqueEmail = true
            };
            var user = userManager.FindById(CurrentUser.Id);

            user.FirstName = FirstName.Text;
            user.LastName = LastName.Text;
            user.Email = Email.Text;

            var result = userManager.Update(user);

            if (result.Succeeded)
            {
                SuccessDetails.Visible = true;
            }
            else if (result.Errors.Any(err => Regex.IsMatch(err, @"Email (.+) is already taken.")))
            {
                EmailUnavailableMessage.Visible = true;
            }
            else
            {
                GenericErrorDetails.Visible = true;
            }
        }

        protected void SubmitPassword(object sender, CommandEventArgs e)
        {
            SuccessPassword.Visible = false;
            GenericErrorPassword.Visible = false;
            WrongPasswordMessage.Visible = false;

            if (!FormHelper.ValidateAndHighlight(Page))
            {
                return;
            }

            var userStore = new UserStore<AppIdentityUser>(new AppIdentityDbContext());
            var userManager = new UserManager<AppIdentityUser>(userStore);
            userManager.PasswordValidator = new MinimumLengthValidator(PasswordMinLength);
            var user = userManager.FindById(CurrentUser.Id);

            var result = userManager.ChangePassword(user.Id, OldPassword.Text, Password.Text);

            if (result.Succeeded)
            {
                SuccessPassword.Visible = true;
            }
            else if (result.Errors.Any(err => err == "Incorrect password."))
            {
                WrongPasswordMessage.Visible = true;
            }
            else
            {
                GenericErrorPassword.Visible = true;
            }
        }

        protected void ChangeView(object sender, CommandEventArgs e)
        {
            switch (e.CommandArgument)
            {
                case "Details":
                    AccountMultiView.SetActiveView(ViewDetails);
                    break;
                case "Password":
                    AccountMultiView.SetActiveView(ViewPassword);
                    break;
            }

            if (AccountMultiView.GetActiveView() == ViewDetails)
            {
                DetailsLink.CssClass = DetailsLink.CssClass.AddToList("active");
                PasswordLink.CssClass = PasswordLink.CssClass.RemoveFromList("active");
            }
            else
            {
                DetailsLink.CssClass = DetailsLink.CssClass.RemoveFromList("active");
                PasswordLink.CssClass = PasswordLink.CssClass.AddToList("active");
            }

            SuccessDetails.Visible = false;
            GenericErrorDetails.Visible = false;
            EmailUnavailableMessage.Visible = false;
            SuccessPassword.Visible = false;
            GenericErrorPassword.Visible = false;
            WrongPasswordMessage.Visible = false;
        }
    }
}