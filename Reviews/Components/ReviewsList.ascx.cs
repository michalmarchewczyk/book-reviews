using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;
using BookReviews.Authors;
using BookReviews.Books;

namespace BookReviews.Reviews.Components
{
    public partial class ReviewsList : UserControl
    {
        public int? BookId { get; set; } = null;

        public int? UserId { get; set; } = null;

        public int Count => ReviewsListView.Items.Count;

        // public bool ShowCurrentUsersFirst { get; set; } // TODO: implement

        protected void Page_Load(object sender, EventArgs e)
        {
            if (BookId != null)
            {
                ReviewsDataSource.SelectCommand += " WHERE r.[BookId] = @BookId";
                if (ReviewsDataSource.SelectParameters["BookId"] == null)
                {
                    ReviewsDataSource.SelectParameters.Add("BookId", DbType.Int32, BookId.ToString());
                }
            }

            if (UserId != null && ReviewsDataSource.SelectParameters["UserId"] == null)
            {
                ReviewsDataSource.SelectCommand += " WHERE r.[UserId] = @UserId";
                if (ReviewsDataSource.SelectParameters["UserId"] == null)
                {
                    ReviewsDataSource.SelectParameters.Add("UserId", DbType.Int32, UserId.ToString());
                }
            }

            ReviewsDataSource.DataBind();
        }

        protected void ReviewsListView_OnItemDataBound(object sender, ListViewItemEventArgs e)
        {
            if (e.Item.ItemType != ListViewItemType.DataItem)
            {
                return;
            }

            var dataItem = (ListViewDataItem)e.Item;
            var rowView = (DataRowView)dataItem.DataItem;
            var review = Review.Create(rowView.Row);
            var book = Book.CreateFromReview(rowView.Row);
            var author = Author.CreateFromBook(rowView.Row);
            foreach (Control dataItemControl in dataItem.Controls)
            {
                if (dataItemControl is ReviewCard reviewCard)
                {
                    reviewCard.PreviewVisible = true;
                    reviewCard.Review = review;
                    reviewCard.Book = book;
                    reviewCard.Author = author;
                }
            }
        }

        public void Sort(string sortColumn, SortDirection sortDirection)
        {
            ReviewsListView.Sort(sortColumn, sortDirection);
        }
    }
}