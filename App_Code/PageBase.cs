using System;
using System.Web.UI;
using BookReviews.Auth;

namespace BookReviews
{
    public class PageBase: Page
    {
        protected override void OnInit(EventArgs e)
        {
            base.OnInit(e);

            var attributes = GetType().GetCustomAttributes(true);
            foreach (var attribute in attributes)
            {
                if (attribute is IPageAttribute pageAttribute)
                {
                    pageAttribute.OnPageInit(this);
                }
            }
        }
    }

    public interface IPageAttribute
    {
        void OnPageInit(Page page);
    }
}