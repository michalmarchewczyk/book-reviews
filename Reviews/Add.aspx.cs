using System;
using System.Data;
using System.Web;
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
    public partial class Add : PageBase
    {
        private int BookId { get; set; }
        private string UserId { get; set; }
        protected Book Book { get; set; }
        protected Author Author { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            BookId = Convert.ToInt32(Request.QueryString["bookId"]);
            UserId = Page.User.Identity.GetUserId();

            ReviewsDataSource.SelectParameters["BookId"].DefaultValue = BookId.ToString();
            ReviewsDataSource.SelectParameters["UserId"].DefaultValue = UserId;

            var foundReviews = ReviewsDataSource.Select(new DataSourceSelectArguments());
            if (foundReviews != null)
            {
                foreach (DataRowView rowView in foundReviews)
                {
                    Response.Redirect($"~/reviews/{rowView["Id"]}"); // TODO: display error?
                }
            }

            BooksDataSource.SelectParameters["Id"].DefaultValue = BookId.ToString();
            var foundBooks = BooksDataSource.Select(new DataSourceSelectArguments());
            if (foundBooks == null)
            {
                throw new HttpException(404, "Not Found");
            }

            foreach (DataRowView rowView in foundBooks)
            {
                Book = Book.FromRow(rowView.Row);
                Author = Author.FromRelatedRow(rowView.Row);
            }

            if (Book == null)
            {
                throw new HttpException(404, "Not Found");
            }

            BookPreview.Book = Book;
            BookPreview.Author = Author;
        }

        protected void CancelButton_OnCommand(object sender, CommandEventArgs e)
        {
            Response.Redirect($"~/books/{BookId}");
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

            ReviewsDataSource.InsertParameters["BookId"].DefaultValue = BookId.ToString();
            ReviewsDataSource.InsertParameters["UserId"].DefaultValue = UserId;
            ReviewsDataSource.InsertParameters["Title"].DefaultValue = title;
            ReviewsDataSource.InsertParameters["Content"].DefaultValue = content;
            ReviewsDataSource.InsertParameters["Rating"].DefaultValue = rating.ToString();

            var reviewId = -1;
            ReviewsDataSource.Inserted += (o, args) =>
            {
                reviewId = int.Parse(args.Command.Parameters["@NewId"].Value.ToString());
            };

            ReviewsDataSource.Insert();

            Response.Redirect($"~/reviews/{reviewId}");
        }
    }
}