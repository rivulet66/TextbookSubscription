<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="SubscriotionPlan.aspx.cs" Inherits="TextbookManage.WebUI.Maintain.SubscriptionPlan.view.ModifySubscription" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>查询计划回告</title>
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
                        <telerik:AjaxUpdatedControl ControlID="GdStudentkSubscriptionPlan" />

                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="cmb_School">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="cmb_Department" />
                        <telerik:AjaxUpdatedControl ControlID="GdStudentkSubscriptionPlan" LoadingPanelID="RadAjaxLoadingPanel1" />
                    </UpdatedControls>
                </telerik:AjaxSetting>
                <telerik:AjaxSetting AjaxControlID="cmb_Department">
                    <UpdatedControls>
                        <telerik:AjaxUpdatedControl ControlID="GdStudentkSubscriptionPlan" LoadingPanelID="RadAjaxLoadingPanel1" />
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
                    <telerik:RadToolBarButton Text="添加" CommandName="Add" ToolTip="添加回告" ImageUrl="../../Img/tlb_Add.png">
                    </telerik:RadToolBarButton>
                    <telerik:RadToolBarButton Text="修改" CommandName="Modify" ToolTip="修改回告" ImageUrl="../../Img/tlb_Change.png">
                    </telerik:RadToolBarButton>
                    <telerik:RadToolBarButton Text="帮助" CommandName="Help" ToolTip="点击获取帮助" ImageUrl="../../Img/tlb_Help.png">
                    </telerik:RadToolBarButton>
                </Items>
            </cp:CPMisToolBar>

            <%--页面标签的标题--%>
            <cp:CPMisTabStrip ID="TabStrip1" runat="server" MultiPageID="MpSubscriptionManage">
                <Tabs>
                    <cp:CPMisTab Text="学生用书回告(S)" AccessKey="S" PageViewID="GdStudentSubscriptionPlan">
                    </cp:CPMisTab>
                    <cp:CPMisTab Text="教师用书回告(T)" AccessKey="T" PageViewID="GdTeacherSubscriptionPlan">
                    </cp:CPMisTab>
                </Tabs>
            </cp:CPMisTabStrip>

            <%--页面标签对应的页面集合--%>
            <cp:CPMisMultiPage ID="MpSubscriptionManage" runat="server" SkinID="Auto">

                <%--页面标签对应的某一个页面--%>

                <cp:CPMisPageView ID="GdStudentSubscriptionPlan" runat="server">
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
                                <td>
                                    <cp:CPMisButton runat="server" ID="cbtnExport" Text="导出" OnClick="BtnExport_OnClick"></cp:CPMisButton>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <%--学生申报查询结果"--%>
                    <cp:CPMisGrid ID="GdStudentkSubscriptionPlan" runat="server" SkinID="AutoPages" CheckControlID="ChkRow"
                        OnBeforeDataBind="GdStudentkSubscriptionPlan_OnBeforeDataBind" OnItemCommand="GdStudentkSubscriptionPlan_OnItemCommand"
                        OnBeforePageIndexChanged="GdStudentkSubscriptionPlan_OnBeforePageIndexChanged">
                        <MasterTableView>
                            <Columns>
                                <%--复选框--%>
                                    <telerik:GridTemplateColumn UniqueName="CheckFlag" DataField="CheckFlag">
                                        <%--顶部的CheckBox--%>
                                        <%--
                                            OnCheckedChanged：当CheckBox的状态发生改变的时候触发的事件，即点击以及取消CheckBox时触发的事件
                                        --%>
                                        <HeaderTemplate>
                                            <cp:CPMisCheckBox ID="ChkAll" AutoPostBack="true" runat="server" OnCheckedChanged="ChkAll_OnCheckedChanged" />
                                        </HeaderTemplate>
                                        <%--每一项的CheckBox--%>
                                        <%--
                                            Checked：当ChexkBox被选中时触发的事件
                                        --%>
                                        <ItemTemplate>
                                            <cp:CPMisCheckBox ID="ChkRow" runat="server" Checked='<% #Eval("CheckFlag") %>' />
                                        </ItemTemplate>
                                        <HeaderStyle Width="30px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>
                                    <%--编辑按钮--%>
                                    <telerik:GridTemplateColumn HeaderText="编辑" >
                                        <%--
                                            onclick：当编辑图标被点击时触发的事件
                                        --%>
                                        <ItemTemplate>
                                            <img alt="编辑教材" src="../../Img/GridEdit.png" onclick="OnClientUpdateCommand('<%# Eval("TextbookId") %>')" />
                                        </ItemTemplate>
                                        <HeaderStyle Width="40px"></HeaderStyle>
                                    </telerik:GridTemplateColumn>
                                <%--序号--%>
                                <telerik:GridTemplateColumn HeaderText="序号" HeaderStyle-Width="40px">
                                    <ItemTemplate><%#Container .DataSetIndex +1 %></ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <%--数据列--%>
                                <telerik:GridBoundColumn DataField="SubscriptionPlanID" UniqueName="SubscriptionPlanID" Visible="false"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn DataField="TextbookID" UniqueName="TextbookID" Visible="false"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="学院名称" DataField="SchoolName" HeaderStyle-Width="80px"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="教研室名称" DataField="DepartmentName" HeaderStyle-Width="80px"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="课程名称" DataField="CourseName" HeaderStyle-Width="80px"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="班级" DataField="ClassName"></telerik:GridBoundColumn>
                                <telerik:GridTemplateColumn HeaderText="教材名称" HeaderStyle-Width="120px">
                                    <ItemTemplate>
                                        <cp:CPMisLinkButton ID="LnkShowTextbook" Text='<%#Eval("TextbookName") %>' CommandName="ShowTextbook" runat="server"></cp:CPMisLinkButton>
                                    </ItemTemplate>
                                </telerik:GridTemplateColumn>
                                <telerik:GridBoundColumn HeaderText="出版社" DataField="Press" HeaderStyle-Width="80px"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="价格" DataField="Price"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="申报数量" DataField="DeclarationCount"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="上抛数量" DataField="SpareCount"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="书商名称" DataField="BooksellerName"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="联系人" DataField="Contact"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="联系电话" DataField="Telephone" HeaderStyle-Width="80px"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="回告时间" DataField="FeedbackDate" HeaderStyle-Width="80px"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="回告状态" DataField="FeedbackStatus"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="审核状态" DataField="ApprovalStatus"></telerik:GridBoundColumn>
                                <telerik:GridBoundColumn HeaderText="备注" DataField="Remark"></telerik:GridBoundColumn>
                            </Columns>
                        </MasterTableView>
                    </cp:CPMisGrid>
                </cp:CPMisPageView>

                <%--  <%--教师申报查询结果 --%>
                <cp:CPMisPageView ID="GdTeacherSubscriptionPlan" runat="server">

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
