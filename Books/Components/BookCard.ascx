<%@ Control Language="C#" CodeBehind="BookCard.ascx.cs" Inherits="BookReviews.Books.Components.BookCard" %>
<%@ Register TagPrefix="auth" TagName="VisibilityControl" Src="~/Auth/Controls/VisibilityControl.ascx" %>

<div class="card mb-3 overflow-hidden row g-0 mh-100 w-100" style="max-width: 780px; max-height: 263px; height: 263px;"%>
    <div class="col-sm-3 align-items-center h-100 ps-3 ps-lg-0 d-none d-sm-flex">
        <asp:Image runat="server" CssClass="img-fluid rounded" style="max-height: 280px; aspect-ratio: 17 / 24;" ID="CoverImage" ImageUrl="/Content/cover_default.png" />
    </div>
    <div class="col-sm-9 card-body d-flex flex-column h-100">
        <h5 class="card-title fw-bolder"><%: Book.Title %></h5>
        <span class="card-subtitle fw-normal"><%: Author.FirstName + " " + Author.LastName %> (rok wydania: <%: Book.ReleaseYear %>)</span>
        <p class="card-text flex-grow-1 overflow-hidden bottom-fade mt-2">
            <%: Book.Description %>
            <%= string.IsNullOrEmpty(Book.Description) ? "<span class='fst-italic'>Brak opisu.</span>" : "" %>
        </p>
        <auth:VisibilityControl runat="server" Visibility="HasRole" Role="Admin">
            <Content>
                <a class="btn btn-secondary position-absolute bottom-0 end-0 m-3" href="/books/edit?id=<%: Book.Id %>">Edytuj</a>
            </Content>
        </auth:VisibilityControl>
        <p class="card-text"><small class="text-muted">Średnia ocena:</small></p>
    </div>
</div>