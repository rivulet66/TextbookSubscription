using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TextbookSubscription.Domain
{
    public class AggregateRoot : IAggregateRoot
    {
        /// <summary>
        /// 获取当前领域实体类的全局唯一标识
        /// </summary>
        public Guid ID { get; set; }

        /// <summary>
        /// 确定指定的Object是否等于当前的Object
        /// </summary>
        /// <param name="obj">要与当前对象进行比较的对象</param>
        /// <returns>如果指定的Object与当前Object相等，则返回true，否则返回false</returns>
        public override bool Equals(object obj)
        {
            if (obj == null)
            {
                return false;
            }
            if (ReferenceEquals(this,obj))
            {
                return true;
            }
            if (!(obj is IAggregateRoot root))
            {
                return false;
            }
            return ID == root.ID;
        }

        /// <summary>
        /// 用作特定类型的哈希函数。
        /// </summary>
        /// <returns>当前Object的哈希代码。</returns>
        public override int GetHashCode()
        {
            return this.ID.GetHashCode();
        }


    }
}
