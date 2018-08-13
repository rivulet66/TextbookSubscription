using Microsoft.VisualStudio.TestTools.UnitTesting;
using System.Linq;
using TextbookSubscription.Repository;
using TextbookSubscription.Domain;

namespace TextbookSubscription.RepositoryTests
{
    [TestClass]
    public class ProfessionalClassRepositoryTests
    {
        public TestContext TestContext { get; set; }

        [TestMethod]
        public void RetriveAllClass()
        {
            ProfessionalClassRepository rep = new ProfessionalClassRepository(new EFRepositoryDbContext());
            //SELECT COUNT(*) FROM ProfessionalClass = 1868
            int totalCount = 1868;
            var termList = rep.GetAll();
            Assert.AreEqual(totalCount, termList.Count());
        }
    }
}
