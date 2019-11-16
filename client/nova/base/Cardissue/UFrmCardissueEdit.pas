unit UFrmCardissueEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, ComCtrls, DB,
  DBClient, jsonClientDataSet, NovaComboBox, NovaHComboBox, NovaHelp, ImgList,
  UICcardRW;

type
  TFrmCardissueEdit = class(TSimpleEditForm, IBaseCardfound, Ivipcardfound)
    lbl3: TLabel;
    lbl7: TLabel;
    jcdsResultSaveCardissue: TjsonClientDataSet;
    lbl4: TLabel;
    cbbtype: TNovaComboBox;
    nvhlpVtypename: TNovaHelp;
    lbl1: TLabel;
    edtserialnumber: TNovaEdit;
    lbl2: TLabel;
    jcdsResult1: TjsonClientDataSet;
    dsResult: TDataSource;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    lbl14: TLabel;
    wdstrngfldResult1serialnumber: TWideStringField;
    dtpvaliddate: TDateTimePicker;
    nvhlpcardno: TNovaHelp;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl11: TLabel;
    lbl15: TLabel;
    lbl16: TLabel;
    cbbissuereason: TNovaComboBox;
    lbl10: TLabel;
    lbl17: TLabel;
    lbl18: TLabel;
    nvhlpticketno: TNovaEdit;
    cbbvipgradefirst: TNovaComboBox;
    edtcardcost: TNovaEdit;
    mmoremark: TMemo;
    nvhlpCustomer: TNovaHelp;
    nvhlpDervier: TNovaHelp;
    nvhlpStawer: TNovaHelp;
    nvhlpEmploye: TNovaHelp;
    nvhlpUnit: TNovaHelp;
    procedure bbtnSaveClick(Sender: TObject);
    procedure cbbtypeChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure nvhlpVtypenameEnter(Sender: TObject);
    procedure nvhlpcardnoEnter(Sender: TObject);
    procedure nvhlpcardnoIdChange(Sender: TObject);
    procedure cbbissuereasonChange(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    procedure visableVipInfo(boolean : Boolean);
    procedure iccardfound(icCard:TBaseCard);
    procedure vipcardfound(vipCard:TVipCard);
  public
    { Public declarations }
    id, functiontype :Int64;
    sign,isrecard : Boolean;
    createby, ticketoutletsid, issueby, issueorgid,
    ctype, issueip, billtypeid, status : string;
    createtime, issuetime : TDateTime;
    typeid,initcardid : Integer;
    baseCard : TBaseCard;
    vipBaseCard : TVipCard;
    isrepair:Boolean;//�Ƿ񲹿�
    viplastmoney,viplastamont:Currency;
  end;

var
  FrmCardissueEdit: TFrmCardissueEdit;

implementation

uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmCardissueEdit.bbtnSaveClick(Sender: TObject);
var nResult, writecard : Integer;
    sResult, log : string;
    _vipBaseCard : TVipCard;
begin
  inherited;
   if Trim(nvhlpcardno.Text) = '' then
    begin
      SysDialogs.ShowMessage('��ˢ����');
      Exit;
    end;
    if Trim(cbbtype.Text) = '' then
    begin
       SysDialogs.ShowMessage('��ѡ�񷢿�����');
      Exit;
    end;

  if functiontype <> 2 then
  begin
    if cbbtype.ItemIndex <> Integer(baseCard.cardtype) then
    begin
      SysDialogs.ShowMessage('����������������ˢ�Ŀ����Ͳ�һ�£�������ѡ��');
      cbbtype.SetFocus;
      Exit;
    end;
  end;
  //����ǹ�ʧ����������ֻ����Թ����
  if isrecard and ( cbbtype.ItemIndex <> 3 ) then
  begin
    SysDialogs.ShowMessage('�ÿ����ǹ���������ܽ��й�ʧ����');
    Exit;
  end;

  if cbbtype.ItemIndex = 0 then
  begin
    if nvhlpVtypename.Id = 0  then
    begin
      SysDialogs.ShowMessage('���ڶ��������У�������Ч���ƣ�');
      nvhlpVtypename.SetFocus;
      Exit;
    end
    else
    typeid := nvhlpVtypename.Id;
  end
  else if cbbtype.ItemIndex =1 then
  begin
    if nvhlpDervier.Id = 0  then
    begin
      SysDialogs.ShowMessage('���ڶ��������У�������Ч��ʻԱ���ƣ�');
      nvhlpVtypename.SetFocus;
      Exit;
    end
    else
    typeid := nvhlpDervier.Id;
  end
  else if cbbtype.ItemIndex = 2 then
  begin
    if nvhlpStawer.Id = 0  then
    begin
      SysDialogs.ShowMessage('���ڶ��������У�������Ч����Ա���ƣ�');
      nvhlpStawer.SetFocus;
      Exit;
    end
    else
    typeid := nvhlpStawer.Id;
  end
  else if cbbtype.ItemIndex = 3 then
  begin
    if nvhlpCustomer.Id = 0  then
    begin
      SysDialogs.ShowMessage('���ڶ��������У�������Ч�˿����ƻ�֤���ţ�');
      nvhlpCustomer.SetFocus;
      Exit;
    end
    else
    typeid := nvhlpCustomer.Id;
  end
  else if cbbtype.ItemIndex = 4 then
  begin
    if nvhlpEmploye.Id = 0  then
    begin
      SysDialogs.ShowMessage('���ڶ��������У�������ЧԱ�����ƣ�');
      nvhlpEmploye.SetFocus;
      Exit;
    end
    else
    typeid := nvhlpEmploye.Id;
  end
  else if cbbtype.ItemIndex = 5 then
  begin
    if nvhlpUnit.Id = 0  then
    begin
      SysDialogs.ShowMessage('���ڶ��������У�������Ч�������ƣ�');
      nvhlpUnit.SetFocus;
      Exit;
    end
    else
    typeid := nvhlpUnit.Id;
  end  ;

  if cbbtype.ItemIndex = 3 then
  begin
    if Trim(cbbissuereason.Text) = '' then
    begin
      SysDialogs.ShowMessage('��ѡ�񷢿�ԭ��!');
      Exit;
    end;
    if Trim(cbbvipgradefirst.Text) = '' then
    begin
      SysDialogs.ShowMessage('��ѡ�񿪿��ȼ�!');
      Exit;
    end;
    if Trim(edtcardcost.Text) = '' then
    begin
      SysDialogs.ShowMessage('�����뿨�ɱ��ѽ��!');
      Exit;
    end;
  end;
  with jcdsResultSaveCardissue do
  begin
    Close;
    if cbbtype.ItemIndex >= 0 then
    begin
      ctype := TCommInfo(cbbtype.Items.Objects[cbbtype.ItemIndex]).Value;
    end;
//    if nvhlptypename.Id > 0 then
//    begin
//      typeid := IntToStr(nvhlptypename.Id);
//    end else
//    begin
//      SysDialogs.ShowMessage('�������Ʋ���Ϊ�գ�');
//      nvhlptypename.SetFocus;
//      Exit;
//    end;
    Params.ParamByName('cardissue.id').Value := id;
    Params.ParamByName('cardissue.ticketoutletsid').Value := ticketoutletsid;
    Params.ParamByName('cardissue.createby').Value := createby;
    Params.ParamByName('cardissue.createtime').Value := DateTimeToStr(createtime);
    Params.ParamByName('cardissue.type').Value := ctype;

    Params.ParamByName('cardissue.issueby').Value := issueby;
    Params.ParamByName('cardissue.issueorgid').Value := issueorgid;
    Params.ParamByName('cardissue.issueip').Value := issueip;
    Params.ParamByName('cardissue.billtypeid').Value := billtypeid;
    Params.ParamByName('cardissue.issuetime').Value := DateTimeToStr(issuetime);
    Params.ParamByName('cardissue.status').Value := status;
    Params.ParamByName('cardissue.cardno').Value := nvhlpcardno.Text;
    Params.ParamByName('cardissue.validdate').Value := formatdatetime('yyyy-mm-dd', dtpvaliddate.DateTime);
    Params.ParamByName('cardissue.serialnumber').Value := edtserialnumber.Text;

    if cbbtype.ItemIndex = 3 then
    begin
      Params.ParamByName('cardissue.typeid').Value := '';
      params.ParamValues['vip.issuereason'] := TCommInfo(cbbissuereason.Items.Objects[cbbissuereason.ItemIndex]).Value;
      Params.ParamValues['vip.vipgradefirst'] := TCommInfo(cbbvipgradefirst.Items.Objects[cbbvipgradefirst.ItemIndex]).Value;
      Params.ParamValues['vip.cardcost'] := edtcardcost.Text;
      Params.ParamValues['vip.remarks'] := mmoremark.Text;
      Params.ParamValues['vip.ticketno'] := nvhlpticketno.Text;
      Params.ParamValues['vip.customerid'] := typeid;
    end else
    begin
      params.ParamValues['vip.issuereason'] := '';
      Params.ParamValues['vip.vipgradefirst'] := '';
      Params.ParamValues['vip.cardcost'] := '';
      Params.ParamValues['vip.remarks'] := '';
      Params.ParamValues['vip.ticketno'] := '';
      Params.ParamValues['vip.customerid'] := '';
      Params.ParamByName('cardissue.typeid').Value := typeid;
    end;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      log := '�������У�';
      if (nResult <= 0) then
      begin
        dtpvaliddate.SetFocus;
      end
      else
      begin

        if cbbtype.ItemIndex = 3 then
        begin
          _vipBaseCard := vipBaseCard;
          if cbbvipgradefirst.ItemIndex = 0 then
          begin
             _vipBaseCard.setNewcardGrade(TCardGrade.ONECARD);
          end else if cbbvipgradefirst.ItemIndex = 1 then
          begin
            _vipBaseCard.setNewcardGrade(TCardGrade.GENERAL);
          end else
          begin
            _vipBaseCard.setNewcardGrade(TCardGrade.GOLD);
          end;
          //��ԭ�������ͻ���ת�Ƶ��¿���:
          if isrepair then
          begin
            _vipBaseCard.incrementmoney(viplastmoney);
            _vipBaseCard.incrementamount(viplastamont);
          end;
           writecard := _vipBaseCard.writeCard;
          while writecard <> 0 do
          begin
            SysDialogs.Warning(_vipBaseCard.getErrorInfo(writecard)+'����źÿ�����ȷ������д����');
            writecard:=_vipBaseCard.writeCard;
          end;
          log := log + ',���ȼ���'+cbbvipgradefirst.Text+',�������ѣ�'+edtcardcost.Text+
          ',����ԭ��:'+cbbissuereason.Text+',������Ϣ'+nvhlpticketno.Text;
        end;

         log := log+'��������'+cbbtype.Text+',���ƣ�'+nvhlpVtypename.Text+',���ţ�'+
        nvhlpcardno.Text+',���кţ�'+edtserialnumber.Text;
        SysLog.WriteLog('ҵ�������>���ܿ�����','���ܿ�����',log);
        id := Params.ParamByName('id').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('���ܿ������޸�ʧ�ܣ�' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmCardissueEdit.cbbissuereasonChange(Sender: TObject);
begin
  inherited;
  if cbbissuereason.ItemIndex = 1 then
    lbl15.Caption := 'Ʊ��'
  else if cbbissuereason.ItemIndex = 2 then
    lbl15.Caption := '������Ϣ';
end;

procedure TFrmCardissueEdit.cbbtypeChange(Sender: TObject);
begin
  inherited;
  nvhlpCustomer.Text :='';
  nvhlpCustomer.Visible := False;
  nvhlpUnit.Text :='';
  nvhlpUnit.Visible := False;
  nvhlpVtypename.Text:='';
  nvhlpVtypename.Visible := False;
  nvhlpDervier.Text:='';
  nvhlpDervier.Visible := False;
  nvhlpEmploye.Text:='';
  nvhlpEmploye.Visible := False;
  nvhlpStawer.Text:='';
  nvhlpStawer.Visible := False;

  if cbbtype.ItemIndex = 0 then
  begin
//    nvhlptypename.HelpOptions.HelpType := 'VehiclenoHelp';
    nvhlpcardno.Params.ParamValues['filter_EQS_i!cardtype'] := '0';
    nvhlpVtypename.Visible := True;
    visableVipInfo(False);
  end;
  if cbbtype.ItemIndex = 1 then
  begin
//    nvhlptypename.HelpOptions.HelpType := 'DriverHelp';
    nvhlpcardno.Params.ParamValues['filter_EQS_i!cardtype'] := '1';
    nvhlpDervier.Visible := True;
    visableVipInfo(False);
  end;
  if cbbtype.ItemIndex = 2 then
  begin
//    nvhlptypename.HelpOptions.HelpType := 'StewardHelp';
    nvhlpcardno.Params.ParamValues['filter_EQS_i!cardtype'] := '2';
    nvhlpStawer.Visible := true;
    visableVipInfo(False);
  end;
  if cbbtype.ItemIndex = 3 then
  begin
//    nvhlptypename.HelpOptions.HelpType := 'CustomerHelp';
    nvhlpcardno.Params.ParamValues['filter_EQS_i!cardtype'] := '3';
    nvhlpCustomer.Visible := True;
    visableVipInfo(True);

  end;
  if cbbtype.ItemIndex = 4 then
  begin
//    nvhlptypename.HelpOptions.HelpType := 'UserHelp';
    nvhlpcardno.Params.ParamValues['filter_EQS_i!cardtype'] := '4';
    nvhlpEmploye.Visible := True;
    visableVipInfo(False);
  end;
  if cbbtype.ItemIndex = 5 then
  begin
//    nvhlptypename.HelpOptions.HelpType := 'UnitHelp';
    nvhlpcardno.Params.ParamValues['filter_EQS_i!cardtype'] := '5';
    nvhlpUnit.Visible := True;
    visableVipInfo(False);
  end;

end;

procedure TFrmCardissueEdit.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  inherited;
  try
    TBaseCardRW.GetInstance.removeObserver(Self);
    TVipcardRW.GetInstance.removeObserver(Self);
  except
  end;
end;

procedure TFrmCardissueEdit.FormCreate(Sender: TObject);
begin
  inherited;
  isrepair:=false;
  viplastmoney:=0;
  viplastamont:=0;
  visableVipInfo(False);

  cbbtype.Active := False;
  cbbtype.Active := True;
  cbbissuereason.Active := False;
  cbbissuereason.Active := True;
  cbbvipgradefirst.Active := False;
  cbbvipgradefirst.Active := True;
  cbbtype.ItemIndex :=0;
  nvhlpVtypename.Visible := True;
  try
    TVipcardRW.GetInstance.addObserver(Self);
  except
    TVipcardRW.GetInstance.addObserver(Self);
    SysDialogs.Warning('��������ʼ��ʧ�ܣ����ܶ�ȡVIP��');
  end;
  try
    TBaseCardRW.GetInstance.addObserver(Self);
  except
    TBaseCardRW.GetInstance.addObserver(Self);
    SysDialogs.Warning('��������ʼ��ʧ�ܣ����ܶ�ȡVIP��');
  end;

    setCardTypeNOLength(Tcardtypes.VEHICLEREPORT,SysInfo.curBillLength.Items['Vehicle']);
    setCardTypeNOLength(Tcardtypes.DRIVER,SysInfo.curBillLength.Items['Driver']);
    setCardTypeNOLength(Tcardtypes.STEWARD,SysInfo.curBillLength.Items['Steward']);
    setCardTypeNOLength(Tcardtypes.VIP,SysInfo.curBillLength.Items['Vip']);
    setCardTypeNOLength(Tcardtypes.USER,SysInfo.curBillLength.Items['Userinfo']);
    setCardTypeNOLength(Tcardtypes.VEHICLEUNIT,SysInfo.curBillLength.Items['Unit']);
end;

procedure TFrmCardissueEdit.FormDestroy(Sender: TObject);
begin
  inherited;
  try
    TBaseCardRW.GetInstance.removeObserver(Self);
    TVipcardRW.GetInstance.removeObserver(Self);
  except
  end;

end;

procedure TFrmCardissueEdit.FormShow(Sender: TObject);
begin
  inherited;
  if isrepair then
    edtcardcost.Text := getParametervalue('7005',SysInfo.LoginUserInfo.OrgID)
  else
    edtcardcost.Text := getParametervalue('7001',SysInfo.LoginUserInfo.OrgID);

  if functiontype = 1 then
  begin
    jcdsResultSaveCardissue.SaveAddress := 'base/savecardissue';
    visableVipInfo(False);
  end
  else
  begin
    jcdsResultSaveCardissue.SaveAddress := 'base/replacecardissue';
    nvhlpCustomer.Visible := True;
    nvhlpcardno.Params.ParamValues['filter_EQS_i!cardtype'] := '3';
//    nvhlptypename.HDBGColumns[0].FieldName := 'name';
//    nvhlptypename.HDBGColumns[1].FieldName := 'code';
//    nvhlptypename.HDBGColumns[0].Title.Caption := '����';
//    nvhlptypename.HDBGColumns[1].Title.Caption := '֤������';
//    nvhlptypename.HDBGColumns[0].Width := 80;
//    nvhlptypename.HDBGColumns[1].Width := 120;
    visableVipInfo(True);
  end;
end;

procedure TFrmCardissueEdit.nvhlpcardnoEnter(Sender: TObject);
begin
  inherited;
  if Trim(cbbtype.Text) = '' then
  begin
    SysDialogs.ShowMessage('����ѡ�񷢿�����');
    cbbtype.SetFocus;
    Exit;
  end;
end;

procedure TFrmCardissueEdit.nvhlpcardnoIdChange(Sender: TObject);
begin
  inherited;
  if (nvhlpcardno.isactive) and  (nvhlpcardno.Id>0) then
  begin
    edtserialnumber.Text:=nvhlpcardno.HelpFieldValue['serialnumber'];
  end;

end;

procedure TFrmCardissueEdit.nvhlpVtypenameEnter(Sender: TObject);
begin
  inherited;
  if cbbtype.ItemIndex = -1 then
  begin
    SysDialogs.ShowMessage('����ѡ�񷢿�����');
    cbbtype.SetFocus;
    Exit;
  end;

end;

procedure TFrmCardissueEdit.visableVipInfo(boolean: Boolean);
begin
    lbl10.Visible := boolean;
    lbl17.Visible := boolean;
    lbl18.Visible := boolean;
    mmoremark.Enabled := boolean;
    nvhlpticketno.Enabled := boolean;
    cbbissuereason.Enabled := boolean;
    cbbvipgradefirst.Enabled := boolean;
    if boolean = True then
    begin
      if getParametervalue('7002',SysInfo.LoginUserInfo.OrgID) = '1' then
        edtcardcost.Enabled := True;
    end else
      edtcardcost.Enabled := False;

end;

procedure TFrmCardissueEdit.iccardfound(icCard: TBaseCard);
begin
  if icCard.isnew then
  begin
    baseCard:=nil;
    nvhlpcardno.Text:='';
    edtserialnumber.Text:='';
    SysDialogs.Warning('�ÿ���û�г�ʼ�������ɷ���');
    exit;
  end;
  nvhlpcardno.Text := icCard.cardNo;
  edtserialnumber.Text := IntToStr(icCard.internalSerialNo);
  //cbbtype.Text := getCardtypeName(icCard.cardtype);
  cbbtype.ItemIndex := Integer(icCard.cardtype);

  if ( functiontype = 2) and (cbbtype.ItemIndex  <> 3) then
  begin
    SysDialogs.ShowMessage('�ÿ����ǹ���������ܽ��й�ʧ����');
    Exit;
  end;

  if cbbtype.ItemIndex = 0 then
  begin
    nvhlpVtypename.Visible:= True;
    nvhlpVtypename.SetFocus;
    nvhlpCustomer.Text :='';
    nvhlpCustomer.Visible := False;
    nvhlpUnit.Text :='';
    nvhlpUnit.Visible := False;
    nvhlpDervier.Text:='';
    nvhlpDervier.Visible := False;
    nvhlpEmploye.Text:='';
    nvhlpEmploye.Visible := False;
    nvhlpStawer.Text:='';
    nvhlpStawer.Visible := False;
    nvhlpcardno.Params.ParamValues['filter_EQS_i!cardtype'] := '0';
    visableVipInfo(False);
  end;
  if cbbtype.ItemIndex = 1 then
  begin
    nvhlpDervier.Visible := True;
    nvhlpDervier.SetFocus;
    nvhlpCustomer.Text :='';
    nvhlpCustomer.Visible := False;
    nvhlpUnit.Text :='';
    nvhlpUnit.Visible := False;
    nvhlpVtypename.Text:='';
    nvhlpVtypename.Visible := False;
    nvhlpEmploye.Text:='';
    nvhlpEmploye.Visible := False;
    nvhlpStawer.Text:='';
    nvhlpStawer.Visible := False;
    nvhlpcardno.Params.ParamValues['filter_EQS_i!cardtype'] := '1';
    visableVipInfo(False);
  end;
  if cbbtype.ItemIndex = 2 then
  begin
    nvhlpStawer.Visible := True;
    nvhlpStawer.SetFocus;
    nvhlpCustomer.Text :='';
    nvhlpCustomer.Visible := False;
    nvhlpUnit.Text :='';
    nvhlpUnit.Visible := False;
    nvhlpVtypename.Text:='';
    nvhlpVtypename.Visible := False;
    nvhlpDervier.Text:='';
    nvhlpDervier.Visible := False;
    nvhlpEmploye.Text:='';
    nvhlpEmploye.Visible := False;
    nvhlpcardno.Params.ParamValues['filter_EQS_i!cardtype'] := '2';
    visableVipInfo(False);
  end;
  if cbbtype.ItemIndex = 3 then
  begin
    nvhlpCustomer.Visible := True;
    if nvhlpCustomer.Text = '' then
      nvhlpCustomer.SetFocus;

    nvhlpUnit.Text :='';
    nvhlpUnit.Visible := False;
    nvhlpVtypename.Text:='';
    nvhlpVtypename.Visible := False;
    nvhlpDervier.Text:='';
    nvhlpDervier.Visible := False;
    nvhlpEmploye.Text:='';
    nvhlpEmploye.Visible := False;
    nvhlpStawer.Text:='';
    nvhlpStawer.Visible := False;
    nvhlpcardno.Params.ParamValues['filter_EQS_i!cardtype'] := '3';
//    nvhlptypename.HDBGColumns[0].FieldName := 'name';
//    nvhlptypename.HDBGColumns[1].FieldName := 'code';
//    nvhlptypename.HDBGColumns[0].Title.Caption := '����';
//    nvhlptypename.HDBGColumns[1].Title.Caption := '֤������';
//    nvhlptypename.HDBGColumns[0].Width := 80;
//    nvhlptypename.HDBGColumns[1].Width := 120;
    visableVipInfo(True);
    cbbissuereason.ItemIndex := 0;
  end;
  if cbbtype.ItemIndex = 4 then
  begin
    nvhlpEmploye.Visible := True;
    nvhlpEmploye.SetFocus;
    nvhlpCustomer.Text :='';
    nvhlpCustomer.Visible := False;
    nvhlpUnit.Text :='';
    nvhlpUnit.Visible := False;
    nvhlpVtypename.Text:='';
    nvhlpVtypename.Visible := False;
    nvhlpDervier.Text:='';
    nvhlpDervier.Visible := False;
    nvhlpStawer.Text:='';
    nvhlpStawer.Visible := False;
    nvhlpcardno.Params.ParamValues['filter_EQS_i!cardtype'] := '4';
    visableVipInfo(False);
  end;
  if cbbtype.ItemIndex = 5 then
  begin
    nvhlpUnit.Visible := True;
    nvhlpUnit.SetFocus;
    nvhlpCustomer.Text :='';
    nvhlpCustomer.Visible := False;
    nvhlpVtypename.Text:='';
    nvhlpVtypename.Visible := False;
    nvhlpDervier.Text:='';
    nvhlpDervier.Visible := False;
    nvhlpEmploye.Text:='';
    nvhlpEmploye.Visible := False;
    nvhlpStawer.Text:='';
    nvhlpStawer.Visible := False;
    nvhlpcardno.Params.ParamValues['filter_EQS_i!cardtype'] := '5';
    visableVipInfo(False);
  end;
  baseCard := icCard;
end;

procedure TFrmCardissueEdit.vipcardfound(vipCard: TVipCard);
begin
  vipBaseCard := vipCard;
end;

end.
