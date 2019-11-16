using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Text;
using System.Windows.Forms;

namespace WindowsApplication1
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            axAcWebClientView1.LoadAptFromURL(textBox1.Text);
            axAcWebClientView1.ShowDesigner();
        }

        private void button2_Click(object sender, EventArgs e)
        {
            axAcWebClientView1.LoadAptFromFile(textBox1.Text);
          //  axAcWebClientView1.ReportEngine.LoadFromFile(textBox1.Text); 
            axAcWebClientView1.ShowDesigner();
        }
    }
}