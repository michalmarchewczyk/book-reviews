<%@ Page Title="Edytuj książkę" Language="C#" MasterPageFile="~/Main.master" CodeBehind="Edit.aspx.cs" Inherits="BookReviews.Books.Edit" %>
<%@ Register TagPrefix="comp" TagName="AuthorSelect" Src="~/Authors/Components/AuthorSelect.ascx" %>
<%@ Register TagPrefix="comp" Namespace="BookReviews.Components.Validators" Assembly="BookReviews" %>

<asp:Content runat="server" ContentPlaceHolderID="MainContent">
    <section class="card mx-auto">
        <h3 class="card-header">
            Edytuj książkę
        </h3>
        <section class="row card-body">
            <section class="col-md-4 d-flex flex-column align-items-center mb-4">
                <asp:Image runat="server" ID="CoverImage" alt="Cover" CssClass="img-thumbnail h-100 img-cover-lg" ImageUrl="/Content/cover_default.png" />
                <asp:Label runat="server" CssClass="form-label w-100 mt-3" AssociatedControlID="Cover">Okładka</asp:Label>
                <asp:FileUpload runat="server" ID="Cover" CssClass="form-control"/>
            </section>
            <section class="col-md-8">
                <asp:UpdatePanel runat="server">
                    <ContentTemplate>
                        <section class="d-flex align-items-center gap-3">
                            <div class="form-check">
                                <asp:RadioButton runat="server" GroupName="Author" Checked="True" ID="AuthorExisting" OnCheckedChanged="AuthorChange" AutoPostBack="True" CausesValidation="False"/>
                                <asp:Label runat="server" AssociatedControlID="AuthorExisting" CssClass="form-label text-nowrap my-0">Istniejący autor</asp:Label>
                            </div>
                            <comp:AuthorSelect runat="server" ID="AuthorSelect" />
                        </section>

                        <section class="d-flex align-items-center gap-3 mt-3">
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
                        </section>
                    </ContentTemplate>
                </asp:UpdatePanel>

                <asp:Label runat="server" CssClass="form-label" AssociatedControlID="BookTitle">Tytuł książki</asp:Label>
                <asp:TextBox ID="BookTitle" runat="server" CssClass="form-control" placeholder="Tytuł" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="BookTitle" EnableClientScript="False" CssClass="invalid-feedback" Display="Dynamic">
                    Tytuł jest wymagany.
                </asp:RequiredFieldValidator>

                <section class="row">
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
                </section>

                <asp:Label runat="server" CssClass="form-label" AssociatedControlID="Description">Opis</asp:Label>
                <asp:TextBox ID="Description" runat="server" CssClass="form-control" placeholder="Opis" TextMode="MultiLine" Rows="4"/>

                <section class="d-flex justify-content-between mt-4">
                    <asp:Button runat="server" ID="CancelButton" Text="Anuluj" CssClass="btn btn-warning" OnCommand="CancelButton_OnCommand"/>
                    <asp:Button runat="server" ID="SubmitButton" Text="Zapisz" CssClass="btn btn-primary" OnCommand="Submit"/>
                </section>
            </section>
        </section>
    </section>




    <asp:SqlDataSource
        ID="AuthorsDataSource"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        DeleteCommand="DELETE FROM [Authors] WHERE [Id] = @Id"
        InsertCommand="INSERT INTO [Authors] ([FirstName], [LastName]) VALUES (@FirstName, @LastName); SELECT @NewId=Scope_Identity();"
        SelectCommand="SELECT [Id], [FirstName], [LastName] FROM [Authors]"
        UpdateCommand="UPDATE [Authors] SET [FirstName] = @FirstName, [LastName] = @LastName WHERE [Id] = @Id">
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
        SelectCommand="SELECT [Id], [Title], [AuthorId], [Description], [ISBN], [CoverPath], [ReleaseYear] FROM [Books] WHERE [Id] = @Id"
        UpdateCommand="UPDATE [Books] SET [Title] = @Title, [AuthorId] = @AuthorId, [Description] = @Description, [ISBN] = @ISBN, [ReleaseYear] = @ReleaseYear, [CoverPath] = @CoverPath WHERE [Id] = @Id">
        <SelectParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </SelectParameters>
        <UpdateParameters>
            <asp:Parameter Name="Title" Type="String" />
            <asp:Parameter Name="AuthorId" Type="Int32" />
            <asp:Parameter Name="Description" Type="String" />
            <asp:Parameter Name="ISBN" Type="String" />
            <asp:Parameter Name="CoverPath" Type="String" />
            <asp:Parameter Name="ReleaseYear" Type="Int32" />
            <asp:Parameter Name="Id" Type="Int32" />
        </UpdateParameters>
    </asp:SqlDataSource>


</asp:Content>