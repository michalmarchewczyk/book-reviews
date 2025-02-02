using System;
using System.Linq;

namespace BookReviews.Utils.CustomExtensions
{
    public static class StringExtension
    {
        public static string FirstChar(this string str)
        {
            return string.IsNullOrEmpty(str) ? null : str[0].ToString();
        }

        public static string RemoveFromList(this string str, string value, string delimiter = " ")
        {
            var list = str.Split(Convert.ToChar(delimiter));
            var result = list.Where(item => item != value)
                .Aggregate(string.Empty, (current, item) => current + item + delimiter);

            return result.Trim();
        }

        public static string AddToList(this string str, string value, string delimiter = " ")
        {
            // check if list already has item
            var list = str.Split(Convert.ToChar(delimiter));
            if (list.Contains(value))
            {
                return str;
            }

            return string.IsNullOrEmpty(str) ? value : str + delimiter + value;
        }
    }
}