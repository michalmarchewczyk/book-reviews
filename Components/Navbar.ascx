<%@ Control Language="C#" CodeBehind="Navbar.ascx.cs" Inherits="BookReviews.Components.Navbar" %>
<%@ Register TagPrefix="comp" TagName="Logotype" Src="~/Components/Logotype.ascx" %>

<nav class="navbar navbar-expand-lg bg-light" data-bs-theme="light">
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
          <a class="nav-link <%: Request.RawUrl == "/books/" ? "active" : "" %>" href="/books">Książki</a>
        </li>
        <li class="nav-item">
          <a class="nav-link <%: Request.RawUrl == "/reviews/" ? "active" : "" %>" href="/reviews">Recenzje</a>
        </li>
      </ul>
      <a href="/auth/register" class="btn btn-primary me-2">Dołącz</a>
      <a href="/auth/login" class="btn btn-secondary">Zaloguj się</a>
      <%-- <form class="d-flex"> --%>
      <%--   <input class="form-control me-sm-2" type="search" placeholder="Search"> --%>
      <%--   <button class="btn btn-secondary my-2 my-sm-0" type="submit">Search</button> --%>
      <%-- </form> --%>
    </div>
  </div>
</nav>