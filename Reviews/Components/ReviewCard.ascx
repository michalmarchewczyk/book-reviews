<%@ Control Language="C#" CodeBehind="ReviewCard.ascx.cs" Inherits="BookReviews.Reviews.Components.ReviewCard" %>
<%@ Import Namespace="BookReviews.Auth" %>
<%@ Import Namespace="Microsoft.AspNet.Identity" %>
<%@ Register TagPrefix="comp" TagName="BookPreview" Src="~/Books/Components/BookPreview.ascx" %>
<%@ Register TagPrefix="comp" TagName="RatingInput" Src="~/Components/RatingInput.ascx" %>
<%@ Register TagPrefix="auth" TagName="VisibilityControl" Src="~/Auth/Controls/VisibilityControl.ascx" %>

<div class="card mb-3 overflow-hidden mh-100 w-100 p-3" style="max-width: 900px; max-height: 370px; height: 370px;">
    <div class="row g-4">
        <div class="col-md-6">
            <a href="/reviews/<%: Review.Id %>" class="text-black link-underline-dark link-underline-opacity-0 link-underline-opacity-100-hover">
                <h5 class="card-title fw-bolder text-truncate">
                    <asp:Label
                        runat="server"
                        Visible="<%# Review.UserId == Page.User.Identity.GetUserId() %>"
                        CssClass="badge rounded-pill bg-primary me-1"
                    >
                        Twoja recenzja
                    </asp:Label>
                    <%: Review.Title %>
                </h5>
            </a>
            <span class="card-subtitle fw-normal d-block">Użytkownik: <%: AuthHelper.GetUserDisplayName(Review?.UserId) %></span>
            <span class="card-subtitle fw-normal d-block">Utworzono: <%: Review.CreatedAt %></span>
            <div class="card-text d-flex align-items-center gap-2">
                <span class="text-muted">Ocena:</span>
                <comp:RatingInput runat="server" ID="RatingInput" ReadOnly="true" Value="<%# Review.Rating %>" />
            </div>
        </div>
        <div class="col-md-6">
            <comp:BookPreview runat="server" ID="BookPreview" Book="<%# Book %>" Author="<%# Author %>" Visible="<%# PreviewVisible %>"/>
        </div>
    </div>

    <p class="card-text flex-grow-1 overflow-hidden bottom-fade mt-2 mb-0" style="white-space: break-spaces;"><%: Review.Content %><%= string.IsNullOrEmpty(Review.Content) ? "<span class='fst-italic'>Brak treści.</span>" : "" %></p>

    <hr/>

    <div class="d-flex">
        <auth:VisibilityControl runat="server" Visibility="HasRoleOrOwner" Role="Admin" OwnerId="<%# Review.UserId %>">
            <Content>
                <a href="/reviews/delete?id=<%: Review.Id %>" class="btn btn-danger me-3">Usuń</a>
            </Content>
        </auth:VisibilityControl>
        <auth:VisibilityControl runat="server" Visibility="IsOwner" OwnerId="<%# Review.UserId %>">
            <Content>
                <a href="/reviews/edit?id=<%: Review.Id %>" class="btn btn-secondary">Edytuj</a>
            </Content>
        </auth:VisibilityControl>

        <div class="flex-fill"></div>

        <%-- For some reason ReviewLikes content does update properly when inside paginated ListView -->
        <%-- <comp:ReviewLikes runat="server" ID="ReviewLikes" ReviewId="<%# Review.Id %>"/> --%>
    </div>
</div>
