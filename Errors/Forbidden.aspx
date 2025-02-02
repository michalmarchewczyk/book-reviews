<%@ Page Title="Title" Language="C#" MasterPageFile="~/Main.master" CodeBehind="Forbidden.aspx.cs" Inherits="BookReviews.Errors.Forbidden" %>

<asp:Content runat="server" ContentPlaceHolderID="MainContent">
    <div class="d-flex flex-column align-items-center justify-content-center my-5 py-5">
        <span class="display-6 py-5 d-block fw-normal">
            Nie masz dostępu do tej strony.
        </span>
        <a href="/" class="btn btn-primary">Powrót do strony głównej</a>
    </div>
</asp:Content>