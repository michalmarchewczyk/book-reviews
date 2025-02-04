<%@ Page Title="Panel administracyjny" Language="C#" MasterPageFile="~/Main.master" CodeBehind="Default.aspx.cs" Inherits="BookReviews.Admin.Default" %>
<%@ Import Namespace="BookReviews.Auth" %>

<asp:Content runat="server" ContentPlaceHolderID="MainContent">
    <div class="card mx-auto">
        <header class="card-header">
            <h3>
                Panel administracyjny
            </h3>
            <ul class="nav nav-tabs card-header-tabs">
                <li class="nav-item">
                    <asp:LinkButton CssClass="nav-link active" runat="server" OnCommand="ChangeView" CommandArgument="Users" ID="UsersLink">Użytkownicy</asp:LinkButton>
                </li>
                <li class="nav-item">
                    <asp:LinkButton CssClass="nav-link" runat="server" OnCommand="ChangeView" CommandArgument="Books" ID="BooksLink">Książki</asp:LinkButton>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/books/add">Dodaj książkę<i class="bi bi-box-arrow-up-right ms-2"></i></a>
                </li>
                <li class="nav-item">
                    <asp:LinkButton CssClass="nav-link" runat="server" OnCommand="ChangeView" CommandArgument="Reviews" ID="ReviewsLink">Recenzje</asp:LinkButton>
                </li>
            </ul>
        </header>
        <section class="card-body p-0">
            <div class="table-container">
                <asp:MultiView runat="server" ID="AdminMultiView" ActiveViewIndex="0"  >
                    <asp:View runat="server" ID="ViewUsers">
                        <asp:GridView ID="GridView3" runat="server" CssClass="table table-striped mb-0" AutoGenerateColumns="False" AllowPagin="True" PageSize="20" DataSourceID="UsersDataSource">
                            <Columns>
                                <asp:BoundField DataField="Id" HeaderText="Id" SortExpression="Id" />
                                <asp:BoundField DataField="UserName" HeaderText="Nazwa użytkownika" SortExpression="UserName" />
                                <asp:BoundField DataField="FirstName" HeaderText="Imię" SortExpression="FirstName" />
                                <asp:BoundField DataField="LastName" HeaderText="Nazwisko" SortExpression="LastName" />
                                <asp:BoundField DataField="Email" HeaderText="Adres email" SortExpression="Email" />
                                <asp:TemplateField HeaderText="Role użytkownika">
                                    <ItemTemplate>
                                        <span><%# string.Join(", ", ((string)Eval("RoleNames")).Split(',').Select(RolesHelper.GetRoleTranslation)) %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <PagerStyle CssClass="table-pager"></PagerStyle>
                        </asp:GridView>
                    </asp:View>
                    <asp:View runat="server" ID="ViewBooks">
                        <asp:GridView ID="GridView1" runat="server" CssClass="table table-striped mb-0" AllowPaging="True" PageSize="20" AutoGenerateColumns="False" DataSourceID="BooksDataSource">
                            <EmptyDataTemplate>
                                <span class="border-0 display-6 text-center w-100 p-5 d-block">Brak książek</span>
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
                                <asp:BoundField DataField="Title" HeaderText="Tytuł" SortExpression="Title">
                                    <ItemStyle CssClass="text-truncate mw-20rem"></ItemStyle>
                                    <HeaderStyle CssClass="text-truncate"></HeaderStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="Description" HeaderText="Opis" SortExpression="Description">
                                    <ItemStyle CssClass="text-truncate mw-20rem" ></ItemStyle>
                                    <HeaderStyle CssClass="text-truncate"></HeaderStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="ISBN" HeaderText="ISBN" SortExpression="ISBN" />
                                <asp:BoundField DataField="ReleaseYear" HeaderText="Rok wydania" SortExpression="ReleaseYear">
                                    <HeaderStyle CssClass="text-truncate"></HeaderStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="FirstName" HeaderText="Imię Autora" SortExpression="FirstName">
                                    <ItemStyle CssClass="text-truncate"></ItemStyle>
                                    <HeaderStyle CssClass="text-truncate"></HeaderStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="LastName" HeaderText="Nazwisko autora" SortExpression="LastName">
                                    <ItemStyle CssClass="text-truncate"></ItemStyle>
                                    <HeaderStyle CssClass="text-truncate"></HeaderStyle>
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="">
                                    <ItemTemplate>
                                        <nav class="d-flex flex-nowrap gap-2 px-2">
                                            <a runat="server" href=<%# "/books/" + Eval("Id") %> class="btn btn-secondary">
                                                Otwórz
                                            </a>
                                            <a runat="server" href=<%# "/books/edit?id=" + Eval("Id") %> class="btn btn-secondary">
                                                Edytuj
                                            </a>
                                            <a runat="server" href=<%# "/books/delete?id=" + Eval("Id") %> class="btn btn-danger">
                                                Usuń
                                            </a>
                                        </nav>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <PagerStyle CssClass="table-pager"></PagerStyle>
                        </asp:GridView>
                    </asp:View>
                    <asp:View runat="server" ID="ViewReviews">
                        <asp:GridView ID="GridView2" runat="server" CssClass="table table-striped mb-0" AllowPaging="True" PageSize="20"  AutoGenerateColumns="False" DataSourceID="ReviewsDataSource">
                            <EmptyDataTemplate>
                                <span class="border-0 display-6 text-center w-100 p-5 d-block">Brak recenzji</span>
                            </EmptyDataTemplate>
                            <Columns>
                                <asp:BoundField DataField="Id" HeaderText="Id" InsertVisible="False" ReadOnly="True" SortExpression="Id" />
                                <asp:BoundField DataField="Title" HeaderText="Tytuł" SortExpression="Title">
                                    <ItemStyle CssClass="text-truncate mw-20rem"></ItemStyle>
                                    <HeaderStyle CssClass="text-truncate"></HeaderStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="Content" HeaderText="Treść" SortExpression="Content">
                                    <ItemStyle CssClass="text-truncate mw-20rem"></ItemStyle>
                                    <HeaderStyle CssClass="text-truncate"></HeaderStyle>
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="Użytkownik">
                                    <ItemTemplate>
                                        <span><%# AuthHelper.GetUserDisplayName((string)Eval("UserId")) %></span>
                                    </ItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="Rating" HeaderText="Ocena" SortExpression="Rating" />
                                <asp:BoundField DataField="CreatedAt" HeaderText="Utworzono" SortExpression="CreatedAt">
                                    <ItemStyle CssClass="text-truncate mw-20rem"></ItemStyle>
                                    <HeaderStyle CssClass="text-truncate"></HeaderStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="BookId1" HeaderText="Id książki" InsertVisible="False" ReadOnly="True" SortExpression="BookId1" >
                                    <HeaderStyle CssClass="text-truncate"></HeaderStyle>
                                </asp:BoundField>
                                <asp:BoundField DataField="BookTitle" HeaderText="Tytuł książki" SortExpression="BookTitle" >
                                    <ItemStyle CssClass="text-truncate mw-20rem"></ItemStyle>
                                    <HeaderStyle CssClass="text-truncate"></HeaderStyle>
                                </asp:BoundField>
                                <asp:TemplateField HeaderText="">
                                    <ItemTemplate>
                                        <nav class="d-flex flex-nowrap gap-2 px-2">
                                            <a runat="server" href=<%# "/reviews/" + Eval("Id") %> class="btn btn-secondary">
                                                Otwórz
                                            </a>
                                            <a runat="server" href=<%# "/reviews/delete?id=" + Eval("Id") %> class="btn btn-danger">
                                                Usuń
                                            </a>
                                        </nav>
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                            <PagerStyle CssClass="table-pager"></PagerStyle>
                        </asp:GridView>
                    </asp:View>
                </asp:MultiView>
            </div>
        </section>
    </div>



    <asp:SqlDataSource
        ID="UsersDataSource"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT Users.Id, Users.UserName, Users.FirstName, Users.LastName, Users.Email,
        STRING_AGG(Roles.Name, ', ') AS RoleNames
        FROM Users
        INNER JOIN UserRoles ON Users.Id = UserRoles.UserId
        INNER JOIN Roles ON UserRoles.RoleId = Roles.Id
        GROUP BY Users.Id, Users.UserName, Users.FirstName, Users.LastName, Users.Email"
    ></asp:SqlDataSource>

    <asp:SqlDataSource
        ID="BooksDataSource"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT Books.Id, Books.Title, Books.AuthorId, Books.Description, Books.ISBN, Books.CoverPath, Books.ReleaseYear,
            Authors.Id AS Expr1, Authors.FirstName, Authors.LastName
            FROM Books LEFT JOIN Authors ON Books.AuthorId = Authors.Id"
    ></asp:SqlDataSource>

    <asp:SqlDataSource
        ID="ReviewsDataSource"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT
           r.[Id], r.[Title], r.[Content], r.[UserId], r.[BookId], r.[Rating], r.[CreatedAt],
           b.[Id] AS BookId, b.[Title] AS BookTitle, b.[Description] AS BookDescription, b.[ISBN] AS BookISBN,
           b.[ReleaseYear] AS BookReleaseYear, b.[CoverPath] AS BookCoverPath, b.[AuthorId] AS BookAuthorId,
           a.[Id] AS AuthorId, a.[FirstName] AS AuthorFirstName, a.[LastName] AS AuthorLastName
           FROM [Reviews] r
           LEFT JOIN [Books] b ON r.BookId = b.Id
           LEFT JOIN [Authors] a ON b.AuthorId = a.Id"
    ></asp:SqlDataSource>

    <asp:SqlDataSource
        ID="RolesDataSource"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT Id AS RoleId, Name AS RoleName FROM Roles"
    ></asp:SqlDataSource>
</asp:Content>