using System;
using System.Web.UI;
using Microsoft.AspNet.Identity;

namespace BookReviews.Auth.Controls
{
    public partial class VisibilityControl : UserControl
    {
        public AuthVisibilityType? Visibility { get; set; } = null;

        public string Role { get; set; }

        public string OwnerId { get; set; }

        [TemplateInstance(TemplateInstance.Single)]
        public ITemplate Content { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            bool visible;

            switch (Visibility)
            {
                case AuthVisibilityType.Authenticated:
                    visible = Request.IsAuthenticated;
                    break;
                case AuthVisibilityType.NotAuthenticated:
                    visible = !Request.IsAuthenticated;
                    break;
                case AuthVisibilityType.HasRole:
                    visible = AuthHelper.CheckRole(Page.User.Identity.GetUserId(),
                        (AuthRole)Enum.Parse(typeof(AuthRole), Role));
                    break;
                case AuthVisibilityType.HasRoleOrOwner:
                    visible = Page.User.Identity.GetUserId() == OwnerId ||
                              AuthHelper.CheckRole(Page.User.Identity.GetUserId(),
                                  (AuthRole)Enum.Parse(typeof(AuthRole), Role));
                    break;
                case AuthVisibilityType.IsOwner:
                    visible = Page.User.Identity.GetUserId() == OwnerId;
                    break;
                default:
                    throw new ArgumentNullException(nameof(Visibility));
            }

            if (visible)
            {
                Content.InstantiateIn(Placeholder);
            }
        }
    }

    public enum AuthVisibilityType
    {
        Authenticated,
        NotAuthenticated,
        HasRole,
        HasRoleOrOwner,
        IsOwner
    }
}