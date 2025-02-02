<%@ Page Title="Title" Language="C#" MasterPageFile="~/Main.master" CodeBehind="BookPage.aspx.cs" Inherits="BookReviews.Books.BookPage" %>
<%@ Register TagPrefix="auth" TagName="VisibilityControl" Src="~/Auth/Controls/VisibilityControl.ascx" %>
<%@ Register TagPrefix="comp" TagName="ReviewsList" Src="~/Reviews/Components/ReviewsList.ascx" %>

<asp:Content runat="server" ContentPlaceHolderID="MainContent">
    <div class="row">
        <div class="col-md-3">
            <asp:Image runat="server" CssClass="img-fluid rounded w-100 border" ID="CoverImage"  style="aspect-ratio: 17 / 24;" ImageUrl="/Content/cover_default.png"/>
        </div>
        <div class="col-md-9">
            <div class="d-flex align-items-center">
                <h2 class="mb-0">
                    <span class="text-muted">Książka</span> <span class="fst-italic fw-bolder"><%: Book.Title %></span>
                </h2>
                <div class="flex-fill"></div>
                <auth:VisibilityControl runat="server" Visibility="HasRole" Role="Admin">
                    <Content>
                        <a class="btn btn-secondary ms-3" href="/books/edit?id=<%: Book.Id %>">Edytuj</a>
                        <a class="btn btn-danger ms-3" href="/books/delete?id=<%: Book.Id %>">Usuń</a>
                    </Content>
                </auth:VisibilityControl>
            </div>
            <hr/>

            <div class="d-flex flex-column">
                <h4><%: Author.FirstName + " " + Author.LastName %></h4>
                <span><span class="text-muted">Rok wydania: </span> <%: Book.ReleaseYear %></span>
                <span><span class="text-muted">Numer ISBN: </span><%: Book.ISBN %></span>
                <span class="text-muted">Opis:</span>
                <p style="white-space: pre;" class="fs-5 text-break overflow-hidden"><%: Book.Description %><%= string.IsNullOrEmpty(Book.Description) ? "<span class='fst-italic'>Brak opisu.</span>" : "" %></p>
                <span class="text-muted">Średnia ocena: </span><span class="fs-5"><%: Book.AverageRating == null ? "brak recenzji" : ((double)Book.AverageRating).ToString("F2") %></span>
            </div>

        </div>
    </div>
    <div class="mt-5 d-flex align-items-center">
        <h4 class="mb-0 me-4">Recenzje (<%: ReviewsList.Count.ToString() %>)</h4>
        <asp:HyperLink runat="server" Text="Dodaj recenzję" ID="AddReviewButton" CssClass="btn btn-primary"></asp:HyperLink>
        <asp:HyperLink runat="server" Text="Zobacz swoją recenzję" ID="ViewReviewButton" CssClass="btn btn-secondary"></asp:HyperLink>
        <div class="flex-fill"></div>
        <asp:DropDownList
            runat="server"
            OnSelectedIndexChanged="ReviewsListSortingChanged"
            CssClass="form-select w-auto"
            ID="ReviewsListSorting"
            AutoPostBack="true">
            <asp:ListItem Value="Title_ASC">Tytuł (A-Z)</asp:ListItem>
            <asp:ListItem Value="Title_DESC">Tytuł (Z-A)</asp:ListItem>
        </asp:DropDownList>
    </div>
    <hr/>

    <comp:ReviewsList runat="server" ID="ReviewsList" />



    <asp:SqlDataSource
        ID="BooksDataSource"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT
            b.[Id], b.[Title], b.[AuthorId], b.[Description], b.[ISBN], b.[CoverPath], b.[ReleaseYear],
            a.[FirstName] AS AuthorFirstName, a.[LastName] AS AuthorLastName,
            r.[Id] as ReviewId,
            (SELECT AVG(Cast(r.[Rating] as Float)) FROM [Reviews] r WHERE r.[BookId] = b.[Id]) AS AverageRating
            FROM [Books] b
            LEFT JOIN [Authors] a ON b.AuthorId = a.Id
            LEFT JOIN [Reviews] r ON r.BookId = b.Id AND r.UserId = @UserId
            WHERE b.[Id] = @Id"
    >
        <SelectParameters>
            <asp:Parameter Name="Id" Type="Int32" />
            <asp:Parameter Name="UserId" Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
</asp:Content>