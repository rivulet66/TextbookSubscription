namespace TextbookSubscription.Domain.EntityMapping
{
    using System.ComponentModel.DataAnnotations.Schema;
    using System.Data.Entity.ModelConfiguration;
    using TextbookSubscription.Domain.Entity;

    public class TermMap : EntityTypeConfiguration<Term>
    {
        public TermMap()
        {
            //Primary Key
            HasKey(t => t.TermNum);
            Property(t => t.TermNum)
                .HasDatabaseGeneratedOption(DatabaseGeneratedOption.Identity);

            //Properties
            Property(t => t.IsCurrentTerm)
                .HasMaxLength(1);

            //Table && Column Mappings
            ToTable("Term", "dbo");
            Property(t => t.TermName).HasColumnName("Term");

            //Ingore property
            //Term table have no Guid
            Ignore(t => t.ID);
        }
    }
}
