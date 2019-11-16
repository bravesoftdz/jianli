unit UFrmTicketentrance;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  PrnDbgeh, ImgList, GridsEh, DBGridEh, ComCtrls, ToolWin, ExtCtrls, StdCtrls,
  NovaEdit, NovaHelp, NovaCheckedComboBox, NvPrnDbgeh, NvDbgridEh;

type
  TFrmTicketentrance = class(TSimpleCRUDForm)
    lblOrgid: TLabel;
    lblName: TLabel;
    jsnclntdtstInitInitOrg: TjsonClientDataSet;
    jsnclntdtstInitCDSDel: TjsonClientDataSet;
    nvedtName: TNovaEdit;
    nvckbOrg: TNovaCheckedComboBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    log: string;
  public
    { Public declarations }
  end;

var
  FrmTicketentrance: TFrmTicketentrance;

implementation
  uses UFrmTicketentranceEdit, Services, PubFn, UDMPublic;
{$R *.dfm}

procedure TFrmTicketentrance.FormShow(Sender: TObject);
begin
  inherited;
    nvckbOrg.Active := False;
    nvckbOrg.Active := True;
end;

procedure TFrmTicketentrance.tbtnDeleteClick(Sender: TObject);
var
  nResult: integer;
  sResult: string;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if not SysDialogs.Confirm('信息提示', '确认要删除该记录吗!') then
    exit;

  with jsnclntdtstInitCDSDel do
  try
    close;
    Params.ParamByName('delID').Value :=jcdsResult.FieldByName('id').AsInteger ;
    Execute;
    nResult := Params.ParamByName('flag').Value;
    sResult := Params.ParamByName('msg').Value;
    SysDialogs.ShowMessage(sResult);
    if (nResult = 1) then
    begin
     log := ' 删除'+jcdsResult.FieldByName('orgname').AsString+'的检票口:'+jcdsResult.FieldByName('name').AsString;
     SysLog.WriteLog('检票口管理', '删除检票口', log);
     log:='';
      tbtnFilterClick(Sender);
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('检票口信息删除失败：' + E.Message);
    end;
  end;
end;

procedure TFrmTicketentrance.tbtnEditClick(Sender: TObject);
var isactive:Boolean;
begin
  inherited;
   if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  FrmTicketentranceEdit := TFrmTicketentranceEdit.Create(self);
  with FrmTicketentranceEdit do
  begin
    Caption := '修改检票口信息';
    flag:=false;
    id :=  jcdsResult.FieldByName('id').AsInteger;
    orgname := jcdsResult.FieldByName('orgname').AsString;
    nvedtname.Text := jcdsResult.FieldByName('name').AsString;
    tname:=jcdsResult.FieldByName('name').AsString;
    printname:= jcdsResult.FieldByName('printname').AsString;
    nvedtPrintname.Text := jcdsResult.FieldByName('printname').AsString;
    createtime :=  jcdsResult.FieldByName('createtime').AsString;
    createby :=  jcdsResult.FieldByName('createby').AsString;
    mmoDeseription.Text := jcdsResult.FieldByName('remarks').AsString;
    isedt := True;
    nvhcbbOrg.SetItemIndexByField('name',jcdsResult.FieldByName('orgname').AsString);
    if SysMainForm.showFormModal(FrmTicketentranceEdit,False) = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id',id,[] );
    end;
  end;
end;

procedure TFrmTicketentrance.tbtnFilterClick(Sender: TObject);
var
  orgid: integer;
  isaction: string;
begin
  inherited;
  with jcdsResult do
  begin
    Active := false;
    Params.ParamByName('filter_INS_t!orgid').Value := nvckbOrg.GetSelectID;
    Params.ParamByName('filter_LIKES_t!name').Value := nvedtName.Text;
    Active := True;
  end
end;

procedure TFrmTicketentrance.tbtnInsertClick(Sender: TObject);
begin
  inherited;
    FrmTicketentranceEdit := TFrmTicketentranceEdit.Create(Self);
  with FrmTicketentranceEdit  do
  begin
    Caption := '检票口信息';
    ShowModal;
    if ModalResult = mrok then
      begin

        tbtnFilterClick(Sender);
      jcdsResult.Locate('id',id,[] );
      end;
  end;
end;

end.
