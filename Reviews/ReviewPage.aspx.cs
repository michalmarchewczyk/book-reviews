using System;
using System.Data;
using System.Web.UI;
using BookReviews.Auth;
using BookReviews.Authors;
using BookReviews.Books;

namespace BookReviews.Reviews
{
    [AuthenticatedGuard]
    public partial class ReviewPage : PageBase
    {
        private int ReviewId { get; set; }
        protected Review Review { get; set; }
        protected Book Book { get; set; }
        protected Author Author { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            ReviewId = Convert.ToInt32(RouteData.Values["id"]);

            ReviewsDataSource.SelectParameters["Id"].DefaultValue = ReviewId.ToString();

            var foundReviews = ReviewsDataSource.Select(new DataSourceSelectArguments());

            if (foundReviews == null)
            {
                throw new Exception("Review not found"); // TODO: handle?
            }

            foreach (DataRowView rowView in foundReviews)
            {
                Review = Review.FromRow(rowView.Row);
                Book = Book.FromRelatedRow(rowView.Row);
                Author = Author.FromRelatedRow(rowView.Row);
            }

            if (Review == null)
            {
                throw new Exception("Review not found"); // TODO: handle?
            }

            BookPreview.Book = Book;
            BookPreview.Author = Author;
            RatingInput.Value = Review.Rating;

            // TODO: edit and delete buttons for owner
            // TODO: delete button for admin
        }
    }
}