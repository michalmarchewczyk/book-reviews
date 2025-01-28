using Microsoft.AspNet.Identity.EntityFramework;

namespace BookReviews.Auth
{
    public class AppIdentityUser : IdentityUser
    {
        public string FirstName { get; set; }
        public string LastName { get; set; }
    }
}