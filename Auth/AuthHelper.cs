using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;

namespace BookReviews.Auth
{
    public static class AuthHelper
    {
        public static bool CheckRole(string userId, AuthRole authRole)
        {
            if(userId == null) return false;
            var userStore = new UserStore<AppIdentityUser>(new AppIdentityDbContext());
            var userManager = new UserManager<AppIdentityUser>(userStore);
            return userManager.IsInRole(userId, authRole.ToString());
        }
    }

    public enum AuthRole
    {
        Admin,
        User
    }
}