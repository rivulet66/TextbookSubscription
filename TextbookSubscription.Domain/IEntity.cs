namespace TextbookSubscription.Domain
{
    using System;

    public interface IEntity
    {
        /// <summary>
        /// 获取当前领域实体类的全局唯一标识。
        /// </summary>
        Guid ID { get; }
    }
}
