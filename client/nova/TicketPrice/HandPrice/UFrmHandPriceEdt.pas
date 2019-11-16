unit UFrmHandPriceEdt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit,
  DBGridEhGrouping, GridsEh, DBGridEh, NvDbgridEh, NovaHComboBox, DB, DBClient,
  jsonClientDataSet, NovaCheckedComboBox, ImgList;

type
  TFrmHandPriceEdt = class(TSimpleEditForm)
    GroupBox1: TGroupBox;
    Panel1: TPanel;
    Label1: TLabel;
    NovaEdtRoute: TNovaEdit;
    NovaEditSchedule: TNovaEdit;
    Label2: TLabel;
    Label3: TLabel;
    NvDbgridEh1: TNvDbgridEh;
    jcsdQryHandprice2: TjsonClientDataSet;
    dshandprice: TDataSource;
    jcsdQryHandprice2scheduleid: TLargeintField;
    jcsdQryHandprice2departstationid: TLargeintField;
    jcsdQryHandprice2reachstationid: TLargeintField;
    jcsdQryHandprice2seattype: TWideStringField;
    jcdsQrySeatTypes: TjsonClientDataSet;
    jcsdQryHandprice2fullprice: TFloatField;
    jcsdQryHandprice2halfprice: TFloatField;
    jcsdQryHandprice2studentprice: TFloatField;
    jcsdQryHandprice2toplimitprice: TFloatField;
    jcsdQryHandprice2lowerlimitprice: TFloatField;
    jcsdQryHandprice2vehicletypeid: TLargeintField;
    jcsdQryHandprice2id: TLargeintField;
    jcsdQryHandprice2createby: TLargeintField;
    jcsdQryHandprice2seattypename: TWideStringField;
    jcsdQryHandprice2vehiclebrandmodelid: TLargeintField;
    NovaCbbVehicletype: TNovaHComboBox;
    lbl1: TLabel;
    mmoSeats: TMemo;
    jcsdQrySeats: TjsonClientDataSet;
    wdstrngfldQryHandpricebrandname: TWideStringField;
    wdstrngfldQryHandpricedepartstation: TWideStringField;
    wdstrngfldQryHandpricereachstation: TWideStringField;
    wdstrngfldQryHandpricevehicletype: TWideStringField;
    Label4: TLabel;
    lblvehiclebrandmodelid: TLabel;
    NvHcbbVehiclebrandmodel: TNovaHComboBox;
    chkiscopyvehicletype: TCheckBox;
    jcsdQryHandprice2moreprice: TFloatField;
    jcsdQryHandprice2distance: TIntegerField;
    procedure FormShow(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure jcsdQryHandprice2fullpriceChange(Sender: TField);
    procedure jcsdQryHandprice2halfpriceChange(Sender: TField);
    procedure jcsdQryHandprice2studentpriceChange(Sender: TField);
    procedure NovaCbbVehicletypeChange(Sender: TObject);
    procedure jcsdQryHandprice2AfterScroll(DataSet: TDataSet);
    procedure NvHcbbVehiclebrandmodelChange(Sender: TObject);
  private
    { Private declarations }
    rate: double;
    procedure qrySeats(vehiclebrandmodelid: Int64; seattype: string);
  public
    { Public declarations }
    createby, vehicletypeid: Int64;
  end;

var
  FrmHandPriceEdt: TFrmHandPriceEdt;

implementation

uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmHandPriceEdt.bbtnSaveClick(Sender: TObject);
var
  nResult, flag, i: integer;
  sResult, result, log, temp,title: string;
begin
  inherited;
  try
    title := 'Ӳ��Ʊ�ۣ�Ӫ����·=' + NovaEdtRoute.Text + ',��κ�=' + NovaEditSchedule.Text +
      ',Ӫ�˳���=' + NovaCbbVehicletype.Text + ',Ʒ���ͺ�=' +
      NvHcbbVehiclebrandmodel.Text + ',��λ��=' + mmoSeats.Text;
    with jcsdQryHandprice2 do
    begin
      first;
      while (not eof) do
      begin
        if (FieldByName('fullprice').AsFloat > FieldByName('toplimitprice')
            .AsFloat) then
        begin
          SysDialogs.Warning('ȫƱƱ�۲��ܳ�������Ʊ�ۣ�');
          NvDbgridEh1.SetFocus;
          exit;
        end;
        if (FieldByName('halfprice').AsFloat > FieldByName('fullprice')
            .AsFloat) then
        begin
          SysDialogs.Warning('��ƱƱ�۲��ܳ���ȫƱƱ�ۣ�');
          NvDbgridEh1.SetFocus;
          exit;
        end;
        if (FieldByName('studentprice').AsFloat > FieldByName('toplimitprice')
            .AsFloat) then
        begin
          SysDialogs.Warning('ѧ��Ʊ�۲��ܳ���ȫƱƱ�ۣ�');
          NvDbgridEh1.SetFocus;
          exit;
        end;
        if (FieldByName('fullprice').AsFloat < FieldByName('lowerlimitprice')
            .AsFloat) then
        begin
          SysDialogs.Warning('ȫƱƱ�۲��ܵ�������Ʊ�ۣ�');
          NvDbgridEh1.SetFocus;
          exit;
        end;
        if (FieldByName('halfprice').AsFloat < FieldByName('lowerlimitprice')
            .AsFloat) then
        begin
          SysDialogs.Warning('��ƱƱ�۲��ܵ�������Ʊ�ۣ�');
          NvDbgridEh1.SetFocus;
          exit;
        end;
        if (FieldByName('studentprice').AsFloat < FieldByName('lowerlimitprice')
            .AsFloat) then
        begin
          SysDialogs.Warning('ѧ��Ʊ�۲��ܵ�������Ʊ�ۣ�');
          NvDbgridEh1.SetFocus;
          exit;
        end;
        if (FieldByName('distance').AsInteger = 0) then
        begin
          SysDialogs.Warning('ͣ��վ�����̲���Ϊ0��');
          NvDbgridEh1.SetFocus;
          exit;
        end;

        result := result + ',�ϳ�վ=' + FieldByName('departstation')
          .AsString + ',����վ=' + FieldByName('reachstation')
          .AsString + ',ȫ��=' + FieldByName('fullprice')
          .AsString + ',���=' + FieldByName('halfprice').AsString;
        log := log + result;
        next;
      end;

     // log := log + result;

      if chkiscopyvehicletype.Checked then
        Params.ParamValues['iscopyvehicletype'] := true
      else
        Params.ParamValues['iscopyvehicletype'] := False;
      nResult := jcsdQryHandprice2.ApplyUpdates(-1);
      sResult := jcsdQryHandprice2.Params.ParamValues['msg'];
      flag := jcsdQryHandprice2.Params.ParamValues['flag'];
      // log := '';
      if flag <= 0 then
      begin
        SysDialogs.ShowMessage(sResult);
        exit;
      end
      else
      begin

        if chkiscopyvehicletype.Checked then
          log := log + ',��Ʊ��ͬʱ���Ƶ�����·��������';

        while(length(log)>0) do
        begin
           temp:=copy(log,1,1000);
           temp:=title+temp;
           SysLog.WriteLog('Ʊ�۹�����>Ӳ��Ʊ��', 'Ӳ��Ʊ��', temp);
           log:=copy(log,1000,1000);
        end;

        SysDialogs.ShowMessage('����ɹ���');
        ModalResult := mrok;
      end;
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('����ƽʱƱ����Ϣʧ�ܣ�' + E.Message);
    end;
  end;

end;

procedure TFrmHandPriceEdt.FormShow(Sender: TObject);
begin
  inherited;
  jcdsQrySeatTypes.Active := False;
  jcdsQrySeatTypes.Active := true;
  with NovaCbbVehicletype do
  begin
    Active := False;
    Params.ParamValues['scheduleid'] := NovaEditSchedule.Id;
    Active := true;
  end;
  NovaCbbVehicletype.SetItemIndexByField('id', vehicletypeid);
  NovaCbbVehicletypeChange(Sender);
  try
    rate := strtofloat(getParametervalue('0017', Sysinfo.LoginUserInfo.OrgID));
  except
    on E: Exception do
      rate := 0.5;
  end;
end;

procedure TFrmHandPriceEdt.jcsdQryHandprice2AfterScroll(DataSet: TDataSet);
begin
  inherited;
  if NvHcbbVehiclebrandmodel.Text<>'' then
  begin
     qrySeats(jcsdQryHandprice2.FieldByName('vehiclebrandmodelid').AsInteger,
    jcsdQryHandprice2.FieldByName('seattype').AsString);
  end;
end;

procedure TFrmHandPriceEdt.jcsdQryHandprice2fullpriceChange(Sender: TField);
var
  price: double;
  toplimitprice, lowerlimitprice: double;
begin
  inherited;
  if Sender.Value = null then
  begin
    Sender.Value := 0;
  end;
  price := Sender.Value;
  toplimitprice := jcsdQryHandprice2.FieldByName('toplimitprice').AsFloat;
  lowerlimitprice := jcsdQryHandprice2.FieldByName('lowerlimitprice').AsFloat;
  jcsdQryHandprice2.FieldByName('halfprice').Value := round(price * rate);
  jcsdQryHandprice2.FieldByName('studentprice').Value := price;
  if (price > toplimitprice) then
  begin
    SysDialogs.Warning('ȫƱƱ�۲��ܳ�������Ʊ�ۣ�');
    // Sender.Value:=Sender.OldValue;
  end;
  if (price < lowerlimitprice) then
  begin
    SysDialogs.Warning('ȫƱƱ�۲��ܵ�������Ʊ�ۣ�');
    // Sender.Value:=Sender.OldValue;
  end;
end;

procedure TFrmHandPriceEdt.jcsdQryHandprice2halfpriceChange(Sender: TField);
var
  price, fullprice: double;
  lowerlimitprice: double;
begin
  inherited;
  if Sender.Value = null then
  begin
    Sender.Value := 0;
  end;
  price := Sender.Value;
  fullprice := jcsdQryHandprice2.FieldByName('fullprice').AsFloat;
  lowerlimitprice := jcsdQryHandprice2.FieldByName('lowerlimitprice').AsFloat;
  if (price > fullprice) then
  begin
    SysDialogs.Warning('��ƱƱ�۲��ܳ���ȫƱƱ�ۣ�');
    // Sender.Value:=Sender.OldValue;
  end;
  if (price < lowerlimitprice) then
  begin
    SysDialogs.Warning('��ƱƱ�۲��ܵ�������Ʊ�ۣ�');
    // Sender.Value:=Sender.OldValue;
  end;
end;

procedure TFrmHandPriceEdt.jcsdQryHandprice2studentpriceChange(Sender: TField);
var
  price, fullprice: double;
  lowerlimitprice: double;
begin
  inherited;
  if Sender.Value = null then
  begin
    Sender.Value := 0;
  end;
  price := Sender.Value;
  fullprice := jcsdQryHandprice2.FieldByName('toplimitprice').AsFloat;
  lowerlimitprice := jcsdQryHandprice2.FieldByName('lowerlimitprice').AsFloat;
  if (price > fullprice) then
  begin
    SysDialogs.Warning('ѧ��ƱƱ�۲��ܳ�������Ʊ�ۣ�');
    // Sender.Value:=Sender.OldValue;
  end;
  if (price < lowerlimitprice) then
  begin
    SysDialogs.Warning('ѧ��Ʊ�۲��ܵ�������Ʊ�ۣ�');
    // Sender.Value:=Sender.OldValue;
  end;

end;

procedure TFrmHandPriceEdt.NovaCbbVehicletypeChange(Sender: TObject);
var
  nResult: integer;
  sResult: string;
begin
  inherited;
  jcsdQryHandprice2.AfterScroll := nil;
  if NovaCbbVehicletype.ItemIndex >= 0 then
    with jcsdQryHandprice2 do
    begin
      Active := False;
      Params.ParamValues['handprice.scheduleid'] := NovaEditSchedule.Id;
      Params.ParamValues['handprice.vehicletypeid'] :=
        NovaCbbVehicletype.HelpFieldValue['id'];
      Params.ParamValues['handprice.createby'] := createby;
      Params.ParamValues['handprice.vehiclebrandmodelid'] := null;
      Active := true;
      nResult := Params.ParamValues['flag'];
      if nResult <> 1 then
      begin
        sResult := Params.ParamValues['msg'];
        SysDialogs.Warning(sResult);
        mmoSeats.Clear;
        exit;

      end
      else
      begin
        qrySeats(jcsdQryHandprice2.FieldByName('vehiclebrandmodelid')
            .AsInteger, jcsdQryHandprice2.FieldByName('seattype').AsString);
      end;
      NvHcbbVehiclebrandmodel.Active := False;
      NvHcbbVehiclebrandmodel.Params.ParamValues['filter_EQL_t!vehicletypeid']
        := NovaCbbVehicletype.HelpFieldValue['id'];
      NvHcbbVehiclebrandmodel.Active := true;
    end;
  jcsdQryHandprice2.AfterScroll := jcsdQryHandprice2AfterScroll;
end;

procedure TFrmHandPriceEdt.NvHcbbVehiclebrandmodelChange(Sender: TObject);
var
  nResult: integer;
  sResult: string;
begin
  if NvHcbbVehiclebrandmodel.ItemIndex >= 0 then
  begin
    with jcsdQryHandprice2 do
    begin
      Active := False;
      Params.ParamValues['handprice.scheduleid'] := NovaEditSchedule.Id;
      Params.ParamValues['handprice.vehicletypeid'] :=
        NovaCbbVehicletype.HelpFieldValue['id'];
      Params.ParamValues['handprice.createby'] := createby;
      Params.ParamValues['handprice.vehiclebrandmodelid'] :=
        NvHcbbVehiclebrandmodel.HelpFieldValue['id'];
      Active := true;
      nResult := Params.ParamValues['flag'];
      if nResult <> 1 then
      begin
        // sResult:=Params.ParamValues['msg'];
        // SysDialogs.Warning(sResult);
        // mmoSeats.Clear;
        // exit;
      end
      else
      begin
        qrySeats(jcsdQryHandprice2.FieldByName('vehiclebrandmodelid')
            .AsInteger, jcsdQryHandprice2.FieldByName('seattype').AsString);
      end;
    end;
  end;
end;

procedure TFrmHandPriceEdt.qrySeats(vehiclebrandmodelid: Int64;
  seattype: string);
begin
  with jcsdQrySeats do
  begin
    Active := False;
    Params.ParamValues['vehiclebrandmodelid'] := vehiclebrandmodelid;
    Params.ParamValues['seattype'] := seattype;
    Execute;
    mmoSeats.Text := Params.ParamValues['seatnos'];
  end;
end;

end.
