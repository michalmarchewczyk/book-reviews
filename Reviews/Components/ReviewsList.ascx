<%@ Control Language="C#" CodeBehind="ReviewsList.ascx.cs" Inherits="BookReviews.Reviews.Components.ReviewsList" %>
<%@ Import Namespace="System.Data" %>
<%@ Import Namespace="BookReviews.Authors" %>
<%@ Import Namespace="BookReviews.Books" %>
<%@ Import Namespace="BookReviews.Reviews" %>
<%@ Register TagPrefix="comp" TagName="ReviewCard" Src="~/Reviews/Components/ReviewCard.ascx" %>


<asp:ListView ID="ReviewsListView" runat="server" DataSourceID="ReviewsDataSource" DataKeyNames="Id">
    <EmptyDataTemplate>
        <span class="display-6 text-muted w-100 text-center d-block my-5 py-5">Nie znaleziono żadnych recenzji.</span>
    </EmptyDataTemplate>
    <ItemTemplate>
        <comp:ReviewCard
            runat="server"
            Review="<%# Review.FromRow(((DataRowView)Container.DataItem).Row) %>"
            Book="<%# Book.FromRelatedRow(((DataRowView)Container.DataItem).Row) %>"
            Author="<%# Author.FromRelatedRow(((DataRowView)Container.DataItem).Row) %>"
            PreviewVisible="<%# BookId == null %>"
            />
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
        LEFT JOIN [Authors] a ON b.AuthorId = a.Id
    "
>
</asp:SqlDataSource>