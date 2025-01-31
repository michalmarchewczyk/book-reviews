using System;
using System.Data;
using System.Web.UI;
using BookReviews.Auth;
using BookReviews.Utils;

namespace BookReviews.Books
{
    [RoleGuard(AuthRole.Admin)]
    public partial class Edit : PageBase
    {
        private int BookId { get; set; }
        private Book Book { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
            BookId = int.Parse(Request.QueryString["id"] ?? "-1");

            BooksDataSource.SelectParameters["Id"].DefaultValue = BookId.ToString();

            var foundBooks = BooksDataSource.Select(new DataSourceSelectArguments());

            if (foundBooks == null)
            {
                throw new Exception("Book not found"); // TODO: handle?
            }

            foreach (DataRowView rowView in foundBooks)
            {
                Book = Book.Create(rowView.Row);
            }

            AuthorExisting.InputAttributes.Add("class", "form-check-input");
            AuthorNew.InputAttributes.Add("class", "form-check-input");

            AuthorChange(Page, EventArgs.Empty);

            if (Page.IsPostBack)
            {
                FormHelper.ValidateAndHighlight(Page, new[] { AuthorLastName.ID });
                return;
            }

            AuthorSelect.SelectedValue = Book.AuthorId;
            BookTitle.Text = Book.Title;
            ISBN.Text = Book.ISBN;
            ReleaseYear.Text = Book.ReleaseYear.ToString();
            Description.Text = Book.Description;
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

        protected void CancelButton_OnSubmit(object sender, EventArgs e)
        {
            Response.Redirect("~/books"); // TODO: change to book page
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

            BooksDataSource.UpdateParameters["Id"].DefaultValue = BookId.ToString();
            BooksDataSource.UpdateParameters["AuthorId"].DefaultValue = authorId.ToString();
            BooksDataSource.UpdateParameters["Title"].DefaultValue = title;
            BooksDataSource.UpdateParameters["ISBN"].DefaultValue = isbn;
            BooksDataSource.UpdateParameters["ReleaseYear"].DefaultValue = releaseYear.ToString();
            BooksDataSource.UpdateParameters["Description"].DefaultValue = description;

            BooksDataSource.Update();
        }
    }
}