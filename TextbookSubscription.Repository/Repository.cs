namespace TextbookSubscription.Repository
{
    using TextbookSubscription.Domain;
    using TextbookSubscription.Domain.EFDbContext;
    using TextbookSubscription.Domain.IRepositories;
    using System.Collections.Generic;
    using System;
    using System.Linq.Expressions;
    using System.Linq;


    /// <summary>
    /// 规定仓库的基础方法
    /// </summary>
    /// <typeparam name="TEntity"></typeparam>
    public abstract class Repository<TAggregateRoot> : IRepository<TAggregateRoot>, IDisposable
        where TAggregateRoot : class, IAggregateRoot
    {
        #region 私有变量

        /// <summary>
        /// 工作单元，数据上下文
        /// </summary>
        private readonly IRepositoryDbContext _context;

        #endregion

        #region 实现IDisposable

        public void Dispose()
        {
            _context.Dispose();
        }

        #endregion

        #region 构造函数

        public Repository(IRepositoryDbContext context)
        {
            this._context = context;
        }

        #endregion

        #region 实现IRepository<TAggreagate>

        public IRepositoryDbContext Context
        {
            get { return _context; }
        }

        public abstract IEnumerable<TAggregateRoot> GetAll();

        public abstract IEnumerable<TAggregateRoot> Find(Expression<Func<TAggregateRoot, bool>> expression);

        public abstract TAggregateRoot Single(Expression<Func<TAggregateRoot, bool>> expression);

        public abstract TAggregateRoot First(Expression<Func<TAggregateRoot, bool>> expression);

        public abstract void Add(TAggregateRoot entity);

        public abstract void Remove(TAggregateRoot entity);

        public abstract void Remove(Expression<Func<TAggregateRoot, bool>> expression);

        public abstract void Modify(TAggregateRoot entity);

        public abstract void Modify(Expression<Func<TAggregateRoot, bool>> filterExpression, 
            Expression<Func<TAggregateRoot, TAggregateRoot>> updateExpression);

        //ISql部分
        public abstract IEnumerable<TEntity> ExecuteQuery<TEntity>(string sqlQuery, params object[] parameters) 
            where TEntity : class, IEntity;

        public abstract int ExecuteCommand(string sqlCommand, params object[] parameters);

        #endregion

    }

}
