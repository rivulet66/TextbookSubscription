namespace TextbookSubscription.Repository
{
    using System.Collections.Generic;
    using TextbookSubscription.Domain;
    using System.Data.Entity;
    using System.Linq;
    using System.Linq.Expressions;
    using System;
    using Z.EntityFramework.Plus;

    public class EFRepository<TAggregateRoot> : Repository<TAggregateRoot>
        where TAggregateRoot : class, IAggregateRoot
    {
        #region 私有变量

        private readonly IEFRepositoryDbContext _context;

        #endregion

        #region Proteced 属性

        /// <summary>
        /// 存储上下文
        /// </summary>
        protected IEFRepositoryDbContext EFContext
        {
            get { return _context; }
        }

        /// <summary>
        /// 数据集
        /// </summary>
        protected DbSet<TAggregateRoot> Set
        {
            get { return _context.Context.Set<TAggregateRoot>(); }
        }

        #endregion

        #region 构造函数

        public EFRepository(IRepositoryDbContext context)
            :base(context)
        {
            if (context is IEFRepositoryDbContext)
            {
                _context = context as IEFRepositoryDbContext;
            }
        }

        #endregion

        #region 实现Repository<TAggregateRoot>

        public override IEnumerable<TAggregateRoot> GetAll()
        {
            //不启用更改跟踪，启用并行化查询
            return Set.AsParallel().ToList();
        }

        public override IEnumerable<TAggregateRoot> Find(Expression<Func<TAggregateRoot, bool>> expression)
        {
            //启用并行化查询
            return Set.Where(expression).AsParallel().ToList();
        }

        public override TAggregateRoot Single(Expression<Func<TAggregateRoot, bool>> expression)
        {
            return Set.SingleOrDefault(expression);
        }

        public override TAggregateRoot First(Expression<Func<TAggregateRoot, bool>> expression)
        {
            return Set.FirstOrDefault(expression);
        }

        public override void Add(TAggregateRoot entity)
        {
            _context.RegisterNew(entity);
        }

        public override void Remove(TAggregateRoot entity)
        {
            _context.RegisterDeleted<TAggregateRoot>(entity);
        }

        public override void Modify(TAggregateRoot entity)
        {
            _context.RegisterModified<TAggregateRoot>(entity);
        }

        public override IEnumerable<TEntity> ExecuteQuery<TEntity>(string sqlQuery, params object[] parameters)
        {
            //将查询结果转换为实体，但不提供跟踪更改
            return _context.Context.Database.SqlQuery<TEntity>(sqlQuery, parameters).AsParallel().ToList();
        }

        public override int ExecuteCommand(string sqlCommand, params object[] parameters)
        {
            //标准ADO.NET命令
            return _context.Context.Database.ExecuteSqlCommand(sqlCommand, parameters);
        }

        public override void Remove(Expression<Func<TAggregateRoot, bool>> expression)
        {
            Set.Where(expression).Delete();
        }

        public override void Modify(Expression<Func<TAggregateRoot, bool>> filterExpression, 
            Expression<Func<TAggregateRoot, TAggregateRoot>> updateExpression)
        {
            Set.Where(filterExpression).Update(updateExpression);
        }

        #endregion

    }
}
