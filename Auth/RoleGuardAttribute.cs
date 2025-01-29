using System;
using System.Web.UI;
using Microsoft.AspNet.Identity;

namespace BookReviews.Auth
{
    [AttributeUsage(AttributeTargets.Class)]
    public class RoleGuardAttribute : Attribute, IPageAttribute
    {
        public RoleGuardAttribute(AuthRole role)
        {
            Role = role;
        }

        private AuthRole Role { get; }

        public void OnPageInit(Page page)
        {
            var hasRole = AuthHelper.CheckRole(page.User.Identity.GetUserId(), Role);

            if (hasRole)
            {
                return;
            }

            page.Response.StatusCode = 403;
            page.Response.End();
        }
    }
}