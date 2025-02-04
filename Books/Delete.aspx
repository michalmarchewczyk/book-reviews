<%@ Page Title="Usuń książkę" Language="C#" MasterPageFile="~/Main.master" CodeBehind="Delete.aspx.cs" Inherits="BookReviews.Books.Delete" %>

<asp:Content runat="server" ContentPlaceHolderID="MainContent">
    <div class="card mx-auto">
        <h3 class="card-header">
            Usuń książkę
        </h3>
        <div class="row card-body">
            <div class="col-md-3 d-flex flex-column align-items-center mb-2">
                <asp:Image runat="server" ID="CoverImage" alt="Cover" CssClass="img-thumbnail h-100 img-cover-md" ImageUrl="/Content/cover_default.png" />
            </div>
            <div class="col-md-9">
                <p class="fs-5">
                    Usuwasz książkę
                    <asp:Label runat="server" CssClass="fst-italic fw-bolder"><%: Book.Title %></asp:Label>
                    <br/>
                    Wszystkie recenzje tej książki także zostaną usunięte. <br/>
                    Usunięcie książki jest nieodwracalne. Czy na pewno chcesz kontynuować?
                </p>
            </div>
            <div class="d-flex justify-content-between mt-4">
                <asp:Button runat="server" ID="CancelButton" Text="Anuluj" CssClass="btn btn-warning" OnCommand="CancelButton_OnCommand"/>
                <asp:Button runat="server" ID="SubmitButton" Text="Usuń" CssClass="btn btn-danger" OnCommand="Submit"/>
            </div>
        </div>

    </div>





    <asp:SqlDataSource
        ID="BooksDataSource"
        runat="server"
        ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
        SelectCommand="SELECT [Id], [Title], [AuthorId], [Description], [ISBN], [CoverPath], [ReleaseYear] FROM [Books] WHERE [Id] = @Id"
        DeleteCommand="DELETE FROM [Books] WHERE [Id] = @Id"
    >
        <SelectParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </SelectParameters>
        <DeleteParameters>
            <asp:Parameter Name="Id" Type="Int32" />
        </DeleteParameters>
    </asp:SqlDataSource>
</asp:Content>