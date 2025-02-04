<%@ Control Language="C#" CodeBehind="Hero.ascx.cs" Inherits="BookReviews.Components.Hero" %>
<%@ Register TagPrefix="comp" TagName="Logotype" Src="~/Components/Layout/Logotype.ascx" %>


<header class="px-4 pt-5 my-5 text-center border-bottom pb-5 pb-md-0">
    <h1 class="display-4 fw-bold text-body-emphasis"><comp:Logotype runat="server" Size="2"/></h1>
    <section class="col-lg-6 mx-auto mb-5">
        <p class="lead mb-4">
        Tysiące wiarygodnych recenzji książek. <br/> Dołącz do naszej społeczności już dziś!
        </p>
        <nav class="d-grid gap-2 d-sm-flex justify-content-sm-center mb-5 mt-5">
            <a href="/auth/register" class="btn btn-primary btn-lg px-4 me-sm-3">Dołącz</a>
            <a href="/auth/login" class="btn btn-secondary btn-lg px-4">Zaloguj się</a>
        </nav>
    </section>
    <aside class="overflow-hidden mt-5 pt-5 d-none d-md-block comp-Hero-image">
        <div class="container px-5">
            <img src="/Content/Screenshot.png" class="img-fluid border rounded-3 shadow-lg mb-4" alt="" width="700" height="500" loading="lazy">
        </div>
    </aside>
</header>