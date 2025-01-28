using System;
using System.Web.UI;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;

namespace BookReviews.Auth
{
    public partial class Register : Page
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
            var firstName = FirstName.Text;
            var lastName = LastName.Text;
            var email = Email.Text;
            var password = Password.Text;


            var userStore = new UserStore<AppIdentityUser>(new AppIdentityDbContext());
            var userManager = new UserManager<AppIdentityUser>(userStore);

            var user = new AppIdentityUser()
            {
                UserName = username,
                FirstName = firstName,
                LastName = lastName,
                Email = email
            };
            var result = userManager.Create(user, password);

            if (result.Succeeded)
            {
                // TODO: sign in user
                Console.WriteLine("User was created successfully!");
                // StatusMessage.Text = string.Format("User {0} was created successfully!", user.UserName);
            }
            else
            {
                Console.WriteLine("Errors:");
                // StatusMessage.Text = result.Errors.FirstOrDefault();
            }
        }

    }
}