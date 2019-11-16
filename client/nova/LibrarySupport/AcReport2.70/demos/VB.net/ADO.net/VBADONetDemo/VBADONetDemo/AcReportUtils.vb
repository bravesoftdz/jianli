Imports System
Imports System.Data
Imports AcReport


'/ <summary>
'/ Summary description for Class1
'/ </summary>
'/ 
Namespace AcReportUtils
    _
    Public Class AcNetStream
        Inherits [Object]
        Implements AcReport.IAcNetStream 'ToDo: Add Implements Clauses for implementation methods of these interface(s)


        Private mStream As System.IO.Stream


        Public Sub New(ByVal connectStream As System.IO.Stream)
            mStream = connectStream
        End Sub 'New


        Public Sub ConnectTo(ByVal connectStream As System.IO.Stream)
            mStream = connectStream
        End Sub 'ConnectTo


        Public Function GetSize() As Integer Implements AcReport.IAcNetStream.GetSize
            Return CInt(mStream.Length)
        End Function 'GetSize


        Public Function Read(ByRef Buffer As String, ByVal Count As Integer) As Integer Implements AcReport.IAcNetStream.Read

            Dim buf(Count) As Byte

            Dim size As Integer = mStream.Read(buf, 0, Count)
            Dim i As Integer

            Buffer = ""
            For i = 0 To size - 1
                Buffer = Buffer + ChrW(buf(i)) 'CType(buf(i), [Char])
            Next i
            Return size
        End Function 'Read


        Public Function Seek(ByVal Offset As Integer, ByVal Origin As AcReport.SeekOrg) As Integer Implements AcReport.IAcNetStream.Seek
            Return CInt(mStream.Seek(Offset, CType(Origin, System.IO.SeekOrigin)))
        End Function 'Seek


        Public Sub SetSize(ByVal NewSize As Integer) Implements AcReport.IAcNetStream.SetSize
            mStream.SetLength(NewSize)
        End Sub 'SetSize


        Public Function Write(ByVal Buffer As String, ByVal Count As Integer) As Integer Implements AcReport.IAcNetStream.Write
            Dim buf(Count) As Byte
            Dim i As Integer
            For i = 0 To Count - 1
                buf(i) = AscW(Buffer(i)) 'CByte(Buffer(i))
            Next i
            mStream.Write(buf, 0, Count)

            Return Count
        End Function 'Write

    End Class 'AcNetStream
    _

    Public Class AcUtils
        Inherits [Object]
        '指定字符类型字段的最大长度
        Public Shared MaxStringFieldLength As Integer = 500


        '在AcCustDataBuilder对象中创建一个表结构
        Public Shared Sub BuildTableStruct(ByVal table As DataTable, ByVal tbBuilder As AcReport.ICustDataBuilder)
            Dim i As Integer
            If tbBuilder.TableExist(table.TableName) Then
                tbBuilder.CloseTable(table.TableName)
                tbBuilder.RemoveTable(table.TableName)
            End If

            tbBuilder.NewTable(table.TableName)

            For i = 0 To table.Columns.Count - 1
                If table.Columns(i).DataType Is GetType(String) Then
                    tbBuilder.AddStringField(table.TableName, table.Columns(i).ColumnName, MaxStringFieldLength)
                Else
                    If table.Columns(i).DataType Is GetType(Integer) Then
                        tbBuilder.AddIntegerField(table.TableName, table.Columns(i).ColumnName)
                    Else
                        If table.Columns(i).DataType Is GetType(Boolean) Then

                            tbBuilder.AddBooleanField(table.TableName, table.Columns(i).ColumnName)

                        Else
                            If (table.Columns(i).DataType Is GetType(Single)) Or (table.Columns(i).DataType Is GetType(Double)) Then
                                tbBuilder.AddFloatField(table.TableName, table.Columns(i).ColumnName)
                            Else
                                If table.Columns(i).DataType Is GetType(DateTime) Then
                                    tbBuilder.AddDateTimeField(table.TableName, table.Columns(i).ColumnName)
                                Else
                                    If table.Columns(i).DataType Is GetType(Byte()) Then
                                        tbBuilder.AddBlobField(table.TableName, table.Columns(i).ColumnName)
                                    Else
                                        tbBuilder.AddStringField(table.TableName, table.Columns(i).ColumnName, MaxStringFieldLength)
                                    End If
                                End If
                            End If
                        End If
                    End If '复制一个表到AcCustDataBuilder对象中
                End If
            Next i
        End Sub 'BuildTableStruct

        Public Shared Sub CopyTableToAcRptDataBuilder(ByVal table As System.Data.DataTable, ByVal tbBuilder As AcReport.ICustDataBuilder)
            tbBuilder.OpenTable(table.TableName)
            Dim i As Integer
            For i = 0 To table.Rows.Count - 1
                tbBuilder.AppendEmptyRow(table.TableName)
                Dim c As Integer
                For c = 0 To table.Columns.Count - 1
                    tbBuilder.SetFieldValue(table.TableName, c, table.Rows(i).ItemArray(c))
                Next c
            Next i
        End Sub 'CopyTableToAcRptDataBuilder


        '复制一个表到AcReportEngine中，isGlobal表示是否全局
        Public Shared Sub CopyTableToAcRptEngine(ByVal table As System.Data.DataTable, ByVal ac As AcReport.IAcRptEngine, ByVal isGlobal As Boolean)
            Dim builder As AcReport.CustDataBuilder            
            If isGlobal Then
                builder = ac.GlobalCustDataBuilder
            Else
                builder = ac.CustDataBuilder
            End If
            BuildTableStruct(table, builder)
            CopyTableToAcRptDataBuilder(table, builder)
        End Sub 'CopyTableToAcRptEngine


        '将一个Dataset中的所有表复制到AcReportEngine中，isGlobal表示是否全局
        Public Shared Sub CopyDatasetToAcRptEngine(ByVal ds As System.Data.DataSet, ByVal ac As AcReport.IAcRptEngine, ByVal isGlobal As Boolean)
            Dim builder As AcReport.CustDataBuilder
            If isGlobal Then
                builder = ac.GlobalCustDataBuilder
            Else
                builder = ac.CustDataBuilder
            End If
            Dim i As Integer
            For i = 0 To ds.Tables.Count - 1
                BuildTableStruct(ds.Tables(i), builder)
                CopyTableToAcRptDataBuilder(ds.Tables(i), builder)
            Next i
        End Sub 'CopyDatasetToAcRptEngine
    End Class 'AcUtils
End Namespace 'AcReport 