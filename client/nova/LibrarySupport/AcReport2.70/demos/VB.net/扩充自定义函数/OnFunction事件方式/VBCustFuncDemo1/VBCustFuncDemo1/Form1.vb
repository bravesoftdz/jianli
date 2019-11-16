Imports AcReport
Imports ADODB

Public Class Form1
    Dim FAcRptEngine As AcReport.AcRptEngine
    Dim dbconn As New ADODB.Connection()
    Private Sub button2_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button2.Click
        Close()
    End Sub

    Private Sub button1_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles button1.Click
        Dim sfile As String = System.IO.Path.GetDirectoryName(Application.ExecutablePath) + "\addfunc.apt"
        If System.IO.File.Exists(sfile) Then
            FAcRptEngine.LoadFromFile(sfile)
        End If
        FAcRptEngine.ShowDesigner()
    End Sub

    Private Sub Form1_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        FAcRptEngine = New AcRptEngine()

        AddHandler FAcRptEngine.OnFunction, AddressOf DoOnFunction '指定事件处理过程

        '加入函数描述，这样用户可以在函数选择窗口看到加入的函数，第一个参数是类别，6表示加入到"其它"类别中
        FAcRptEngine.AddFunctionName(6, "GetMyStr", "", "返回一个固定字符串")
        FAcRptEngine.AddFunctionName(6, "DayOf", "DateValue", "返回一个日期的天数部分")
        FAcRptEngine.AddFunctionName(6, "GetMax", "Value1, Value2", "返回两个值中的较大值")
        FAcRptEngine.AddFunctionName(6, "RepeatStr", "Str, Count", "将指定的字符串重复N遍并返回")
        FAcRptEngine.AddFunctionName(6, "GetBySQL", "SQL", "执行SQL，并返回一个值")
    End Sub


    Public Sub DoOnFunction(ByVal RptEngine As AcRptEngine, ByVal FuncName As String, ByVal P1 As Object, ByVal P2 As Object, ByVal P3 As Object, ByRef Value As Object)
        Dim v1, v2 As Double
        Dim i, n As Integer
        Dim str, str2 As String

        If FuncName = "GETMYSTR" Then
            Value = "HI,这是一个自定义函数!" 'Value是返回值。
        Else
            If FuncName = "DAYOF" Then
                Dim dt As DateTime = CType(FAcRptEngine.Calac(CStr(P1)), DateTime) '注意是 FAcRptEngine.Calac(P1)，而不是直接使用P1，因为P1可能是一个公式
                Value = dt.Day
            Else
                If FuncName = "GETMAX" Then
                    v1 = CDbl(FAcRptEngine.Calac(CStr(P1)))
                    v2 = CDbl(FAcRptEngine.Calac(CStr(P2)))
                    If v1 < v2 Then
                        Value = v2
                    Else
                        Value = v1
                    End If
                Else
                    If FuncName = "REPEATSTR" Then
                        str = CStr(FAcRptEngine.Calac(CStr(P1)))
                        n = CInt(CDbl(FAcRptEngine.Calac(CStr(P2)))) '只含有数字的object变量视为double类型
                        str2 = ""
                        For i = 0 To n - 1
                            str2 = str2 + str
                        Next i
                        Value = str2
                    Else
                        If FuncName = "GETBYSQL" Then
                            Value = DoGetBySQL(CStr(FAcRptEngine.Calac(CStr(P1))))
                        End If
                    End If
                End If
            End If
        End If
    End Sub 'DoOnFunction

    Function DoGetBySQL(ByVal sql As String) As Object
        If (dbconn.State And &H1) = 0 Then
            Dim strConn As String
            Dim DataPath As String
            DataPath = System.IO.Path.GetDirectoryName(Application.ExecutablePath) + "\..\..\..\..\..\..\..\Data\"
            strConn = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + DataPath + "ReportDemo.mdb;Persist Security Info=False"
            dbconn.Open(strConn, "admin", "", -1)
        End If
        Dim rcTemp As New ADODB.Recordset()
        rcTemp.CursorLocation = ADODB.CursorLocationEnum.adUseClient
        rcTemp.Open(sql, dbconn, ADODB.CursorTypeEnum.adOpenKeyset, ADODB.LockTypeEnum.adLockReadOnly, 1)
        If rcTemp.RecordCount > 0 Then
            Return rcTemp.Fields(0).Value
        End If
        Return Nothing
    End Function 'DoGetBySQL
End Class
