using System;
using System.Data;

namespace BookReviews.Reviews
{
    public class Review
    {
        public int Id { get; set; }
        public int BookId { get; set; }
        public string UserId { get; set; }
        public string Title { get; set; }
        public string Content { get; set; }
        public int Rating { get; set; }
        public DateTime CreatedAt { get; set; }

        public static Review FromRow(DataRow row)
        {
            return new Review
            {
                Id = (int)row["Id"],
                BookId = (int)row["BookId"],
                UserId = row["UserId"].ToString(),
                Title = row["Title"].ToString(),
                Content = row["Content"].ToString(),
                Rating = (int)row["Rating"],
                CreatedAt = (DateTime)row["CreatedAt"]
            };
        }
    }
}