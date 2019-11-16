namespace AcCustPreview
{
    partial class Form1
    {
        /// <summary>
        /// 必需的设计器变量。
        /// </summary>
        private System.ComponentModel.IContainer components = null;

        /// <summary>
        /// 清理所有正在使用的资源。
        /// </summary>
        /// <param name="disposing">如果应释放托管资源，为 true；否则为 false。</param>
        protected override void Dispose(bool disposing)
        {
            if (disposing && (components != null))
            {
                components.Dispose();
            }
            base.Dispose(disposing);
        }

        #region Windows 窗体设计器生成的代码

        /// <summary>
        /// 设计器支持所需的方法 - 不要
        /// 使用代码编辑器修改此方法的内容。
        /// </summary>
        private void InitializeComponent()
        {
            System.ComponentModel.ComponentResourceManager resources = new System.ComponentModel.ComponentResourceManager(typeof(Form1));
            this.panel1 = new System.Windows.Forms.Panel();
            this.btnClose = new System.Windows.Forms.Button();
            this.btnApply = new System.Windows.Forms.Button();
            this.EdTopMgn = new System.Windows.Forms.TextBox();
            this.EdLeftMgn = new System.Windows.Forms.TextBox();
            this.label2 = new System.Windows.Forms.Label();
            this.label1 = new System.Windows.Forms.Label();
            this.CB1 = new System.Windows.Forms.CheckBox();
            this.btnShowDesiner = new System.Windows.Forms.Button();
            this.btnShowRep = new System.Windows.Forms.Button();
            this.AcRepView = new AxAcWebClient.AxAcWebClientView();
            this.palTool = new System.Windows.Forms.Panel();
            this.toolStrip1 = new System.Windows.Forms.ToolStrip();
            this.tbOpen = new System.Windows.Forms.ToolStripButton();
            this.tbSave = new System.Windows.Forms.ToolStripButton();
            this.toolStripSeparator1 = new System.Windows.Forms.ToolStripSeparator();
            this.tbSetup = new System.Windows.Forms.ToolStripButton();
            this.tbEdit = new System.Windows.Forms.ToolStripButton();
            this.toolStripSeparator2 = new System.Windows.Forms.ToolStripSeparator();
            this.tbExportXls = new System.Windows.Forms.ToolStripButton();
            this.tbPrint = new System.Windows.Forms.ToolStripButton();
            this.tbPrintCurPg = new System.Windows.Forms.ToolStripButton();
            this.tbSetToPg = new System.Windows.Forms.ToolStripButton();
            this.tbZoomIn = new System.Windows.Forms.ToolStripButton();
            this.tbZoomOut = new System.Windows.Forms.ToolStripButton();
            this.toolStripSeparator3 = new System.Windows.Forms.ToolStripSeparator();
            this.tbFirst = new System.Windows.Forms.ToolStripButton();
            this.tbPrev = new System.Windows.Forms.ToolStripButton();
            this.tbNext = new System.Windows.Forms.ToolStripButton();
            this.tbLast = new System.Windows.Forms.ToolStripButton();
            this.tbEdIndex = new System.Windows.Forms.ToolStripTextBox();
            this.tbClose = new System.Windows.Forms.ToolStripButton();
            this.panel1.SuspendLayout();
            ((System.ComponentModel.ISupportInitialize)(this.AcRepView)).BeginInit();
            this.palTool.SuspendLayout();
            this.toolStrip1.SuspendLayout();
            this.SuspendLayout();
            // 
            // panel1
            // 
            this.panel1.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                        | System.Windows.Forms.AnchorStyles.Left)));
            this.panel1.Controls.Add(this.btnClose);
            this.panel1.Controls.Add(this.btnApply);
            this.panel1.Controls.Add(this.EdTopMgn);
            this.panel1.Controls.Add(this.EdLeftMgn);
            this.panel1.Controls.Add(this.label2);
            this.panel1.Controls.Add(this.label1);
            this.panel1.Controls.Add(this.CB1);
            this.panel1.Controls.Add(this.btnShowDesiner);
            this.panel1.Controls.Add(this.btnShowRep);
            this.panel1.Location = new System.Drawing.Point(12, 12);
            this.panel1.Name = "panel1";
            this.panel1.Size = new System.Drawing.Size(146, 477);
            this.panel1.TabIndex = 0;
            // 
            // btnClose
            // 
            this.btnClose.Location = new System.Drawing.Point(25, 274);
            this.btnClose.Name = "btnClose";
            this.btnClose.Size = new System.Drawing.Size(75, 23);
            this.btnClose.TabIndex = 10;
            this.btnClose.Text = "退出";
            this.btnClose.UseVisualStyleBackColor = true;
            this.btnClose.Click += new System.EventHandler(this.btnClose_Click);
            // 
            // btnApply
            // 
            this.btnApply.Enabled = false;
            this.btnApply.Location = new System.Drawing.Point(87, 162);
            this.btnApply.Name = "btnApply";
            this.btnApply.Size = new System.Drawing.Size(38, 79);
            this.btnApply.TabIndex = 9;
            this.btnApply.Text = "应用";
            this.btnApply.UseVisualStyleBackColor = true;
            this.btnApply.Click += new System.EventHandler(this.btnApply_Click);
            // 
            // EdTopMgn
            // 
            this.EdTopMgn.Location = new System.Drawing.Point(25, 220);
            this.EdTopMgn.Name = "EdTopMgn";
            this.EdTopMgn.Size = new System.Drawing.Size(56, 21);
            this.EdTopMgn.TabIndex = 8;
            // 
            // EdLeftMgn
            // 
            this.EdLeftMgn.Location = new System.Drawing.Point(25, 169);
            this.EdLeftMgn.Name = "EdLeftMgn";
            this.EdLeftMgn.Size = new System.Drawing.Size(56, 21);
            this.EdLeftMgn.TabIndex = 7;
            // 
            // label2
            // 
            this.label2.AutoSize = true;
            this.label2.Location = new System.Drawing.Point(23, 205);
            this.label2.Name = "label2";
            this.label2.Size = new System.Drawing.Size(65, 12);
            this.label2.TabIndex = 6;
            this.label2.Text = "上边距(mm)";
            // 
            // label1
            // 
            this.label1.AutoSize = true;
            this.label1.Location = new System.Drawing.Point(23, 154);
            this.label1.Name = "label1";
            this.label1.Size = new System.Drawing.Size(65, 12);
            this.label1.TabIndex = 5;
            this.label1.Text = "左边距(mm)";
            // 
            // CB1
            // 
            this.CB1.AutoSize = true;
            this.CB1.Location = new System.Drawing.Point(25, 108);
            this.CB1.Name = "CB1";
            this.CB1.Size = new System.Drawing.Size(84, 16);
            this.CB1.TabIndex = 4;
            this.CB1.Text = "默认工具条";
            this.CB1.UseVisualStyleBackColor = true;
            this.CB1.CheckedChanged += new System.EventHandler(this.CB1_CheckedChanged);
            // 
            // btnShowDesiner
            // 
            this.btnShowDesiner.Location = new System.Drawing.Point(25, 55);
            this.btnShowDesiner.Name = "btnShowDesiner";
            this.btnShowDesiner.Size = new System.Drawing.Size(75, 23);
            this.btnShowDesiner.TabIndex = 3;
            this.btnShowDesiner.Text = "设计器";
            this.btnShowDesiner.UseVisualStyleBackColor = true;
            this.btnShowDesiner.Click += new System.EventHandler(this.btnShowDesiner_Click);
            // 
            // btnShowRep
            // 
            this.btnShowRep.Location = new System.Drawing.Point(25, 14);
            this.btnShowRep.Name = "btnShowRep";
            this.btnShowRep.Size = new System.Drawing.Size(75, 23);
            this.btnShowRep.TabIndex = 2;
            this.btnShowRep.Text = "显示报表";
            this.btnShowRep.UseVisualStyleBackColor = true;
            this.btnShowRep.Click += new System.EventHandler(this.btnShowRep_Click);
            // 
            // AcRepView
            // 
            this.AcRepView.Anchor = ((System.Windows.Forms.AnchorStyles)((((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Bottom)
                        | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.AcRepView.Location = new System.Drawing.Point(163, 35);
            this.AcRepView.Name = "AcRepView";
            this.AcRepView.OcxState = ((System.Windows.Forms.AxHost.State)(resources.GetObject("AcRepView.OcxState")));
            this.AcRepView.Size = new System.Drawing.Size(622, 454);
            this.AcRepView.TabIndex = 1;
            // 
            // palTool
            // 
            this.palTool.Anchor = ((System.Windows.Forms.AnchorStyles)(((System.Windows.Forms.AnchorStyles.Top | System.Windows.Forms.AnchorStyles.Left)
                        | System.Windows.Forms.AnchorStyles.Right)));
            this.palTool.Controls.Add(this.toolStrip1);
            this.palTool.Location = new System.Drawing.Point(164, 7);
            this.palTool.Name = "palTool";
            this.palTool.Size = new System.Drawing.Size(621, 28);
            this.palTool.TabIndex = 2;
            // 
            // toolStrip1
            // 
            this.toolStrip1.Items.AddRange(new System.Windows.Forms.ToolStripItem[] {
            this.tbOpen,
            this.tbSave,
            this.toolStripSeparator1,
            this.tbSetup,
            this.tbEdit,
            this.toolStripSeparator2,
            this.tbExportXls,
            this.tbPrint,
            this.tbPrintCurPg,
            this.tbSetToPg,
            this.tbZoomIn,
            this.tbZoomOut,
            this.toolStripSeparator3,
            this.tbFirst,
            this.tbPrev,
            this.tbNext,
            this.tbLast,
            this.tbEdIndex,
            this.tbClose});
            this.toolStrip1.Location = new System.Drawing.Point(0, 0);
            this.toolStrip1.Name = "toolStrip1";
            this.toolStrip1.Size = new System.Drawing.Size(621, 25);
            this.toolStrip1.TabIndex = 0;
            this.toolStrip1.Text = "toolStrip1";
            // 
            // tbOpen
            // 
            this.tbOpen.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.tbOpen.Image = ((System.Drawing.Image)(resources.GetObject("tbOpen.Image")));
            this.tbOpen.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.tbOpen.Name = "tbOpen";
            this.tbOpen.Size = new System.Drawing.Size(23, 22);
            this.tbOpen.Text = "toolStripButton1";
            this.tbOpen.ToolTipText = "打开";
            this.tbOpen.Click += new System.EventHandler(this.tbOpen_Click);
            // 
            // tbSave
            // 
            this.tbSave.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.tbSave.Image = ((System.Drawing.Image)(resources.GetObject("tbSave.Image")));
            this.tbSave.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.tbSave.Name = "tbSave";
            this.tbSave.Size = new System.Drawing.Size(23, 22);
            this.tbSave.Text = "toolStripButton2";
            this.tbSave.ToolTipText = "保存";
            this.tbSave.Click += new System.EventHandler(this.tbSave_Click);
            // 
            // toolStripSeparator1
            // 
            this.toolStripSeparator1.Name = "toolStripSeparator1";
            this.toolStripSeparator1.Size = new System.Drawing.Size(6, 25);
            // 
            // tbSetup
            // 
            this.tbSetup.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.tbSetup.Image = ((System.Drawing.Image)(resources.GetObject("tbSetup.Image")));
            this.tbSetup.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.tbSetup.Name = "tbSetup";
            this.tbSetup.Size = new System.Drawing.Size(23, 22);
            this.tbSetup.Text = "toolStripButton3";
            this.tbSetup.ToolTipText = "页面设置";
            this.tbSetup.Click += new System.EventHandler(this.toolStripButton3_Click);
            // 
            // tbEdit
            // 
            this.tbEdit.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.tbEdit.Image = ((System.Drawing.Image)(resources.GetObject("tbEdit.Image")));
            this.tbEdit.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.tbEdit.Name = "tbEdit";
            this.tbEdit.Size = new System.Drawing.Size(23, 22);
            this.tbEdit.Text = "toolStripButton4";
            this.tbEdit.ToolTipText = "编辑本页";
            this.tbEdit.Click += new System.EventHandler(this.tbEdit_Click);
            // 
            // toolStripSeparator2
            // 
            this.toolStripSeparator2.Name = "toolStripSeparator2";
            this.toolStripSeparator2.Size = new System.Drawing.Size(6, 25);
            // 
            // tbExportXls
            // 
            this.tbExportXls.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.tbExportXls.Image = ((System.Drawing.Image)(resources.GetObject("tbExportXls.Image")));
            this.tbExportXls.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.tbExportXls.Name = "tbExportXls";
            this.tbExportXls.Size = new System.Drawing.Size(23, 22);
            this.tbExportXls.Text = "toolStripButton5";
            this.tbExportXls.ToolTipText = "导出Excel";
            this.tbExportXls.Click += new System.EventHandler(this.tbExportXls_Click);
            // 
            // tbPrint
            // 
            this.tbPrint.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.tbPrint.Image = ((System.Drawing.Image)(resources.GetObject("tbPrint.Image")));
            this.tbPrint.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.tbPrint.Name = "tbPrint";
            this.tbPrint.Size = new System.Drawing.Size(23, 22);
            this.tbPrint.Text = "toolStripButton6";
            this.tbPrint.ToolTipText = "打印";
            this.tbPrint.Click += new System.EventHandler(this.tbPrint_Click);
            // 
            // tbPrintCurPg
            // 
            this.tbPrintCurPg.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.tbPrintCurPg.Image = ((System.Drawing.Image)(resources.GetObject("tbPrintCurPg.Image")));
            this.tbPrintCurPg.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.tbPrintCurPg.Name = "tbPrintCurPg";
            this.tbPrintCurPg.Size = new System.Drawing.Size(23, 22);
            this.tbPrintCurPg.Text = "toolStripButton7";
            this.tbPrintCurPg.ToolTipText = "打印本页";
            this.tbPrintCurPg.Click += new System.EventHandler(this.tbPrintCurPg_Click);
            // 
            // tbSetToPg
            // 
            this.tbSetToPg.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.tbSetToPg.Image = ((System.Drawing.Image)(resources.GetObject("tbSetToPg.Image")));
            this.tbSetToPg.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.tbSetToPg.Name = "tbSetToPg";
            this.tbSetToPg.Size = new System.Drawing.Size(23, 22);
            this.tbSetToPg.Text = "toolStripButton8";
            this.tbSetToPg.ToolTipText = "页面大小";
            this.tbSetToPg.Click += new System.EventHandler(this.tbSetToPg_Click);
            // 
            // tbZoomIn
            // 
            this.tbZoomIn.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.tbZoomIn.Image = ((System.Drawing.Image)(resources.GetObject("tbZoomIn.Image")));
            this.tbZoomIn.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.tbZoomIn.Name = "tbZoomIn";
            this.tbZoomIn.Size = new System.Drawing.Size(23, 22);
            this.tbZoomIn.Text = "toolStripButton9";
            this.tbZoomIn.ToolTipText = "放大";
            this.tbZoomIn.Click += new System.EventHandler(this.tbZoomIn_Click);
            // 
            // tbZoomOut
            // 
            this.tbZoomOut.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.tbZoomOut.Image = ((System.Drawing.Image)(resources.GetObject("tbZoomOut.Image")));
            this.tbZoomOut.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.tbZoomOut.Name = "tbZoomOut";
            this.tbZoomOut.Size = new System.Drawing.Size(23, 22);
            this.tbZoomOut.Text = "toolStripButton10";
            this.tbZoomOut.ToolTipText = "缩小";
            this.tbZoomOut.Click += new System.EventHandler(this.tbZoomOut_Click);
            // 
            // toolStripSeparator3
            // 
            this.toolStripSeparator3.Name = "toolStripSeparator3";
            this.toolStripSeparator3.Size = new System.Drawing.Size(6, 25);
            // 
            // tbFirst
            // 
            this.tbFirst.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.tbFirst.Image = ((System.Drawing.Image)(resources.GetObject("tbFirst.Image")));
            this.tbFirst.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.tbFirst.Name = "tbFirst";
            this.tbFirst.Size = new System.Drawing.Size(23, 22);
            this.tbFirst.Text = "toolStripButton11";
            this.tbFirst.ToolTipText = "第一页";
            this.tbFirst.Click += new System.EventHandler(this.tbFirst_Click);
            // 
            // tbPrev
            // 
            this.tbPrev.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.tbPrev.Image = ((System.Drawing.Image)(resources.GetObject("tbPrev.Image")));
            this.tbPrev.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.tbPrev.Name = "tbPrev";
            this.tbPrev.Size = new System.Drawing.Size(23, 22);
            this.tbPrev.Text = "toolStripButton12";
            this.tbPrev.ToolTipText = "上一页";
            this.tbPrev.Click += new System.EventHandler(this.tbPrev_Click);
            // 
            // tbNext
            // 
            this.tbNext.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.tbNext.Image = ((System.Drawing.Image)(resources.GetObject("tbNext.Image")));
            this.tbNext.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.tbNext.Name = "tbNext";
            this.tbNext.Size = new System.Drawing.Size(23, 22);
            this.tbNext.Text = "toolStripButton13";
            this.tbNext.ToolTipText = "下一页";
            this.tbNext.Click += new System.EventHandler(this.tbNext_Click);
            // 
            // tbLast
            // 
            this.tbLast.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.tbLast.Image = ((System.Drawing.Image)(resources.GetObject("tbLast.Image")));
            this.tbLast.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.tbLast.Name = "tbLast";
            this.tbLast.Size = new System.Drawing.Size(23, 22);
            this.tbLast.Text = "toolStripButton14";
            this.tbLast.ToolTipText = "最后一页";
            this.tbLast.Click += new System.EventHandler(this.tbLast_Click);
            // 
            // tbEdIndex
            // 
            this.tbEdIndex.Name = "tbEdIndex";
            this.tbEdIndex.Size = new System.Drawing.Size(50, 25);
            // 
            // tbClose
            // 
            this.tbClose.DisplayStyle = System.Windows.Forms.ToolStripItemDisplayStyle.Image;
            this.tbClose.Image = ((System.Drawing.Image)(resources.GetObject("tbClose.Image")));
            this.tbClose.ImageTransparentColor = System.Drawing.Color.Magenta;
            this.tbClose.Name = "tbClose";
            this.tbClose.Size = new System.Drawing.Size(23, 22);
            this.tbClose.Text = "toolStripButton15";
            this.tbClose.ToolTipText = "退出";
            this.tbClose.Click += new System.EventHandler(this.tbClose_Click);
            // 
            // Form1
            // 
            this.AutoScaleDimensions = new System.Drawing.SizeF(6F, 12F);
            this.AutoScaleMode = System.Windows.Forms.AutoScaleMode.Font;
            this.ClientSize = new System.Drawing.Size(798, 517);
            this.Controls.Add(this.palTool);
            this.Controls.Add(this.AcRepView);
            this.Controls.Add(this.panel1);
            this.Name = "Form1";
            this.Text = "Form1";
            this.Load += new System.EventHandler(this.Form1_Load);
            this.panel1.ResumeLayout(false);
            this.panel1.PerformLayout();
            ((System.ComponentModel.ISupportInitialize)(this.AcRepView)).EndInit();
            this.palTool.ResumeLayout(false);
            this.palTool.PerformLayout();
            this.toolStrip1.ResumeLayout(false);
            this.toolStrip1.PerformLayout();
            this.ResumeLayout(false);

        }

        #endregion

        private System.Windows.Forms.Panel panel1;
        private AxAcWebClient.AxAcWebClientView AcRepView;
        private System.Windows.Forms.Panel palTool;
        private System.Windows.Forms.ToolStrip toolStrip1;
        private System.Windows.Forms.ToolStripButton tbOpen;
        private System.Windows.Forms.ToolStripButton tbSave;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator1;
        private System.Windows.Forms.ToolStripButton tbSetup;
        private System.Windows.Forms.ToolStripButton tbEdit;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator2;
        private System.Windows.Forms.ToolStripButton tbExportXls;
        private System.Windows.Forms.ToolStripButton tbPrint;
        private System.Windows.Forms.ToolStripButton tbPrintCurPg;
        private System.Windows.Forms.ToolStripButton tbSetToPg;
        private System.Windows.Forms.ToolStripButton tbZoomIn;
        private System.Windows.Forms.ToolStripButton tbZoomOut;
        private System.Windows.Forms.ToolStripSeparator toolStripSeparator3;
        private System.Windows.Forms.ToolStripButton tbFirst;
        private System.Windows.Forms.ToolStripButton tbPrev;
        private System.Windows.Forms.ToolStripButton tbNext;
        private System.Windows.Forms.ToolStripButton tbLast;
        private System.Windows.Forms.ToolStripTextBox tbEdIndex;
        private System.Windows.Forms.ToolStripButton tbClose;
        private System.Windows.Forms.CheckBox CB1;
        private System.Windows.Forms.Button btnShowDesiner;
        private System.Windows.Forms.Button btnShowRep;
        private System.Windows.Forms.Label label2;
        private System.Windows.Forms.Label label1;
        private System.Windows.Forms.Button btnApply;
        private System.Windows.Forms.TextBox EdTopMgn;
        private System.Windows.Forms.TextBox EdLeftMgn;
        private System.Windows.Forms.Button btnClose;
    }
}

