using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace RepObjectDemo
{
    public partial class Form1 : Form
    {
        AcReport.AcRptEngine mac; //定义一个AcRptEngine成员变量

        public Form1()
        {
            InitializeComponent();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            mac = new AcReport.AcRptEngine();
            string sfile = System.IO.Path.GetDirectoryName(Application.ExecutablePath) + "\\test.apt";
            if (System.IO.File.Exists(sfile))
                mac.LoadFromFile(sfile);

        }

        private void button2_Click(object sender, EventArgs e)
        {
            AcReport.IAcCell cell; //定义一个单元格对象变量


            cell = mac.GetCellX(2, 2);  //取得第2行第2格的单元格（下标从0开始）
            cell.BkColor = ColorTranslator.ToWin32(Color.Red); //设置背景色为红色
            cell.CellText = "AC Report";

            //通过行对象取得单元格的方法
            mac.GetLineX(2).GetCell(4).TextSize = 20; //设置文字大小为20
            mac.GetLineX(2).GetCell(4).CellText = "内容由程序设定"; //设置单元格文本
            //访问子页面
            if (mac.SubPageCount > 0)
            {
                mac.GetSubPage(0).GetCellX(1, 2).CellText = "子页面单元格";
                mac.GetSubPage(0).GetCellX(1, 2).TextSize = 20;
            }

            if (!(mac.CustDataBuilder.TableExist("table1"))) //利用CustDataBuilder创建一个内存表，并添加一行记录
            {
                mac.CustDataBuilder.NewTable("table1");
                mac.CustDataBuilder.AddStringField("table1", "field1", 20);
                mac.CustDataBuilder.AddIntegerField("table1", "field2");
                mac.CustDataBuilder.OpenTable("table1");

                mac.CustDataBuilder.AppendEmptyRow("table1");
                mac.CustDataBuilder.SetFieldValue("table1", "field1", "第一个字段的值");
                mac.CustDataBuilder.SetFieldValue("table1", "field2", 100);
            }

            mac.ShowDesigner();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            mac.ShowDesigner();
        }
    }
}