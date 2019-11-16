unit UFrmAdjustHandPrice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls,
  DBGridEhGrouping, NovaCheckedComboBox, NovaEdit, NovaHelp, GridsEh, DBGridEh,
  NvDbgridEh, DB, DBClient, jsonClientDataSet;

type
  TFrmAdjustHandPrice = class(TSimpleEditForm)
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    chkCheckAll: TCheckBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    NovaHStation: TNovaHelp;
    NovaEdtFullprice: TNovaEdit;
    NovaEdtHalfprice: TNovaEdit;
    NovaEdtStudentprice: TNovaEdit;
    NovaEdtTopprice: TNovaEdit;
    NovaChOrgStation: TNovaCheckedComboBox;
    NovaEdtMoreprice: TNovaEdit;
    jcsdQrySchedule: TjsonClientDataSet;
    ds1: TDataSource;
    Label16: TLabel;
    Label17: TLabel;
    jscdsaveStationPrice: TjsonClientDataSet;
    CobType: TComboBox;
    Label19: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure chkCheckAllClick(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure NovaHStationIdChange(Sender: TObject);
    procedure CobTypeChange(Sender: TObject);
    procedure NovaEdtFullpriceChange(Sender: TObject);
  private
    { Private declarations }
    function getIds(jscdQryDate: TjsonClientDataSet): String;
  public
    { Public declarations }
    //routeid, schId: int64;
    code,station,full,half,student,more,topprice,cotype,recher:string;
  end;

var
  FrmAdjustHandPrice: TFrmAdjustHandPrice;

implementation

uses PubFn, Services, UDMPublic;
{$R *.dfm}

function TFrmAdjustHandPrice.getIds(jscdQryDate: TjsonClientDataSet): String;
var
  ids: string;
begin
  ids := '';
  with jscdQryDate do
  begin
    First;
    while not Eof do
    begin
      if (FieldByName('isselect').AsBoolean) then
      begin
        ids := ids + ',' + FieldByName('id').AsString;
        code := code+','+ FieldByName('code').AsString;
      end;
      next;
    end;
  end;
  if Length(ids) > 0 then
  begin
    ids := Copy(ids, 2, Length(ids));
    result := ids;
  end
  else
    result := '';
end;

procedure TFrmAdjustHandPrice.NovaEdtFullpriceChange(Sender: TObject);
begin
  inherited;
  if CobType.ItemIndex<>0 then
  begin
      NovaEdtHalfprice.Text:=NovaEdtFullprice.Text;
      NovaEdtStudentprice.Text:=NovaEdtFullprice.Text;
      NovaEdtTopprice.Text:=NovaEdtFullprice.Text;
  end;
end;

procedure TFrmAdjustHandPrice.NovaHStationIdChange(Sender: TObject);
begin
  inherited;
  if NovaChOrgStation.GetSelectID = '' then
  begin
    SysDialogs.ShowMessage('��ѡ�񷢳�վ��');
    NovaChOrgStation.SetFocus;
    exit;
  end;
  with jcsdQrySchedule do
  begin
    Active := false;
    Params.ParamValues['departstationids'] := NovaChOrgStation.GetSelectID;
    Params.ParamValues['reachstationid'] := NovaHStation.Id;
    Active := true;
    if recordcount>0 then
    begin
      NovaEdtFullprice.Text:=fieldbyname('fullprice').AsString;
      NovaEdtHalfprice.Text:=fieldbyname('halfprice').AsString;
      NovaEdtStudentprice.Text:=fieldbyname('studentprice').AsString;
      NovaEdtTopprice.Text:=fieldbyname('toplimitprice').AsString;
      NovaEdtMoreprice.Text:=fieldbyname('moreprice').AsString;
    end;
  end;
end;

procedure TFrmAdjustHandPrice.bbtnSaveClick(Sender: TObject);
var
  departids, scheduleids, sResult,log: string;
  nResult: integer;
begin
  inherited;

  departids := NovaChOrgStation.GetSelectID;
  if departids = '' then
  begin
    SysDialogs.ShowMessage('��ѡ�񷢳�վ��');
    exit;
  end;
  departids:=Copy(departids,2, Length(departids)-2) ;
  if (NovaHStation.Text = '') or (NovaHStation.Id = 0) then
  begin
    SysDialogs.ShowMessage('��ѡ�񵽴�վ��');
    exit;
  end;
  scheduleids := getIds(jcsdQrySchedule);
  if scheduleids = '' then
  begin
    SysDialogs.ShowMessage('��ѡ���Σ�');
    exit;
  end;
  scheduleids:='('+scheduleids+')';
  if  strtofloat(NovaEdtTopprice.Text)<strtofloat(NovaEdtFullprice.Text) then
  begin
    NovaEdtFullprice.SetFocus;
    SysDialogs.ShowMessage('ȫƱƱ�۲��ܳ�������Ʊ�ۣ�');
    exit;
  end;
  if CobType.ItemIndex=2 then
  begin
    if (strtofloat(NovaEdtFullprice.Text)<=0) or (strtofloat(NovaEdtFullprice.Text)>=1)
    or (strtofloat(NovaEdtHalfprice.Text)<=0) or (strtofloat(NovaEdtHalfprice.Text)>=1)
    or (strtofloat(NovaEdtStudentprice.Text)<=0) or (strtofloat(NovaEdtStudentprice.Text)>=1)
    or (strtofloat(NovaEdtTopprice.Text)<=0) or (strtofloat(NovaEdtTopprice.Text)>=1) then
    begin
      NovaEdtFullprice.SetFocus;
      SysDialogs.ShowMessage('Ʊ�۸������ܳ���100%����С��0��');
      exit;
    end;
  end;
  try
    with jscdsaveStationPrice do
    begin
      Active := false;
      Params.ParamValues['adjusttype'] := CobType.ItemIndex;
      Params.ParamValues['departstationids'] := departids;
      Params.ParamValues['scheduleids'] := scheduleids;
      Params.ParamValues['handprice.reachstationid'] := NovaHStation.Id;
      Params.ParamValues['handprice.updateby'] := sysinfo.LoginUserInfo.UserID;
      Params.ParamValues['handprice.fullprice'] := NovaEdtFullprice.Text;
      Params.ParamValues['handprice.halfprice'] := NovaEdtHalfprice.Text;
      Params.ParamValues['handprice.studentprice'] := NovaEdtStudentprice.Text;
      Params.ParamValues['handprice.moreprice'] := NovaEdtMoreprice.Text;
      Params.ParamValues['handprice.toplimitprice'] := NovaEdtTopprice.Text;
      Execute;
      nResult := Params.ParamValues['flag'];
      sResult := Params.ParamValues['msg'];
      if nResult = 1 then
      begin
        SysDialogs.ShowMessage(sResult);

        log := '��������:'+CobType.Text +',';
        if station <> NovaChOrgStation.Text then
            log := log +'ʼ��վ �� '+station +' �ĳ� '+NovaChOrgStation.Text+',';
        if recher <> NovaHStation.Text then
            log := log + '����վ �� '+recher +' �ĳ� '+NovaHStation.Text+',';
        if full <> NovaEdtFullprice.Text then
            log := log + 'ȫƱ�� �� '+full +' �ĳ� '+NovaEdtFullprice.Text+',';
        if half <> NovaEdtHalfprice.Text then
            log := log + '��Ʊ�� �� '+half +' �ĳ� '+NovaEdtHalfprice.Text+',';
        if student <> NovaEdtStudentprice.Text then
            log := log + 'ѧ���� �� '+student +' �ĳ� '+NovaEdtStudentprice.Text+',';
        if more <> NovaEdtMoreprice.Text then
            log := log + '�۲� �� '+more +' �ĳ� '+NovaEdtMoreprice.Text+',';
	if topprice <> Trim(NovaEdtTopprice.Text) then
            log := log +'���޼� �� '+topprice+' �ĳ� '+NovaEdtTopprice.Text+',';

        log := log +'��κ�:'+ code;
        SysLog.WriteLog('Ʊ�۹���->Ӳ��Ʊ�۹���','�޸�վ��Ʊ��',log);

        ModalResult := mrok;
      end
      else
      begin
        SysDialogs.Warning(sResult);
      end;
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('����վ��Ʊ����Ϣʧ�ܣ�' + E.Message);
    end;
  end;
end;

procedure TFrmAdjustHandPrice.chkCheckAllClick(Sender: TObject);
begin
  inherited;
  if chkCheckAll.Checked then
  begin
    if (jcsdQrySchedule.Active) and (jcsdQrySchedule.RecordCount > 0) then
    begin
      with jcsdQrySchedule do
      begin
        First;
        while not Eof do
        begin
          Edit;
          FieldValues['isselect'] := true;
          next;
        end;
      end;
    end;
  end
  else
  begin
    if (jcsdQrySchedule.Active) and (jcsdQrySchedule.RecordCount > 0) then
    begin
      with jcsdQrySchedule do
      begin
        First;
        while not Eof do
        begin
          Edit;
          FieldValues['isselect'] := false;
          next;
        end;
      end;
    end;
  end;
end;

procedure TFrmAdjustHandPrice.CobTypeChange(Sender: TObject);
begin
  inherited;
  if CobType.ItemIndex=0 then
  begin
    with jcsdQrySchedule do
    if active  and  (recordcount>0) then
    begin
      NovaEdtFullprice.Text:=fieldbyname('fullprice').AsString;
      NovaEdtHalfprice.Text:=fieldbyname('halfprice').AsString;
      NovaEdtStudentprice.Text:=fieldbyname('studentprice').AsString;
      NovaEdtTopprice.Text:=fieldbyname('toplimitprice').AsString;
      NovaEdtMoreprice.Text:=fieldbyname('moreprice').AsString;
    end;
  end
  else
  begin
      NovaEdtFullprice.Text:='0';
      NovaEdtHalfprice.Text:='0';
      NovaEdtStudentprice.Text:='0';
      NovaEdtTopprice.Text:='0';
      NovaEdtMoreprice.Text:='0';
  end;

end;

procedure TFrmAdjustHandPrice.FormCreate(Sender: TObject);
begin
  inherited;
  with NovaChOrgStation do
  begin
    Active := false;
    Params.ParamValues['orgids'] := sysinfo.LoginUserInfo.OrgIDs;
    Active := true;
    NovaChOrgStation.CheckById(true, sysinfo.LoginUserInfo.StationID);
  end;
end;

end.
