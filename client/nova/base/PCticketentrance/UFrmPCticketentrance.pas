unit UFrmPCticketentrance;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  ImgList, GridsEh, DBGridEh, ComCtrls, ToolWin, ExtCtrls, StdCtrls,Services,
  PrnDbgeh, NovaEdit, NovaHelp, NovaComboBox, NvPrnDbgeh, NvDbgridEh,
  NovaCheckedComboBox, NovaHComboBox;

type
  TPCticketentrance = class(TSimpleCRUDForm)
    nvedtIp: TNovaEdit;
    lblOrg: TLabel;
    lblIp: TLabel;
    pnl1: TPanel;
    grp3: TGroupBox;
    spl1: TSplitter;
    jsdcEntrancenames: TjsonClientDataSet;
    dsEntrance: TDataSource;
    dbgrdhTypeids: TDBGridEh;
    grp5: TGroupBox;
    dbgrdh5: TDBGridEh;
    jcdsDleEntrance: TjsonClientDataSet;
    nvHcbbOrgNovaCbbOrg: TNovaHComboBox;
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure jcdsResultAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    isactive : Boolean;
    procedure refreshtEntrance;

  end;

var
  PCticketentrance: TPCticketentrance;

implementation
  uses UFrmPCticketentrnaceEdit, PubFn, UDMPublic;

{$R *.dfm}

procedure TPCticketentrance.FormCreate(Sender: TObject);
begin
  inherited;
  nvHcbbOrgNovaCbbOrg.Active:= False;
  nvHcbbOrgNovaCbbOrg.Active:= True;
end;

procedure TPCticketentrance.jcdsResultAfterOpen(DataSet: TDataSet);
begin
  inherited;
 if dsResult.DataSet.RecordCount<1 then
 begin
   jsdcEntrancenames.Close;
 end;

end;

procedure TPCticketentrance.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
   refreshtEntrance
end;

procedure TPCticketentrance.refreshtEntrance;
begin
  with jsdcEntrancenames do
  begin
    Active:=False;
    //Params.ParamValues['filter_EQS_t!orgid']:=jcdsResult.FieldByName('orgid').AsString;
    Params.ParamValues['filter_EQS_p!ip']:=jcdsResult.FieldByName('ip').AsString;
    Active:=True;
  end;
end;

procedure TPCticketentrance.tbtnDeleteClick(Sender: TObject);
  var nResult: integer;sResult: string;
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  if not SysDialogs.Confirm('提示','您即将删除电脑IP为；'+jcdsResult.FieldByName('ip').AsString+
                      ' 的所有记录。(如果要删除检票口，请进行修改)'+#13+'确定要删除该记录吗？') then
    begin
      exit;
    end;
  with jcdsDleEntrance do
  try
     Close;
     Params.ParamByName('orgid').Value := jcdsResult.FieldByName('orgid').AsInteger ;
     Params.ParamByName('ip').Value := jcdsResult.FieldByName('ip').AsString;
      Execute;
    nResult := Params.ParamByName('flag').Value;
    sResult := Params.ParamByName('msg').Value;
    SysDialogs.ShowMessage(sResult);
    if (nResult = 1) then
    begin
      tbtnFilterClick(Sender);
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('删除失败：' + E.Message);
    end;
  end;
end;

procedure TPCticketentrance.tbtnEditClick(Sender: TObject);
var curip: string;
begin
  inherited;

  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;
  with frmPCentranceEdit do
  begin
    frmPCentranceEdit := TfrmPCticketentrnceEdit.Create(self);
    frmPCentranceEdit.Caption := '修改检票控制信息';
    frmPCentranceEdit.flag:=false;
    isupdate:= True;
    isedt:= True;
    frmPCentranceEdit.id := id;
    nvhcbbOrg.SetItemIndexByField('name',jcdsResult.FieldByName('orgname').AsString);
    frmPCentranceEdit.nvedtIP.Text := jcdsResult.FieldByName('ip').AsString;
    nvlvEntrance.Params[0].Value := jcdsResult.FieldByName('orgid').AsString;
    curip := jcdsResult.FieldByName('ip').AsString;
    frmPCentranceEdit.nvedtIP.Enabled := False;
    frmPCentranceEdit.nvhcbbOrg.Enabled := False;
    nvlvEntrance.Active := True;
    nvlvEntrance.SetCheck(jsdcEntrancenames,'id');
    //frmPCentranceEdit.isedt :=True;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('ip', curip, []);
    end;
  end;
end;

procedure TPCticketentrance.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  jcdsResult.AfterScroll := nil;
   with jcdsResult do
   begin
   Active := False;
     Params.ParamByName('filter_EQL_p!orgid').Value := nvHcbbOrgNovaCbbOrg.HelpFieldValue['id'];
     Params.ParamByName('filter_LIKES_p!ip').Value := nvedtIp.Text;
   Active :=True;
   isactive :=  Active;
   end;
   refreshtEntrance;
    jcdsResult.AfterScroll := jcdsResultAfterScroll;
end;

procedure TPCticketentrance.tbtnInsertClick(Sender: TObject);
var
  curip: string;
begin
  inherited;
    with frmPCentranceEdit do
   begin
    frmPCentranceEdit := TfrmPCticketentrnceEdit.Create(self);
    frmPCentranceEdit.Caption := '添加检票控制信息';
    frmPCentranceEdit.ShowModal;
    if ModalResult = mrok then
    begin
      curip := Trim(nvedtIP.Text);
      tbtnFilterClick(Sender);
      jcdsResult.Locate('ip', curip, []);
    end;
  end;
end;

end.
