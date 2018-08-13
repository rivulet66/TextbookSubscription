namespace TextbookSubscription.Domain.EntityMapping
{
    using System.Data.Entity.ModelConfiguration;
    using TextbookSubscription.Domain.Entity;
    using System.ComponentModel.DataAnnotations.Schema;

    public class ProfessionalClassMap : EntityTypeConfiguration<ProfessionalClass>
    {
        public ProfessionalClassMap()
        {
            //Primary Key
            HasKey(t => t.ClassID);

            //Table && Column Mappings
            ToTable("ProfessionalClass", "dbo");

            //Ignore
            Ignore(t => t.ID);
        }
    }
}
