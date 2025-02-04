<%@ Page Title="Zaloguj się" Language="C#" MasterPageFile="~/Auth/AuthPage.Master" CodeBehind="Login.aspx.cs" Inherits="BookReviews.Auth.Login" %>

<asp:Content runat="server" ContentPlaceHolderID="MainContent">
    <asp:Label runat="server" CssClass="alert alert-secondary" ID="ReturnUrlInfo" Visible="False">
        Zaloguj się, aby kontynuować.
    </asp:Label>
    <asp:Label runat="server" CssClass="alert alert-secondary" ID="LogoutMessage" Visible="False">
        Wylogowano.
    </asp:Label>

    <asp:Label runat="server" CssClass="alert alert-danger" ID="InvalidCredentialsMessage" Visible="False">
        Nieprawidłowa nazwa użytkownika lub hasło.
    </asp:Label>

    <asp:Label runat="server" CssClass="form-label mt-0" AssociatedControlID="Username">Nazwa użytkownika</asp:Label>
    <asp:TextBox ID="Username" runat="server" CssClass="form-control" placeholder="Nazwa użytkownika" />
    <asp:RequiredFieldValidator runat="server" ControlToValidate="Username" EnableClientScript="False" CssClass="invalid-feedback" Display="Dynamic">
        Nazwa użytkownika jest wymagana.
    </asp:RequiredFieldValidator>

    <asp:Label runat="server" CssClass="form-label" AssociatedControlID="Password">Hasło</asp:Label>
    <asp:TextBox ID="Password" runat="server" CssClass="form-control" placeholder="Hasło" TextMode="Password" />
    <asp:RequiredFieldValidator runat="server" ControlToValidate="Password" EnableClientScript="False" CssClass="invalid-feedback" Display="Dynamic">
        Hasło jest wymagane.
    </asp:RequiredFieldValidator>

    <hr class="opacity-0"/>

    <asp:Button runat="server" CssClass="btn btn-primary mb-2" Text="Zaloguj się"/>

    <hr/>
    <asp:Label runat="server" CssClass="text-center mb-2">Nie masz jeszcze konta?</asp:Label>
    <a
        href="/auth/register<%: Request.QueryString.HasKeys() ? "?" + Request.QueryString : "" %>"
        class="btn btn-secondary">
        Zarejestruj się
    </a>
</asp:Content>