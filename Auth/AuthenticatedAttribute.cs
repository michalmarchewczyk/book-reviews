using System;
using System.Web.UI;

namespace BookReviews.Auth
{
    [AttributeUsage(AttributeTargets.Class)]
    public class AuthenticatedAttribute : Attribute, IPageAttribute
    {
        public void OnPageInit(Page page)
        {
            var isAuthenticated = page.User.Identity.IsAuthenticated;

            if (isAuthenticated)
            {
                return;
            }

            page.Response.StatusCode = 401;
            page.Response.End();
        }
    }
}