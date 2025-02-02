using System.Web.UI.WebControls;

namespace BookReviews.Components.Validators
{
    public class MaxLengthValidator : BaseValidator
    {
        public int MaxLength { get; set; }

        protected override bool EvaluateIsValid()
        {
            var controlValue = GetControlValidationValue(ControlToValidate);
            return controlValue.Length <= MaxLength;
        }
    }
}