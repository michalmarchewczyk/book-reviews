<%@ Page Title="Strona główna" Language="C#" MasterPageFile="~/Main.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="BookReviews.Default" %>
<%@ Register TagPrefix="comp" TagName="Hero" Src="~/Components/Hero.ascx" %>
<%@ Register TagPrefix="comp" TagName="ReviewCounter" Src="~/Components/ReviewCounter.ascx" %>
<%@ Register TagPrefix="comp" TagName="Features" Src="~/Components/Features.ascx" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <comp:Hero runat="server" />
    <comp:ReviewCounter runat="server" />
    <comp:Features runat="server" />
</asp:Content>
