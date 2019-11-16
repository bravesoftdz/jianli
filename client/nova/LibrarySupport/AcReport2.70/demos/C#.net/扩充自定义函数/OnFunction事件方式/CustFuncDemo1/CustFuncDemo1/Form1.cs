using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using AcReport;
using System.Windows.Forms;

namespace CustFuncDemo1
{
    public partial class Form1 : Form
    {
        AcReport.AcRptEngine FAcRptEngine;
        ADODB.Connection dbconn = new ADODB.Connection();

        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string  sfile = System.IO.Path.GetDirectoryName(Application.ExecutablePath) + "\\addfunc.apt";
            if(System.IO.File.Exists(sfile))
               FAcRptEngine.LoadFromFile(sfile); 
            FAcRptEngine.ShowDesigner();
        }


        private void Form1_Load(object sender, EventArgs e)
        {
            FAcRptEngine = new AcRptEngine();
            FAcRptEngine.OnFunction += DoOnFunction; //指定事件处理过程

            //加入函数描述，这样用户可以在函数选择窗口看到加入的函数，第一个参数是类别，6表示加入到"其它"类别中
 
            FAcRptEngine.AddFunctionName(6, "GetMyStr", "", "返回一个固定字符串");
            FAcRptEngine.AddFunctionName(6, "DayOf", "DateValue", "返回一个日期的天数部分");
            FAcRptEngine.AddFunctionName(6, "GetMax", "Value1, Value2", "返回两个值中的较大值");
            FAcRptEngine.AddFunctionName(6, "RepeatStr", "Str, Count", "将指定的字符串重复N遍并返回");
            FAcRptEngine.AddFunctionName(6, "GetBySQL", "SQL", "执行SQL，并返回一个值");

             //加入函数描述后，并无实际函数功能，需要响应OnFunction事件，对相应的函数请求进行处理
        }

        public void DoOnFunction(IAcRptEngine RptEngine, string FuncName, object P1, object P2, object P3, ref object Value)
         {
             double v1, v2;
             int i, n;
             string str, str2;

             if(FuncName == "GETMYSTR")
             {
                 Value = "HI,这是一个自定义函数!";  //Value是返回值。
             }
             else if (FuncName == "DAYOF")
             {
                 DateTime dt = (DateTime)FAcRptEngine.Calac((string)P1); //注意是 FAcRptEngine.Calac(P1)，而不是直接使用P1，因为P1可能是一个公式
                 Value = dt.Day; 
             }
             else if (FuncName == "GETMAX")
             {
                 v1 = (double)FAcRptEngine.Calac((string)P1);
                 v2 = (double)FAcRptEngine.Calac((string)P2);
                 if (v1 < v2)
                     Value = v2;
                 else
                     Value = v1;
             }
             else if (FuncName == "REPEATSTR")
             { 
                 str = (string)FAcRptEngine.Calac((string)P1);
                 n = (int)(double)FAcRptEngine.Calac((string)P2); //C#中将只含有数字的object变量视为double类型
                 str2 = "";
                 for (i = 0; i <= n - 1; i++)
                     str2 = str2 + str;
                 Value = str2;
             }
             else if (FuncName == "GETBYSQL")
             {
                 Value = DoGetBySQL((string)FAcRptEngine.Calac((string)P1));
             }
         }

        object DoGetBySQL(string sql)
        {
            if ((dbconn.State & 0x00000001) == 0)
            {
                string DataPath = System.IO.Path.GetDirectoryName(Application.ExecutablePath) + @"\..\..\..\..\..\..\..\Data\";
                dbconn.ConnectionString = @"Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + DataPath + @"ReportDemo.mdb;Persist Security Info=False";
                dbconn.Open(dbconn.ConnectionString, "admin", "", -1);
            }
            ADODB.Recordset rcTemp = new ADODB.Recordset();
            rcTemp.CursorLocation = ADODB.CursorLocationEnum.adUseClient;
            rcTemp.Open(sql, dbconn, ADODB.CursorTypeEnum.adOpenKeyset, ADODB.LockTypeEnum.adLockReadOnly, 1);
            if (rcTemp.RecordCount > 0)
                return rcTemp.Fields[0].Value;
            return null;
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Close();
        }
    }
}