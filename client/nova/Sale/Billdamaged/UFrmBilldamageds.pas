unit UFrmBilldamageds;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  PrnDbgeh,Services, ImgList, GridsEh, DBGridEh, ComCtrls, ToolWin, ExtCtrls, StdCtrls,
  NovaComboBox, NovaEdit, NvPrnDbgeh, NvDbgridEh, UFrmBilldamagedEdit, NovaHelp,
  NovaHComboBox;

type
  TFrmBilldamageds =class(TSimpleCRUDForm)
    jcdsResultid: TLargeintField;
    jcdsResultisactive: TBooleanField;
    jcdsResultparvalue: TFloatField;
    jcdsResultcreatetime: TDateTimeField;
    GroupBox2: TGroupBox;
    NvDbgridEh1: TNvDbgridEh;
    jcdsResult1: TjsonClientDataSet;
    DataSource: TDataSource;
    lbllbcode: TLabel;
    jcdsResultmeiumname: TjsonClientDataSet;
    wdstrngfldResultmediumname: TWideStringField;
    cbbbilltype: TNovaHComboBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure jcdsResultAfterOpen(DataSet: TDataSet);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
     isdemageothers:boolean;
  public
    { Public declarations }
  end;

var
  FrmBilldamageds: TFrmBilldamageds;

implementation
 uses PubFn;
{$R *.dfm}



procedure TFrmBilldamageds.FormCreate(Sender: TObject);
begin
  inherited;
  cbbbilltype.Active := false;
  cbbbilltype.Active := True;
  isdemageothers:= getParametervalue('0019',SysInfo.LoginUserInfo.OrgID)='1';
end;

procedure TFrmBilldamageds.jcdsResultAfterOpen(DataSet: TDataSet);
begin
  inherited;
  if jcdsResult.RecordCount<1 then
  begin
    jcdsResult1.Close;
  end;
end;

procedure TFrmBilldamageds.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if (not jcdsResult.Active) then
      exit;
  if jcdsResult.RecordCount<1 then
      exit;
  with jcdsResult1 do
  begin

    Active:=false;
      Params.ParamValues['filter_EQL_b!billtypeid'] :=jcdsResult.FieldByName('id').AsString;
      if not isdemageothers then
      begin
        Params.ParamValues['filter_EQL_b!recipients'] := SysInfo.LoginUserInfo.UserID;
      end;
      Params.ParamValues['filter_INS_b!status'] := '(0,1)';
    Active:=true;

  end;
end;

procedure TFrmBilldamageds.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
      jcdsResult.AfterScroll:=nil;
    Active := false;
      Params.ParamValues['filter_EQL_b!id'] := cbbbilltype.HelpFieldValue['id'];
  //Params.ParamValues['filter_EQL_b!createby'] := SysInfo.LoginUserInfo.UserID;
    Active := true;
   jcdsResult.AfterScroll:=jcdsResultAfterScroll;
   jcdsResultAfterScroll(nil);
  end;

end;



procedure TFrmBilldamageds.tbtnInsertClick(Sender: TObject);
var damagedid : LongWord;
    startno : string;
begin
  inherited;
  if not DataSource.DataSet.Active then
    exit;
  if DataSource.DataSet.RecordCount < 1 then
    exit;
  if (not isdemageothers) and (SysInfo.LoginUserInfo.UserID <> jcdsResult1.FieldByName('recipients').Value) then
  begin
    SysDialogs.ShowMessage('该段票据类型不是你领用的记录，不能进行登记！');
    Exit;
  end;
  with FrmBilldamagedEdit do
  begin
    FrmBilldamagedEdit := TFrmBilldamagedEdit.Create(Self);
    Caption := '坏票登记';
    sign := true;
    damagedid := jcdsResult.FieldByName('id').AsInteger;
    edtbilltype.Text := jcdsResult1.FieldByName('billtypename').AsString;
    startno := jcdsResult1.FieldByName('nextno').AsString;
    while jcdsResult.FieldByName('ticketnolength').AsInteger - Length(startno) > 0 do
    begin
      startno := '0' + startno;
    end;
    edtstartno.Text := startno;
    edtendno.OnChange:=nil;
    edtendno.Text := startno;
    edtendno.OnChange:=edtendnoChange;
    billinuseid := jcdsResult1.FieldByName('id').AsInteger;
    billtypeid := jcdsResult1.FieldByName('billtypeid').AsInteger;
    insureendno := jcdsResult1.FieldByName('endno').AsInteger;
    recipients := jcdsResult1.FieldByName('recipients').AsString;
    edtavailablecount.Text := jcdsResult1.FieldByName('availablecount').AsString;
    edtstartno.Enabled := False;
    ShowModal;
    if ModalResult = mrOk then
    begin
      tbtnFilterClick(Self);
      jcdsResult.Locate('id', damagedid, []);
    end;
  end;
end;

end.
     