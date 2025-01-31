using System;
using System.Web.UI;

namespace BookReviews.Authors.Components
{
    public partial class AuthorSelect : UserControl
    {
        public bool Disabled
        {
            get => AuthorsList.Attributes["disabled"] == "disabled";
            set
            {
                if (value)
                {
                    AuthorsList.Attributes.Add("disabled", "disabled");
                }
                else
                {
                    AuthorsList.Attributes.Remove("disabled");
                }
            }
        }

        public int SelectedValue
        {
            get => int.Parse(AuthorsList.SelectedValue);
            set => AuthorsList.SelectedValue = value.ToString();
        }

        protected void Page_Load(object sender, EventArgs e)
        {
        }
    }
}