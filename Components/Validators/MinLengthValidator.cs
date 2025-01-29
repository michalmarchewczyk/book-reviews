using System.Web.UI.WebControls;

namespace BookReviews.Components.Validators
{
    public class MinLengthValidator : BaseValidator
    {
        public int MinLength { get; set; }

        protected override bool EvaluateIsValid()
        {
            var controlValue = GetControlValidationValue(ControlToValidate);
            return string.IsNullOrEmpty(controlValue) || controlValue.Length >= MinLength;
        }
    }
}