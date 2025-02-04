namespace BookReviews.Auth
{
    public class RolesHelper
    {
        public static string GetRoleTranslation(string roleName)
        {
            switch (roleName.Trim())
            {
                case "Admin":
                    return "Administrator";
                case "User":
                    return "Użytkownik";
                default:
                    return roleName;
            }
        }
    }
}