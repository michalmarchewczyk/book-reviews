<%@ Page Title="Title" Language="C#" MasterPageFile="~/Main.master" CodeBehind="Delete.aspx.cs" Inherits="BookReviews.Reviews.Delete" %>
<%@ Import Namespace="BookReviews.Auth" %>
<%@ Import Namespace="Microsoft.AspNet.Identity" %>
<%@ Register TagPrefix="comp" TagName="BookPreview" Src="~/Books/Components/BookPreview.ascx" %>


<asp:Content runat="server" ContentPlaceHolderID="MainContent" xmlns:asp="http://www.w3.org/1999/html">
    <div class="card mx-auto">
        <h3 class="card-header">
            Usuń recenzję
        </h3>
        <div class="card-body">
            <div class="row g-5">
                <div class="col-md-7">
                    <span class="d-inline-block mb-1">Usuwasz recenzję dla książki:</span>
                    <comp:BookPreview runat="server" ID="BookPreview" />
                </div>
            </div>


            <p class="fs-5">
                Usuwasz recenzję
                <asp:Label runat="server" CssClass="fst-italic fw-bolder"><%: Review.Title %></asp:Label>
                <asp:Label runat="server"><%: Review.UserId == Page.User.Identity.GetUserId() ? "" : "użytkownika " + AuthHelper.GetUserDisplayName(Review.UserId) %></asp:Label>
                <br/>
                Wszystkie polubienia recenzji także zostaną usunięte. <br/>
                Usunięcie recenzji jest nieodwracalne. Czy na pewno chcesz kontynuować?
            </p>

            <div class="d-flex justify-content-between mt-4">
                <asp:Button runat="server" ID="CancelButton" Text="Anuluj" CssClass="btn btn-warning" OnCommand="CancelButton_OnCommand"/>
                <asp:Button runat="server" ID="SubmitButton" Text="Usuń" CssClass="btn btn-danger" OnCommand="Submit"/>
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
        SelectCommand="SELECT [Id], [UserId], [BookId], [Title], [Rating], [Content] FROM [Reviews] WHERE [Id] = @Id"
        DeleteCommand="DELETE FROM [Reviews] WHERE [Id] = @Id"
    >
        <SelectParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>
</asp:Content>