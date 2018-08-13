namespace TextbookSubscription.Repository
{
    using TextbookSubscription.Domain.Entity;
    using TextbookSubscription.Domain;
    using TextbookSubscription.Domain.IRepositories;

    public class TermRepository : EFRepository<Term>, ITermRepository
    {
        public TermRepository(IRepositoryDbContext dbContext)
            :base(dbContext)
        {

        }
    }

}
