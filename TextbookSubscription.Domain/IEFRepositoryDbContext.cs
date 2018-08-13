namespace TextbookSubscription.Domain
{
    using System.Data.Entity;

    public interface IEFRepositoryDbContext : IRepositoryDbContext
    {
        /// <summary>
        /// 获取当前仓储上下文所使用的Entity Framework的<see cref="DbContext"/>实例。
        /// </summary>
        DbContext Context { get; }
    }
}
