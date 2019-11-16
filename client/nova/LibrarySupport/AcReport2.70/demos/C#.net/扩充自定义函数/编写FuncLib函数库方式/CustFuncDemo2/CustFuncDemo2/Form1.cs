using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using AcReport;
using System.Windows.Forms;

namespace CustFuncDemo2
{
    public partial class Form1 : Form
    {
        public ADODB.Connection dbconn = new ADODB.Connection();
        public AcReport.AcRptEngine FAcRptEngine;
        public static Form1 MainForm;

        public Form1()
        {
            InitializeComponent();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            Close();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            string sfile = System.IO.Path.GetDirectoryName(Application.ExecutablePath) + "\\addfunc.apt";
            if (System.IO.File.Exists(sfile))
                FAcRptEngine.LoadFromFile(sfile);
            FAcRptEngine.ShowDesigner();
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            MainForm = this;//将当前实例赋值给静态成员变量，以便别的类可以引用
            FAcRptEngine = new AcRptEngine();
            FAcRptEngine.AddFunctionLib(new MyFuncLib(), 0); //将函数库类的实例加入到报表引擎
        }
    }

    //编写函数库，实现IAcFunctionLib接口
    public class MyFuncLib : Object, AcReport.IAcFunctionLib
    {
      
        //返回本库中函数的个数
        public int GetFuncCount()
        {
            return 5;//本函数库中包含5个自定义函数
        }

        //当AcReportEngine询问函数的描述信息时，根据参数将函数的描述返回
        public void GetFuncInfo(int AFuncID, ref int AFuncKind, ref string AFuncName, ref string AParamDesc, ref string AFuncDesc)
        {
            switch (AFuncID) //AFuncID 从0到GetFuncCount() - 1
            {
                //AFuncKind是函数类别(取值：1..6)，6表示将函数添加在“其它”类别中
                case 0: { AFuncKind = 6; AFuncName = "GetMyStr2"; AParamDesc = ""; AFuncDesc = "返回一个固定字符串"; } break;
                case 1: { AFuncKind = 6; AFuncName = "DayOf2"; AParamDesc = "DateValue"; AFuncDesc = "返回一个日期的天数部分"; } break;
                case 2: { AFuncKind = 6; AFuncName = "GetMax2"; AParamDesc = "Value1, Value2"; AFuncDesc = "返回两个值中的较大值"; } break;
                case 3: { AFuncKind = 6; AFuncName = "RepeatStr2"; AParamDesc = "Str"; AFuncDesc = "将指定的字符串重复N遍并返回"; } break;
                case 4: { AFuncKind = 6; AFuncName = "GetBySQL2"; AParamDesc = "SQL"; AFuncDesc = "执行SQL，并返回一个值"; } break;

            }

        }

        //当执行函数时，在此过程中处理
        public object DoFunction(AcRptEngine ARptEgine, int AFuncID, string AFuncName, object AParam1, object AParam2, object AParam3)
        {
            //ACReportEngine在计算报表公式、处理脚本的过程中，就会触发此过程，可以根据AFuncID或AFuncName来确定要处理哪个函数请求
           // switch (AFuncID)
           // { 
           // }

            double v1, v2;
            int i, n;
            string str, str2;

            if (AFuncName == "GETMYSTR2") //或：if (AFuncID == 0)
            { 
                return "HI,这是一个自定义函数!";
            }
            else if (AFuncName == "DAYOF2") //也可以写成：if (AFuncID == 1)
            {
                DateTime dt = (DateTime)ARptEgine.Calac((string)AParam1); //注意是 FAcRptEngine.Calac(P1)，而不是直接使用P1，因为P1可能是一个公式
                return dt.Day; 
            }
            else if (AFuncName == "GETMAX2") //或：if (AFuncID == 2)
            {
                v1 = (double)ARptEgine.Calac((string)AParam1);
                v2 = (double)ARptEgine.Calac((string)AParam2);
                if (v1 < v2)
                    return v2;
                else
                    return v1;
            }
            else if (AFuncName == "REPEATSTR2") //或：if (AFuncID == 3)
            {
                str = (string)ARptEgine.Calac((string)AParam1);
                n = (int)(double)ARptEgine.Calac((string)AParam2); //C#中将只含有数字的object变量视为double类型
                str2 = "";
                for (i = 0; i <= n - 1; i++)
                    str2 = str2 + str;
                return str2;
            }
            else if (AFuncName == "GETBYSQL2") //或：if (AFuncID == 4)
            {
                return DoGetBySQL((string)ARptEgine.Calac((string)AParam1));
            }
            else 
                return null;
        }

        object DoGetBySQL(string sql)
        {
            ADODB.Connection dbconn = Form1.MainForm.dbconn; //取得主form中的连接对象

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

    }
}