﻿<Global.Microsoft.VisualBasic.CompilerServices.DesignerGenerated()> _
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
        Me.button2 = New System.Windows.Forms.Button
        Me.button1 = New System.Windows.Forms.Button
        Me.richTextBox1 = New System.Windows.Forms.RichTextBox
        Me.SuspendLayout()
        '
        'button2
        '
        Me.button2.Location = New System.Drawing.Point(232, 127)
        Me.button2.Name = "button2"
        Me.button2.Size = New System.Drawing.Size(125, 29)
        Me.button2.TabIndex = 7
        Me.button2.Text = "退出"
        Me.button2.UseVisualStyleBackColor = True
        '
        'button1
        '
        Me.button1.Location = New System.Drawing.Point(12, 127)
        Me.button1.Name = "button1"
        Me.button1.Size = New System.Drawing.Size(115, 29)
        Me.button1.TabIndex = 6
        Me.button1.Text = "显示报表"
        Me.button1.UseVisualStyleBackColor = True
        '
        'richTextBox1
        '
        Me.richTextBox1.Location = New System.Drawing.Point(12, 12)
        Me.richTextBox1.Name = "richTextBox1"
        Me.richTextBox1.Size = New System.Drawing.Size(345, 105)
        Me.richTextBox1.TabIndex = 5
        Me.richTextBox1.Text = "本程序演示通过IAcFunctionLib函数库接口加自定义函数。" & Global.Microsoft.VisualBasic.ChrW(10) & "主要有两个步骤：" & Global.Microsoft.VisualBasic.ChrW(10) & "1.实现IAcFunctionLib接口，编写函数库类" & Global.Microsoft.VisualBasic.ChrW(10) & "2.调用AcRptE" & _
            "ngine.AddFunctionLib()将函数库对象添加到AcReportEngine"
        '
        'Form1
        '
        Me.AutoScaleDimensions = New System.Drawing.SizeF(6.0!, 12.0!)
        Me.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font
        Me.ClientSize = New System.Drawing.Size(373, 168)
        Me.Controls.Add(Me.button2)
        Me.Controls.Add(Me.button1)
        Me.Controls.Add(Me.richTextBox1)
        Me.Name = "Form1"
        Me.StartPosition = System.Windows.Forms.FormStartPosition.CenterScreen
        Me.Text = "AC Report扩充自定义函数2(VB.net)"
        Me.ResumeLayout(False)

    End Sub
    Private WithEvents button2 As System.Windows.Forms.Button
    Private WithEvents button1 As System.Windows.Forms.Button
    Private WithEvents richTextBox1 As System.Windows.Forms.RichTextBox

End Class
