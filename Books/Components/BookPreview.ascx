<%@ Control Language="C#" CodeBehind="BookPreview.ascx.cs" Inherits="BookReviews.Books.Components.BookPreview" %>

<div class="card mb-3 overflow-hidden mh-100 w-100 d-flex gap-2 flex-row" style="max-height: 93px; height: 93px;">
    <a href="/books/<%: Book.Id %>" class="align-items-center h-100 ps-3 ps-lg-0 d-none d-sm-flex">
        <asp:Image runat="server" CssClass="img-fluid rounded" style="max-height: 100%; aspect-ratio: 17 / 24;" ID="CoverImage" ImageUrl="/Content/cover_default.png"/>
    </a>
    <div class="card-body d-flex flex-column h-100">
        <a href="/books/<%: Book.Id %>" class="text-black link-underline-dark link-underline-opacity-0 link-underline-opacity-100-hover">
            <h5 class="card-title fw-bolder text-truncate"><%: Book.Title %></h5>
        </a>
        <span class="card-subtitle fw-normal text-truncate"><%: Author.FirstName + " " + Author.LastName %> (<%: Book.ReleaseYear %>)</span>
    </div>
</div>
