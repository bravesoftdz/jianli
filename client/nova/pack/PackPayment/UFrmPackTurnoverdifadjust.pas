unit UFrmPackTurnoverdifadjust;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp, NovaCheckedComboBox;

type
  TFrmPackTurnoverdifadjust = class(TSimpleCRUDForm)
    lbl5: TLabel;
    cbborg: TNovaCheckedComboBox;
    lbl4: TLabel;
    dtpstartdate: TDateTimePicker;
    lbl3: TLabel;
    dtpenddate: TDateTimePicker;
    lbl1: TLabel;
    nvhlpseller: TNovaHelp;
    jscdDel: TjsonClientDataSet;
    procedure tbtnCloseClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPackTurnoverdifadjust: TFrmPackTurnoverdifadjust;

implementation
uses Services,PubFn,UFrmPackTurnoverdifadjustEdt;
{$R *.dfm}

procedure TFrmPackTurnoverdifadjust.FormShow(Sender: TObject);
begin
  inherited;
  cbborg.Active:=false;
  cbborg.Active:=true;
  dtpstartdate.DateTime:=now;
  dtpenddate.DateTime:=now;
end;

procedure TFrmPackTurnoverdifadjust.tbtnCloseClick(Sender: TObject);
begin
  inherited;
  close;
end;

procedure TFrmPackTurnoverdifadjust.tbtnDeleteClick(Sender: TObject);
var
   log:string;
begin
  inherited;
    if (jcdsResult.Active) and (jcdsResult.RecordCount>0) then
  begin
    if not SysDialogs.Confirm('提示','确定要删除该记录吗？') then
    begin
      exit;
    end;
    with jscdDel do
    begin
        log := '日期：'+jcdsResult.FieldByName('moneydate').AsString
              +'，办理员：'+self.jcdsResult.FieldByName('sellername').AsString
              +'，调整金额：'+self.jcdsResult.FieldByName('difmoney').AsString
              +'，备注：'+self.jcdsResult.FieldByName('remark').AsString;
      Params.ParamValues['tdifadjusts.id']:=jcdsResult.FieldByName('id').AsString;
      Execute;
      if Params.ParamValues['msg']<>'' then
      begin
        SysDialogs.ShowMessage(Params.ParamValues['msg']);
      end;
      if Params.ParamValues['flag']=1 then
      begin
        SysLog.WriteLog('差错调整', '删除差错调整', log);
        tbtnFilter.Click;
      end;
    end;
  end;
end;

procedure TFrmPackTurnoverdifadjust.tbtnEditClick(Sender: TObject);
begin
  inherited;
  if not jcdsResult.Active then exit;
  if  jcdsResult.RecordCount=0 then exit;

  FrmPackTurnoverdifadjustEdt := TFrmPackTurnoverdifadjustEdt.Create(self);
  try
    with FrmPackTurnoverdifadjustEdt do
    begin
      Caption := '修改行包差错调整';
      id:=jcdsResult.FieldByName('id').AsLargeInt;
      dtpstartdate.Date:=jcdsResult.FieldByName('moneydate').AsDateTime;
      nvhlpseller.id:=jcdsResult.FieldByName('seller').AsLargeInt;
      nvhlpseller.text:=jcdsResult.FieldByName('sellername').AsString;
      NovaEdtMoney.text:=jcdsResult.FieldByName('difmoney').AsString;
      MeRemark.text:=jcdsResult.FieldByName('remark').AsString;
      createby:=jcdsResult.FieldByName('createby').AsLargeInt;
      createbytime:=jcdsResult.FieldByName('createtime').AsString;
      if SysMainForm.showFormModal(FrmPackTurnoverdifadjustEdt, false) = mrok then
      begin
         tbtnFilterClick(nil);
         jcdsResult.Locate('id',id,[]);
      end;
    end;
  finally
    FreeAndNil(FrmPackTurnoverdifadjustEdt);
  end;


end;

procedure TFrmPackTurnoverdifadjust.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  if ((cbborg.CheckedCount=0) or (cbborg.GetSelectID='') ) then
  begin
    SysDialogs.ShowMessage('请选择机构！');
    cbborg.SetFocus;
    exit;
  end;
  with jcdsResult do
  begin
    Active := false;
    Params.ParamValues['filter_INS_t!orgid'] := cbborg.GetSelectID;
    if nvhlpseller.Id > 0 then
        Params.ParamValues['filter_EQL_t!seller'] := nvhlpseller.Id
    else
        Params.ParamValues['filter_EQL_t!seller'] := null;

    Params.ParamValues['filter_GED_t!moneydate'] :=
                formatdatetime('yyyy-mm-dd',dtpstartdate.Date)+' 00:00:00';
    Params.ParamValues['filter_LED_t!moneydate'] :=
                formatdatetime('yyyy-mm-dd',dtpenddate.Date)+' 23:59:59';

    Active := true;
  end;
end;

procedure TFrmPackTurnoverdifadjust.tbtnInsertClick(Sender: TObject);
begin
  inherited;
    FrmPackTurnoverdifadjustEdt := TFrmPackTurnoverdifadjustEdt.Create(self);
  try
    with FrmPackTurnoverdifadjustEdt do
    begin
      Caption := '添加行包差错调整';
      if SysMainForm.showFormModal(FrmPackTurnoverdifadjustEdt, false) = mrok then
      begin
         tbtnFilterClick(nil);
      end;
    end;
  finally
    FreeAndNil(FrmPackTurnoverdifadjustEdt);
  end;
end;

end.
