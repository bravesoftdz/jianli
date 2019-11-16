unit main;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Buttons, ExtCtrls, OleCtrls,
  DB, ADODB, Grids, DBGrids, ACReport_TLB;

type
  TForm1 = class(TForm)
    rg1: TRadioGroup;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    GroupBox1: TGroupBox;
    B1: TBitBtn;
    B2: TBitBtn;
    B3: TBitBtn;
    B4: TBitBtn;
    B5: TBitBtn;
    B6: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBox2: TGroupBox;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    GroupBox3: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    procedure FormCreate(Sender: TObject);
    procedure B1Click(Sender: TObject);
    procedure B2Click(Sender: TObject);
    procedure B3Click(Sender: TObject);
    procedure B4Click(Sender: TObject);
    procedure B5Click(Sender: TObject);
    procedure B6Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    { Private declarations }
    ACRptEngine1: TAcRptEngine;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation
uses data;
{$R *.DFM}
var
  rpt_path: string = '';

procedure TForm1.FormCreate(Sender: TObject);
begin
  ACRptEngine1 := TAcRptEngine.Create(nil);

  rpt_path := ExtractFilePath(ParamStr(0)) + '..\..\reports\';
  ACRptEngine1.AddGlobalVariable('使用单位', Edit1.Text)
end;

procedure TForm1.B1Click(Sender: TObject);
begin
  ACRptEngine1.Init;
  ACRptEngine1.AddDataSet('animals', dm.qryAnimals.Recordset);
  ACRptEngine1.AddDataSet('zlemployee', dm.qryZlemployee.Recordset);
  ACRptEngine1.SetReportFile(rpt_path+'list.apt');
  case rg1.ItemIndex of
   0: ACRptEngine1.Preview;
   1: ACRptEngine1.ShowDesigner;
   2: ACRptEngine1.Print;
  end;  
end;

procedure TForm1.B2Click(Sender: TObject);
begin
  ACRptEngine1.Init;
  ACRptEngine1.AddDataSet('customer', dm.qryCustomer.Recordset);
  ACRptEngine1.AddDataSet('orders', dm.qryOrders.Recordset);
  ACRptEngine1.AddDataSetRelation('customer', 'orders', 'CustNo=CustNo');
  ACRptEngine1.SetReportFile(rpt_path+'md.apt');
  case rg1.ItemIndex of
   0: ACRptEngine1.Preview;
   1: ACRptEngine1.ShowDesigner;
   2: ACRptEngine1.Print;
  end;
end;

procedure TForm1.B3Click(Sender: TObject);
begin
  ACRptEngine1.Init;
  ACRptEngine1.AddDataSet('zlemployee', dm.qryZlemployee.Recordset);
  ACRptEngine1.SetReportFile(rpt_path+'group.apt');
  case rg1.ItemIndex of
   0: ACRptEngine1.Preview;
   1: ACRptEngine1.ShowDesigner;
   2: ACRptEngine1.Print;
  end;

end;

procedure TForm1.B4Click(Sender: TObject);
begin
  ACRptEngine1.Init;
  ACRptEngine1.AddDataSet('customer', dm.qryCustomer.Recordset);
  ACRptEngine1.AddDataSet('orders', dm.qryOrders.Recordset);
  ACRptEngine1.AddDataSetRelation('customer', 'orders', 'CustNo=CustNo');
  ACRptEngine1.SetReportFile(rpt_path+'sub1.apt');
  case rg1.ItemIndex of
   0: ACRptEngine1.Preview;
   1: ACRptEngine1.ShowDesigner;
   2: ACRptEngine1.Print;
  end;
end;

procedure TForm1.B5Click(Sender: TObject);
begin
  ACRptEngine1.Init;
  ACRptEngine1.AddDataSet('customer', dm.qryCustomer.Recordset);
  ACRptEngine1.AddDataSet('orders', dm.qryOrders.Recordset);
  ACRptEngine1.AddDataSet('items', dm.qryItems.Recordset);
  ACRptEngine1.AddDataSetRelation('customer', 'orders', 'CustNo=CustNo');
  ACRptEngine1.AddDataSetRelation('orders', 'items', 'OrderNo=OrderNo');
  ACRptEngine1.SetReportFile(rpt_path+'sub2.apt');
  case rg1.ItemIndex of
   0: ACRptEngine1.Preview;
   1: ACRptEngine1.ShowDesigner;
   2: ACRptEngine1.Print;
  end;
end;

procedure TForm1.B6Click(Sender: TObject);
begin
  ACRptEngine1.Init;
  ACRptEngine1.AddDataSet('customer', dm.qryCustomer.Recordset);
  ACRptEngine1.AddDataSet('orders', dm.qryOrders.Recordset);
  ACRptEngine1.AddDataSet('zlemployee', dm.qryZlEmployee.Recordset);
  ACRptEngine1.AddDataSet('XueLi', dm.qryXueli.Recordset);
  ACRptEngine1.AddDataSet('photos', dm.qryPhoto.Recordset);
  ACRptEngine1.AddDataSet('XueLiEmp', dm.qryxueLiEmp.Recordset);
  ACRptEngine1.AddDataSetRelation('customer', 'orders', 'CustNo=CustNo');
  ACRptEngine1.SetReportFile(rpt_path+'label.apt');
  case rg1.ItemIndex of
   0: ACRptEngine1.Preview;
   1: ACRptEngine1.ShowDesigner;
   2: ACRptEngine1.Print;
  end;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  ACRptEngine1.Init;
  ACRptEngine1.AddDataSet('customer', dm.qryCustomer.Recordset);
  ACRptEngine1.AddDataSet('orders', dm.qryOrders.Recordset);
  ACRptEngine1.AddDataSet('zlemployee', dm.qryZlEmployee.Recordset);
  ACRptEngine1.AddDataSet('xueli', dm.qryXueli.Recordset);
  ACRptEngine1.AddDataSet('photos', dm.qryPhoto.Recordset);
  ACRptEngine1.SetReportFile(rpt_path+'multcol.apt');
  case rg1.ItemIndex of
   0: ACRptEngine1.Preview;
   1: ACRptEngine1.ShowDesigner;
   2: ACRptEngine1.Print;
  end;

end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
  ACRptEngine1.Init;
  ACRptEngine1.SetReportFile(rpt_path+'dlg1.apt');
  case rg1.ItemIndex of
   0: ACRptEngine1.Preview;
   1: ACRptEngine1.ShowDesigner;
   2: ACRptEngine1.Print;
  end;

end;

procedure TForm1.BitBtn4Click(Sender: TObject);
begin
  ACRptEngine1.Init;
  ACRptEngine1.AddDataSet('zlemployee', dm.qryZlemployee.Recordset);
  ACRptEngine1.SetReportFile(rpt_path+'dlg2.apt');
  case rg1.ItemIndex of
   0: ACRptEngine1.Preview;
   1: ACRptEngine1.ShowDesigner;
   2: ACRptEngine1.Print;
  end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  ACRptEngine1.Init;
  ACRptEngine1.SetReportFile(rpt_path+'innertable.apt');
  case rg1.ItemIndex of
   0: ACRptEngine1.Preview;
   1: ACRptEngine1.ShowDesigner;
   2: ACRptEngine1.Print;
  end;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  ACRptEngine1.Init;
  ACRptEngine1.SetReportFile(rpt_path+'innerqry.apt');
  case rg1.ItemIndex of
   0: ACRptEngine1.Preview;
   1: ACRptEngine1.ShowDesigner;
   2: ACRptEngine1.Print;
  end;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  ACRptEngine1.Init;
  ACRptEngine1.SetReportFile(rpt_path+'innerqryado.apt');
  case rg1.ItemIndex of
   0: ACRptEngine1.Preview;
   1: ACRptEngine1.ShowDesigner;
   2: ACRptEngine1.Print;
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  ACRptEngine1.Init;
  ACRptEngine1.SetReportFile(rpt_path+'paramqry.apt');
  case rg1.ItemIndex of
   0: ACRptEngine1.Preview;
   1: ACRptEngine1.ShowDesigner;
   2: ACRptEngine1.Print;
  end;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
  ACRptEngine1.Free;
end;

end.
