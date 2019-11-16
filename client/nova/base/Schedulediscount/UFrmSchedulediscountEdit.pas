unit UFrmSchedulediscountEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, DB, DBClient, jsonClientDataSet, NovaComboBox,
  StdCtrls, NovaEdit, ComCtrls, Buttons, ExtCtrls, NovaHelp,
  NovaHComboBox, NovaCheckedComboBox, NovaListView, DBGridEhGrouping, GridsEh,
  DBGridEh, NvDbgridEh, ImgList;

type
  TFrmSchedulediscountEdit = class(TSimpleEditForm)
    lbl1: TLabel;
    Label1: TLabel;
    nvhelproute: TNovaHelp;
    lbl2: TLabel;
    Label2: TLabel;
    cbbhelpcode: TNovaCheckedComboBox;
    dsResult: TDataSource;
    jsonCDSSchedulediscountSave: TjsonClientDataSet;
    jcdsgradename: TjsonClientDataSet;
    wdstrngfldCDSSchedulediscountSavevipgrade: TWideStringField;
    wdstrngfldCDSSchedulediscountSavegradename: TWideStringField;
    fltfldCDSSchedulediscountSavedefaultdiscountrate: TFloatField;
    lrgntfldCDSSchedulediscountSaveid: TLargeintField;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    Label4: TLabel;
    lbl9: TLabel;
    cbbstartdate: TDateTimePicker;
    cbbenddate: TDateTimePicker;
    edtfromnum: TNovaEdit;
    edtendnum: TNovaEdit;
    edtdefaultdiscountrate: TNovaEdit;
    edtmindiscountrate: TNovaEdit;
    nvdbgrdh1: TNvDbgridEh;
    edtschedule: TNovaEdit;
    lbl10: TLabel;
    lbl11: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure nvhelprouteExit(Sender: TObject);
    procedure nvhelprouteChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtdefaultdiscountrateExit(Sender: TObject);
    procedure edtmindiscountrateExit(Sender: TObject);
    procedure cbbhelpcodeEnter(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    flag: Boolean;
    id:int64;
    orgid, createby, discountid, vipcreateby,
    createtime, vipcreatetime, scheduleid: string;
  end;

var
  FrmSchedulediscountEdit: TFrmSchedulediscountEdit;

implementation

uses Services, PubFn;
{$R *.dfm}

procedure TFrmSchedulediscountEdit.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult: string;
begin
  if ((trim(edtfromnum.Text) = '') or (trim(edtendnum.Text) = '') or
      (trim(edtdefaultdiscountrate.Text) = '') or
      (trim(edtmindiscountrate.Text) = '') or (trim(nvhelproute.Text) = '')) then
  begin
    SysDialogs.Warning('请填写相关的信息！');
    cbbhelpcode.SetFocus;
    exit;
  end;
  if id=0 then
  begin
  if(cbbhelpcode.GetSelectID='')then
  begin
    SysDialogs.Warning('请选择班次！');
    cbbhelpcode.SetFocus;
    exit;
  end;
  end;

  if FormatDateTime('yyyymmdd', cbbstartdate.Date) > FormatDateTime('yyyymmdd',
    cbbenddate.Date)then
  begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期！');
    exit;
  end;
  if (StrToFloat(edtdefaultdiscountrate.Text) < StrToFloat(edtmindiscountrate.Text)) then
  begin
    SysDialogs.Warning('默认折扣率要大于最低折扣率！！');
    edtdefaultdiscountrate.SetFocus;
    exit;
  end;

  with jsonCDSSchedulediscountSave do
  begin
   // Close;
   if Trim(cbbhelpcode.GetSelectID) = '' then
   begin
     scheduleid := scheduleid;
   end else
   begin
     scheduleid := cbbhelpcode.GetSelectID;
   end;
    Params.ParamByName('schedulediscount.id').Value := id;
    Params.ParamByName('schedulediscount.orgid').Value := orgid;
    Params.ParamByName('scheduleid').Value := scheduleid;
    //Params.ParamByName('schedulediscount.scheduleid').Value := scheduleid;
    Params.ParamByName('schedulediscount.startdate').Value :=
      DateTimeToStr(cbbstartdate.DateTime);
    Params.ParamByName('schedulediscount.createby').Value := createby;
    Params.ParamByName('schedulediscount.createtime').Value := createtime;
    Params.ParamByName('schedulediscount.enddate').Value := DateTimeToStr(cbbenddate.DateTime);

    Params.ParamByName('schedulediscount.fromnum').Value := edtfromnum.Text;
    Params.ParamByName('schedulediscount.endnum').Value := edtendnum.Text;
    Params.ParamByName('schedulediscount.defaultdiscountrate').Value :=
      FloatToStr(StrToFloat(edtdefaultdiscountrate.Text)/100);
    Params.ParamByName('schedulediscount.mindiscountrate').Value :=
      FloatToStr(StrToFloat(edtmindiscountrate.Text)/100);
    try
      //Execute;
      ApplyUpdates(-1);
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        cbbhelpcode.SetFocus;
      end
      else
      begin
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('班次折扣添加失败：' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmSchedulediscountEdit.cbbhelpcodeEnter(Sender: TObject);
begin
  inherited;
  if nvhelproute.Id = 0 then
  begin
    SysDialogs.ShowMessage('请先填写线路！');
    nvhelproute.SetFocus;
    Exit;
  end;
end;

procedure TFrmSchedulediscountEdit.edtdefaultdiscountrateExit(Sender: TObject);
begin
  inherited;
  if (StrToFloat(edtdefaultdiscountrate.Text) > 100) or (StrToFloat(edtdefaultdiscountrate.Text) < 0) then
  begin
    SysDialogs.ShowMessage('请输入0-100之间的数');
    edtdefaultdiscountrate.SetFocus;
    exit;
  end;
end;

procedure TFrmSchedulediscountEdit.edtmindiscountrateExit(Sender: TObject);
begin
  inherited;
  if (StrToFloat(edtmindiscountrate.Text) > 100) or (StrToFloat(edtmindiscountrate.Text) < 0) then
  begin
    SysDialogs.ShowMessage('请输入0-100之间的数');
    edtmindiscountrate.SetFocus;
    exit;
  end;
end;

procedure TFrmSchedulediscountEdit.FormCreate(Sender: TObject);
begin
  inherited;
  cbbstartdate.DateTime:= now();
  cbbenddate.DateTime := now();

end;

procedure TFrmSchedulediscountEdit.FormShow(Sender: TObject);
begin
  inherited;
//  if nvhelproute.Id <> 0 then
//  begin
//    with cbbhelpcode do
//    begin
//      cbbhelpcode.Active := false;
//        Params.ParamByName('filter_EQL_t!route.id').Value := nvhelproute.id;
//      cbbhelpcode.Active := true;
//    end;
//  end;

  with jsonCDSSchedulediscountSave do
  begin
    Active := false;
      Params.ParamByName('schedulediscount.id').Value := id;
    Active := true;
  end;
end;

procedure TFrmSchedulediscountEdit.nvhelprouteChange(Sender: TObject);
begin
  inherited;
  cbbhelpcode.CheckAll(false);
end;

procedure TFrmSchedulediscountEdit.nvhelprouteExit(Sender: TObject);
begin
  inherited;
  with cbbhelpcode do
  begin
    Params.ParamByName('filter_EQL_t!route.id').Value := nvhelproute.id;
  end;
  cbbhelpcode.Active := false;
  cbbhelpcode.Active := true;
  cbbhelpcode.CheckAll(false);
end;

end.
