<%@ Control Language="C#" CodeBehind="ReviewCounter.ascx.cs" Inherits="BookReviews.Components.ReviewCounter" %>

<div class="comp-ReviewCounter w-100 text-center display-6 py-5">
    <span>Mamy już ponad</span>
    <span class="counter"><%: GetCount() %></span>
    <span>recenzji</span>
</div>
