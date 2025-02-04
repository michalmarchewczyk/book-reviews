using System;
using System.Web.UI.WebControls;
using BookReviews.Auth;
using Microsoft.AspNet.Identity;

namespace BookReviews.Reviews
{
    [AuthenticatedGuard]
    public partial class My : PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            ReviewsList.UserId = Page.User.Identity.GetUserId();
            ReviewsListSortingChanged(Page, EventArgs.Empty);
        }

        protected void ReviewsListSortingChanged(object sender, EventArgs e)
        {
            var selectedValue = ReviewsListSorting.SelectedValue;
            var sortColumn = selectedValue.Split('_')[0];
            var sortDirection = selectedValue.Split('_')[1];
            ReviewsList.Sort(sortColumn,
                sortDirection == "DESC" ? SortDirection.Descending : SortDirection.Ascending);
        }
    }
}