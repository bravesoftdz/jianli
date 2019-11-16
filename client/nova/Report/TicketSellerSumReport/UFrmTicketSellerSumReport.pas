unit UFrmTicketSellerSumReport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaCheckedComboBox, NovaEdit, NovaHelp, Services,
   AcRptUtilsSecurity, OleServer, AcReport_TLB;


type
  TfrmTicketSellerSumReport = class(TSimpleCRUDForm)
    lblorgname: TLabel;
    lbl2: TLabel;
    lbl1: TLabel;
    lbl6: TLabel;
    nvhlpUserid: TNovaHelp;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    cbborg: TNovaCheckedComboBox;
    acrptngnTotalDeatil: TAcRptEngine;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnPrinterClick(Sender: TObject);
  private
    { Private declarations }
     rpt_path: String; // 生成.apt文件的路径
  public
    { Public declarations }
  end;

var
  frmTicketSellerSumReport: TfrmTicketSellerSumReport;

implementation

{$R *.dfm}

procedure TfrmTicketSellerSumReport.FormCreate(Sender: TObject);
begin
  inherited;
  cbborg.Active := False;
  cbborg.Active := True;
  cbborg.CheckById(true,sysinfo.LoginUserInfo.OrgID);

  acrptngnTotalDeatil := TAcRptEngine.Create(nil); // 初始化AcReport
 rpt_path := ExtractFilePath(ParamStr(0)); // 生成.apt文件的路径
end;

procedure TfrmTicketSellerSumReport.FormShow(Sender: TObject);
begin
  inherited;
  dtpstartdate.Date := Now;
  dtpenddate.Date := Now;
end;

procedure TfrmTicketSellerSumReport.tbtnFilterClick(Sender: TObject);
begin
  inherited;

  if dtpenddate.DateTime < dtpstartdate.DateTime then
  begin
    SysDialogs.ShowMessage('结束日期不能小于开始日期！');
    Exit;
  end;
 with jcdsResult do
  begin
   Active := false;
   if (Trim(cbborg.Text) <> '') and (cbborg.GetSelectID <> '') then
    begin
      Params.ParamValues['filter_INS_d!orgid'] := cbborg.GetSelectID;
    end
    else
    begin
      Params.ParamValues['filter_INS_d!orgid'] := '';
    end;

    Params.ParamValues['filter_GED_d!selfdepartdate'] := formatdatetime
      ('yyyy-mm-dd', dtpstartdate.DateTime);
    Params.ParamValues['filter_LED_d!selfdepartdate'] := formatdatetime
      ('yyyy-mm-dd', dtpenddate.DateTime + 0.999999);

      if nvhlpUserid.Id > 0 then
    begin
      Params.ParamValues['filter_EQL_d!seller'] := nvhlpUserid.Id;
    end
    else
    begin
      Params.ParamValues['filter_EQL_d!seller'] := '';
    end;
   Active := True;


  end;
end;

procedure TfrmTicketSellerSumReport.tbtnPrinterClick(Sender: TObject);
begin
  //inherited;
  if not jcdsResult.Active then
  begin
    SysDialogs.ShowMessage('无打印数据！');
    Exit;
  end;
  if jcdsResult.recordcount = 0 then
  begin
    SysDialogs.ShowMessage('无打印数据！');
    Exit;
  end;
  AddCommonDatasetToAcReport(dsResult.DataSet, acrptngnTotalDeatil, 'detail');   //给acreport赋数据源
  acrptngnTotalDeatil.SetReportFile(rpt_path + 'TicketSellerSumReport.apt'); //.apt路径

   acrptngnTotalDeatil.AddGlobalVariable('startdate', formatdatetime('yyyy-mm-dd', dtpstartdate.DateTime));
   acrptngnTotalDeatil.AddGlobalVariable('enddate',  formatdatetime('yyyy-mm-dd', dtpenddate.DateTime));
   acrptngnTotalDeatil.AddGlobalVariable('menuname', frmTicketSellerSumReport.Caption);

    acrptngnTotalDeatil.ShowDesigner;  //开发模式
   //acrptngnTotalDeatil.Preview; // 预览模式

end;

end.
