<%@ Control Language="C#" CodeBehind="ReviewCard.ascx.cs" Inherits="BookReviews.Reviews.Components.ReviewCard" %>
<%@ Import Namespace="BookReviews.Auth" %>
<%@ Register TagPrefix="comp" TagName="BookPreview" Src="~/Books/Components/BookPreview.ascx" %>
<%@ Register TagPrefix="comp" TagName="RatingInput" Src="~/Components/RatingInput.ascx" %>
<%@ Register TagPrefix="comp" TagName="ReviewLikes" Src="~/Reviews/Components/ReviewLikes.ascx" %>

<div class="card mb-3 overflow-hidden mh-100 w-100 p-3" style="max-width: 900px; max-height: 360px; height: 360px;">
    <div class="row g-4">
        <div class="col-md-6">
            <a href="/reviews/<%: Review.Id %>" class="text-black link-underline-dark link-underline-opacity-0 link-underline-opacity-100-hover">
                <h5 class="card-title fw-bolder text-truncate"><%: Review.Title %></h5>
            </a>
            <span class="card-subtitle fw-normal">Użytkownik: <%: AuthHelper.GetUserDisplayName(Review?.UserId) %></span>
            <div class="card-text d-flex align-items-center gap-2">
                <span class="text-muted">Ocena:</span>
                <comp:RatingInput runat="server" ID="RatingInput" ReadOnly="true" Value="<%# Review.Rating %>" />
            </div>
        </div>
        <div class="col-md-6">
            <comp:BookPreview runat="server" ID="BookPreview" Book="<%# Book %>" Author="<%# Author %>" Visible="<%# PreviewVisible %>"/>
        </div>
    </div>

    <p class="card-text flex-grow-1 overflow-hidden bottom-fade mt-2" style="white-space: pre;"><%: Review.Content %><%= string.IsNullOrEmpty(Review.Content) ? "<span class='fst-italic'>Brak treści.</span>" : "" %></p>

    <hr/>

    <div class="d-flex">
        <div class="flex-fill"></div>
        <comp:ReviewLikes runat="server" ID="ReviewLikes" ReviewId="<%# Review.Id %>"/>
    </div>

    <%-- <auth:VisibilityControl runat="server" Visibility="HasRole" Role="Admin"> --%>
    <%--     <Content> --%>
    <%--         <a class="btn btn-secondary position-absolute bottom-0 end-0 m-3" href="/books/edit?id=<%: Book.Id %>">Edytuj</a> --%>
    <%--     </Content> --%>
    <%-- </auth:VisibilityControl> --%>
</div>
