<%@ Page Title="Dodaj książkę" Language="C#" MasterPageFile="~/Main.master" CodeBehind="Add.aspx.cs" Inherits="BookReviews.Books.Add" %>
<%@ Register TagPrefix="comp" TagName="AuthorSelect" Src="~/Authors/Components/AuthorSelect.ascx" %>
<%@ Register TagPrefix="comp" Namespace="BookReviews.Components.Validators" Assembly="BookReviews" %>

<asp:Content runat="server" ContentPlaceHolderID="MainContent">
    <div class="card mx-auto">
        <h3 class="card-header">
            Dodaj książkę
        </h3>
        <div class="row card-body">
            <div class="col-md-4 d-flex flex-column align-items-center mb-4">
                <asp:Image runat="server" ID="CoverImage" alt="Cover" CssClass="img-thumbnail" style="height: 100%; max-height: 320px; aspect-ratio: 17 / 24; " ImageUrl="/Content/cover_default.png" />
                <asp:Label runat="server" CssClass="form-label w-100 mt-3" AssociatedControlID="Cover">Okładka</asp:Label>
                <asp:FileUpload runat="server" ID="Cover" CssClass="form-control"/>
            </div>
            <div class="col-md-8">
                <asp:UpdatePanel runat="server">
                    <ContentTemplate>
                        <div class="d-flex align-items-center gap-3">
                            <div class="form-check">
                                <asp:RadioButton runat="server" GroupName="Author" Checked="True" ID="AuthorExisting" OnCheckedChanged="AuthorChange" AutoPostBack="True" CausesValidation="False"/>
                                <asp:Label runat="server" AssociatedControlID="AuthorExisting" CssClass="form-label text-nowrap my-0">Istniejący autor</asp:Label>
                            </div>
                            <comp:AuthorSelect runat="server" ID="AuthorSelect" />
                        </div>

                        <div class="d-flex align-items-center gap-3 mt-3">
                            <div class="form-check">
                                <asp:RadioButton runat="server" GroupName="Author" Checked="False" ID="AuthorNew" OnCheckedChanged="AuthorChange" AutoPostBack="True" CausesValidation="False"/>
                                <asp:Label runat="server" AssociatedControlID="AuthorNew" CssClass="form-label text-nowrap my-0">Nowy autor</asp:Label>
                            </div>
                            <div class="flex-grow-1">
                                <asp:TextBox ID="AuthorFirstName" runat="server" CssClass="form-control" placeholder="Imię autora"/>
                            </div>
                            <div class="flex-grow-1">
                                <asp:TextBox ID="AuthorLastName" runat="server" CssClass="form-control" placeholder="Nazwisko autora"/>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="AuthorLastName" EnableClientScript="False" CssClass="invalid-feedback" Display="Dynamic" ID="AuthorLastNameValidator">
                                    Nazwisko autora jest wymagane.
                                </asp:RequiredFieldValidator>
                            </div>
                        </div>
                    </ContentTemplate>
                </asp:UpdatePanel>

                <asp:Label runat="server" CssClass="form-label" AssociatedControlID="BookTitle">Tytuł książki</asp:Label>
                <asp:TextBox ID="BookTitle" runat="server" CssClass="form-control" placeholder="Tytuł" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="BookTitle" EnableClientScript="False" CssClass="invalid-feedback" Display="Dynamic">
                    Tytuł jest wymagany.
                </asp:RequiredFieldValidator>

                <div class="row">
                    <div class="col-sm-8">
                        <asp:Label runat="server" CssClass="form-label" AssociatedControlID="ISBN">Numer ISBN</asp:Label>
                        <asp:TextBox ID="ISBN" runat="server" CssClass="form-control" placeholder="ISBN (same cyfry, bez myślników)" TextMode="Number"/>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="ISBN" EnableClientScript="False" CssClass="invalid-feedback" Display="Dynamic">
                            Numer ISBN jest wymagany.
                        </asp:RequiredFieldValidator>
                        <comp:MinLengthValidator runat="server" ControlToValidate="ISBN" MinLength="13" CssClass="invalid-feedback" Display="Dynamic">
                            Numer ISBN musi mieć 13 znaków.
                        </comp:MinLengthValidator>
                        <comp:MaxLengthValidator runat="server" ControlToValidate="ISBN" MaxLength="13" CssClass="invalid-feedback" Display="Dynamic">
                            Numer ISBN musi mieć 13 znaków.
                        </comp:MaxLengthValidator>
                    </div>

                    <div class="col-sm-4">
                        <asp:Label runat="server" CssClass="form-label" AssociatedControlID="ReleaseYear">Rok wydania</asp:Label>
                        <asp:TextBox ID="ReleaseYear" runat="server" CssClass="form-control" placeholder="Rok wydania" TextMode="Number"/>
                        <asp:RequiredFieldValidator runat="server" ControlToValidate="ReleaseYear" EnableClientScript="False" CssClass="invalid-feedback" Display="Dynamic">
                            Rok wydania jest wymagany.
                        </asp:RequiredFieldValidator>
                    </div>
                </div>

                <asp:Label runat="server" CssClass="form-label" AssociatedControlID="Description">Opis</asp:Label>
                <asp:TextBox ID="Description" runat="server" CssClass="form-control" placeholder="Opis" TextMode="MultiLine" Rows="4"/>

                <div class="d-flex justify-content-between mt-4">
                    <asp:Button runat="server" ID="CancelButton" Text="Anuluj" CssClass="btn btn-warning" OnCommand="CancelButton_OnCommand"/>
                    <asp:Button runat="server" ID="SubmitButton" Text="Dodaj" CssClass="btn btn-primary" OnCommand="Submit"/>
                </div>
            </div>
        </div>
    </div>



    <asp:SqlDataSource
        ID="AuthorsDataSource"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        InsertCommand="INSERT INTO
            [Authors] ([FirstName], [LastName])
            VALUES (@FirstName, @LastName);
            SELECT @NewId=Scope_Identity();">
        <InsertParameters>
            <asp:Parameter Name="NewId" Type="Int32" Direction="Output" />
            <asp:Parameter Name="FirstName" Type="String" />
            <asp:Parameter Name="LastName" Type="String" />
        </InsertParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource
        ID="BooksDataSource"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        InsertCommand="INSERT INTO
            [Books] ([Title], [AuthorId], [Description], [ISBN], [ReleaseYear], [CoverPath])
            VALUES (@Title, @AuthorId, @Description, @ISBN, @ReleaseYear, @CoverPath);
            SELECT @NewId=Scope_Identity();"
        >
        <InsertParameters>
            <asp:Parameter Name="NewId" Type="Int32" Direction="Output" />
            <asp:Parameter Name="Title" Type="String" />
            <asp:Parameter Name="AuthorId" Type="Int32" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="ISBN" Type="String" />
            <asp:Parameter Name="CoverPath" Type="String"/>
            <asp:Parameter Name="ReleaseYear" Type="Int32" />
        </InsertParameters>
    </asp:SqlDataSource>


</asp:Content>

