<%@ Control Language="C#" CodeBehind="Navbar.ascx.cs" Inherits="BookReviews.Components.Layout.Navbar" %>
<%@ Import Namespace="BookReviews.Auth" %>
<%@ Register TagPrefix="comp" TagName="Logotype" Src="~/Components/Layout/Logotype.ascx" %>
<%@ Register TagPrefix="auth" TagName="VisibilityControl" Src="~/Auth/Controls/VisibilityControl.ascx" %>
<%@ Register TagPrefix="comp" TagName="UserImage" Src="~/Components/Layout/UserImage.ascx" %>

<nav class="navbar navbar-expand-lg bg-light sticky-top" data-bs-theme="light">
    <div class="container px-4">
        <a class="navbar-brand" href="/"><comp:Logotype runat="server"/></a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#main-navbar" aria-controls="main-navbar" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="main-navbar">
        <ul class="navbar-nav me-auto mb-4 mb-lg-0">
            <li class="nav-item">
                <a class="nav-link <%: Request.RawUrl == "/" ? "active" : "" %>" href="/">Strona główna</a>
            </li>
            <li class="nav-item">
                <a class="nav-link <%: Request.RawUrl.StartsWith("/books/") ? "active" : "" %>" href="/books">Książki</a>
            </li>
            <li class="nav-item">
                <a class="nav-link <%: Request.RawUrl.StartsWith("/reviews/") ? "active" : "" %>" href="/reviews">Recenzje</a>
            </li>
            <auth:VisibilityControl runat="server" Visibility="HasRole" Role="Admin">
                <Content>
                    <li class="nav-item">
                        <a class="nav-link <%: Request.RawUrl.StartsWith("/admin/") ? "active" : "" %>" href="/admin">Panel administracyjny</a>
                    </li>
                </Content>
            </auth:VisibilityControl>
        </ul>

        <auth:VisibilityControl runat="server" Visibility="Authenticated">
            <Content>
                <div class="nav-item dropdown">
                  <a class="nav-link dropdown-toggle" data-bs-toggle="dropdown" href="#">
                      <comp:UserImage runat="server" Size="0.45"/>
                      <span class="ms-2"><%: AuthHelper.GetCurrentUserDisplayName(Page) %></span>
                  </a>
                  <div class="dropdown-menu dropdown-menu-end">
                    <a class="dropdown-item" href="/account">Moje konto</a>
                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="/auth/logout">Wyloguj się</a>
                  </div>
                </div>

            </Content>
        </auth:VisibilityControl>
        <auth:VisibilityControl runat="server" Visibility="NotAuthenticated">
            <Content>
                <a href="/auth/register" class="btn btn-primary me-2">Dołącz</a>
                <a href="/auth/login" class="btn btn-secondary">Zaloguj się</a>
            </Content>
        </auth:VisibilityControl>
        <%-- <form class="d-flex"> --%>
        <%--   <input class="form-control me-sm-2" type="search" placeholder="Search"> --%>
        <%--   <button class="btn btn-secondary my-2 my-sm-0" type="submit">Search</button> --%>
        <%-- </form> --%>
        </div>
    </div>
</nav>