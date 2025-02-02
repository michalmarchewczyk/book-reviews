using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using BookReviews.Auth;
using BookReviews.Authors;
using BookReviews.Books.Components;

namespace BookReviews.Books
{
    [AuthenticatedGuard]
    public partial class Default : PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            BooksListSortingChanged(Page, EventArgs.Empty);
        }

        protected void BooksListView_OnItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType != ListViewItemType.DataItem)
            {
                return;
            }

            var dataItem = (ListViewDataItem)e.Item;
            var rowView = (DataRowView)dataItem.DataItem;
            var book = Book.FromRow(rowView.Row);
            var author = Author.FromRelatedRow(rowView.Row);
            foreach (Control dataItemControl in dataItem.Controls)
            {
                if (dataItemControl is BookCard bookCard)
                {
                    bookCard.Book = book;
                    bookCard.Author = author;
                }
            }
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