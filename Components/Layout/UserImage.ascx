<%@ Control Language="C#" CodeBehind="UserImage.ascx.cs" Inherits="BookReviews.Components.Layout.UserImage" %>


<svg
    xmlns="http://www.w3.org/2000/svg"
    xmlns:xlink="http://www.w3.org/1999/xlink"
    width="<%: Size * 100 %>px"
    height="<%: Size * 100 %>px"
    viewBox="0 0 <%: Size * 100 %> <%: Size * 100 %>"
    >
    <rect
        fill="<%: BgColor %>"
        width="<%: Size * 100 %>"
        height="<%: Size * 100 %>"
        rx="<%: Size * 50 %>"
        ry="<%: Size * 50 %>"/>
    <text x="50%"
          y="50%"
          style="line-height: 1; font-family: sans-serif; pointer-events: none; user-select: none;"
          alignment-baseline="middle"
          text-anchor="middle"
          font-size="<%: Size * 48 %>"
          font-weight="500"
          dy=".1em"
          dominant-baseline="middle"
          fill="<%: TextColor %>">
        <%: UserInitials %>
    </text>
</svg>