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
        MainForm = Me '����ǰʵ����ֵ����̬��Ա�������Ա������������
        FAcRptEngine = New AcRptEngine()
        FAcRptEngine.AddFunctionLib(New MyFuncLib(), 0) '�����������ʵ�����뵽��������
    End Sub
End Class

'��д�����⣬ʵ��IAcFunctionLib�ӿ�
Public Class MyFuncLib
    Inherits [Object]
    Implements AcReport.IAcFunctionLib 'ToDo: Add Implements Clauses for implementation methods of these interface(s)



    '���ر����к����ĸ���
    Public Function GetFuncCount() As Integer Implements AcReport.IAcFunctionLib.GetFuncCount
        Return 5 '���������а���5���Զ��庯��
    End Function 'GetFuncCount


    '��AcReportEngineѯ�ʺ�����������Ϣʱ�����ݲ�������������������
    Public Sub GetFuncInfo(ByVal AFuncID As Integer, ByRef AFuncKind As Integer, ByRef AFuncName As String, ByRef AParamDesc As String, ByRef AFuncDesc As String) Implements AcReport.IAcFunctionLib.GetFuncInfo
        Select Case AFuncID 'AFuncID ��0��GetFuncCount() - 1
            'AFuncKind�Ǻ������(ȡֵ��1..6)��6��ʾ����������ڡ������������
            Case 0
                If (True) Then
                    AFuncKind = 6
                    AFuncName = "GetMyStr2"
                    AParamDesc = ""
                    AFuncDesc = "����һ���̶��ַ���"
                End If
            Case 1
                If (True) Then
                    AFuncKind = 6
                    AFuncName = "DayOf2"
                    AParamDesc = "DateValue"
                    AFuncDesc = "����һ�����ڵ���������"
                End If
            Case 2
                If (True) Then
                    AFuncKind = 6
                    AFuncName = "GetMax2"
                    AParamDesc = "Value1, Value2"
                    AFuncDesc = "��������ֵ�еĽϴ�ֵ"
                End If
            Case 3
                If (True) Then
                    AFuncKind = 6
                    AFuncName = "RepeatStr2"
                    AParamDesc = "Str"
                    AFuncDesc = "��ָ�����ַ����ظ�N�鲢����"
                End If
            Case 4
                If (True) Then
                    AFuncKind = 6
                    AFuncName = "GetBySQL2"
                    AParamDesc = "SQL"
                    AFuncDesc = "ִ��SQL��������һ��ֵ"
                End If
        End Select
    End Sub 'GetFuncInfo


    '��ִ�к���ʱ���ڴ˹����д���
    Public Function DoFunction(ByVal ARptEgine As AcRptEngine, ByVal AFuncID As Integer, ByVal AFuncName As String, ByVal AParam1 As Object, ByVal AParam2 As Object, ByVal AParam3 As Object) As Object Implements AcReport.IAcFunctionLib.DoFunction
        'ACReportEngine�ڼ��㱨��ʽ������ű��Ĺ����У��ͻᴥ���˹��̣����Ը���AFuncID��AFuncName��ȷ��Ҫ�����ĸ���������

        Dim v1, v2 As Double
        Dim i, n As Integer
        Dim str, str2 As String

        If AFuncName = "GETMYSTR2" Then '��if AFuncID = 0
            Return "HI,����һ���Զ��庯��!"
        Else
            If AFuncName = "DAYOF2" Then 'Ҳ����д�ɣ�if (AFuncID == 1)
                Dim dt As DateTime = CType(ARptEgine.Calac(CStr(AParam1)), DateTime) 'ע���� FAcRptEngine.Calac(P1)��������ֱ��ʹ��P1����ΪP1������һ����ʽ
                Return dt.Day
            Else
                If AFuncName = "GETMAX2" Then '��if AFuncID = 2
                    v1 = CDbl(ARptEgine.Calac(CStr(AParam1)))
                    v2 = CDbl(ARptEgine.Calac(CStr(AParam2)))
                    If v1 < v2 Then
                        Return v2
                    Else
                        Return v1
                    End If
                Else
                    If AFuncName = "REPEATSTR2" Then '��if AFuncID = 3
                        str = CStr(ARptEgine.Calac(CStr(AParam1)))
                        n = CInt(CDbl(ARptEgine.Calac(CStr(AParam2)))) 'ֻ�������ֵ�object������Ϊdouble����
                        str2 = ""
                        For i = 0 To n - 1
                            str2 = str2 + str
                        Next i
                        Return str2
                    Else
                        If AFuncName = "GETBYSQL2" Then '��if AFuncID = 4
                            Return DoGetBySQL(CStr(ARptEgine.Calac(CStr(AParam1))))
                        Else
                            Return Nothing
                        End If
                    End If
                End If
            End If
        End If 'ȡ����form�е����Ӷ���
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


