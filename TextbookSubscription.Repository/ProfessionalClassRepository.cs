namespace TextbookSubscription.Repository
{
    using TextbookSubscription.Domain.Entity;
    using TextbookSubscription.Domain;
    using TextbookSubscription.Domain.IRepositories;

    public class ProfessionalClassRepository : EFRepository<ProfessionalClass>, IProfessionalClassRepository
    {
        public ProfessionalClassRepository(IRepositoryDbContext context)
            :base(context)
        {

        }
    }
}
