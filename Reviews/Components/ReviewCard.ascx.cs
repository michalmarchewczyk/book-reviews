using System;
using System.Web.UI;
using BookReviews.Authors;
using BookReviews.Books;

namespace BookReviews.Reviews.Components
{
    public partial class ReviewCard : UserControl
    {
        private Author _author;

        private Book _book;

        private bool _previewVisible;

        private Review _review;

        public Review Review
        {
            get => _review;
            set
            {
                _review = value;
                Render();
            }
        }

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

        public bool PreviewVisible
        {
            get => _previewVisible;
            set
            {
                _previewVisible = value;
                Render();
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            Render();
        }

        private void Render()
        {
            if (Review == null || Book == null || Author == null)
            {
                return;
            }

            BookPreview.Visible = PreviewVisible;
            BookPreview.Book = Book;
            BookPreview.Author = Author;
            RatingInput.Value = Review.Rating;


            // TODO: edit and delete buttons for owner
            // TODO: delete button for admin
        }
    }
}