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

        public static Book Create(DataRow row)
        {
            return new Book
            {
                Id = (int)row["Id"],
                Title = row["Title"].ToString(),
                ISBN = row["ISBN"].ToString(),
                Description = row["Description"].ToString(),
                AuthorId = (int)row["AuthorId"],
                ReleaseYear = (int)row["ReleaseYear"]
            };
        }
    }
}