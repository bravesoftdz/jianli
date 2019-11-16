unit UFrmVipGiftStorage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, ComCtrls, NovaHelp,
  NovaComboBox, NovaEdit, DB, DBClient, jsonClientDataSet,Services,
  NovaHComboBox, ImgList, NovaCheckedComboBox, DBGridEhGrouping, GridsEh,
  DBGridEh, NvDbgridEh;

type
  TfrmVipGiftStorage = class(TSimpleEditForm)
    lbl1: TLabel;
    lbl2: TLabel;
    lbl10: TLabel;
    lbldate: TLabel;
    lbl3: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    nvcbbOperation: TNovaCheckedComboBox;
    lbl4: TLabel;
    nvdbgrdh1: TNvDbgridEh;
    jcdsFindDetail: TjsonClientDataSet;
    ds1: TDataSource;
    nvhlpUserid: TNovaHelp;
    btn2: TBitBtn;
    btn1: TBitBtn;
    nvhlpVipGiftname: TNovaHelp;
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
    Foperationid:Integer;
  public
    { Public declarations }
    property operationid:Integer read Foperationid;
  end;

var
  frmVipGiftStorage: TfrmVipGiftStorage;

implementation
  uses UDMPublic,PubFn;
{$R *.dfm}


procedure TfrmVipGiftStorage.btn1Click(Sender: TObject);
begin
  inherited;
    if FormatDateTime('yyyymmdd', dtpstartdate.Date) >
     FormatDateTime('yyyymmdd',  dtpenddate.Date) then
  begin
    SysDialogs.ShowMessage('操作开始日期不能大于结束日期！');
    exit;
  end;
   if Trim(nvcbbOperation.Text)='' then
   begin
      SysDialogs.ShowMessage('操作类型不能为空！');
      nvcbbOperation.SetFocus;
      Exit;
   end;

   //查询
  with jcdsFindDetail do
  begin
    Active:=False;
    Params.ParamValues['startdate'] :=
            formatdatetime('yyyy-mm-dd hh:mm:ss',dtpstartdate.DateTime)+' 00:00:00';
    Params.ParamValues['enddate'] :=
            formatdatetime('yyyy-mm-dd hh:mm:ss',dtpenddate.DateTime)+' 23:59:59';
    Params.ParamValues['operation']:= nvcbbOperation.GetSelectID;
    Params.ParamByName('createby').Value := nvhlpUserid.Id;

    Params.ParamByName('vipgiftname').Value  := nvhlpVipGiftname.Text;

    Active := True;
  end;
end;
end.

