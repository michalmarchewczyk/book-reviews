using System.Data;

namespace BookReviews.Authors
{
    public class Author
    {
        public int Id { get; set; }
        public string FirstName { get; set; }
        public string LastName { get; set; }

        public static Author FromRow(DataRow row)
        {
            return new Author
            {
                Id = (int)row["Id"],
                FirstName = row["FirstName"].ToString(),
                LastName = row["LastName"].ToString()
            };
        }

        public static Author FromRelatedRow(DataRow row)
        {
            return new Author
            {
                Id = (int)row["AuthorId"],
                FirstName = row["AuthorFirstName"].ToString(),
                LastName = row["AuthorLastName"].ToString()
            };
        }
    }
}