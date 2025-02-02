using System;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BookReviews.Auth;
using BookReviews.Authors;
using Microsoft.AspNet.Identity;

namespace BookReviews.Books
{
    [AuthenticatedGuard]
    public partial class BookPage : PageBase
    {
        private int BookId { get; set; }
        protected Book Book { get; set; }
        protected Author Author { get; set; }
        protected int CurrentUserReview { get; set; } = -1;

        protected void Page_Load(object sender, EventArgs e)
        {
            BookId = Convert.ToInt32(RouteData.Values["id"]);

            BooksDataSource.SelectParameters["Id"].DefaultValue = BookId.ToString();
            BooksDataSource.SelectParameters["UserId"].DefaultValue = Page.User.Identity.GetUserId();

            var foundBooks = BooksDataSource.Select(new DataSourceSelectArguments());

            if (foundBooks == null)
            {
                throw new HttpException(404, "Not Found");
            }

            foreach (DataRowView rowView in foundBooks)
            {
                Book = Book.FromRow(rowView.Row);
                Author = Author.FromRelatedRow(rowView.Row);
                CurrentUserReview = rowView.Row["ReviewId"] == DBNull.Value
                    ? -1
                    : Convert.ToInt32(rowView.Row["ReviewId"]);
            }

            if (Book == null)
            {
                throw new HttpException(404, "Not Found");
            }

            ReviewsList.BookId = BookId;
            AddReviewButton.Visible = CurrentUserReview == -1;
            AddReviewButton.NavigateUrl = $"~/reviews/add?bookId={BookId}";
            ViewReviewButton.Visible = CurrentUserReview != -1;
            ViewReviewButton.NavigateUrl = $"~/reviews/{CurrentUserReview}";

            ReviewsListSortingChanged(Page, EventArgs.Empty);

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