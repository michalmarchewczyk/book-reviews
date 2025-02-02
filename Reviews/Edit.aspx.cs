using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using BookReviews.Auth;
using BookReviews.Authors;
using BookReviews.Books;
using BookReviews.Utils;
using Microsoft.AspNet.Identity;

namespace BookReviews.Reviews
{
    [AuthenticatedGuard]
    public partial class Edit : PageBase
    {
        private int ReviewId { get; set; }
        protected Review Review { get; set; }
        protected Book Book { get; set; }
        protected Author Author { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            ReviewId = Convert.ToInt32(Request.QueryString["id"]);
            ReviewsDataSource.SelectParameters["Id"].DefaultValue = ReviewId.ToString();
            var foundReviews = ReviewsDataSource.Select(new DataSourceSelectArguments());
            if (foundReviews == null)
            {
                throw new Exception("Review not found"); // TODO: handle?
            }

            foreach (DataRowView rowView in foundReviews)
            {
                Review = Review.FromRow(rowView.Row);
            }

            if (Review == null)
            {
                throw new Exception("Review not found"); // TODO: handle?
            }

            var currentUserId = Page.User.Identity.GetUserId();

            if (Review.UserId != currentUserId)
            {
                Response.StatusCode = 403; // TODO: handle?
                Response.End();
            }

            BooksDataSource.SelectParameters["Id"].DefaultValue = Review.BookId.ToString();
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

            BookPreview.Book = Book;
            BookPreview.Author = Author;

            if (Page.IsPostBack)
            {
                return;
            }

            RatingInput.Value = Review.Rating;
            ReviewTitle.Text = Review.Title;
            ReviewContent.Text = Review.Content;
        }

        protected void CancelButton_OnCommand(object sender, CommandEventArgs e)
        {
            Response.Redirect($"~/reviews/{ReviewId}");
        }

        protected void Submit(object sender, CommandEventArgs e)
        {
            if (!FormHelper.ValidateAndHighlight(Page))
            {
                return;
            }

            var title = ReviewTitle.Text;
            var content = ReviewContent.Text;
            var rating = RatingInput.Value;

            ReviewsDataSource.UpdateParameters["Id"].DefaultValue = ReviewId.ToString();
            ReviewsDataSource.UpdateParameters["Title"].DefaultValue = title;
            ReviewsDataSource.UpdateParameters["Content"].DefaultValue = content;
            ReviewsDataSource.UpdateParameters["Rating"].DefaultValue = rating.ToString();

            ReviewsDataSource.Update();

            Response.Redirect($"~/reviews/{ReviewId}");
        }
    }
}