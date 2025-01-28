using System;
using System.Data.Entity;

namespace BookReviews.Auth
{
    public class AppIdentityDbInitializer: CreateDatabaseIfNotExists<AppIdentityDbContext>
    {
        public override void InitializeDatabase(AppIdentityDbContext context)
        {
            base.InitializeDatabase(context);
        }

        protected override void Seed(AppIdentityDbContext context)
        {
            base.Seed(context);
        }
    }
}