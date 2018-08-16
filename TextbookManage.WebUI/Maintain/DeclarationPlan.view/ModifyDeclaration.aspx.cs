using CPMis.Web.WebControls;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Telerik.Web.UI;
using TextbookSubscription.IApplication;
using TextbookSubscription.Infrastructure.ServiceLocators;
using TextbookSubscription.ViewModels;

namespace TextbookManage.WebUI.Maintain_1
{
    public partial class RetifyDeclaration : System.Web.UI.Page
    {
        private ISchoolAppl _schoolList = ServiceLocator.Current.GetInstance<ISchoolAppl>();
        private IDepartmentAppl _departmentList = ServiceLocator.Current.GetInstance<IDepartmentAppl>();

        //var schoolList;

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GdStudentModifyDeclare.DoDataBind();
                ComBoxSchool(); //学年学期 下拉框
               // ComBoxDepartment();
            }
        }
        /// <summary>
        /// 学院
        /// </summary>
        private void ComBoxSchool()
        {
            var list = _schoolList.GetAll();
            cmb_School.DataSource = list;
            cmb_School.DataBind();

            //var schoolName = cmb_School.Text;
            var departmentList = _departmentList.GetDepartmentList(list.First().SchoolName);
            cmb_Department.DataSource = departmentList;
            cmb_Department.DataBind();

            // CPMis.Web.WebClient.ScriptManager.Alert("comboxshool");
        }
        /// <summary>
        /// 教研室
        /// </summary>
        private void ComBoxDepartment()
        {
            var schoolName = cmb_School.Text;
            var list = _departmentList.GetDepartmentList(schoolName);
            cmb_Department.DataSource = list;
            cmb_Department.DataBind();
        }

        protected void OnSchoolCmbTextChange(object sender,EventArgs e)
        {
            ComBoxDepartment();
        }

        protected void RadAjaxManager1_OnAjaxRequest(object sender, AjaxRequestEventArgs e)
        {
            var argument = e.Argument;
            switch (argument)
            {
                case "Add":

                    break;
                case "Modify":

                    break;
                case "Help":

                    break;
                default:
                    GdStudentModifyDeclare.DoDataBind();
                    break;
            }
        }
        protected void RadAjaxManager1_AjaxSettingCreated(object sender, AjaxSettingCreatedEventArgs e)
        {
            if (e.Updated.ID == "RadAjaxManager1")
                e.UpdatePanel.RenderMode = UpdatePanelRenderMode.Block;
        }
        private void SaveCheckedState()
        {

        }
        private void OpenNewWindow(string url,string path)
        {

        }
        protected void BtnQuery_OnClick(object sender,EventArgs e)
        {
            CPMis.Web.WebClient.ScriptManager.Alert("btn clicked");
        }

        protected void GdStudentModifyDeclare_OnBeforeDataBind(object sender,EventArgs e)
        {
            IList<ModifyStudentDeclarationView> list = new List<ModifyStudentDeclarationView>();
            list.Add(new ModifyStudentDeclarationView()
            {
                DataSign = "本部",
                DeclarationID= "1",
                TextbookID="1",
                ClassName="软工四班",
                CourseName= "操作系统",
                TextbookName="计算机操作系统",
                Press="西安电子科技大学出版社",
                Price=32.2,
                DeclarationCount=30,
                Mobile= "11111111111",
                ImportDate=DateTime.Now,
                ApprovalStatus="未审核",
                Priority="优选",
                NeedTextbook="是",
                Remarks=""
            });
            GdStudentModifyDeclare.DataSource = list;
        }
        protected void GdStudentModifyDeclare_OnItemCommand(object sender,EventArgs e)
        {

        }
        protected void GdStudentModifyDeclare_OnBeforePageIndexChanged(object sender,EventArgs e)
        {
            SaveCheckedState();
        }
        protected void ChkAll_OnCheckedChanged(object sender, EventArgs e)
        {
            var control = sender as CPMisCheckBox;
            var isChecked = control.Checked;
            GdStudentModifyDeclare.SetAllCheckControlState(isChecked);
        }

    }
}