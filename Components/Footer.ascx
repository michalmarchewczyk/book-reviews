<%@ Control Language="C#" CodeBehind="Footer.ascx.cs" Inherits="BookReviews.Components.Footer" %>
<%@ Register TagPrefix="comp" TagName="Logotype" Src="~/Components/Logotype.ascx" %>


<div class="container">
  <footer class="row row-cols-1 row-cols-sm-2 row-cols-md-5 py-5 my-5 border-top">
    <div class="col mb-3">
      <a href="/" class="d-flex align-items-center mb-3 link-body-emphasis text-decoration-none">
        <comp:Logotype runat="server" />
      </a>
      <p class="text-body-secondary">&copy; <%: DateTime.Now.Year %> Michał Marchewczyk</p>
    </div>

    <div class="col mb-3">

    </div>

    <div class="col mb-3">
      <h5>Recenzje</h5>
      <ul class="nav flex-column">
        <li class="nav-item mb-2"><a href="/reviews/new" class="nav-link p-0 text-body-secondary">Nowe recenzje</a></li>
        <li class="nav-item mb-2"><a href="/reviews/popular" class="nav-link p-0 text-body-secondary">Popularne recenzje</a></li>
        <li class="nav-item mb-2"><a href="/books/popular" class="nav-link p-0 text-body-secondary">Popularne książki</a></li>
      </ul>
    </div>

    <div class="col mb-3">
      <h5>Moje konto</h5>
      <ul class="nav flex-column">
        <li class="nav-item mb-2"><a href="/account" class="nav-link p-0 text-body-secondary">Moje konto</a></li>
        <li class="nav-item mb-2"><a href="/reviews/my" class="nav-link p-0 text-body-secondary">Moje recenzje</a></li>
        <li class="nav-item mb-2"><a href="/auth/logout" class="nav-link p-0 text-body-secondary">Wyloguj się</a></li>
      </ul>
    </div>

    <div class="col mb-3">
      <h5>Informacje</h5>
      <ul class="nav flex-column">
        <li class="nav-item mb-2"><a href="/" class="nav-link p-0 text-body-secondary">Strona główna</a></li>
        <li class="nav-item mb-2"><a href="/about" class="nav-link p-0 text-body-secondary">O nas</a></li>
        <li class="nav-item mb-2"><a href="/terms-of-service" class="nav-link p-0 text-body-secondary">Regulamin</a></li>
      </ul>
    </div>
  </footer>
</div>