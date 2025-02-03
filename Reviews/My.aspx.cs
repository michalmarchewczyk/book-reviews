using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;

namespace BookReviews.Reviews
{
    public partial class My : Page
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