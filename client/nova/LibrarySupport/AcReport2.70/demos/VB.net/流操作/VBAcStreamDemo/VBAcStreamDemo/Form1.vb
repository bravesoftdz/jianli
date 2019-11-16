Imports AcReport

Public Class Form1
    Dim mac As AcReport.AcRptEngine

    Private Sub btnStreamTest_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnStreamTest.Click
        Dim errcode As Integer = 0
        Dim errmsg As String = ""
        Dim stRead, stWrite As System.IO.FileStream
        Dim curpath As String

        '��δ�����ʾ�������AcNetStream��ʵ�ִ����ж�ȡһ��ģ��ͽ�ģ�屣�浽һ�����С�
        'Ϊ������������õ����ļ�����
        'AcNetStream��һ��ʵ����IAcNetStream�ӿڵ��࣬����AcReportEngine��֧�ֵ����ӿڣ�����Ĵ�����AcReportUtils.vb��
        'AcNetStreamֻ��һ�������࣬����Ҫ������һ��ʵ�ʵ�.net�����е�������
        curpath = System.IO.Path.GetDirectoryName(Application.ExecutablePath) + "\"
        stRead = System.IO.File.Open(curpath + "test.apt", System.IO.FileMode.Open)
        stWrite = System.IO.File.Open(curpath + "testsave.apt", System.IO.FileMode.OpenOrCreate)

        Dim acstream As New AcReportUtils.AcNetStream(stRead) '����һ��AcNetStream��ȱʡ������stRead������
        If mac.LoadFromStream(acstream) <> 0 Then
            stRead.Dispose()
            mac.GetLastError(errcode, errmsg) 'GetLastError�������һ�β����Ĵ�����Ϣ
            Throw New System.Exception(errmsg)
        Else
            stRead.Dispose()
            mac.ShowDesigner()

            '�ر�������󣬽�ģ����浽stWrite��
            acstream.ConnectTo(stWrite) '�ı��������ΪstWrite
            mac.SaveToStream(acstream)
            stWrite.Dispose()
        End If
    End Sub

    Private Sub Form1_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        mac = New AcReport.AcRptEngine()
    End Sub
End Class
