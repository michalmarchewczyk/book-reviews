<%@ Page Title="Błąd" Language="C#" MasterPageFile="~/Main.master" CodeBehind="GenericError.aspx.cs" Inherits="BookReviews.Errors.GenericError" %>

<asp:Content runat="server" ContentPlaceHolderID="MainContent">
    <section class="d-flex flex-column align-items-center justify-content-center my-5 py-5">
        <span class="display-6 py-5 d-block fw-normal">
            Wystąpił błąd. Spróbuj ponownie później.
        </span>
        <a href="/" class="btn btn-primary">Powrót do strony głównej</a>
    </section>
</asp:Content>