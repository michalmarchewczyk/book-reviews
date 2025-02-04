using System;
using BookReviews.Auth;

namespace BookReviews.Admin
{
    [RoleGuard(AuthRole.Admin)]
    public partial class Default : PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }
    }
}