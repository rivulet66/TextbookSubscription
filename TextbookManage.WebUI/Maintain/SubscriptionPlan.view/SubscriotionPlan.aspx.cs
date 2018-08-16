

using CPMis.Web.WebControls;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web.UI;
using Telerik.Web.UI;
using TextbookSubscription.IApplication;
using TextbookSubscription.Infrastructure.ServiceLocators;
using TextbookSubscription.ViewModels;

namespace TextbookManage.WebUI.Maintain.SubscriptionPlan.view
{
    public partial class ModifySubscription : System.Web.UI.Page
    {

        private ISchoolAppl _schoolList = ServiceLocator.Current.GetInstance<ISchoolAppl>();
        private IDepartmentAppl _departmentList = ServiceLocator.Current.GetInstance<IDepartmentAppl>();

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GdStudentkSubscriptionPlan.DoDataBind();
                OnSchoolCmb();
            }
        }
        /// <summary>
        /// 学院下拉框 事件
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        private void OnSchoolCmb()
        {
            var list = _schoolList.GetAll();
            cmb_School.DataSource = list;
            cmb_School.DataBind();

            var departmentList = _departmentList.GetDepartmentList(list.First().SchoolName);
            cmb_Department.DataSource = departmentList;
            cmb_Department.DataBind();
        }

        private void OnDepartmentCmb()
        {
            var schoolName = cmb_School.Text;
            var departmentList = _departmentList.GetDepartmentList(schoolName);
            cmb_Department.DataSource = departmentList;
            cmb_Department.DataBind();
        }

        protected void OnSchoolCmbTextChange(object sender,EventArgs e)
        {
            OnDepartmentCmb();
        }

        /// <summary>
        /// 查询
        /// </summary>
        /// <param name="sender"></param>
        /// <param name="e"></param>
        protected void BtnQuery_OnClick(object sender,EventArgs e)
        {

        }

        protected void BtnExport_OnClick(object sender,EventArgs e)
        {

        }

        protected void RadAjaxManager1_OnAjaxRequest(object sender,EventArgs e)
        {

        }

        protected void GdStudentkSubscriptionPlan_OnBeforeDataBind(object sender,EventArgs e)
        {
            IList<SubscriptionPlanView> list = new List<SubscriptionPlanView>
            {
                new SubscriptionPlanView()
                {
                    SubscriptionPlanID = "01",
                    TextbookID = "01",
                    TextbookName = "计算机操作系统",
                    Press = "西安电子科技大学出版社",
                    Price = 46.8,
                    DeclarationCount = 41,
                    SpareCount = 41,
                    BooksellerName = "衡阳学府",
                    Contact = "欧阳磊",
                    Telephone = "--",
                    FeedbackDate = "2018-08-14",
                    FeedbackStatus = "已审核",
                    Remark = "--",
                    ApprovalStatus = "审核通过"
                }
            };
            GdStudentkSubscriptionPlan.DataSource = list;
        }

        protected void RadAjaxManager1_AjaxSettingCreated(object sender, AjaxSettingCreatedEventArgs e)
        {
            if (e.Updated.ID == "RadAjaxManager1")
                e.UpdatePanel.RenderMode = UpdatePanelRenderMode.Block;
        }

        protected void GdStudentkSubscriptionPlan_OnItemCommand(object sender,EventArgs e)
        {

        }

        protected void GdStudentkSubscriptionPlan_OnBeforePageIndexChanged(object sender,EventArgs e)
        {

        }

        protected void ChkAll_OnCheckedChanged(object sender,EventArgs e)
        {
            var control = sender as CPMisCheckBox;
            var isChecked = control.Checked;
            GdStudentkSubscriptionPlan.SetAllCheckControlState(isChecked);
        }
    }
}