namespace TextbookSubscription.Domain.Entity
{
    using System;

    public class Term : AggregateRoot
    {
        /// <summary>
        /// 学期编号
        /// </summary>
        public long TermNum { get; set; }

        /// <summary>
        /// 学年学期名称
        /// </summary>
        public string TermName { get; set; }

        /// <summary>
        /// 是否是当前学期
        /// </summary>
        public string IsCurrentTerm { get; set; }

        /// <summary>
        /// 开始时间
        /// </summary>
        public DateTime BeginDate { get; set; }

        /// <summary>
        /// 结束时间
        /// </summary>
        public DateTime EndDate { get; set; }
    }

}
