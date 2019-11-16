unit UFrmAddStationprice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, NovaEdit,
  NovaHelp, NovaCheckedComboBox, DB, DBClient, jsonClientDataSet,
  DBGridEhGrouping, GridsEh, DBGridEh, NvDbgridEh;

type
  TFrmAddStationprice = class(TSimpleEditForm)
    Label1: TLabel;
    NovaHStation: TNovaHelp;
    NovaEdtFullprice: TNovaEdit;
    NovaEdtHalfprice: TNovaEdit;
    NovaEdtStudentprice: TNovaEdit;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    NovaEdtTopprice: TNovaEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    NovaChOrgStation: TNovaCheckedComboBox;
    Label12: TLabel;
    jscdSaveStatioinprice: TjsonClientDataSet;
    jsonQryStationprice: TjsonClientDataSet;
    Label13: TLabel;
    NovaEdtMoreprice: TNovaEdit;
    Label14: TLabel;
    NovaEdtDistance: TNovaEdit;
    Label15: TLabel;
    procedure NovaEdtFullpriceChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure NovaHStationIdChange(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    departstationid, scheduleplanid: int64;
  end;

var
  FrmAddStationprice: TFrmAddStationprice;

implementation

uses Services, PubFn, UDMPublic;
{$R *.dfm}

procedure TFrmAddStationprice.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult,ids,log: string;
begin
  inherited;
  if NovaChOrgStation.GetSelectID = '' then
  begin
    SysDialogs.Warning('��ѡ�񷢳�վ��');
    NovaChOrgStation.SetFocus;
    exit;
  end;

  if (NovaHStation.Text = '') or (NovaHStation.Id = 0) then
  begin
    SysDialogs.Warning('������ͣ��վ����Ϣ��');
    NovaHStation.SetFocus;
    exit;
  end;
  ids:=copy(NovaChOrgStation.GetSelectID,2,length(NovaChOrgStation.GetSelectID)-2);
  try
    with jscdSaveStatioinprice do
    begin
      active := false;
      Params.ParamValues['scheduleplanid'] := scheduleplanid;
      Params.ParamValues['departstationids'] := ids;
      Params.ParamValues['reachstationid'] := NovaHStation.Id;
      Params.ParamValues['fullprice'] := NovaEdtFullprice.Text;
      Params.ParamValues['halfprice'] := NovaEdtHalfprice.Text;
      Params.ParamValues['studentprice'] := NovaEdtStudentprice.Text;
      Params.ParamValues['moreprice'] := NovaEdtMoreprice.Text;
      Params.ParamValues['distance'] := NovaEdtDistance.Text;
      Params.ParamValues['topprice'] := NovaEdtTopprice.Text;
      execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        NovaHStation.SetFocus;
      end
      else
      begin
        log := '�ۺϵ�������ͣ��վ�㣺����վ='+NovaChOrgStation.Text+',ͣ��վ��='+NovaHStation.Text
        +',ȫƱƱ��:'+NovaEdtFullprice.Text
        +',ѧ��ƱƱ��='+NovaEdtStudentprice.Text+',��ƱƱ��='+NovaEdtHalfprice.Text
        +',���޼�:'+NovaEdtTopprice.Text+',���='+NovaEdtDistance.Text;
        SysLog.WriteLog('���ȹ���->�ۺϵ���','����ͣ��վ��',log);
        ModalResult := mrok;
      end;
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('���ͣ��վ��Ʊ�۲���ʧ�ܣ�' + E.Message);
    end;
  end;
end;

procedure TFrmAddStationprice.FormShow(Sender: TObject);
begin
  inherited;
  with NovaChOrgStation do
  begin
    active := false;
    Params.ParamValues['orgids'] := Sysinfo.LoginUserInfo.OrgIDs;
    active := True;
    NovaChOrgStation.CheckById(True, departstationid);
  end;
  NovaHStation.SetFocus;
end;

procedure TFrmAddStationprice.NovaEdtFullpriceChange(Sender: TObject);
begin
  inherited;
 // if (NovaEdtHalfprice.Text = '') or (NovaEdtHalfprice.Text = '0') then
    NovaEdtHalfprice.Text := IntToStr(Trunc(strtofloat(NovaEdtFullprice.Text)/2));
  //if (NovaEdtStudentprice.Text = '') or (NovaEdtStudentprice.Text = '0') then
    NovaEdtStudentprice.Text := NovaEdtFullprice.Text;
  //if (NovaEdtTopprice.Text = '') or (NovaEdtTopprice.Text = '0') then
    NovaEdtTopprice.Text := FloatToStr(strtofloat(Trim(NovaEdtFullprice.Text))*2);
end;

procedure TFrmAddStationprice.NovaHStationIdChange(Sender: TObject);
begin
  inherited;
  with jsonQryStationprice do
  begin
    active := false;
    Params.ParamValues['departstationid'] := departstationid;
    Params.ParamValues['reachstationid'] := NovaHStation.Id;
    active := True;
    if recordcount > 0 then
    begin
      NovaEdtFullprice.Text := FieldByName('fullprice').AsString;
      NovaEdtHalfprice.Text := FieldByName('halfprice').AsString;
      NovaEdtStudentprice.Text := FieldByName('studentprice').AsString;
      NovaEdtTopprice.Text := FieldByName('toplimitprice').AsString;
      NovaEdtMoreprice.Text := FieldByName('moreprice').AsString;
      NovaEdtDistance.Text := FieldByName('distance').AsString;
    end;
  end;
end;

end.
