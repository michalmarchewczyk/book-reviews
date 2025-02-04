<%@ Page Title="Zarejestruj się" Language="C#" MasterPageFile="~/Auth/AuthPage.master" CodeBehind="Register.aspx.cs" Inherits="BookReviews.Auth.Register" %>
<%@ Register TagPrefix="comp" Namespace="BookReviews.Components.Validators" Assembly="BookReviews" %>

<asp:Content runat="server" ContentPlaceHolderID="MainContent">
    <asp:Label runat="server" class="alert alert-danger" ID="UsernameUnavailableMessage" Visible="False">
        Ta nazwa użytkownika jest już zajęta.
    </asp:Label>
    <asp:Label runat="server" class="alert alert-danger" ID="EmailUnavailableMessage" Visible="False">
        Ten adres email jest już zajęty.
    </asp:Label>
    <asp:Label runat="server" class="alert alert-danger" ID="GenericError" Visible="False">
        Coś poszło nie tak. Spróbuj ponownie.
    </asp:Label>

    <asp:Label runat="server" CssClass="form-label mt-0" AssociatedControlID="Username">Nazwa użytkownika</asp:Label>
    <asp:TextBox ID="Username" runat="server" CssClass="form-control" placeholder="Nazwa użytkownika" />
    <asp:RequiredFieldValidator runat="server" ControlToValidate="Username" EnableClientScript="False" CssClass="invalid-feedback" Display="Dynamic">
        Nazwa użytkownika jest wymagana.
    </asp:RequiredFieldValidator>

    <asp:Label runat="server" CssClass="form-label" AssociatedControlID="FirstName">Imię</asp:Label>
    <asp:TextBox ID="FirstName" runat="server" CssClass="form-control" placeholder="Imię" />

    <asp:Label runat="server" CssClass="form-label" AssociatedControlID="LastName">Nazwisko</asp:Label>
    <asp:TextBox ID="LastName" runat="server" CssClass="form-control" placeholder="Nazwisko" />

    <asp:Label runat="server" CssClass="form-label" AssociatedControlID="Email">Adres email</asp:Label>
    <asp:TextBox ID="Email" runat="server" CssClass="form-control" placeholder="Email" />
    <asp:RequiredFieldValidator runat="server" ControlToValidate="Email" EnableClientScript="False" CssClass="invalid-feedback" Display="Dynamic">
        Email jest wymagany.
    </asp:RequiredFieldValidator>
    <asp:RegularExpressionValidator runat="server" ControlToValidate="Email" EnableClientScript="False" CssClass="invalid-feedback" Display="Dynamic" ValidationExpression="^\S+@\S+\.\S+$">
        Nieprawidłowy adres email.
    </asp:RegularExpressionValidator>

    <asp:Label runat="server" CssClass="form-label" AssociatedControlID="Password">Hasło</asp:Label>
    <asp:TextBox ID="Password" runat="server" CssClass="form-control" placeholder="Hasło" TextMode="Password" />
    <asp:Label runat="server" CssClass="form-text text-muted">
        Co najmniej <%: PasswordMinLength %> znaków
    </asp:Label>
    <asp:RequiredFieldValidator runat="server" ControlToValidate="Password" EnableClientScript="False" CssClass="invalid-feedback" Display="Dynamic">
        Hasło jest wymagane.
    </asp:RequiredFieldValidator>
    <comp:MinLengthValidator runat="server" ControlToValidate="Password" EnableClientScript="False" CssClass="invalid-feedback" Display="Dynamic" ID="MinLengthValidator">
        Minimalna długość hasła to <%: PasswordMinLength %>.
    </comp:MinLengthValidator>

    <asp:Label runat="server" CssClass="form-label" AssociatedControlID="ConfirmPassword">Powtórz hasło</asp:Label>
    <asp:TextBox ID="ConfirmPassword" runat="server" CssClass="form-control" placeholder="Powtórz hasło" TextMode="Password" />
    <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmPassword" EnableClientScript="False" CssClass="invalid-feedback" Display="Dynamic">
        Hasło jest wymagane.
    </asp:RequiredFieldValidator>
    <asp:CompareValidator runat="server" ControlToValidate="ConfirmPassword" ControlToCompare="Password" EnableClientScript="False" CssClass="invalid-feedback" Display="Dynamic" Operator="Equal">
        Hasła nie są takie same.
    </asp:CompareValidator>

    <hr class="opacity-0"/>

    <asp:Button runat="server" CssClass="btn btn-primary mb-2" Text="Zarejestruj się"/>

    <hr/>
    <asp:Label runat="server" CssClass="text-center mb-2">Masz już konto?</asp:Label>
    <a
        href="/auth/login<%: Request.QueryString.HasKeys() ? "?" + Request.QueryString : "" %>"
        class="btn btn-secondary">
        Zaloguj się
    </a>
</asp:Content>