using System;
using System.Web.UI.WebControls;
using BookReviews.Auth;
using BookReviews.Utils.CustomExtensions;

namespace BookReviews.Admin
{
    [RoleGuard(AuthRole.Admin)]
    public partial class Default : PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }

        protected void ChangeView(object sender, CommandEventArgs e)
        {
            UsersLink.CssClass = UsersLink.CssClass.RemoveFromList("active");
            BooksLink.CssClass = BooksLink.CssClass.RemoveFromList("active");
            ReviewsLink.CssClass = ReviewsLink.CssClass.RemoveFromList("active");
            switch (e.CommandArgument)
            {
                case "Users":
                    AdminMultiView.SetActiveView(ViewUsers);
                    UsersLink.CssClass = UsersLink.CssClass.AddToList("active");
                    break;
                case "Books":
                    AdminMultiView.SetActiveView(ViewBooks);
                    BooksLink.CssClass = BooksLink.CssClass.AddToList("active");
                    break;
                case "Reviews":
                    AdminMultiView.SetActiveView(ViewReviews);
                    ReviewsLink.CssClass = ReviewsLink.CssClass.AddToList("active");
                    break;
            }
        }
    }
}