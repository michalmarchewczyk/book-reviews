<%@ Page Title="Konto" Language="C#" MasterPageFile="~/Main.master" CodeBehind="Default.aspx.cs" Inherits="BookReviews.Account.Default" %>
<%@ Register TagPrefix="comp" Namespace="BookReviews.Components.Validators" Assembly="BookReviews" %>

<asp:Content runat="server" ContentPlaceHolderID="MainContent">
    <div class="card mx-auto">
        <div class="card-header">
            <h3>
                Moje konto
            </h3>
            <ul class="nav nav-tabs card-header-tabs">
              <li class="nav-item">
                <asp:LinkButton CssClass="nav-link active" runat="server" OnCommand="ChangeView" CommandArgument="Details" ID="DetailsLink">Edytuj dane</asp:LinkButton>
              </li>
              <li class="nav-item">
                <asp:LinkButton CssClass="nav-link" runat="server" OnCommand="ChangeView" CommandArgument="Password" ID="PasswordLink">Zmień hasło</asp:LinkButton>
              </li>
              <li class="nav-item">
                <a class="nav-link" href="/reviews/my">Moje recenzje<i class="bi bi-box-arrow-up-right ms-2"></i></a>
              </li>
            </ul>
        </div>
        <div class="card-body">
            <asp:MultiView runat="server" ID="AccountMultiView" ActiveViewIndex="0">
                <asp:View runat="server" ID="ViewDetails">
                    <div class="row gx-3">
                        <div class="col-12">
                            <asp:Label runat="server" class="alert alert-danger d-block" ID="EmailUnavailableMessage" Visible="False">
                                Ten adres email jest już zajęty.
                            </asp:Label>
                            <asp:Label runat="server" class="alert alert-danger d-block" ID="GenericErrorDetails" Visible="False">
                                Coś poszło nie tak. Spróbuj ponownie.
                            </asp:Label>
                            <asp:Label runat="server" class="alert alert-success d-block" ID="SuccessDetails" Visible="False">
                                Dane zostały zapisane.
                            </asp:Label>
                        </div>

                        <div class="col-md-6">
                            <asp:Label runat="server" CssClass="form-label mt-0" AssociatedControlID="FirstName">Imię</asp:Label>
                            <asp:TextBox ID="FirstName" runat="server" CssClass="form-control" placeholder="Twoje imię"/>
                        </div>
                        <div class="col-md-6">
                            <asp:Label runat="server" CssClass="form-label mt-0" AssociatedControlID="LastName">Nazwisko</asp:Label>
                            <asp:TextBox ID="LastName" runat="server" CssClass="form-control" placeholder="Twoje nazwisko"/>
                        </div>
                    </div>
                    <div class="row gx-3 mt-3">
                        <div class="col-md-4">
                            <asp:Label runat="server" CssClass="form-label mt-0" AssociatedControlID="UserName">Nazwa użytkownika</asp:Label>
                            <asp:TextBox ID="UserName" runat="server" CssClass="form-control" placeholder="Nazwa użytkownika" Disabled="true"/>
                        </div>
                        <div class="col-md-8">
                            <asp:Label runat="server" CssClass="form-label mt-0" AssociatedControlID="Email">Email</asp:Label>
                            <asp:TextBox ID="Email" runat="server" CssClass="form-control" placeholder="Twój adres email"/>
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="Email" EnableClientScript="False" CssClass="invalid-feedback" Display="Dynamic">
                                Email jest wymagany.
                            </asp:RequiredFieldValidator>
                            <asp:RegularExpressionValidator runat="server" ControlToValidate="Email" EnableClientScript="False" CssClass="invalid-feedback" Display="Dynamic" ValidationExpression="^\S+@\S+\.\S+$">
                                Nieprawidłowy adres email.
                            </asp:RegularExpressionValidator>
                        </div>
                    </div>

                    <div class="d-flex justify-content-end mt-4">
                        <asp:Button runat="server" ID="SubmitButtonDetails" Text="Zapisz" CssClass="btn btn-primary" OnCommand="SubmitDetails"/>
                    </div>
                </asp:View>
                <asp:View runat="server" ID="ViewPassword">
                    <div class="d-flex flex-column">
                        <asp:Label runat="server" class="alert alert-danger" ID="WrongPasswordMessage" Visible="False">
                            Nieprawidłowe hasło.
                        </asp:Label>
                        <asp:Label runat="server" class="alert alert-danger" ID="GenericErrorPassword" Visible="False">
                            Coś poszło nie tak. Spróbuj ponownie.
                        </asp:Label>
                        <asp:Label runat="server" class="alert alert-success" ID="SuccessPassword" Visible="False">
                            Hasło zostało zmienione.
                        </asp:Label>

                        <asp:Label runat="server" CssClass="form-label mt-0" AssociatedControlID="OldPassword">Stare hasło</asp:Label>
                        <asp:TextBox ID="OldPassword" runat="server" CssClass="form-control" placeholder="Stare hasło" TextMode="Password" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="OldPassword" EnableClientScript="False" CssClass="invalid-feedback" Display="Dynamic">
                            Stare hasło jest wymagane.
                        </asp:RequiredFieldValidator>

                        <asp:Label runat="server" CssClass="form-label" AssociatedControlID="Password">Nowe hasło</asp:Label>
                        <asp:TextBox ID="Password" runat="server" CssClass="form-control" placeholder="Nowe hasło" TextMode="Password" />
                        <asp:Label runat="server" CssClass="form-text text-muted">
                            Co najmniej <%: PasswordMinLength %> znaków
                        </asp:Label>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="Password" EnableClientScript="False" CssClass="invalid-feedback" Display="Dynamic">
                            Hasło jest wymagane.
                        </asp:RequiredFieldValidator>
                        <comp:MinLengthValidator runat="server" ControlToValidate="Password" EnableClientScript="False" CssClass="invalid-feedback" Display="Dynamic" ID="MinLengthValidator">
                            Minimalna długość hasła to <%: PasswordMinLength %>.
                        </comp:MinLengthValidator>

                        <asp:Label runat="server" CssClass="form-label" AssociatedControlID="ConfirmPassword">Powtórz nowe hasło</asp:Label>
                        <asp:TextBox ID="ConfirmPassword" runat="server" CssClass="form-control" placeholder="Powtórz nowe hasło" TextMode="Password" />
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="ConfirmPassword" EnableClientScript="False" CssClass="invalid-feedback" Display="Dynamic">
                            Hasło jest wymagane.
                        </asp:RequiredFieldValidator>
                        <asp:CompareValidator runat="server" ControlToValidate="ConfirmPassword" ControlToCompare="Password" EnableClientScript="False" CssClass="invalid-feedback" Display="Dynamic" Operator="Equal">
                            Hasła nie są takie same.
                        </asp:CompareValidator>

                        <div class="d-flex justify-content-end mt-4">
                            <asp:Button runat="server" ID="SubmitButtonPassword" Text="Zapisz" CssClass="btn btn-primary" OnCommand="SubmitPassword"/>
                        </div>
                    </div>
                </asp:View>
            </asp:MultiView>
        </div>
    </div>
</asp:Content>