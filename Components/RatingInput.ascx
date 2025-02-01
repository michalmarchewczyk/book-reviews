<%@ Control Language="C#" CodeBehind="RatingInput.ascx.cs" Inherits="BookReviews.Components.RatingInput" %>

<div>
    <asp:HiddenField runat="server" ID="ValueField" Value="3"/>
    <asp:Repeater runat="server" ID="Repeater">
        <ItemTemplate>
            <button
                type="button"
                class="btn btn-link comp-RatingInput-star"
                data-value="<%# Container.DataItem %>"
                data-input-id="<%# ValueField.ClientID %>"
                onclick="RatingInput_setRating(this)">
                <i class="bi <%# (int)Container.DataItem <= Value ? "bi-star-fill" : "bi-star" %>"></i>
            </button>
        </ItemTemplate>
    </asp:Repeater>
</div>