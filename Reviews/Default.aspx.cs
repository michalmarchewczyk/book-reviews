using System;
using System.Web.UI.WebControls;
using BookReviews.Auth;

namespace BookReviews.Reviews
{
    [AuthenticatedGuard]
    public partial class Default : PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
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