<%@ Control Language="C#" CodeBehind="ReviewLikes.ascx.cs" Inherits="BookReviews.Reviews.Components.ReviewLikes" %>

<asp:UpdatePanel runat="server">
    <ContentTemplate>
        <asp:LinkButton ClientIdMode="AutoID" ID="LikeButton" runat="server" CssClass="btn btn-outline-success me-2" style="min-width: 60px; white-space: nowrap;" OnCommand="LikeButton_OnCommand">
            <i class="bi bi-hand-thumbs-up<%: CurrentUserVote == 1 ? "-fill" : "" %> me-2 "></i> <asp:Label ID="LikeCount" runat="server" Text="-" />
        </asp:LinkButton>
        <asp:LinkButton ClientIdMode="AutoID" ID="DislikeButton" runat="server" CssClass="btn btn-outline-danger" style="min-width: 60px; white-space: nowrap;" OnCommand="DislikeButton_OnCommand">
            <i class="bi bi-hand-thumbs-down<%: CurrentUserVote == -1 ? "-fill" : "" %> me-2"></i> <asp:Label ID="DislikeCount" runat="server" Text="-" />
        </asp:LinkButton>
    </ContentTemplate>
</asp:UpdatePanel>


<asp:SqlDataSource
    ID="ReviewLikesDataSource"
    runat="server"
    ConnectionString="<%$ ConnectionStrings:ConnectionString %>"
    SelectCommand="SELECT UserId, Value FROM ReviewLikes WHERE ReviewId = @Id"
    InsertCommand="INSERT INTO ReviewLikes (ReviewId, UserId, Value) VALUES (@Id, @UserId, @Value)"
    UpdateCommand="UPDATE ReviewLikes SET Value = @Value WHERE ReviewId = @Id AND UserId = @UserId"
    DeleteCommand="DELETE FROM ReviewLikes WHERE ReviewId = @Id AND UserId = @UserId"
>
    <SelectParameters>
        <asp:Parameter Name="Id" Type="Int32" />
    </SelectParameters>
    <InsertParameters>
        <asp:Parameter Name="Id" Type="Int32" />
        <asp:Parameter Name="UserId" Type="String" />
        <asp:Parameter Name="Value" Type="Int32" />
    </InsertParameters>
    <UpdateParameters>
        <asp:Parameter Name="Id" Type="Int32" />
        <asp:Parameter Name="UserId" Type="String" />
        <asp:Parameter Name="Value" Type="Int32" />
    </UpdateParameters>
    <DeleteParameters>
        <asp:Parameter Name="Id" Type="Int32" />
        <asp:Parameter Name="UserId" Type="String" />
    </DeleteParameters>
</asp:SqlDataSource>