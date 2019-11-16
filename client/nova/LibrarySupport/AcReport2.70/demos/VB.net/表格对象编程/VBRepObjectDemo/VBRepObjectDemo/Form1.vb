Imports AcReport

Public Class Form1
    Dim mac As AcReport.AcRptEngine '����һ��AcRptEngine��Ա����

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
        Dim cell As AcReport.IAcCell '����һ����Ԫ��������

        cell = mac.GetCellX(2, 2) 'ȡ�õ�2�е�2��ĵ�Ԫ���±��0��ʼ��
        cell.BkColor = ColorTranslator.ToWin32(Color.Red) '���ñ���ɫΪ��ɫ
        cell.CellText = "AC Report"

        'ͨ���ж���ȡ�õ�Ԫ��ķ���
        mac.GetLineX(2).GetCell(4).TextSize = 20 '�������ִ�СΪ20
        mac.GetLineX(2).GetCell(4).CellText = "�����ɳ����趨" '���õ�Ԫ���ı�
        '������ҳ��
        If mac.SubPageCount > 0 Then
            mac.GetSubPage(0).GetCellX(1, 2).CellText = "��ҳ�浥Ԫ��"
            mac.GetSubPage(0).GetCellX(1, 2).TextSize = 20
        End If

        If Not mac.CustDataBuilder.TableExist("table1") Then '����CustDataBuilder����һ���ڴ�������һ�м�¼
            mac.CustDataBuilder.NewTable("table1")
            mac.CustDataBuilder.AddStringField("table1", "field1", 20)
            mac.CustDataBuilder.AddIntegerField("table1", "field2")
            mac.CustDataBuilder.OpenTable("table1")

            mac.CustDataBuilder.AppendEmptyRow("table1")
            mac.CustDataBuilder.SetFieldValue("table1", "field1", "��һ���ֶε�ֵ")
            mac.CustDataBuilder.SetFieldValue("table1", "field2", 100)
        End If

        mac.ShowDesigner()
    End Sub
End Class
