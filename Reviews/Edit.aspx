<%@ Page Title="Title" Language="C#" MasterPageFile="~/Main.master" CodeBehind="Edit.aspx.cs" Inherits="BookReviews.Reviews.Edit" %>

<%@ Register TagPrefix="comp" TagName="BookPreview" Src="~/Books/Components/BookPreview.ascx" %>
<%@ Register TagPrefix="comp" TagName="RatingInput" Src="~/Components/RatingInput.ascx" %>

<asp:Content runat="server" ContentPlaceHolderID="MainContent">
    <div class="card mx-auto">
        <h3 class="card-header">
            Edytuj recenzję
        </h3>
        <div class="card-body">
            <div class="row g-5">
                <div class="col-md-7">
                    <span class="d-inline-block mb-1">Edytujesz recenzję dla książki:</span>
                    <comp:BookPreview runat="server" ID="BookPreview" />
                </div>
                <div class="col-md-5">
                    <span class="d-inline-block mb-1">Twoja ocena:</span>
                    <comp:RatingInput runat="server" ID="RatingInput" Value="5" MaxRating="5"/>
                </div>
            </div>

            <asp:Label runat="server" CssClass="form-label mt-0" AssociatedControlID="ReviewTitle">Tytuł recenzji</asp:Label>
            <asp:TextBox ID="ReviewTitle" runat="server" CssClass="form-control" placeholder="Tytuł" />
            <asp:RequiredFieldValidator runat="server" ControlToValidate="ReviewTitle" EnableClientScript="False" CssClass="invalid-feedback" Display="Dynamic">
                Tytuł jest wymagany.
            </asp:RequiredFieldValidator>

            <asp:Label runat="server" CssClass="form-label" AssociatedControlID="ReviewContent">Treść recenzji</asp:Label>
            <asp:TextBox ID="ReviewContent" runat="server" CssClass="form-control" placeholder="Treść" TextMode="MultiLine" Rows="8"/>

            <div class="d-flex justify-content-between mt-4">
                <asp:Button runat="server" ID="CancelButton" Text="Anuluj" CssClass="btn btn-warning" OnCommand="CancelButton_OnCommand"/>
                <asp:Button runat="server" ID="SubmitButton" Text="Zapisz" CssClass="btn btn-primary" OnCommand="Submit"/>
            </div>
        </div>
    </div>




    <asp:SqlDataSource
        ID="BooksDataSource"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT
            b.[Id], b.[Title], b.[AuthorId], b.[Description], b.[ISBN], b.[CoverPath], b.[ReleaseYear],
            a.[FirstName] AS AuthorFirstName, a.[LastName] AS AuthorLastName
            FROM [Books] b LEFT JOIN [Authors] a ON b.AuthorId = a.Id WHERE b.[Id] = @Id"
    >
        <SelectParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
    <asp:SqlDataSource
        ID="ReviewsDataSource"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT [Id], [UserId], [BookId], [Title], [Rating], [Content], [CreatedAt] FROM [Reviews] WHERE [Id] = @Id"
        UpdateCommand="UPDATE [Reviews] SET [Title] = @Title, [Rating] = @Rating, [Content] = @Content WHERE [Id] = @Id">
        <SelectParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Title" Type="String" />
            <asp:Parameter Name="Rating" Type="Int32" />
            <asp:Parameter Name="Content" Type="String" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>
</asp:Content>