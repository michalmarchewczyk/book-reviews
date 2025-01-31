using System;
using BookReviews.Auth;
using BookReviews.Utils;

namespace BookReviews.Books
{
    [RoleGuard(AuthRole.Admin)]
    public partial class Add : PageBase
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            AuthorExisting.InputAttributes.Add("class", "form-check-input");
            AuthorNew.InputAttributes.Add("class", "form-check-input");

            AuthorChange(Page, EventArgs.Empty);

            if (Page.IsPostBack)
            {
                FormHelper.ValidateAndHighlight(Page, new[] { AuthorLastName.ID });
            }
        }

        protected void AuthorChange(object sender, EventArgs e)
        {
            if (AuthorNew.Checked)
            {
                AuthorSelect.Disabled = true;
                AuthorFirstName.Attributes.Remove("disabled");
                AuthorLastName.Attributes.Remove("disabled");
            }
            else
            {
                AuthorSelect.Disabled = false;
                AuthorFirstName.Attributes.Add("disabled", "disabled");
                AuthorLastName.Attributes.Add("disabled", "disabled");
                // TODO: disable validation
                // AuthorLastNameValidator.IsValid = true;
            }
        }

        protected void CancelButton_OnCommand(object sender, EventArgs e)
        {
            Response.Redirect("~/books");
        }

        protected void Submit(object sender, EventArgs e)
        {
            if (!FormHelper.ValidateAndHighlight(Page))
            {
                return;
            }

            var authorId = -1;
            if (AuthorNew.Checked)
            {
                AuthorsDataSource.InsertParameters["FirstName"].DefaultValue = AuthorFirstName.Text;
                AuthorsDataSource.InsertParameters["LastName"].DefaultValue = AuthorLastName.Text;
                AuthorsDataSource.Inserted += (o, args) =>
                {
                    authorId = int.Parse(args.Command.Parameters["@NewId"].Value.ToString());
                };
                AuthorsDataSource.Insert();
            }
            else
            {
                authorId = AuthorSelect.SelectedValue;
            }

            var title = BookTitle.Text;
            var isbn = ISBN.Text;
            var releaseYear = int.Parse(ReleaseYear.Text);
            var description = Description.Text;

            BooksDataSource.InsertParameters["AuthorId"].DefaultValue = authorId.ToString();
            BooksDataSource.InsertParameters["Title"].DefaultValue = title;
            BooksDataSource.InsertParameters["ISBN"].DefaultValue = isbn;
            BooksDataSource.InsertParameters["ReleaseYear"].DefaultValue = releaseYear.ToString();
            BooksDataSource.InsertParameters["Description"].DefaultValue = description;

            BooksDataSource.Insert();
        }
    }
}