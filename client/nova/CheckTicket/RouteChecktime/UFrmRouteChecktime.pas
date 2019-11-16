unit UFrmRouteChecktime;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp, NovaCheckedComboBox;

type
  TFrmRouteChecktime = class(TSimpleCRUDForm)
    Label1: TLabel;
    Label2: TLabel;
    jcdsResultupdatetime: TDateTimeField;
    jcdsResultcreatetime: TDateTimeField;
    jcdsResultcreateby: TLargeintField;
    jcdsResultupdateby: TLargeintField;
    jcdsResultid: TLargeintField;
    jcdsResultrouteid: TLargeintField;
    jcdsResultorgname: TWideStringField;
    jcdsResultroutename: TWideStringField;
    jcdsResultcreatename: TWideStringField;
    jcdsResultupdatename: TWideStringField;
    jcdsResultorgid: TLargeintField;
    jcdsResultstarttime: TShortintField;
    NovaCkbOrg: TNovaCheckedComboBox;
    NovaHelpRoute: TNovaHelp;
    jcdsRouteChecktimeDelete: TjsonClientDataSet;
    procedure FormShow(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmRouteChecktime: TFrmRouteChecktime;

implementation

uses   UFrmRouteChecktimeEdit, UFrmInfo, UDMPublic, Services, PubFn;
{$R *.dfm}


procedure TFrmRouteChecktime.tbtnDeleteClick(Sender: TObject);
var
  sResult, log: string;
  nResult: Integer;
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount <= 0 then
    exit;
  if SysDialogs.Confirm('提示','确定要删除该机构线路检票时间吗？') then
    with jcdsRouteChecktimeDelete do
    begin
      Active := false;
      log := '检票时间信息: 机构=' +  jcdsResult.FieldByName('orgname').AsString + ',运营线路='
             + jcdsResult.FieldByName('routename').AsString + ',检票时间='
             + jcdsResult.FieldByName('starttime').AsString + ',创建人='
             + jcdsResult.FieldByName('createname').AsString + ',创建时间='
             + jcdsResult.FieldByName('createtime').AsString + ',修改人='
             + jcdsResult.FieldByName('updatename').AsString + ',修改时间='
             + jcdsResult.FieldByName('updatetime').AsString;
      Params.ParamValues['routechecktime.id'] := jcdsResult.FieldByName('id').AsLargeInt;
      execute;
      sResult := Params.ParamByName('msg').Value;
      nResult := Params.ParamByName('flag').Value;
      if (nResult = 1) then
      begin
        SysLog.WriteLog('删除检票时间信息', '删除', log);
        SysDialogs.ShowMessage(sResult);
        tbtnFilterClick(Sender);
      end
      else
      begin
        SysDialogs.Warning(sResult);
      end;
    end;

end;

procedure TFrmRouteChecktime.tbtnEditClick(Sender: TObject);
begin
  inherited;
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount <= 0 then
    exit;
  FrmRouteChecktimeEdit := TFrmRouteChecktimeEdit.Create(self);
  with FrmRouteChecktimeEdit do
  begin
    Caption := '修改检票时间信息';
    id := jcdsResult.FieldByName('id').AsLargeInt;
    NovaCbbOrg.Enabled := False;
    NovaCbbOrg.SetItemIndexByField('id', jcdsResult.FieldByName('orgid').AsLargeInt);
    NHelpRoute.Id := jcdsResult.FieldByName('routeid').AsLargeInt;
    NHelpRoute.Text := jcdsResult.FieldByName('routename').AsString;
    NHelpRoute.ReadOnly := True;
    NEditRouteChecktime.Text := jcdsResult.FieldByName('starttime').AsString;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id',id,[] );
      FreeAndNil(FrmRouteChecktimeEdit);
    end;
  end;
end;


procedure TFrmRouteChecktime.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
       Active := False;
       Params.ParamByName('filter_INS_o!id').Value := NovaCkbOrg.GetSelectID;
       if NovaHelpRoute.Id >0 then
       begin
           Params.ParamByName('filter_EQL_r!id').Value := NovaHelpRoute.Id;
       end else
       begin
           Params.ParamByName('filter_EQL_r!id').Value := null;
       end;
       Active := True;
  end;
end;



procedure TFrmRouteChecktime.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  FrmRouteChecktimeEdit := TFrmRouteChecktimeEdit.Create(self);
  with FrmRouteChecktimeEdit do
  begin
    Caption := '添加检票时间信息';
    NovaCbbOrg.SetItemIndexByField('id', sysinfo.LoginUserInfo.OrgID);
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id', id, []);
      FreeAndNil(FrmRouteChecktimeEdit);
    end;
  end;
end;

procedure TFrmRouteChecktime.FormShow(Sender: TObject);
begin
  inherited;
  NovaCkbOrg.Active := False;
  NovaCkbOrg.Active := True;
  NovaCkbOrg.CheckById(true, sysinfo.LoginUserInfo.OrgID);

end;

end.
