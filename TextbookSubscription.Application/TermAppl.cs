namespace TextbookSubscription.Application
{
    using System.Collections.Generic;
    using TextbookSubscription.Domain.IRepositories;
    using IApplication;
    using ViewModels;
    using TextbookSubscription.Infrastructure;

    public class TermAppl : ITermAppl
    {
        private ITermRepository _rep;
        private ITypeAdapter _adpater;
        public TermAppl(ITermRepository rep, ITypeAdapter adapter)
        {
            _rep = rep;
            _adpater = adapter;
        }
        public IEnumerable<TermView> GetAll()
        {
            var termList = _rep.GetAll();
            return _adpater.Adapt<TermView>(termList);
        }

        public TermView GetCurrent()
        {
            var term = _rep.Single(t => t.IsCurrentTerm == "1");
            return _adpater.Adapt<TermView>(term);
        }
    }
}
