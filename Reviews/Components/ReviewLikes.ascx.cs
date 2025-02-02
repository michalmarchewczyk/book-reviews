using System;
using System.Data;
using System.Diagnostics;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.AspNet.Identity;

namespace BookReviews.Reviews.Components
{
    public partial class ReviewLikes : UserControl
    {
        public int ReviewId { get; set; }
        public int Likes { get; set; }
        public int Dislikes { get; set; }
        public int CurrentUserVote { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            Debug.WriteLine("ReviewLikes RENDER ID=" + ReviewId);

            ReviewLikesDataSource.SelectParameters["Id"].DefaultValue = ReviewId.ToString();

            var foundRecords = ReviewLikesDataSource.Select(DataSourceSelectArguments.Empty);

            if (foundRecords == null)
            {
                return;
            }

            Likes = 0;
            Dislikes = 0;

            var currentUserId = Page.User.Identity.GetUserId();

            foreach (DataRowView rowView in foundRecords)
            {
                var value = (int)rowView.Row["Value"];
                var userId = (string)rowView.Row["UserId"];
                if (value == 1)
                {
                    Likes += 1;
                }
                else
                {
                    Dislikes += 1;
                }

                if (userId == currentUserId)
                {
                    CurrentUserVote = value;
                }
            }

            RenderButtons();
        }

        protected void LikeButton_OnCommand(object sender, CommandEventArgs e)
        {
            ChangeCurrentUserVote(1);
        }

        protected void DislikeButton_OnCommand(object sender, CommandEventArgs e)
        {
            ChangeCurrentUserVote(-1);
        }

        private void ChangeCurrentUserVote(int value)
        {
            if (CurrentUserVote == value)
            {
                RemoveLike(value);
                CurrentUserVote = 0;
                return;
            }

            if (CurrentUserVote == -1 * value)
            {
                RemoveLike(-1 * value);
            }

            AddLike(value);
            CurrentUserVote = value;
        }

        private void RenderButtons()
        {
            LikeCount.Text = Likes.ToString();
            DislikeCount.Text = Dislikes.ToString();
        }

        private void AddLike(int value)
        {
            ReviewLikesDataSource.InsertParameters["Id"].DefaultValue = ReviewId.ToString();
            ReviewLikesDataSource.InsertParameters["UserId"].DefaultValue = Page.User.Identity.GetUserId();
            ReviewLikesDataSource.InsertParameters["Value"].DefaultValue = value.ToString();
            ReviewLikesDataSource.Insert();
            if (value == 1)
            {
                Likes += 1;
            }
            else
            {
                Dislikes += 1;
            }

            RenderButtons();
        }

        private void RemoveLike(int value)
        {
            ReviewLikesDataSource.DeleteParameters["Id"].DefaultValue = ReviewId.ToString();
            ReviewLikesDataSource.DeleteParameters["UserId"].DefaultValue = Page.User.Identity.GetUserId();
            ReviewLikesDataSource.Delete();
            if (value == 1)
            {
                Likes -= 1;
            }
            else
            {
                Dislikes -= 1;
            }

            RenderButtons();
        }
    }
}