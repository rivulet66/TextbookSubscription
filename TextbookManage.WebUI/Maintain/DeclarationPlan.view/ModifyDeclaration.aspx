<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="ModifyDeclaration.aspx.cs" Inherits="TextbookManage.WebUI.Maintain_1.RetifyDeclaration" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>修改申报</title>
    <style type="text/css">
        .table,.cell11,.cell12,.cell13{
            border:0px;
            margin:0px;
            padding:0px;
        }
        .cell11{
            text-align:right;
            width:62px;
        }
        .cell12{
            text-align:center;
            width:182px;
        }
        .cell13{
            text-align:center;
            width:80px;
        }
    </style>
</head>
<body>
    <form id="form1" runat="server">
        <telerik:RadStyleSheetManager runat="server" ID="RadStyleSheetManager1">
        </telerik:RadStyleSheetManager>
        <telerik:RadScriptManager ID="RadScriptManager1" runat="server">
        </telerik:RadScriptManager>
        <telerik:RadSkinManager ID="RadSkinManager1" runat="server">
        </telerik:RadSkinManager>
        <telerik:RadToolTipManager ID="RadToolTipManager1" runat="server" AutoTooltipify="true">
        </telerik:RadToolTipManager>
        <telerik:RadFormDecorator ID="RadFormDecorator1" runat="server" DecoratedControls="All"></telerik:RadFormDecorator>
        <%--脚本块，放置JS代码--%>
        <telerik:RadCodeBlock ID="RadCodeBlock1" runat="server">

            <script type="text/javascript">
                //如果点击的是导出按钮则将AJAX禁用
                function onRequestStart(sender, args) {
                    if (args.get_eventTarget().indexOf("ExportToExcelButton") >= 0 ||
                        args.get_eventTarget().indexOf("ExportToWordButton") >= 0 ||
                        args.get_eventTarget().indexOf("ExportToPdfButton") >= 0 ||
                        args.get_eventTarget().indexOf("ExportToCsvButton") >= 0) {

                        args.set_enableAjax(false);
                    }
                }
                //工具栏
                function OnToolBarButtonClicked(sender, args) {
                    var button = args.get_item();
                    var command = button.get_commandName();
                    var a = true;
                    if (command == "Add") {
                        var oWnd = $find("<%=RadWindow1.ClientID%>");
                        oWnd.setUrl(encodeURI("TextbookAdd.aspx?Id=" + "")); //
                        oWnd.show();
                        args.set_cancel(true);
                    }
                    else if (command == "Import") {
                        var oWnd = $find("<%=RadWindow2.ClientID%>");
                        oWnd.setUrl(encodeURI("Import.aspx"));
                        oWnd.show();
                        args.set_cancel(true);
                    }
                    else if (command == "Help") {
                        refreshGrid("Help");
                        args.set_cancel(true);
                    }
                }
                //Grid编辑
                function OnClientUpdateCommand(textbookId) {
                    var oWnd = $find("<%=RadWindow1.ClientID%>");
                    oWnd.setUrl(encodeURI("TextbookAdd.aspx?Id=" + textbookId)); //
                    oWnd.show();
                    //oWnd.setSize(800, 380);
                }
                //异步回调,刷新Grid
                function refreshGrid(arg) {
                    $find("<%= RadAjaxManager1.ClientID %>").ajaxRequest(arg);
                }
            </script>
        </telerik:RadCodeBlock>

        <%--AJAX放置处--%>
        <telerik:RadAjaxManager ID="RadAjaxManager1" runat="server" DefaultLoadingPanelID="RadAjaxLoadingPanel1" RenderMode="Inline"
            OnAjaxRequest="RadAjaxManager1_OnAjaxRequest">
            <ClientEvents OnRequestStart="onRequestStart" />
            <AjaxSettings>
                <telerik:AjaxSetting AjaxControlID="RadAjaxManager1">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="GdStudentModifyDeclare" />

                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="cmb_School">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="cmb_Department" />
                        <telerik:AjaxUpdatedControl ControlID="GdStudentModifyDeclare" LoadingPanelID="RadAjaxLoadingPanel1" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="cmb_Department">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="GdStudentModifyDeclare" LoadingPanelID="RadAjaxLoadingPanel1" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
            </AjaxSettings>
        </telerik:RadAjaxManager>
        <telerik:RadAjaxLoadingPanel ID="RadAjaxLoadingPanel1" runat="server">
        </telerik:RadAjaxLoadingPanel>
        <div>
            <%--顶部工具栏--%>
            <cp:CPMisToolBar ID="ToolBar1" OnClientButtonClicking="OnToolBarButtonClicked" runat="server" SkinID="ToolBarSkin">
                <Items>
                    <telerik:RadToolBarButton Text="添加" CommandName="Add" ToolTip="添加申报计划" ImageUrl="../Img/tlb_Add.png">
                    </telerik:RadToolBarButton>
                    <telerik:RadToolBarButton Text="修改" CommandName="Modify" ToolTip="修改申报计划" ImageUrl="../Img/tbl_Change.png">
                    </telerik:RadToolBarButton>
                    <telerik:RadToolBarButton Text="帮助" CommandName="Help" ToolTip="点击获取帮助" ImageUrl="../Img/tlb_Help.png">
                    </telerik:RadToolBarButton>
                </Items>
            </cp:CPMisToolBar>

            <%--页面标签的标题--%>
            <cp:CPMisTabStrip ID="TabStrip1" runat="server" MultiPageID="MpTextbookManage">
                <Tabs>
                    <cp:CPMisTab Text="学生申报(S)" AccessKey="S" PageViewID="GdStudentImport">
                    </cp:CPMisTab>
                    <cp:CPMisTab Text="教师申报(T)" AccessKey="T" PageViewID="GdTeacherImport">
                    </cp:CPMisTab>
                </Tabs>
            </cp:CPMisTabStrip>
            <%--页面标签对应的页面集合--%>
            <cp:CPMisMultiPage ID="MpTextbookManage" runat="server" SkinID="Auto">

                <%--页面标签对应的某一个页面--%>

                <cp:CPMisPageView ID="GdStudentImport" runat="server">
                    <%--查询--%>
                    <div id="div3" runat="server" style="padding-left: 5px; padding-top: 2px; text-align: left; background-color: #E1EBF7;">
                        <table cellspacing="0px" cellpadding="0px" class="table" width="600px">
                            <tr>
                                <td class="cell11">
                                    <cp:CPMisLabel ID="CPMisLabel4" runat="server" Text="开课学院：" SkinID="Average"></cp:CPMisLabel>
                                </td>
                                <td class="cell12">
                                    <cp:CPMisComboBox runat="server" ID="cmb_School" AutoPostBack="True"
                                        DataTextField="SchoolName" DataValueField="SchoolName" OnTextChanged="OnSchoolCmbTextChange" DefaultIndex="0" IsCancelDataBind="False"
                                        IsMaintainSelectedValue="False" SelectedText="" SkinID="cmb180">
                                    </cp:CPMisComboBox>
                                </td>
                                <td class="cell11">
                                    <cp:CPMisLabel ID="CPMisLabel3" runat="server" Text="教研室：" SkinID="Average"></cp:CPMisLabel>
                                </td>
                                <td class="cell12">
                                    <cp:CPMisComboBox runat="server" ID="cmb_Department" AutoPostBack="True"
                                        DataTextField="DepartmentName" DataValueField="DepartmentName" DefaultIndex="0" IsCancelDataBind="False"
                                        IsMaintainSelectedValue="False" SelectedText="" SkinID="cmb180">
                                    </cp:CPMisComboBox>
                                </td>
                                <td class="cell13">
                                    <cp:CPMisButton runat="server" ID="cbtnQuery" Text="查询" OnClick="BtnQuery_OnClick"></cp:CPMisButton>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <%--学生申报查询结果"--%>
                    <cp:CPMisGrid ID="GdStudentModifyDeclare" runat="server" SkinID="AutoPages"
                        OnBeforeDataBind="GdStudentModifyDeclare_OnBeforeDataBind" OnItemCommand="GdStudentModifyDeclare_OnItemCommand"
                        OnBeforePageIndexChanged="GdStudentModifyDeclare_OnBeforePageIndexChanged">
                        <MasterTableView>
                            <Columns>
                                <%--序号--%>
                                <telerik:GridTemplateColumn HeaderText="序号" HeaderStyle-Width="40px">
                                    <ItemTemplate><%#Container .DataSetIndex +1 %></ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <%--数据列--%>
                                <telerik:GridBoundColumn DataField="DeclarationID" UniqueName="DeclarationID" Visible="false"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="TextbookID" UniqueName="TextbookId" Visible="false"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="学院名称" DataField="SchoolName" HeaderStyle-Width="80px"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="教研室名称" DataField="DepartmentName" HeaderStyle-Width="80px"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="课程名称" DataField="CourseName" HeaderStyle-Width="80px"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="班级" DataField="ClassName"></telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn HeaderText="书名" HeaderStyle-Width="120px">
                                    <ItemTemplate>
                                        <cp:CPMisLinkButton ID="LnkShowTextbook" Text='<%#Eval("TextbookName") %>' CommandName="ShowTextbook" runat="server"></cp:CPMisLinkButton>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn HeaderText="出版社" DataField="Press" HeaderStyle-Width="80px"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="价格" DataField="Price"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="电话" DataField="Mobile" HeaderStyle-Width="80px"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="导入时间" DataField="ImportDate" HeaderStyle-Width="80px"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="审核状态" DataField="ApprovalStatus"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="优选状态" DataField="Priority"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="数据标识" DataField="DataSign"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="需要教材" DataField="NeedTextbook"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="备注" DataField="Remarks"></telerik:GridBoundColumn>
                            </Columns>
                        </MasterTableView>
                    </cp:CPMisGrid>
                </cp:CPMisPageView>

                <%--  <%--教师申报查询结果 --%>
                <cp:CPMisPageView ID="GdTeacherImport" runat="server">

                    <%--查询部分--%>
                    <div id="div2" runat="server" style="padding-left: 5px; padding-top: 2px; text-align: left; background-color: #E1EBF7;">
                        <cp:CPMisLabel ID="CPMisLabel1" runat="server" Text="教材名称：" SkinID="AutoSize"></cp:CPMisLabel>&nbsp;&nbsp;
                        <cp:CPMisTextBox runat="server" ID="CPMisTextBox1" SkinID="AutoSize"></cp:CPMisTextBox>&nbsp;&nbsp;
                        <cp:CPMisLabel ID="CPMisLabel2" runat="server" Text="ISBN：" SkinID="AutoSize"></cp:CPMisLabel>&nbsp;&nbsp;
                        <cp:CPMisTextBox runat="server" ID="CPMisTextBox2" SkinID="AutoSize"></cp:CPMisTextBox>&nbsp;&nbsp;
                        <cp:CPMisButton runat="server" ID="CPMisButton1" Text="查询" OnClick="BtnQuery_OnClick"></cp:CPMisButton>
                    </div>

                </cp:CPMisPageView>
            </cp:CPMisMultiPage>
            <%--弹窗管理器--%>
            <telerik:RadWindowManager ID="RadWindowManager1" runat="server">
                <Windows>
                    <telerik:RadWindow ID="RadWindow1" runat="server" Top="100" Left="100" Width="800" Height="380">
                    </telerik:RadWindow>
                    <telerik:RadWindow ID="RadWindow2" runat="server" Top="100" Left="200" Width="400" Height="180">
                    </telerik:RadWindow>
                </Windows>
            </telerik:RadWindowManager>
        </div>
    </form>
</body>
</html>
