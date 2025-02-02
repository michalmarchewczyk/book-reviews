using System;
using System.Web.UI.WebControls;
using BookReviews.Auth;

namespace BookReviews.Books
{
    [AuthenticatedGuard]
    public partial class Default : PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            BooksListSortingChanged(Page, EventArgs.Empty);
        }

        protected void BooksListSortingChanged(object sender, EventArgs e)
        {
            var selectedValue = BooksListSorting.SelectedValue;
            var sortColumn = selectedValue.Split('_')[0];
            var sortDirection = selectedValue.Split('_')[1];
            BooksListView.Sort(sortColumn,
                sortDirection == "DESC" ? SortDirection.Descending : SortDirection.Ascending);
        }
    }
}