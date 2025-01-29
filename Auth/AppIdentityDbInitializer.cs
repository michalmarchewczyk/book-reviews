using System;
using System.Data.Entity;
using System.Linq;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.EntityFramework;

namespace BookReviews.Auth
{
    public class AppIdentityDbInitializer : CreateDatabaseIfNotExists<AppIdentityDbContext>
    {
        public override void InitializeDatabase(AppIdentityDbContext context)
        {
            base.InitializeDatabase(context);
        }

        protected override void Seed(AppIdentityDbContext context)
        {
            base.Seed(context);

            // add roles
            var adminRole = new IdentityRole { Name = AuthRole.Admin.ToString() };
            var userRole = new IdentityRole { Name = AuthRole.User.ToString() };
            context.Roles.Add(adminRole);
            context.Roles.Add(userRole);

            // add users
            var passwordHasher = new PasswordHasher();
            var adminUser = new AppIdentityUser
            {
                UserName = "admin",
                Email = "admin@example.com",
                FirstName = "",
                LastName = "Administrator",
                PasswordHash = passwordHasher.HashPassword("admin"),
                SecurityStamp = Guid.NewGuid().ToString("D")
            };
            var testUser = new AppIdentityUser
            {
                UserName = "test",
                Email = "test@example.com",
                FirstName = "Test",
                LastName = "User",
                PasswordHash = passwordHasher.HashPassword("test"),
                SecurityStamp = Guid.NewGuid().ToString("D")
            };
            context.Users.Add(adminUser);
            context.Users.Add(testUser);

            context.SaveChanges();

            // assign user roles
            AssignRole(context, adminUser, AuthRole.Admin);
            AssignRole(context, adminUser, AuthRole.User);
            AssignRole(context, testUser, AuthRole.User);
        }

        private static void AssignRole(AppIdentityDbContext context, AppIdentityUser user, AuthRole authRole)
        {
            var roleId = context.Roles.First(r => r.Name == authRole.ToString()).Id;
            context.Set<IdentityUserRole>().Add(new IdentityUserRole
            {
                RoleId = roleId,
                UserId = user.Id
            });
        }
    }
}