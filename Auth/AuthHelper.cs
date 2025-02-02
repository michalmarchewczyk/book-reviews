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
                Id = user.Id,
                Username = user.UserName,
                FirstName = user.FirstName,
                LastName = user.LastName,
                Email = user.Email
            };
        }

        public static string GetCurrentUserDisplayName(Page page)
        {
            var data = GetCurrentUserData(page);
            if (data == null)
            {
                return null;
            }

            if (!string.IsNullOrEmpty(data.FirstName) || !string.IsNullOrEmpty(data.LastName))
            {
                return data.FirstName + " " + data.LastName;
            }

            return data.Username;
        }

        public static string GetUserDisplayName(string userId)
        {
            if (userId == null)
            {
                return null;
            }

            var userStore = new UserStore<AppIdentityUser>(new AppIdentityDbContext());
            var userManager = new UserManager<AppIdentityUser>(userStore);
            var user = userManager.FindById(userId);
            if (user == null)
            {
                return null;
            }

            if (!string.IsNullOrEmpty(user.FirstName) || !string.IsNullOrEmpty(user.LastName))
            {
                return user.FirstName + " " + user.LastName;
            }

            return user.UserName;
        }
    }

    public class AuthUserData
    {
        public string Id { get; set; }
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