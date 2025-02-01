<%@ Page Title="Title" Language="C#" MasterPageFile="~/Main.Master" CodeBehind="Default.aspx.cs" Inherits="BookReviews.Books.Default" %>
<%@ Register TagPrefix="comp" TagName="BookCard" Src="~/Books/Components/BookCard.ascx" %>
<%@ Register TagPrefix="auth" TagName="VisibilityControl" Src="~/Auth/Controls/VisibilityControl.ascx" %>


<asp:Content runat="server" ContentPlaceHolderID="MainContent">
    <div class="d-flex align-items-center">
        <h2 class="mb-0">
            Książki
        </h2>
        <auth:VisibilityControl runat="server" Visibility="HasRole" Role="Admin">
            <Content>
                <a class="btn btn-secondary mx-4" href="/books/add">Dodaj książkę</a>
            </Content>
        </auth:VisibilityControl>
        <div class="flex-fill"></div>
        <asp:DropDownList
            runat="server"
            OnSelectedIndexChanged="BooksListSortingChanged"
            CssClass="form-select w-auto"
            ID="BooksListSorting"
            AutoPostBack="true">
            <asp:ListItem Value="Title_ASC">Tytuł (A-Z)</asp:ListItem>
            <asp:ListItem Value="Title_DESC">Tytuł (Z-A)</asp:ListItem>
            <asp:ListItem Value="ReleaseYear_ASC">Rok wydania (rosnąco)</asp:ListItem>
            <asp:ListItem Value="ReleaseYear_DESC">Rok wydania (malejąco)</asp:ListItem>
        </asp:DropDownList>
    </div>
    <hr/>

    <asp:ListView ID="BooksListView" runat="server" DataSourceID="BooksDataSource" OnItemDataBound="BooksListView_OnItemDataBound" DataKeyNames="Id">
        <EmptyDataTemplate>
            <span class="display-6 text-muted w-100 text-center d-block my-5 py-5">Nie znaleziono żadnych książek.</span>
        </EmptyDataTemplate>
        <ItemTemplate>
            <comp:BookCard runat="server" />
        </ItemTemplate>
        <LayoutTemplate>
            <div id="itemPlaceholderContainer" runat="server" class="d-flex flex-column align-items-center">
                <span runat="server" id="itemPlaceholder"></span>
            </div>
            <asp:DataPager ID="BooksListDataPager" runat="server" PageSize="10" class="btn-group mx-auto d-flex mt-4" style="width: min-content;">
               <Fields>
                    <asp:NextPreviousPagerField PreviousPageText="&lsaquo;" FirstPageText="&laquo;" ShowPreviousPageButton="true"
                        ShowFirstPageButton="true" ShowNextPageButton="false" ShowLastPageButton="false"
                        ButtonCssClass="btn btn-light px-3" RenderNonBreakingSpacesBetweenControls="false" RenderDisabledButtonsAsLabels="false" />
                    <asp:NumericPagerField ButtonType="Link" CurrentPageLabelCssClass="btn btn-primary disabled px-3"  RenderNonBreakingSpacesBetweenControls="false"
                        NumericButtonCssClass="btn btn-light px-3" ButtonCount="10" NextPageText="..." NextPreviousButtonCssClass="btn btn-default" />
                    <asp:NextPreviousPagerField NextPageText="&rsaquo;" LastPageText="&raquo;" ShowNextPageButton="true"
                        ShowLastPageButton="true" ShowPreviousPageButton="false" ShowFirstPageButton="false"
                        ButtonCssClass="btn btn-light px-3" RenderNonBreakingSpacesBetweenControls="false" RenderDisabledButtonsAsLabels="false"/>
                </Fields>
            </asp:DataPager>
        </LayoutTemplate>
    </asp:ListView>


    <asp:SqlDataSource
        ID="BooksDataSource"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT
            b.[Id], b.[Title], b.[AuthorId], b.[Description], b.[ISBN], b.[CoverPath], b.[ReleaseYear],
            a.[FirstName] AS AuthorFirstName, a.[LastName] AS AuthorLastName
            FROM [Books] b LEFT JOIN [Authors] a ON b.AuthorId = a.Id"
    >
    </asp:SqlDataSource>
</asp:Content>