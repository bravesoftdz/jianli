Imports AcReport

Public Class Form1
    Dim mac As AcReport.AcRptEngine

    Private Sub btnStreamTest_Click(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles btnStreamTest.Click
        Dim errcode As Integer = 0
        Dim errmsg As String = ""
        Dim stRead, stWrite As System.IO.FileStream
        Dim curpath As String

        '这段代码演示了如何用AcNetStream来实现从流中读取一个模板和将模板保存到一个流中。
        '为简单起见，这里用到了文件流。
        'AcNetStream是一个实现了IAcNetStream接口的类，这是AcReportEngine所支持的流接口，该类的代码在AcReportUtils.vb中
        'AcNetStream只是一个代理类，它需要关联到一个实际的.net环境中的流对象。
        curpath = System.IO.Path.GetDirectoryName(Application.ExecutablePath) + "\"
        stRead = System.IO.File.Open(curpath + "test.apt", System.IO.FileMode.Open)
        stWrite = System.IO.File.Open(curpath + "testsave.apt", System.IO.FileMode.OpenOrCreate)

        Dim acstream As New AcReportUtils.AcNetStream(stRead) '创建一个AcNetStream，缺省关联到stRead流对象
        If mac.LoadFromStream(acstream) <> 0 Then
            stRead.Dispose()
            mac.GetLastError(errcode, errmsg) 'GetLastError返回最后一次操作的错误信息
            Throw New System.Exception(errmsg)
        Else
            stRead.Dispose()
            mac.ShowDesigner()

            '关闭设计器后，将模板另存到stWrite中
            acstream.ConnectTo(stWrite) '改变关联对象为stWrite
            mac.SaveToStream(acstream)
            stWrite.Dispose()
        End If
    End Sub

    Private Sub Form1_Load(ByVal sender As System.Object, ByVal e As System.EventArgs) Handles MyBase.Load
        mac = New AcReport.AcRptEngine()
    End Sub
End Class
