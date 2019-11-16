unit UFrmTickettype;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  PrnDbgeh, ImgList, GridsEh, DBGridEh, Math, jpeg, ComCtrls, ToolWin, ExtCtrls,
  StdCtrls,
  DBCtrls, NovaEdit, NvPrnDbgeh, NvDbgridEh;

type
  TFrmTickettype = class(TSimpleCRUDForm)
    lbl3: TLabel;
    lbl5: TLabel;
    rb_isdefault: TRadioButton;
    rball: TRadioButton;
    jsonCDSDelTickettype: TjsonClientDataSet;
    edt_name: TNovaEdit;
    edt_code: TNovaEdit;
    jcdsPrior: TjsonClientDataSet;
    jcdsNext: TjsonClientDataSet;
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure dbgrdhResultColumns11AdvDrawDataCell(Sender: TCustomDBGridEh;
      Cell, AreaCell: TGridCoord; Column: TColumnEh; const ARect: TRect;
      var Params: TColCellParamsEh; var Processed: Boolean);
    procedure tbtnSaveClick(Sender: TObject);
    procedure tbtnCancelClick(Sender: TObject);
  private
    { Private declarations }
    log : String;
  public
    { Public declarations }

  end;

var
  FrmTickettype: TFrmTickettype;

implementation

uses UFrmTickettypeAdd, PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmTickettype.dbgrdhResultColumns11AdvDrawDataCell
  (Sender: TCustomDBGridEh; Cell, AreaCell: TGridCoord; Column: TColumnEh;
  const ARect: TRect; var Params: TColCellParamsEh; var Processed: Boolean);
var
  HexStr: String;
  jpg: TJPEGImage;
begin
  inherited;
  HexStr := jcdsResult.FieldByName('soldpicture').AsString;
  Sender.Canvas.FillRect(ARect);
  if HexStr <> '' then
  begin
    jpg := HexStrToJpg(HexStr);
    Sender.Canvas.Draw(ARect.Left, max(ARect.Top,
        trunc(ARect.Top + (ARect.Bottom - ARect.Top - jpg.Height) / 2)), jpg);
  end;
  Processed := true;
end;

procedure TFrmTickettype.tbtnCancelClick(Sender: TObject);
var
  nResult: integer;
  sResult: string;
    curid:int64;
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount <= 0 then
    exit;
  // ����
  try
    with jcdsNext do
    begin
      Active := false;
      curid:=jcdsResult.FieldByName('id').AsLargeInt;
      Params.ParamByName('tickettype.id').Value:= jcdsResult.FieldByName('id').AsString;;
      Params.ParamByName('tickettype.updateby').Value := sysInfo.LoginUserInfo.UserID;
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult <0)  then
      begin
        SysDialogs.Warning(sResult);
        exit;
      end;
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', curid, []);
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('Ʊ������ʧ�ܣ�' + E.Message);
    end;
  end;
end;

procedure TFrmTickettype.tbtnDeleteClick(Sender: TObject);
var
  flag: integer;
  msg: string;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;

  if jcdsResult.FieldByName('isdefault').AsBoolean then
  begin
    SysDialogs.ShowMessage('Ĭ��Ʊ�ֲ�����ɾ��!');
    exit;
  end;

  if not SysDialogs.Confirm('��Ϣ��ʾ', 'ȷ��Ҫɾ���ü�¼��!') then
    exit;

  with jsonCDSDelTickettype do
    try
      Params.ParamByName('tickettype.id').Value := jcdsResult.FieldByName('id')
        .AsInteger;
      Execute;
      flag := Params.ParamByName('flag').Value;
      msg := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(msg);
      if (flag = 1) then
      begin
        log := 'ɾ��Ʊ�����ã�Ʊ������='+jcdsResult.FieldByName('name').AsString+
        ',Ʊ�ֱ���='+jcdsResult.FieldByName('code').AsString+
        ',��ӡ����='+jcdsResult.FieldByName('printname').AsString+
        ',�Ƿ�Ĭ��Ʊ��='+jcdsResult.FieldByName('isdefault').AsString;
        SysLog.WriteLog('Ʊ�۹���->Ʊ������','ɾ��',log);
        tbtnFilterClick(Sender);
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('Ʊ����Ϣɾ��ʧ�ܣ�' + E.Message);
      end;
    end;
end;

procedure TFrmTickettype.tbtnEditClick(Sender: TObject);
var
  HexStr: string;
  curid:int64;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  with FrmTickettypeAdd do
  begin
    FrmTickettypeAdd := TFrmTickettypeAdd.Create(self);
    FrmTickettypeAdd.Caption := '�޸�Ʊ����Ϣ';
    isdefault := jcdsResult.FieldByName('isdefault').AsBoolean;
    FrmTickettypeAdd.id := jcdsResult.FieldByName('id').AsInteger;
    orgid := jcdsResult.FieldByName('orgid').AsInteger;
    id := jcdsResult.FieldByName('id').AsInteger;
    curid:= jcdsResult.FieldByName('id').AsInteger;
    FrmTickettypeAdd.edtname.Text := jcdsResult.FieldByName('name').AsString;
    FrmTickettypeAdd.edtcode.Text := jcdsResult.FieldByName('code').AsString;
    synccode := jcdsResult.FieldByName('synccode').AsString;
    orderno := jcdsResult.FieldByName('orderno').AsInteger;
    FrmTickettypeAdd.edtprintname.Text := jcdsResult.FieldByName('printname')
      .AsString;
    FrmTickettypeAdd.createby := jcdsResult.FieldByName('createby').AsInteger;
    FrmTickettypeAdd.createtime := jcdsResult.FieldByName('createtime')
      .AsString;
    HexStr := jcdsResult.FieldByName('soldpicture').AsString;
    if HexStr <> '' then
      FrmTickettypeAdd.Img_Picture.Picture.Bitmap.Assign(HexStrToJpg(HexStr));
    if jcdsResult.FieldByName('isscore').AsBoolean then
    begin
      FrmTickettypeAdd.Rb_ISSCORE1.Checked := true;
    end
    else
    begin
      FrmTickettypeAdd.Rb_ISSCORE1.Checked := false;
    end;
    edtname.Enabled:=false;
    edtcode.Enabled:=false;
    if ShowModal = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', curid, []);
    end;
  end;
end;

procedure TFrmTickettype.tbtnFilterClick(Sender: TObject);

begin
  inherited;

  with jcdsResult do
  begin
    Active := false;
    Params.ParamValues['filter_INS_t!orgid'] := sysInfo.LoginUserInfo.OrgIDs;
    if rb_isdefault.Checked then
    begin
      Params.ParamByName('filter_EQB_t!isdefault').Value := true;
    end
    else
      Params.ParamByName('filter_EQB_t!isdefault').Value := null;
    Params.ParamByName('filter_LIKES_t!name').Value := trim(edt_name.Text);
    Params.ParamByName('filter_LIKES_t!code').Value := trim(edt_code.Text);
    Active := true;
  end
end;

procedure TFrmTickettype.tbtnInsertClick(Sender: TObject);
var
  curid: integer;
begin
  inherited;
  FrmTickettypeAdd := TFrmTickettypeAdd.Create(self);
  try
    with FrmTickettypeAdd do
    begin
      Caption := '���Ʊ����Ϣ';
      createby := sysInfo.LoginUserInfo.UserID;
      orgid := sysInfo.LoginUserInfo.orgid;
      edittype := add;
      if SysMainForm.showFormModal(FrmTickettypeAdd, false) = mrok then
      begin
        tbtnFilterClick(Sender);
        curid := id;
        jcdsResult.Locate('id', curid, []);
      end;
    end;
  finally
    FreeAndNil(FrmTickettypeAdd);
  end;
end;

procedure TFrmTickettype.tbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult: string;
  curid:int64;
begin
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount <= 0 then
    exit;
  if  jcdsResult.FieldByName('orderno').AsInteger=1 then
  begin
    SysDialogs.Warning('�Ѿ��ǵ�һ����¼�ˣ�');
    exit;
  end ;
  // ����
  try
    with jcdsPrior do
    begin
      Active := false;
      curid:=jcdsResult.FieldByName('id').AsLargeInt;
      Params.ParamByName('tickettype.id').Value:= jcdsResult.FieldByName('id').AsString;
      Params.ParamByName('tickettype.updateby').Value := sysInfo.LoginUserInfo.UserID;
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult <0)  then
      begin
        SysDialogs.Warning(sResult);
        exit;
      end;
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', curid, []);
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('Ʊ������ʧ�ܣ�' + E.Message);
    end;
  end;

end;

end.
