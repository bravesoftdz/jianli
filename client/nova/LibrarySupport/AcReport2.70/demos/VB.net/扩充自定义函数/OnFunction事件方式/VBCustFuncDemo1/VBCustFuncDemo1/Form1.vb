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

        AddHandler FAcRptEngine.OnFunction, AddressOf DoOnFunction 'ָ���¼��������

        '���뺯�������������û������ں���ѡ�񴰿ڿ�������ĺ�������һ�����������6��ʾ���뵽"����"�����
        FAcRptEngine.AddFunctionName(6, "GetMyStr", "", "����һ���̶��ַ���")
        FAcRptEngine.AddFunctionName(6, "DayOf", "DateValue", "����һ�����ڵ���������")
        FAcRptEngine.AddFunctionName(6, "GetMax", "Value1, Value2", "��������ֵ�еĽϴ�ֵ")
        FAcRptEngine.AddFunctionName(6, "RepeatStr", "Str, Count", "��ָ�����ַ����ظ�N�鲢����")
        FAcRptEngine.AddFunctionName(6, "GetBySQL", "SQL", "ִ��SQL��������һ��ֵ")
    End Sub


    Public Sub DoOnFunction(ByVal RptEngine As AcRptEngine, ByVal FuncName As String, ByVal P1 As Object, ByVal P2 As Object, ByVal P3 As Object, ByRef Value As Object)
        Dim v1, v2 As Double
        Dim i, n As Integer
        Dim str, str2 As String

        If FuncName = "GETMYSTR" Then
            Value = "HI,����һ���Զ��庯��!" 'Value�Ƿ���ֵ��
        Else
            If FuncName = "DAYOF" Then
                Dim dt As DateTime = CType(FAcRptEngine.Calac(CStr(P1)), DateTime) 'ע���� FAcRptEngine.Calac(P1)��������ֱ��ʹ��P1����ΪP1������һ����ʽ
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
                        n = CInt(CDbl(FAcRptEngine.Calac(CStr(P2)))) 'ֻ�������ֵ�object������Ϊdouble����
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
