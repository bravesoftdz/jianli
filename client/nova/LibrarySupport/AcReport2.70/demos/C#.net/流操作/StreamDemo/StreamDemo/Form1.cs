using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace StreamDemo
{
    public partial class Form1 : Form
    {
        AcReport.AcRptEngine mac;
        public Form1()
        {
            InitializeComponent();
        }

        private void btnStreamTest_Click(object sender, EventArgs e)
        {
            int errcode = 0;
            string errmsg = "";
            System.IO.FileStream stRead, stWrite;
            string curpath;

            //这段代码演示了如何用AcNetStream来实现从流中读取一个模板和将模板保存到一个流中。
            //为简单起见，这里用到了文件流。
            //AcNetStream是一个实现了IAcNetStream接口的类，这是AcReportEngine所支持的流接口，该类的代码在AcReportUtils.cs中
            //AcNetStream只是一个代理类，它需要关联到一个实际的.net环境中的流对象。

            curpath = System.IO.Path.GetDirectoryName(Application.ExecutablePath) + "\\";
            stRead = System.IO.File.Open(curpath + "test.apt", System.IO.FileMode.Open);
            stWrite = System.IO.File.Open(curpath + "testsave.apt", System.IO.FileMode.OpenOrCreate);

            AcReport.AcNetStream acstream = new AcReport.AcNetStream(stRead); //创建一个AcNetStream，缺省关联到stRead流对象
            if (mac.LoadFromStream(acstream) != 0)
            {
                stRead.Dispose();
                mac.GetLastError(ref errcode, ref errmsg); //GetLastError返回最后一次操作的错误信息
                throw new System.Exception(errmsg);
            }
            else
            {
                stRead.Dispose();
                mac.ShowDesigner();

                //关闭设计器后，将模板另存到stWrite中
                acstream.ConnectTo(stWrite); //改变关联对象为stWrite
                mac.SaveToStream(acstream);
                stWrite.Dispose();
            }
        }

        private void Form1_Load(object sender, EventArgs e)
        {
            mac = new AcReport.AcRptEngine();
        }

        private void label1_Click(object sender, EventArgs e)
        {

        }
    }
}