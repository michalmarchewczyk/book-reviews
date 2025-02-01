using System;
using System.Data;
using System.Web.UI;
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
                Book = Book.Create(rowView.Row);
                Author = Author.CreateFromBook(rowView.Row);
            }

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
        }
    }
}