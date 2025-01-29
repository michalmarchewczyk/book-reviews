namespace BookReviews.Utils.CustomExtensions
{
    public static class StringExtension
    {
        public static string FirstChar(this string str)
        {
            return string.IsNullOrEmpty(str) ? null : str[0].ToString();
        }
    }
}