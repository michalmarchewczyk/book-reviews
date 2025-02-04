<%@ Page Title="Title" Language="C#" MasterPageFile="~/Main.master" CodeBehind="ReviewPage.aspx.cs" Inherits="BookReviews.Reviews.ReviewPage" %>
<%@ Import Namespace="BookReviews.Auth" %>
<%@ Register TagPrefix="comp" TagName="BookPreview" Src="~/Books/Components/BookPreview.ascx" %>
<%@ Register TagPrefix="comp" TagName="RatingInput" Src="~/Components/RatingInput.ascx" %>
<%@ Register TagPrefix="comp" TagName="ReviewLikes" Src="~/Reviews/Components/ReviewLikes.ascx" %>
<%@ Register TagPrefix="auth" TagName="VisibilityControl" Src="~/Auth/Controls/VisibilityControl.ascx" %>

<asp:Content runat="server" ContentPlaceHolderID="MainContent">
    <div class="d-flex align-items-center">
        <comp:ReviewLikes runat="server" ID="ReviewLikes"/>
        <h2 class="mb-0 ms-3">
            <span class="text-muted">Recenzja</span> <span class="fst-italic fw-bolder"><%: Review.Title %></span>
        </h2>
        <div class="flex-fill"></div>
        <auth:VisibilityControl runat="server" Visibility="HasRoleOrOwner" Role="Admin" ID="VisibilityControl1">
            <Content>
                <a href="/reviews/delete?id=<%: Review.Id %>" class="btn btn-danger me-3">Usuń</a>
            </Content>
        </auth:VisibilityControl>
        <auth:VisibilityControl runat="server" Visibility="IsOwner" ID="VisibilityControl2">
            <Content>
                <a href="/reviews/edit?id=<%: Review.Id %>" class="btn btn-secondary">Edytuj</a>
            </Content>
        </auth:VisibilityControl>
    </div>

    <hr/>
    <div class="row g-5 mb-2">
        <div class="col-md-7">
            <span class="d-inline-block mb-2">Dla książki:</span>
            <comp:BookPreview runat="server" ID="BookPreview" />
        </div>
        <div class="col-md-5">
            <span class="d-block mb-1 fs-5">Użytkownik: <%: AuthHelper.GetUserDisplayName(Review.UserId) %></span>
            <span class="d-block mb-1">Utworzono: <%: Review.CreatedAt %></span>
            <span class="text-muted">Ocena:</span>
            <comp:RatingInput runat="server" ID="RatingInput" ReadOnly="true" />
        </div>
    </div>
    <span class="d-block text-muted mb-2">Treść:</span>
    <p style="white-space: break-spaces;" class="fs-5"><%: Review.Content %></p>


    <asp:SqlDataSource
        ID="ReviewsDataSource"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT
        r.[Id], r.[Title], r.[Content], r.[UserId], r.[BookId], r.[Rating], r.[CreatedAt],
        b.[Id] AS BookId, b.[Title] AS BookTitle, b.[Description] AS BookDescription, b.[ISBN] AS BookISBN,
        b.[ReleaseYear] AS BookReleaseYear, b.[CoverPath] AS BookCoverPath, b.[AuthorId] AS BookAuthorId,
        a.[Id] AS AuthorId, a.[FirstName] AS AuthorFirstName, a.[LastName] AS AuthorLastName
        FROM [Reviews] r
        LEFT JOIN [Books] b ON r.BookId = b.Id
        LEFT JOIN [Authors] a ON b.AuthorId = a.Id WHERE r.[Id] = @Id"
    >
        <SelectParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>