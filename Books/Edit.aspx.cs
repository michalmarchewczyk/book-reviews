using System;
using System.Data;
using System.IO;
using System.Web;
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
                throw new HttpException(404, "Not Found");
            }

            foreach (DataRowView rowView in foundBooks)
            {
                Book = Book.FromRow(rowView.Row);
            }

            if (Book == null)
            {
                throw new HttpException(404, "Not Found");
            }

            AuthorExisting.InputAttributes.Add("class", "form-check-input");
            AuthorNew.InputAttributes.Add("class", "form-check-input");

            Page.ClientScript.RegisterClientScriptBlock(GetType(), $"FileUploadPreview-{Cover.ClientID}",
                $"var FileUploadPreviewInputIds = (FileUploadPreviewInputIds || []).concat('{Cover.ClientID}');" +
                $"var FileUploadPreviewPreviewIds = (FileUploadPreviewPreviewIds || []).concat('{CoverImage.ClientID}');",
                true);

            AuthorChange(Page, EventArgs.Empty);

            if (Page.IsPostBack)
            {
                // TODO: dont validate if not dirty
                FormHelper.ValidateAndHighlight(Page, new[] { AuthorLastName.ID });
                return;
            }

            AuthorSelect.SelectedValue = Book.AuthorId;
            BookTitle.Text = Book.Title;
            ISBN.Text = Book.ISBN;
            ReleaseYear.Text = Book.ReleaseYear.ToString();
            Description.Text = Book.Description;
            if (!string.IsNullOrEmpty(Book.CoverPath))
            {
                CoverImage.ImageUrl = Book.CoverPath;
            }
        }

        protected void AuthorChange(object sender, EventArgs e)
        {
            if (AuthorNew.Checked)
            {
                AuthorSelect.Disabled = true;
                AuthorFirstName.Attributes.Remove("disabled");
                AuthorLastName.Attributes.Remove("disabled");
                AuthorLastNameValidator.Enabled = true;
            }
            else
            {
                AuthorSelect.Disabled = false;
                AuthorFirstName.Attributes.Add("disabled", "disabled");
                AuthorLastName.Attributes.Add("disabled", "disabled");
                AuthorLastNameValidator.Enabled = false;
            }
        }

        protected void CancelButton_OnCommand(object sender, EventArgs e)
        {
            Response.Redirect($"~/books/{Book.Id}");
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

            if (Cover.HasFile)
            {
                var fileName = Guid.NewGuid() + Path.GetExtension(Cover.FileName);
                var coverPath = $"/Files/{fileName}";
                Cover.SaveAs(Server.MapPath(coverPath));
                BooksDataSource.UpdateParameters["CoverPath"].DefaultValue = coverPath;
            }

            BooksDataSource.Update();

            Response.Redirect($"~/books/{Book.Id}");
        }
    }
}