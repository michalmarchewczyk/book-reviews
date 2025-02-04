<%@ Control Language="C#" CodeBehind="BookCard.ascx.cs" Inherits="BookReviews.Books.Components.BookCard" %>
<%@ Register TagPrefix="auth" TagName="VisibilityControl" Src="~/Auth/Controls/VisibilityControl.ascx" %>

<div class="card mb-3 overflow-hidden row g-0 mh-100 w-100 comp-BookCard-card">
    <a href="/books/<%: Book.Id %>" class="col-sm-3 align-items-center h-100 ps-3 ps-lg-0 d-none d-sm-flex">
        <asp:Image runat="server" CssClass="img-fluid rounded mh-100 img-cover" ID="CoverImage" ImageUrl="/Content/cover_default.png"/>
    </a>
    <div class="col-sm-9 card-body d-flex flex-column h-100">
        <a href="/books/<%: Book.Id %>" class="text-black link-underline-dark link-underline-opacity-0 link-underline-opacity-100-hover">
            <h5 class="card-title fw-bolder"><%: Book.Title %></h5>
        </a>
        <span class="card-subtitle fw-normal"><%: Author.FirstName + " " + Author.LastName %> (rok wydania: <%: Book.ReleaseYear %>)</span>
        <p class="card-text flex-grow-1 overflow-hidden bottom-fade mt-2 text-break text-break-spaces"><%: Book.Description %><%= string.IsNullOrEmpty(Book.Description) ? "<span class='fst-italic'>Brak opisu.</span>" : "" %></p>
        <auth:VisibilityControl runat="server" Visibility="HasRole" Role="Admin">
            <Content>
                <div class="position-absolute bottom-0 end-0 m-3">
                    <a class="btn btn-secondary me-3" href="/books/edit?id=<%: Book.Id %>">Edytuj</a>
                    <a class="btn btn-danger" href="/books/delete?id=<%: Book.Id %>">Usuń</a>
                </div>
            </Content>
        </auth:VisibilityControl>
        <p class="card-text"><span class="text-muted">Średnia ocena: </span><span class="fs-5"><%: Book.AverageRating == null ? "brak recenzji" : ((double)Book.AverageRating).ToString("F2") %></span></p>
    </div>
</div>