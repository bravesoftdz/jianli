Imports AcReport
Imports ADODB



Public Class Form1
    Public dbconn As New ADODB.Connection()
    Public FAcRptEngine As AcReport.AcRptEngine
    Public Shared MainForm As Form1

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
        MainForm = Me '将当前实例赋值给静态成员变量，以便别的类可以引用
        FAcRptEngine = New AcRptEngine()
        FAcRptEngine.AddFunctionLib(New MyFuncLib(), 0) '将函数库类的实例加入到报表引擎
    End Sub
End Class

'编写函数库，实现IAcFunctionLib接口
Public Class MyFuncLib
    Inherits [Object]
    Implements AcReport.IAcFunctionLib 'ToDo: Add Implements Clauses for implementation methods of these interface(s)



    '返回本库中函数的个数
    Public Function GetFuncCount() As Integer Implements AcReport.IAcFunctionLib.GetFuncCount
        Return 5 '本函数库中包含5个自定义函数
    End Function 'GetFuncCount


    '当AcReportEngine询问函数的描述信息时，根据参数将函数的描述返回
    Public Sub GetFuncInfo(ByVal AFuncID As Integer, ByRef AFuncKind As Integer, ByRef AFuncName As String, ByRef AParamDesc As String, ByRef AFuncDesc As String) Implements AcReport.IAcFunctionLib.GetFuncInfo
        Select Case AFuncID 'AFuncID 从0到GetFuncCount() - 1
            'AFuncKind是函数类别(取值：1..6)，6表示将函数添加在“其它”类别中
            Case 0
                If (True) Then
                    AFuncKind = 6
                    AFuncName = "GetMyStr2"
                    AParamDesc = ""
                    AFuncDesc = "返回一个固定字符串"
                End If
            Case 1
                If (True) Then
                    AFuncKind = 6
                    AFuncName = "DayOf2"
                    AParamDesc = "DateValue"
                    AFuncDesc = "返回一个日期的天数部分"
                End If
            Case 2
                If (True) Then
                    AFuncKind = 6
                    AFuncName = "GetMax2"
                    AParamDesc = "Value1, Value2"
                    AFuncDesc = "返回两个值中的较大值"
                End If
            Case 3
                If (True) Then
                    AFuncKind = 6
                    AFuncName = "RepeatStr2"
                    AParamDesc = "Str"
                    AFuncDesc = "将指定的字符串重复N遍并返回"
                End If
            Case 4
                If (True) Then
                    AFuncKind = 6
                    AFuncName = "GetBySQL2"
                    AParamDesc = "SQL"
                    AFuncDesc = "执行SQL，并返回一个值"
                End If
        End Select
    End Sub 'GetFuncInfo


    '当执行函数时，在此过程中处理
    Public Function DoFunction(ByVal ARptEgine As AcRptEngine, ByVal AFuncID As Integer, ByVal AFuncName As String, ByVal AParam1 As Object, ByVal AParam2 As Object, ByVal AParam3 As Object) As Object Implements AcReport.IAcFunctionLib.DoFunction
        'ACReportEngine在计算报表公式、处理脚本的过程中，就会触发此过程，可以根据AFuncID或AFuncName来确定要处理哪个函数请求

        Dim v1, v2 As Double
        Dim i, n As Integer
        Dim str, str2 As String

        If AFuncName = "GETMYSTR2" Then '或：if AFuncID = 0
            Return "HI,这是一个自定义函数!"
        Else
            If AFuncName = "DAYOF2" Then '也可以写成：if (AFuncID == 1)
                Dim dt As DateTime = CType(ARptEgine.Calac(CStr(AParam1)), DateTime) '注意是 FAcRptEngine.Calac(P1)，而不是直接使用P1，因为P1可能是一个公式
                Return dt.Day
            Else
                If AFuncName = "GETMAX2" Then '或：if AFuncID = 2
                    v1 = CDbl(ARptEgine.Calac(CStr(AParam1)))
                    v2 = CDbl(ARptEgine.Calac(CStr(AParam2)))
                    If v1 < v2 Then
                        Return v2
                    Else
                        Return v1
                    End If
                Else
                    If AFuncName = "REPEATSTR2" Then '或：if AFuncID = 3
                        str = CStr(ARptEgine.Calac(CStr(AParam1)))
                        n = CInt(CDbl(ARptEgine.Calac(CStr(AParam2)))) '只含有数字的object变量视为double类型
                        str2 = ""
                        For i = 0 To n - 1
                            str2 = str2 + str
                        Next i
                        Return str2
                    Else
                        If AFuncName = "GETBYSQL2" Then '或：if AFuncID = 4
                            Return DoGetBySQL(CStr(ARptEgine.Calac(CStr(AParam1))))
                        Else
                            Return Nothing
                        End If
                    End If
                End If
            End If
        End If '取得主form中的连接对象
    End Function 'DoFunction

    Function DoGetBySQL(ByVal sql As String) As Object
        Dim connstr As String
        Dim dbconn As ADODB.Connection = Form1.MainForm.dbconn
        If (dbconn.State And &H1) = 0 Then
            Dim DataPath As String = System.IO.Path.GetDirectoryName(Application.ExecutablePath) + "\..\..\..\..\..\..\..\Data\"
            connstr = "Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + DataPath + "ReportDemo.mdb;Persist Security Info=False"
            dbconn.Open(connstr, "admin", "", -1)
        End If
        Dim rcTemp As New ADODB.Recordset()
        rcTemp.CursorLocation = ADODB.CursorLocationEnum.adUseClient
        rcTemp.Open(sql, dbconn, ADODB.CursorTypeEnum.adOpenKeyset, ADODB.LockTypeEnum.adLockReadOnly, 1)
        If rcTemp.RecordCount > 0 Then
            Return rcTemp.Fields(0).Value
        End If
        Return Nothing
    End Function 'DoGetBySQL

End Class 'MyFuncLib 


