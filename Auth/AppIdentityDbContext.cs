using System.Data.Entity;
using Microsoft.AspNet.Identity.EntityFramework;

namespace BookReviews.Auth
{
    public class AppIdentityDbContext : IdentityDbContext<AppIdentityUser>
    {
        public AppIdentityDbContext() : base("ConnectionString")
        {
            Database.SetInitializer(new AppIdentityDbInitializer());
        }

        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            base.OnModelCreating(modelBuilder);

            modelBuilder.Entity<AppIdentityUser>()
                .Ignore(u => u.AccessFailedCount)
                .Ignore(u => u.LockoutEnabled)
                .Ignore(u => u.LockoutEndDateUtc)
                .Ignore(u => u.PhoneNumber)
                .Ignore(u => u.PhoneNumberConfirmed)
                .Ignore(u => u.TwoFactorEnabled);

            modelBuilder.Entity<AppIdentityUser>().ToTable("Users");

            modelBuilder.Entity<IdentityRole>().ToTable("Roles");

            modelBuilder.Entity<IdentityUserRole>().ToTable("UserRoles");

            modelBuilder.Entity<IdentityUserClaim>().ToTable("UserClaims");

            modelBuilder.Entity<IdentityUserLogin>().ToTable("UserLogins");
        }
    }
}