<%@ Control Language="C#" CodeBehind="AuthorSelect.ascx.cs" Inherits="BookReviews.Authors.Components.AuthorSelect" %>

<asp:SqlDataSource
    ID="AuthorsDataSource"
    runat="server"
    ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
    SelectCommand="SELECT [Id], [FirstName], [LastName], [FirstName] + ' ' + [LastName] AS FullName FROM [Authors] ORDER BY [LastName]"
    >
</asp:SqlDataSource>

<asp:DropDownList runat="server" ID="AuthorsList" CssClass="form-select" DataSourceID="AuthorsDataSource" DataTextField="FullName" DataValueField="Id">
    <asp:ListItem Text="Select author" Value="" />
</asp:DropDownList>