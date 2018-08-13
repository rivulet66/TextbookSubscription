using System;
using System.Collections.Generic;
using CPMis.Web.WebControls;
using Telerik.Web.UI;
using TextbookSubscription.ViewModels;
using TextbookSubscription.IApplication;
using TextbookSubscription.Infrastructure.ServiceLocators;

namespace TextbookManage.WebUI.Tb_Maintain.Tb_Maintain_1
{
    public partial class TextbookImport : System.Web.UI.Page
    {
        private ITermAppl _appl = ServiceLocator.Current.GetInstance<ITermAppl>();
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                GdStudentDeclare.DoDataBind();
                //学年学期视图
                ComBoxTerm();
            }
        }
        protected void ComBoxTerm()
        {

            var list = _appl.GetAll();
            cmb_Term.DataSource = list;
            cmb_Term.DataBind();
        }

        protected void RadAjaxManager1_OnAjaxRequest(object sender, AjaxRequestEventArgs e)
        {
            var argument = e.Argument;
            switch (argument)
            {
                case "Delete":
                    DeleteTextbook();
                    break;
                case "Help":
                    //OpenHelpFile("/Help/SystemManage/系统管理.htm");
                    break;
                default:
                    GdStudentDeclare.DoDataBind();
                    break;
            }
        }


        private void DeleteTextbook()
        {
            ////取出选中的记录
            //SaveCheckedState();
            //var data = GdStudentDeclare.GetAllCheckedDataList<TextbookView>();
            //if (data.Count > 0)
            //{
            //    //删除
            //    var result = _appl.Remove(data);
            //    CPMis.Web.WebClient.ScriptManager.Alert(result.Message);
            //    GdStudentDeclare.DoDataBind();
            //}
            //else
            //{
            //    //客户端消息
            //    CPMis.Web.WebClient.ScriptManager.Alert("还没有选择待删除的记录!");
            //}
        }

        private void SaveCheckedState()
        {
            //GdStudentDeclare.PersistCheckState<TextbookView>();
        }

        private void OpenNewWindow(string url, string textbookId)
        {
            var path = $"{url}?TextbookId={textbookId}";
            CPMis.Web.WebClient.ScriptManager.OpenRadWindow(path, "RadWindow1");
        }

        protected void BtnQuery_OnClick(object sender, EventArgs e)
        {

            var data = cmb_Term.DataSource;
            //GdStudentDeclare.DoDataBind();
        }



        protected void GdStudentDeclare_OnBeforeDataBind(object sender, EventArgs e)
        {
            IList<ImportStudentDeclarationView> list = new List<ImportStudentDeclarationView>();
            list.Add(new ImportStudentDeclarationView()
            {
                DeclarationID = "1",
                TextbookID = "1",
                DataSign = "本部",
                SchoolName = "计算机学院",
                DepartmentName = "软件工程",
                ClassName = "04班",
                CourseName = "数据库原理与技术",
                TextbookName = "SQL Server",
                Press = "清华大学出版社",
                Price = 12.3,
                DeclarationCount = 100,
                Mobile = "1586752553",
                ImportDate = DateTime.Now,
                ApprovalStatus = "未审核",
                Priority = "优选",
                NeedTextbook = "是",
                Remarks = ""
            });
            GdStudentDeclare.DataSource = list;
        }

        protected void GdStudentDeclare_OnItemCommand(object sender, GridCommandEventArgs e)
        {

        }

        protected void GdStudentDeclare_OnBeforePageIndexChanged(object sender, EventArgs e)
        {
            SaveCheckedState();
        }

        protected void ChkAll_OnCheckedChanged(object sender, EventArgs e)
        {
            var control = sender as CPMisCheckBox;
            var isChecked = control.Checked;
            GdStudentDeclare.SetAllCheckControlState(isChecked);
        }

    }
}