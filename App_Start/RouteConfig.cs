using System.Web.Routing;
using Microsoft.AspNet.FriendlyUrls;

namespace BookReviews
{
    public static class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            var settings = new FriendlyUrlSettings();
            settings.AutoRedirectMode = RedirectMode.Permanent;
            routes.EnableFriendlyUrls(settings);

            routes.MapPageRoute(
                "BookPageRoute",
                "books/{id}",
                "~/books/BookPage.aspx");

            routes.MapPageRoute(
                "ReviewPageRoute",
                "reviews/{id}",
                "~/reviews/ReviewPage.aspx");
        }
    }
}