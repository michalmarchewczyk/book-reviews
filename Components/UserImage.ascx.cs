using System;
using System.Linq;
using System.Web.UI;
using BookReviews.Auth;
using BookReviews.Utils.CustomExtensions;

namespace BookReviews.Components
{
    public partial class UserImage : UserControl
    {
        private AuthUserData _userData;
        public float Size { get; set; } = 1;

        private AuthUserData UserData => _userData ?? (_userData = AuthHelper.GetCurrentUserData(Page));

        protected string UserInitials
        {
            get
            {
                var data = UserData;
                if (data == null)
                {
                    return null;
                }

                if (!string.IsNullOrEmpty(data.FirstName) || !string.IsNullOrEmpty(data.LastName))
                {
                    return data.FirstName.FirstChar() + "" + data.LastName.FirstChar();
                }

                return data.Username.FirstChar();
            }
        }

        protected string BgColor => $"hsl({UserIdUniqueHash % 360}, 40%, 80%)";

        protected string TextColor => $"hsl({UserIdUniqueHash % 360}, 80%, 20%)";

        private int UserIdUniqueHash => UserData.Id.Aggregate(0, (acc, c) => c + ((acc << 5) - acc));

        protected void Page_Load(object sender, EventArgs e)
        {
        }
    }
}