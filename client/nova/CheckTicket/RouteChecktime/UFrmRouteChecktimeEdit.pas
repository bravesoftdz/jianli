unit UFrmRouteChecktimeEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaComboBox, NovaHComboBox, USimpleEditForm, NovaEdit,
  NovaHelp, Buttons;

type
  TFrmRouteChecktimeEdit = class(TSimpleEditForm)
    lbl3: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    NHelpRoute: TNovaHelp;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    jsonCDSSaveRouteChecktime: TjsonClientDataSet;
    NEditRouteChecktime: TNovaEdit;
    NovaCbbOrg: TNovaHComboBox;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);

  private
    { Private declarations }

    function checkSchedule(var msg: String): boolean;

  public
    { Public declarations }

    id: Int64;

  end;

var
  FrmRouteChecktimeEdit: TFrmRouteChecktimeEdit;

implementation
uses Services, PubFn;
{$R *.dfm}


procedure TFrmRouteChecktimeEdit.bbtnSaveClick(Sender: TObject);
var
  msg, result, sResult, log: string;
  nResult: Integer;
begin
  inherited;

  if (not checkSchedule(msg)) then
  begin
    SysDialogs.ShowMessage(msg);
    exit;
  end;

  with jsonCDSSaveRouteChecktime do
  begin
    Params.ParamByName('routechecktime.id').Value := id;
    Params.ParamByName('routechecktime.orgid').Value := NovaCbbOrg.HelpFieldValue['id'];
    Params.ParamByName('routechecktime.routeid').Value := NHelpRoute.Id;
    Params.ParamByName('routechecktime.starttime').Value := NEditRouteChecktime.Text;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if nResult < 0 then
      begin
        NHelpRoute.SetFocus;
      end else
      begin
        if id > 0 then
          result := '修改'
        else
          result := '添加';
        log := '检票时间信息: 机构=' + NovaCbbOrg.Text + ',运营线路=' + NHelpRoute.Text
               + ',检票时间=' + NEditRouteChecktime.Text;
        SysLog.WriteLog('检票管理->检票时间设置', result, log);
        id := Params.ParamByName('routechecktimeid').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('检票时间增加失败：' + E.Message);
      end;
    end;
  end;

end;

function TFrmRouteChecktimeEdit.checkSchedule(var msg: String): boolean;
begin

  result := False;

  if NovaCbbOrg.ItemIndex < 0 then
  begin
    msg := '请选择所属机构！';
    NovaCbbOrg.SetFocus;
    exit;
  end;

  if ((NHelpRoute.Text = '') or (NHelpRoute.id <= 0)) then
  begin
    msg := '运营线路不能为空！';
    NHelpRoute.SetFocus;
    exit;
  end;

  if NEditRouteChecktime.Text = '' then
  begin
    msg := '检票时间不能为空！';
    NEditRouteChecktime.SetFocus;
    exit;
  end;

  result := True;
end;

procedure TFrmRouteChecktimeEdit.FormCreate(Sender: TObject);
begin
  inherited;
    NovaCbbOrg.Active := False;
    NovaCbbOrg.Active := True;
end;

end.
