using System;
using BookReviews.Auth;

namespace BookReviews.Books
{
    [AuthenticatedGuard]
    public partial class Default : PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
        }
    }
}