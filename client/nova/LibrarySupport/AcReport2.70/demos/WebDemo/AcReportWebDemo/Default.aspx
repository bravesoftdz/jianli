<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="AcReportWebDemo._Default" %>

<html>
<head id="Head1" runat="server">
    <title>AcReport报表</title>
    <link rel="stylesheet" type="text/css" href="/Style/Main.css" />

    <script type="text/javascript" src="Js/jquery.js"></script>

    <script type="text/javascript" language="javascript">
        function win_load() {
            var myPrintArea = document.getElementById("myPrintArea");
            myPrintArea.style.width = window.document.body.offsetWidth;
            myPrintArea.style.height = window.document.body.offsetHeight - 30;
            var objAcReport = document.getElementById("AcReport");
            objAcReport.style.height = window.document.body.offsetHeight - 60;
        }
        function ShowDesigner() {
            var objAcReport = document.getElementById("AcReport");
            objAcReport.ReportEngine.ShowDesigner();
        }
        function SetAcReportUrl(url) {
            jQuery(document).ready(function() {
                try {
                    var objAcReport = document.getElementById('AcReport');
                    objAcReport.OpenRepFromURL(url, 0);
                } catch (e) { }
            });
        }
        function ShowDesinger(url) {
            var objAcReport = document.getElementById("AcReport");
            url = "http://localhost:7759" + url;
            alert(url);
            objAcReport.LoadAptFromURL(url);
            objAcReport.ShowDesigner();
            return false;
        }
    </script>

</head>
<body scroll="no" onload="win_load();" onresize="win_load();">
    <form id="form1" runat="server">
    <table class="page_list_header" style="width: 100%" cellspacing="0" cellpadding="4">
        <tr>
            <td>
                <asp:Label ID="lblSummaryCaption" runat="server" Text="报表预览"></asp:Label>
            </td>
            <td align="right">
            </td>
        </tr>
    </table>
    <div id="myPrintArea" style="overflow: auto">
        <table border="0" style="width: 100%" cellspacing="0" cellpadding="0" align="center">
            <tr>
                <td>
                    <asp:LinkButton ID="LinkButton1" runat="server" OnClick="LinkButton1_Click">多种样式单元格</asp:LinkButton>
                    <asp:LinkButton ID="LinkButton2" runat="server" OnClick="LinkButton2_Click">普通清单</asp:LinkButton>
                    <asp:LinkButton ID="LinkButton3" runat="server" OnClick="LinkButton3_Click">自动合并/销售明细表</asp:LinkButton>
                    <asp:LinkButton ID="LinkButton4" runat="server" OnClick="LinkButton4_Click">主从报表</asp:LinkButton>
                    <asp:LinkButton ID="LinkButton5" runat="server" OnClick="LinkButton5_Click">分组报表</asp:LinkButton>
                    <asp:LinkButton ID="LinkButton6" runat="server" OnClientClick="return ShowDesinger('/report/00.rpt');">设计报表示例</asp:LinkButton>
                </td>
            </tr>
            <tr>
                <td align="center">
                    <object id="AcReport" classid="clsid:62E6B2C0-43AF-4FEA-A0E5-0B496DA5A681" codebase="../../../ActiveX/Setup.exe"
                        style="font-size: 10px; background-color: #eeeeee; width: 100%;">
                    </object>
                </td>
            </tr>
        </table>
    </div>
    </form>
</body>
</html>
<%--<script type="text/javascript">
    SetAcReportUrl("http://localhost:7759/outputfile/00.acr");
</script>--%>