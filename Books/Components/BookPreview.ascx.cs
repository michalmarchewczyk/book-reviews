using System;
using System.Web.UI;
using BookReviews.Authors;

namespace BookReviews.Books.Components
{
    public partial class BookPreview : UserControl
    {
        private Author _author;
        private Book _book;

        public Book Book
        {
            get => _book;
            set
            {
                _book = value;
                Render();
            }
        }

        public Author Author
        {
            get => _author;
            set
            {
                _author = value;
                Render();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
        }

        private void Render()
        {
            if (Book == null || Author == null)
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