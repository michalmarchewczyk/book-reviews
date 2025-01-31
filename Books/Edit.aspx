<%@ Page Title="Title" Language="C#" MasterPageFile="~/Main.master" CodeBehind="Edit.aspx.cs" Inherits="BookReviews.Books.Edit" %>
<%@ Register TagPrefix="comp" TagName="AuthorSelect" Src="~/Authors/Components/AuthorSelect.ascx" %>

<asp:Content runat="server" ContentPlaceHolderID="MainContent">
    <h1>EDIT BOOK</h1>
    <div class="card">
        <div class="form-check">
            <asp:RadioButton runat="server" GroupName="Author" Checked="True" ID="AuthorExisting" OnCheckedChanged="AuthorChange" AutoPostBack="True"/>
            <asp:Label runat="server" AssociatedControlID="AuthorExisting" CssClass="form-label">Istniejący autor</asp:Label>
        </div>

        <comp:AuthorSelect runat="server" ID="AuthorSelect" />

        <div class="form-check">
            <asp:RadioButton runat="server" GroupName="Author" Checked="False" ID="AuthorNew" OnCheckedChanged="AuthorChange" AutoPostBack="True"/>
            <asp:Label runat="server" AssociatedControlID="AuthorNew" CssClass="form-label">Nowy autor</asp:Label>
        </div>

        <asp:Label runat="server" CssClass="form-label" AssociatedControlID="AuthorFirstName">Imię autora</asp:Label>
        <asp:TextBox ID="AuthorFirstName" runat="server" CssClass="form-control" placeholder="Imię autora"/>

        <asp:Label runat="server" CssClass="form-label" AssociatedControlID="AuthorLastName">Nazwisko autora</asp:Label>
        <asp:TextBox ID="AuthorLastName" runat="server" CssClass="form-control" placeholder="Nazwisko autora"/>
        <asp:RequiredFieldValidator runat="server" ControlToValidate="AuthorLastName" EnableClientScript="False" CssClass="invalid-feedback" Display="Dynamic" ID="AuthorLastNameValidator">
            Nazwisko autora jest wymagane.
        </asp:RequiredFieldValidator>


        <asp:Label runat="server" CssClass="form-label" AssociatedControlID="BookTitle">Tytuł książki</asp:Label>
        <asp:TextBox ID="BookTitle" runat="server" CssClass="form-control" placeholder="Tytuł" />
        <asp:RequiredFieldValidator runat="server" ControlToValidate="BookTitle" EnableClientScript="False" CssClass="invalid-feedback" Display="Dynamic">
            Tytuł jest wymagany.
        </asp:RequiredFieldValidator>

        <asp:Label runat="server" CssClass="form-label" AssociatedControlID="ISBN">Numer ISBN</asp:Label>
        <asp:TextBox ID="ISBN" runat="server" CssClass="form-control" placeholder="ISBN"/>
        <asp:RequiredFieldValidator runat="server" ControlToValidate="ISBN" EnableClientScript="False" CssClass="invalid-feedback" Display="Dynamic">
            Numer ISBN jest wymagany.
        </asp:RequiredFieldValidator>

        <asp:Label runat="server" CssClass="form-label" AssociatedControlID="ReleaseYear">Rok wydania</asp:Label>
        <asp:TextBox ID="ReleaseYear" runat="server" CssClass="form-control" placeholder="Rok wydania" TextMode="Number"/>
        <asp:RequiredFieldValidator runat="server" ControlToValidate="ReleaseYear" EnableClientScript="False" CssClass="invalid-feedback" Display="Dynamic">
            Rok wydania jest wymagany.
        </asp:RequiredFieldValidator>

        <asp:Label runat="server" CssClass="form-label" AssociatedControlID="Description">Opis</asp:Label>
        <asp:TextBox ID="Description" runat="server" CssClass="form-control" placeholder="Opis" TextMode="MultiLine" Rows="4"/>

        <asp:Button runat="server" ID="CancelButton" Text="Anuluj" CssClass="btn btn-danger" OnClick="CancelButton_OnSubmit"/>
        <asp:Button runat="server" ID="SubmitButton" Text="Zapisz" CssClass="btn btn-primary" OnCommand="Submit"/>

        <asp:SqlDataSource
            ID="AuthorsDataSource"
            runat="server"
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
            DeleteCommand="DELETE FROM [Authors] WHERE [Id] = @Id"
            InsertCommand="INSERT INTO [Authors] ([FirstName], [LastName]) VALUES (@FirstName, @LastName); SELECT @NewId=Scope_Identity();"
            SelectCommand="SELECT [Id], [FirstName], [LastName] FROM [Authors]"
            UpdateCommand="UPDATE [Authors] SET [FirstName] = @FirstName, [LastName] = @LastName WHERE [Id] = @Id">
            <%-- <DeleteParameters> --%>
            <%--     <asp:Parameter Name="Id" Type="Int32" /> --%>
            <%-- </DeleteParameters> --%>
            <InsertParameters>
                <asp:Parameter Name="NewId" Type="Int32" Direction="Output" />
                <asp:Parameter Name="FirstName" Type="String" />
                <asp:Parameter Name="LastName" Type="String" />
            </InsertParameters>
            <%-- <UpdateParameters> --%>
            <%--     <asp:Parameter Name="FirstName" Type="String" /> --%>
            <%--     <asp:Parameter Name="LastName" Type="String" /> --%>
            <%--     <asp:Parameter Name="Id" Type="Int32" /> --%>
            <%-- </UpdateParameters> --%>
        </asp:SqlDataSource>

        <asp:SqlDataSource
            ID="BooksDataSource"
            runat="server"
            ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
            DeleteCommand="DELETE FROM [Books] WHERE [Id] = @Id"
            InsertCommand="INSERT INTO [Books] ([Title], [AuthorId], [Description], [ISBN], [ReleaseYear]) VALUES (@Title, @AuthorId, @Description, @ISBN, @ReleaseYear)"
            SelectCommand="SELECT [Id], [Title], [AuthorId], [Description], [ISBN], [Cover], [ReleaseYear] FROM [Books] WHERE [Id] = @Id"
            UpdateCommand="UPDATE [Books] SET [Title] = @Title, [AuthorId] = @AuthorId, [Description] = @Description, [ISBN] = @ISBN, [ReleaseYear] = @ReleaseYear WHERE [Id] = @Id">
            <SelectParameters>
                <asp:Parameter Name="Id" Type="Int32" />
            </SelectParameters>
            <%-- <DeleteParameters> --%>
            <%--     <asp:Parameter Name="Id" Type="Int32" /> --%>
            <%-- </DeleteParameters> --%>
            <%-- <InsertParameters> --%>
            <%--     <asp:Parameter Name="Title" Type="String" /> --%>
            <%--     <asp:Parameter Name="AuthorId" Type="Int32" /> --%>
            <%--     <asp:Parameter Name="Description" Type="String" /> --%>
            <%--     <asp:Parameter Name="ISBN" Type="String" /> --%>
            <%--     $1$ <asp:Parameter Name="Cover" Type="Object" /> #1# --%>
            <%--     <asp:Parameter Name="ReleaseYear" Type="Int32" /> --%>
            <%-- </InsertParameters> --%>
            <UpdateParameters>
                <asp:Parameter Name="Title" Type="String" />
                <asp:Parameter Name="AuthorId" Type="Int32" />
                <asp:Parameter Name="Description" Type="String" />
                <asp:Parameter Name="ISBN" Type="String" />
                <%-- <asp:Parameter Name="Cover" Type="Object" /> --%>
                <asp:Parameter Name="ReleaseYear" Type="Int32" />
                <asp:Parameter Name="Id" Type="Int32" />
            </UpdateParameters>
        </asp:SqlDataSource>

    </div>
</asp:Content>