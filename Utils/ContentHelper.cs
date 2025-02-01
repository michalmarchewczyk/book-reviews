using System.Linq;
using System.Web.UI;
using System.Web.UI.HtmlControls;

namespace BookReviews.Utils
{
    public static class ContentHelper
    {
        public static void AddCssFile(string path, Page page)
        {
            var href = page.ResolveUrl(path);
            if (page.Header.Controls.OfType<HtmlLink>().Any(l => l.Href == href))
            {
                return;
            }

            var link = new HtmlLink();
            link.Href = href;
            link.Attributes.Add("rel", "stylesheet");
            link.Attributes.Add("type", "text/css");
            page.Header.Controls.Add(link);
        }

        public static void AddJsFile(string path, Page page)
        {
            var src = page.ResolveUrl(path);
            if (page.Header.Controls.OfType<HtmlGenericControl>()
                .Any(s => s.TagName == "script" && s.Attributes["src"] == src))
            {
                return;
            }

            var script = new HtmlGenericControl("script");
            script.Attributes.Add("type", "text/javascript");
            script.Attributes.Add("src", src);
            page.Header.Controls.Add(script);
        }
    }
}