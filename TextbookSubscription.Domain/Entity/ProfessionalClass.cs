namespace TextbookSubscription.Domain.Entity
{
    using TextbookSubscription.Domain;

    public class ProfessionalClass : AggregateRoot
    {
        /// <summary>
        /// 班级ID,GUID值
        /// </summary>
        public string ClassID { get; set; }

        /// <summary>
        /// 班级编号
        /// </summary>
        public string ClassNum { get; set; }

        /// <summary>
        /// 班级名称
        /// </summary>
        public string ClassName { get; set; }

        /// <summary>
        /// 年级
        /// </summary>
        public string Grade { get; set; }

        /// <summary>
        /// 班级对应的学院ID
        /// </summary>
        public string SchoolID { get; set; }
    }
}
