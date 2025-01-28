using System;
using System.ComponentModel.DataAnnotations;
using System.Web.UI;

namespace BookReviews.Auth.Controls
{
    public partial class VisibilityControl : UserControl
    {
        public AuthVisibilityType? Visibility { get; set; } = null;

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
                default:
                    throw new ArgumentNullException(nameof (Visibility));
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
        NotAuthenticated
    }
}