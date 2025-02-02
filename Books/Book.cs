using System;
using System.Data;

namespace BookReviews.Books
{
    public class Book
    {
        public int Id { get; set; }
        public string Title { get; set; }
        public string ISBN { get; set; }
        public string Description { get; set; }
        public int AuthorId { get; set; }
        public int ReleaseYear { get; set; }
        public string CoverPath { get; set; }
        public double? AverageRating { get; set; }

        public static Book FromRow(DataRow row)
        {
            return new Book
            {
                Id = (int)row["Id"],
                Title = row["Title"].ToString(),
                ISBN = row["ISBN"].ToString(),
                Description = row["Description"].ToString(),
                AuthorId = (int)row["AuthorId"],
                ReleaseYear = (int)row["ReleaseYear"],
                CoverPath = row["CoverPath"].ToString(),
                AverageRating = !row.Table.Columns.Contains("AverageRating") || row["AverageRating"] == DBNull.Value
                    ? null
                    : (double?)row["AverageRating"]
            };
        }

        public static Book FromRelatedRow(DataRow row)
        {
            return new Book
            {
                Id = (int)row["BookId"],
                Title = row["BookTitle"].ToString(),
                ISBN = row["BookISBN"].ToString(),
                Description = row["BookDescription"].ToString(),
                AuthorId = (int)row["BookAuthorId"],
                ReleaseYear = (int)row["BookReleaseYear"],
                CoverPath = row["BookCoverPath"].ToString()
            };
        }
    }
}