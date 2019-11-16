<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
Partial Class Form1
    Inherits System.Windows.Forms.Form

    'Form 重写 Dispose，以清理组件列表。
    <System.Diagnostics.DebuggerNonUserCode()> _
    Protected Overrides Sub Dispose(ByVal disposing As Boolean)
        If disposing AndAlso components IsNot Nothing Then
            components.Dispose()
        End If
        MyBase.Dispose(disposing)
    End Sub

    'Windows 窗体设计器所必需的
    Private components As System.ComponentModel.IContainer

    '注意: 以下过程是 Windows 窗体设计器所必需的
    '可以使用 Windows 窗体设计器修改它。
    '不要使用代码编辑器修改它。
    <System.Diagnostics.DebuggerStepThrough()> _
    Private Sub InitializeComponent()
        Me.label1 = New System.Windows.Forms.Label
        Me.btnStreamTest = New System.Windows.Forms.Button
        Me.SuspendLayout()
        '
        'label1
        '
        Me.label1.AutoSize = True
        Me.label1.Location = New System.Drawing.Point(71, 83)
        Me.label1.Name = "label1"
        Me.label1.Size = New System.Drawing.Size(125, 12)
        Me.label1.TabIndex = 6
        Me.label1.Text = "请查看按扭的事件代码"
        '
        'btnStreamTest
        '
        Me.btnStreamTest.Location = New System.Drawing.Point(73, 53)
        Me.btnStreamTest.Name = "btnStreamTest"
        Me.btnStreamTest.Size = New System.Drawing.Size(109, 27)
        Me.btnStreamTest.TabIndex = 5
        Me.btnStreamTest.Text = "执行"
        Me.btnStreamTest.UseVisualStyleBackColor = True
        '
        'Form1
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 12.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(281, 152)
        Me.Controls.Add(Me.label1)
        Me.Controls.Add(Me.btnStreamTest)
        Me.Name = "Form1"
        Me.Text = "流操作演示(VB.net)"
        Me.ResumeLayout(False)
        Me.PerformLayout()

    End Sub
    Private WithEvents label1 As System.Windows.Forms.Label
    Private WithEvents btnStreamTest As System.Windows.Forms.Button

End Class
