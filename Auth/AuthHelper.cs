using System.Web.UI;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;

namespace BookReviews.Auth
{
    public static class AuthHelper
    {
        public static bool CheckRole(string userId, AuthRole authRole)
        {
            if (userId == null)
            {
                return false;
            }

            var userStore = new UserStore<AppIdentityUser>(new AppIdentityDbContext());
            var userManager = new UserManager<AppIdentityUser>(userStore);
            return userManager.IsInRole(userId, authRole.ToString());
        }

        public static AuthUserData GetCurrentUserData(Page page)
        {
            var userId = page.User.Identity.GetUserId();
            if (userId == null)
            {
                return null;
            }

            var userStore = new UserStore<AppIdentityUser>(new AppIdentityDbContext());
            var userManager = new UserManager<AppIdentityUser>(userStore);
            var user = userManager.FindById(userId);
            return new AuthUserData
            {
                Username = user.UserName,
                FirstName = user.FirstName,
                LastName = user.LastName,
                Email = user.Email
            };
        }
    }

    public class AuthUserData
    {
        public string Username { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }
        public string Email { get; set; }
    }

    public enum AuthRole
    {
        Admin,
        User
    }
}