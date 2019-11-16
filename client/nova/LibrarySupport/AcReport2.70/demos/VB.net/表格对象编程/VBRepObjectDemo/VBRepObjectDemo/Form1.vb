Imports AcReport

Public Class Form1
    Dim mac As AcReport.AcRptEngine '定义一个AcRptEngine成员变量

    Private Sub button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button1.Click
        mac.ShowDesigner()
    End Sub

    Private Sub Form1_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        mac = New AcReport.AcRptEngine()
        Dim sfile As String = System.IO.Path.GetDirectoryName(Application.ExecutablePath) + "\test.apt"
        If System.IO.File.Exists(sfile) Then
            mac.LoadFromFile(sfile)
        End If
    End Sub

    Private Sub button2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button2.Click
        Dim cell As AcReport.IAcCell '定义一个单元格对象变量

        cell = mac.GetCellX(2, 2) '取得第2行第2格的单元格（下标从0开始）
        cell.BkColor = ColorTranslator.ToWin32(Color.Red) '设置背景色为红色
        cell.CellText = "AC Report"

        '通过行对象取得单元格的方法
        mac.GetLineX(2).GetCell(4).TextSize = 20 '设置文字大小为20
        mac.GetLineX(2).GetCell(4).CellText = "内容由程序设定" '设置单元格文本
        '访问子页面
        If mac.SubPageCount > 0 Then
            mac.GetSubPage(0).GetCellX(1, 2).CellText = "子页面单元格"
            mac.GetSubPage(0).GetCellX(1, 2).TextSize = 20
        End If

        If Not mac.CustDataBuilder.TableExist("table1") Then '利用CustDataBuilder创建一个内存表，并添加一行记录
            mac.CustDataBuilder.NewTable("table1")
            mac.CustDataBuilder.AddStringField("table1", "field1", 20)
            mac.CustDataBuilder.AddIntegerField("table1", "field2")
            mac.CustDataBuilder.OpenTable("table1")

            mac.CustDataBuilder.AppendEmptyRow("table1")
            mac.CustDataBuilder.SetFieldValue("table1", "field1", "第一个字段的值")
            mac.CustDataBuilder.SetFieldValue("table1", "field2", 100)
        End If

        mac.ShowDesigner()
    End Sub
End Class
