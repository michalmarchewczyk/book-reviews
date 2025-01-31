using System.Linq;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace BookReviews.Utils
{
    public static class FormHelper
    {
        public static bool ValidateAndHighlight(Page page, string[] skipValidators = null)
        {
            page.Validate();

            var validatedControls = page.Validators.Cast<BaseValidator>()
                .Select(v => v.NamingContainer.FindControl(v.ControlToValidate))
                .OfType<WebControl>()
                .ToArray();

            foreach (var control in validatedControls)
            {
                if (skipValidators != null && skipValidators.Contains(control.ID))
                {
                    continue;
                }

                control.CssClass = control.CssClass.Replace("is-invalid", "").Trim();
                var validators = page.Validators.Cast<BaseValidator>()
                    .Where(v => v.ControlToValidate == control.ID);
                if (validators.Any(v => !v.IsValid))
                {
                    control.CssClass += " is-invalid";
                }
            }

            return page.IsValid;
        }
    }
}