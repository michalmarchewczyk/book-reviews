using System;
using System.Data;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BookReviews.Reviews.Components
{
    public partial class ReviewsList : UserControl
    {
        public int? BookId { get; set; } = null;

        public string UserId { get; set; } = null;

        public int Count => ReviewsListView.Items.Count;

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

            if (UserId != null)
            {
                ReviewsDataSource.SelectCommand += " WHERE r.[UserId] = @UserId";
                if (ReviewsDataSource.SelectParameters["UserId"] == null)
                {
                    ReviewsDataSource.SelectParameters.Add("UserId", DbType.String, UserId);
                }
            }

            ReviewsListView.DataBind();
        }

        public void Sort(string sortColumn, SortDirection sortDirection)
        {
            ReviewsListView.Sort(sortColumn, sortDirection);
        }
    }
}