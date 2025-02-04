<%@ Control Language="C#" CodeBehind="Footer.ascx.cs" Inherits="BookReviews.Components.Layout.Footer" %>
<%@ Register TagPrefix="comp" TagName="Logotype" Src="~/Components/Layout/Logotype.ascx" %>


<footer class="container row row-cols-1 row-cols-sm-2 row-cols-md-5 py-5 mt-5 border-top">
    <section class="col mb-3">
        <a href="/" class="d-flex align-items-center mb-3 link-body-emphasis text-decoration-none">
            <comp:Logotype runat="server" />
        </a>
        <p class="text-body-secondary">&copy; <%: DateTime.Now.Year %> Michał Marchewczyk</p>
    </section>

    <section class="col mb-3">

    </section>

    <section class="col mb-3">
        <h5>Recenzje</h5>
        <ul class="nav flex-column">
            <li class="nav-item mb-2"><a href="/reviews/" class="nav-link p-0 text-body-secondary">Lista recenzji</a></li>
            <li class="nav-item mb-2"><a href="/books/" class="nav-link p-0 text-body-secondary">Lista książek</a></li>
        </ul>
    </section>

    <section class="col mb-3">
        <h5>Moje konto</h5>
        <ul class="nav flex-column">
            <li class="nav-item mb-2"><a href="/account" class="nav-link p-0 text-body-secondary">Moje konto</a></li>
            <li class="nav-item mb-2"><a href="/reviews/my" class="nav-link p-0 text-body-secondary">Moje recenzje</a></li>
            <li class="nav-item mb-2"><a href="/auth/logout" class="nav-link p-0 text-body-secondary">Wyloguj się</a></li>
        </ul>
    </section>

    <section class="col mb-3">
        <h5>Informacje</h5>
        <ul class="nav flex-column">
            <li class="nav-item mb-2"><a href="/" class="nav-link p-0 text-body-secondary">Strona główna</a></li>
            <li class="nav-item mb-2"><a href="/about" class="nav-link p-0 text-body-secondary">O nas</a></li>
            <li class="nav-item mb-2"><a href="/termsofservice" class="nav-link p-0 text-body-secondary">Regulamin</a></li>
        </ul>
    </section>
</footer>