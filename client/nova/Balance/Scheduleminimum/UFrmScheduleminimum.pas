unit UFrmScheduleminimum;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, UFrmScheduleminimumEdit, NovaEdit, NovaHelp,
  NovaCheckedComboBox;

type
  TFrmScheduleminimum = class(TSimpleCRUDForm)
    jsonCDSDelminimum: TjsonClientDataSet;
    lbl1: TLabel;
    nvhlpschedule: TNovaHelp;
    lbl2: TLabel;
    nvhlpvehicleno: TNovaHelp;
    Label1: TLabel;
    cbborg: TNovaCheckedComboBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    log : String;
  public
  resultid:Int64;
    { Public declarations }
  end;

var
  FrmScheduleminimum: TFrmScheduleminimum;

implementation

uses Services, UDMPublic;
{$R *.dfm}

procedure TFrmScheduleminimum.FormCreate(Sender: TObject);
begin
  inherited;
  cbborg.Active := False;
  cbborg.Active := True;
end;

procedure TFrmScheduleminimum.tbtnDeleteClick(Sender: TObject);
var nResult : LongWord;
    sResult : string;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if not SysDialogs.Confirm('信息提示', '确认要删除该记录吗!') then
    exit;

  with jsonCDSDelminimum do
  try
    close;
    Params.ParamByName('minimum.id').Value :=jcdsResult.FieldByName('id').AsInteger ;
    Execute;
    nResult := Params.ParamByName('flag').Value;
    sResult := Params.ParamByName('msg').Value;
    SysDialogs.ShowMessage(sResult);
    if (nResult = 1) then
    begin
      log := '删除班次保底数：班次'+jcdsResult.FieldByName('schedulename').AsString+
      ',车牌号='+jcdsResult.FieldByName('vehicleno').AsString+
      ',保底人数='+jcdsResult.FieldByName('num').AsString;
      SysLog.WriteLog('结算管理—>班次保底数','删除',log);
      tbtnFilterClick(Sender);
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('班次保底数记录删除失败：' + E.Message);
    end;
  end;
end;

procedure TFrmScheduleminimum.tbtnEditClick(Sender: TObject);
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  with FrmScheduleminimumEdit do
  begin
    FrmScheduleminimumEdit := TFrmScheduleminimumEdit.Create(self);
    Caption := '修改班次保底数信息';
    edittype:=Tedittype.update;
    id := jcdsResult.FieldByName('id').AsInteger;
    vehicleid :=  jcdsResult.FieldByName('vehicleid').AsString;
    vehicleno :=  jcdsResult.FieldByName('vehicleno').AsString;
    createby := jcdsResult.FieldByName('createby').AsString;
    nvhlpschedule.Text := jcdsResult.FieldByName('schedulename').AsString;
    nvhlpschedule.Id := jcdsResult.FieldByName('scheduleid').AsInteger;
    nvhlpcode.Text := jcdsResult.FieldByName('vehicleno').AsString;
    nvhlpcode.Id := jcdsResult.FieldByName('vehicleid').AsInteger;
    createtime := jcdsResult.FieldByName('createtime').AsDateTime;
    edtminimum.Text := jcdsResult.FieldByName('num').AsString;
    nums := jcdsResult.FieldByName('num').AsInteger;
    nvhlpschedule.Enabled := False;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id',id,[] );
    end;
  end;
  {inherited;
  if (jcdsResult.Active=True) and (jcdsResult.RecNo>=0) then
  begin
    FrmScheduleminimumEdit:=TFrmScheduleminimumEdit.Create(self,self.functionItem);
    try
      with FrmScheduleminimumEdit do
      begin
        Caption:='修改班次保底数信息';
        edittype:=Tedittype.update;
        id := jcdsResult.FieldByName('id').AsString;
        vehicleid :=  jcdsResult.FieldByName('vehicleid').AsString;
        createby := jcdsResult.FieldByName('createby').AsString;
        nvhlpschedule.Text := jcdsResult.FieldByName('schedulename').AsString;
        nvhlpschedule.Id := jcdsResult.FieldByName('scheduleid').AsInteger;
        nvhlpcode.Text := jcdsResult.FieldByName('vehicleno').AsString;
        createtime := jcdsResult.FieldByName('createtime').AsDateTime;
        edtminimum.Text := jcdsResult.FieldByName('num').AsString;
      end;
      if ModalResult = mrok then
      begin
        tbtnFilterClick(Sender);
        jcdsResult.Locate('vehicleid',vehicleid,[] );
      end;
    finally
      FreeAndNil(FrmScheduleminimumEdit);
    end;
  end
  else
  begin
    SysDialogs.ShowError('请先选择需要修改的记录！');
  end;}
end;

procedure TFrmScheduleminimum.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active:= false;
    if Trim(nvhlpvehicleno.Text) = '' then
    begin
      Params.ParamValues['filter_EQL_t!vehicleid'] := '';
    end else
    begin
      Params.ParamValues['filter_EQL_t!vehicleid'] := nvhlpvehicleno.Id;
    end;
    if Trim(nvhlpschedule.Text) = '' then
    begin
      Params.ParamValues['filter_EQL_t!scheduleid'] := '';
    end else
    begin
      Params.ParamValues['filter_EQL_t!scheduleid'] := nvhlpschedule.Id;
    end;
    if cbborg.CheckedCount = 0 then
      Params.ParamValues['filter_INS_s!orgid'] := SysInfo.LoginUserInfo.OrgIDs
    else
      Params.ParamValues['filter_INS_s!orgid'] := cbborg.GetSelectID;
    Active:= true;
  end;
end;

procedure TFrmScheduleminimum.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  with FrmScheduleminimumEdit do
  begin
    FrmScheduleminimumEdit := TFrmScheduleminimumEdit.Create(Self);
    Caption:= '班次保底数设置';
    sign := true;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Self);
      jcdsResult.Locate('id',id,[] );
    end;
  end;
end;

end.
