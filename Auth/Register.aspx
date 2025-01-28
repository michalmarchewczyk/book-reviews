<%@ Page Title="Title" Language="C#" MasterPageFile="~/Site.Master" CodeBehind="Register.aspx.cs" Inherits="BookReviews.Auth.Register" %>

<asp:Content runat="server" ContentPlaceHolderID="MainContent">
    <h1>
        Register
    </h1>
    <asp:TextBox ID="Username" runat="server" CssClass="form-control" placeholder="Username" />
    <asp:TextBox ID="FirstName" runat="server" CssClass="form-control" placeholder="First Name" />
    <asp:TextBox ID="LastName" runat="server" CssClass="form-control" placeholder="Last Name" />
    <asp:TextBox ID="Email" runat="server" CssClass="form-control" placeholder="Email" />
    <asp:TextBox ID="Password" runat="server" CssClass="form-control" placeholder="Password" TextMode="Password" />
    <asp:Button runat="server" CssClass="btn btn-primary" UseSubmitBehavior="False" Text="Register"/>
</asp:Content>