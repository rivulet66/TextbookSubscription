using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace TextbookSubscription.ViewModels
{
    public class SubscriptionPlanView : BaseViewModel
    {
        /// <summary>
        /// 征订计划ID
        /// </summary>
        public string SubscriptionPlanID { get; set; }

        /// <summary>
        /// 教材ID
        /// </summary>
        public string TextbookID { get; set; }

        /// <summary>
        /// 教材名称
        /// </summary>
        public string TextbookName { get; set; }

        /// <summary>
        /// 出版社
        /// </summary>
        public string Press { get; set; }

        /// <summary>
        /// 价格
        /// </summary>
        public double Price { get; set; }

        /// <summary>
        /// 申报数量
        /// </summary>
        public int DeclarationCount { get; set; }

        /// <summary>
        /// 上抛数量
        /// </summary>
        public int SpareCount { get; set; }

        /// <summary>
        /// 书商名称
        /// </summary>
        public string BooksellerName { get; set; }

        /// <summary>
        /// 联系人
        /// </summary>
        public string Contact { get; set; }

        /// <summary>
        /// 联系电话
        /// </summary>
        public string Telephone { get; set; }

        /// <summary>
        /// 回告时间
        /// </summary>
        public string FeedbackDate { get; set; }

        /// <summary>
        /// 回告状态
        /// </summary>
        public string FeedbackStatus { get; set; }

        /// <summary>
        /// 回告说明
        /// </summary>
        public string Remark { get; set; }

        /// <summary>
        /// 审核状态
        /// </summary>
        public string ApprovalStatus { get; set; }
    }
}
