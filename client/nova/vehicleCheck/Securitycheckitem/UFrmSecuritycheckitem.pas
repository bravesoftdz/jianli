unit UFrmSecuritycheckitem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, UFrmSecuritycheckitemEdit, NovaComboBox;

type
  TFrmSecuritycheckitem = class(TSimpleCRUDForm)
    jcdscategoryname: TjsonClientDataSet;
    jcdsResultid: TLargeintField;
    jcdsResultcategorycode: TWideStringField;
    jcdsResultname: TWideStringField;
    jcdsResultdiscribe: TWideStringField;
    jcdsResultcreatename: TWideStringField;
    jcdsResultupdatename: TWideStringField;
    jcdsResultcreateby: TLargeintField;
    jcdsResultupdateby: TLargeintField;
    jcdsResultcategoryname: TWideStringField;
    jsonCDSDelSecuritycheckitem: TjsonClientDataSet;
    nvcbbcategorycode: TNovaComboBox;
    lbcategoryname: TLabel;
    jcdsResultcreatetime: TDateTimeField;
    jcdsResultupdatetime: TDateTimeField;
    jcdsResultisroutinecheck: TBooleanField;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    log : String;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSecuritycheckitem: TFrmSecuritycheckitem;

implementation

uses Services, PubFn;
{$R *.dfm}

procedure TFrmSecuritycheckitem.FormCreate(Sender: TObject);
begin
  inherited;
  nvcbbcategorycode.Active:= false;
  nvcbbcategorycode.Active:= true;
end;

procedure TFrmSecuritycheckitem.tbtnDeleteClick(Sender: TObject);
var
  nResult: integer;
  sResult: string;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if not SysDialogs.Confirm('信息提示', '确认要删除该记录吗?') then
    exit;

  with jsonCDSDelSecuritycheckitem do
  try
    close;
    log := '删除安检项目：安检项目名称='+jcdsResult.FieldByName('categoryname').AsString+
    ',名称='+jcdsResult.FieldByName('name').AsString;
    Params.ParamByName('securitycheckitem.id').Value :=jcdsResult.FieldByName('id').AsInteger ;
    Execute;
    nResult := Params.ParamByName('flag').Value;
    sResult := Params.ParamByName('msg').Value;
    SysDialogs.ShowMessage(sResult);
    if (nResult = 1) then
    begin
      SysLog.WriteLog('删除安检项目','删除',log);
      tbtnFilterClick(Sender);
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('安检项目删除失败：' + E.Message);
    end;
  end;
end;

procedure TFrmSecuritycheckitem.tbtnEditClick(Sender: TObject);
var i,id:integer;
begin
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  with FrmSecuritycheckitemEdit do
  begin
    FrmSecuritycheckitemEdit := TFrmSecuritycheckitemEdit.Create(self);
    Caption := '修改安检项目信息';
    flag:=false;
    id :=  jcdsResult.FieldByName('id').AsInteger;
    nvedtname.Text := jcdsResult.FieldByName('name').AsString;
    createby := jcdsResult.FieldByName('createby').AsString;
    createtime := jcdsResult.FieldByName('createtime').AsString;
    mmodescribe.Text := jcdsResult.FieldByName('describe').AsString;
    chkroutinecheck.Checked := jcdsResult.FieldByName('isroutinecheck').AsBoolean;
    routinecheck := jcdsResult.FieldByName('isroutinecheck').AsString;
    for i := 0 to nvcbbcategorycode.Items.Count - 1 do
    begin
    try
      if TCommInfo(nvcbbcategorycode.Items.Objects[i]).Value= jcdsResult.FieldByName('categorycode').AsString then
      begin
           nvcbbcategorycode.ItemIndex:= i;
           break;
      end;
      except

      end;
    end;

    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id',id,[] );
    end;
  end;
end;

procedure TFrmSecuritycheckitem.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active := false;
    if ((trim(nvcbbcategorycode.Text) = '') or (trim(nvcbbcategorycode.Text) = '请选择...')) then
    begin
      Params.ParamValues['filter_LIKES_t!categorycode'] := '';
    end else
    begin
      Params.ParamValues['filter_LIKES_t!categorycode'] := nvcbbcategorycode.ItemIndex;
    end;
    Active := true;
  end;
end;

procedure TFrmSecuritycheckitem.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  with FrmSecuritycheckitemEdit do
  begin
    FrmSecuritycheckitemEdit := TFrmSecuritycheckitemEdit.Create(self);
    Caption := '添加安检项目信息';
    flag:=true;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', id, []);
    end;
  end;
end;

end.
