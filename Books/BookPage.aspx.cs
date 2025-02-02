using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using BookReviews.Auth;
using BookReviews.Authors;

namespace BookReviews.Books
{
    [AuthenticatedGuard]
    public partial class BookPage : PageBase
    {
        private int BookId { get; set; }
        protected Book Book { get; set; }
        protected Author Author { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            BookId = Convert.ToInt32(RouteData.Values["id"]);

            BooksDataSource.SelectParameters["Id"].DefaultValue = BookId.ToString();

            var foundBooks = BooksDataSource.Select(new DataSourceSelectArguments());

            if (foundBooks == null)
            {
                throw new Exception("Book not found"); // TODO: handle?
            }

            foreach (DataRowView rowView in foundBooks)
            {
                Book = Book.FromRow(rowView.Row);
                Author = Author.FromRelatedRow(rowView.Row);
            }

            if (Book == null)
            {
                throw new Exception("Book not found"); // TODO: handle?
            }

            ReviewsList.BookId = BookId;

            Render();
        }

        private void Render()
        {
            if (Book == null)
            {
                return;
            }

            if (!string.IsNullOrEmpty(Book.CoverPath))
            {
                CoverImage.ImageUrl = Book.CoverPath;
            }

            // TODO: dont show add review button if review already exists
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