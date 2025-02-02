using System;
using System.Web.UI;
using BookReviews.Authors;
using BookReviews.Books;

namespace BookReviews.Reviews.Components
{
    public partial class ReviewCard : UserControl
    {
        public Review Review { get; set; }

        public Book Book { get; set; }

        public Author Author { get; set; }

        public bool PreviewVisible { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            Render();
        }

        private void Render()
        {
            if (Review == null || Book == null || Author == null)
            {
            }

            // TODO: edit and delete buttons for owner
            // TODO: delete button for admin
        }
    }
}