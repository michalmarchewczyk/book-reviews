using System;
using System.Data;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BookReviews.Auth;

namespace BookReviews.Books
{
    [RoleGuard(AuthRole.Admin)]
    public partial class Delete : PageBase
    {
        private int BookId { get; set; }
        protected Book Book { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            BookId = int.Parse(Request.QueryString["id"] ?? "-1");

            BooksDataSource.SelectParameters["Id"].DefaultValue = BookId.ToString();

            var foundBooks = BooksDataSource.Select(new DataSourceSelectArguments());

            if (foundBooks == null)
            {
                throw new HttpException(404, "Not Found");
            }

            foreach (DataRowView rowView in foundBooks)
            {
                Book = Book.FromRow(rowView.Row);
            }

            if (Book == null)
            {
                throw new HttpException(404, "Not Found");
            }

            if (!string.IsNullOrEmpty(Book.CoverPath))
            {
                CoverImage.ImageUrl = Book.CoverPath;
            }
        }


        protected void CancelButton_OnCommand(object sender, CommandEventArgs e)
        {
            Response.Redirect($"~/books/{BookId}");
        }

        protected void Submit(object sender, CommandEventArgs e)
        {
            BooksDataSource.DeleteParameters["Id"].DefaultValue = BookId.ToString();

            BooksDataSource.Delete();

            Response.Redirect("~/books/");
        }
    }
}