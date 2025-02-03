<%@ Page Title="Title" Language="C#" MasterPageFile="~/Main.master" CodeBehind="My.aspx.cs" Inherits="BookReviews.Reviews.My" %>
<%@ Register TagPrefix="comp" TagName="ReviewsList" Src="~/Reviews/Components/ReviewsList.ascx" %>

<asp:Content runat="server" ContentPlaceHolderID="MainContent">
    <div class="d-flex align-items-center">
        <h2 class="mb-0">
            Moje recenzje
        </h2>
        <div class="flex-fill"></div>
        <asp:DropDownList
            runat="server"
            OnSelectedIndexChanged="ReviewsListSortingChanged"
            CssClass="form-select w-auto"
            ID="ReviewsListSorting"
            AutoPostBack="true">
            <asp:ListItem Value="Title_ASC">Tytuł (A-Z)</asp:ListItem>
            <asp:ListItem Value="Title_DESC">Tytuł (Z-A)</asp:ListItem>
            <asp:ListItem Value="BookTitle_ASC">Tytuł książki (A-Z)</asp:ListItem>
            <asp:ListItem Value="BookTitle_DESC">Tytuł książki (Z-A)</asp:ListItem>
        </asp:DropDownList>
    </div>
    <hr/>

    <comp:ReviewsList runat="server" ID="ReviewsList"/>

</asp:Content>