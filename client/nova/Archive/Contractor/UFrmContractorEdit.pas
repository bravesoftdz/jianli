unit UFrmContractorEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, ComCtrls, NovaComboBox,
  NovaEdit, NovaHComboBox, DB, DBClient, jsonClientDataSet,Services, NovaHelp,
  ImgList;

type
  TfrmContractorEdt = class(TSimpleEditForm)
    grp1: TGroupBox;
    lbl1: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    lbl14: TLabel;
    lbl11: TLabel;
    lbl21: TLabel;
    lbl22: TLabel;
    nvedtName: TNovaEdit;
    nvedtIDcard: TNovaEdit;
    nvedtContactphone: TNovaEdit;
    nvedtAdress: TNovaEdit;
    grp2: TGroupBox;
    lbl18: TLabel;
    lblWorkn: TLabel;
    lbl23: TLabel;
    lbl24: TLabel;
    lbllbvehicleid: TLabel;
    lbl35: TLabel;
    lbl15: TLabel;
    nvhcbbOrg: TNovaHComboBox;
    lbl9: TLabel;
    lbl2: TLabel;
    jcdsSave: TjsonClientDataSet;
    nvedtMonthamount: TNovaEdit;
    nvedtContractno: TNovaEdit;
    dtpEnddate: TDateTimePicker;
    dtpStartdate: TDateTimePicker;
    nvhelpVehicle: TNovaHelp;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    Foperationid:Integer;
    mem: TMemoryStream;
    memstr: TStringStream;
    function checkInput(var msg: String): boolean;
  public
    { Public declarations }
    isedit:boolean;
   id:Integer;
   createby,orgname,idcard,phone,adress,contractno,contractname,
   amount,starttime,endtime,vehicle,createtime,code: string;
    property operationid:Integer read Foperationid;
  end;

var
  frmContractorEdt: TfrmContractorEdt;

implementation
  uses UDMPublic,PubFn;

{$R *.dfm}

procedure TfrmContractorEdt.bbtnSaveClick(Sender: TObject);
 var  msg,operationtype,log: String;
  nResult: integer;
  sResult,contractorno: String;
begin
  inherited;
   if (not checkInput(msg)) then
  begin
    SysDialogs.ShowMessage(msg);
    exit;
  end;

  with jcdsSave do
  begin
    close;
    Params.ParamByName('contractor.id').Value := id;
    Params.ParamByName('contractor.createtime').Value := createtime;
    Params.ParamByName('contractor.createby').Value := createby;
    Params.ParamByName('contractor.name').Value := nvedtName.Text;
    Params.ParamByName('contractor.idcard').Value := nvedtIDcard.Text;
    Params.ParamByName('contractor.contactphone').Value := nvedtContactphone.Text;
    Params.ParamByName('contractor.contactaddress').Value := nvedtAdress.Text;
    Params.ParamByName('contractor.contractno').Value := nvedtContractno.Text;
    if nvedtMonthamount.Text ='' then
      Params.ParamByName('contractor.monthamount').Value :='0'
    else
    Params.ParamByName('contractor.monthamount').Value := nvedtMonthamount.Text;

    Params.ParamByName('contractor.orgid').Value := nvhcbbOrg.HelpFieldValue['id'];
    Params.ParamByName('contractor.vehicleid').Value := nvhelpVehicle.Id;
    Params.ParamByName('contractor.startdate').Value :=formatdatetime('c',dtpStartdate.Date);
    Params.ParamByName('contractor.enddate').Value := formatdatetime('c',dtpEnddate.Date);
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      contractorno :='��ͬ����';
      if (nResult <= 0) then
      begin
       if Pos(contractorno,sResult)>0 then
       begin
        nvedtContractno.SetFocus;
       end
       else
       begin
        nvhelpVehicle.SetFocus;
       end;
      end
      else
      begin
        if id>0 then
        begin
           operationtype:='�޸�';
           if orgname <> nvhcbbOrg.Text then
           begin
              log := ' ����������'+orgname+'�ĳ�'+nvhcbbOrg.Text;
           end;
            if contractname <> nvedtName.Text then
           begin
              log := log+', �а���������'+contractname+'�ĳ�'+nvedtName.Text;
           end;
            if idcard <> nvedtIDcard.Text then
           begin
              log := log+', ���֤��'+idcard+'�ĳ�'+nvedtIDcard.Text;
           end;
            if phone <> nvedtContactphone.Text then
           begin
              log := log+', �绰��'+phone+'�ĳ�'+nvedtContactphone.Text;
           end;
            if adress <> nvedtAdress.Text then
           begin
              log := log+', ��ַ��'+adress+'�ĳ�'+nvedtAdress.Text;
           end;
           if vehicle <> nvhelpVehicle.Text then
           begin
              log := log+', �а�����'+vehicle+'�ĳ�'+nvhelpVehicle.Text;
           end;
           if contractno <> nvedtContractno.Text then
           begin
              log := log+', �а���ͬ�����'+contractno+'�ĳ�'+nvedtContractno.Text;
           end;
           if amount <> nvedtMonthamount.Text then
           begin
              log := log+', �а������'+amount+'�ĳ�'+nvedtMonthamount.Text;
           end;
           if starttime <> DateToStr(dtpStartdate.Date) then
           begin
              log := log+', �а���ʼ������'+starttime+'�ĳ�'+DateToStr(dtpStartdate.Date);
           end;
           if endtime <> DateToStr(dtpEnddate.Date) then
           begin
              log := log+', �а�����������'+endtime+'�ĳ�'+DateToStr(dtpEnddate.Date);
           end;
        end
        else
        begin
           operationtype:='���';
            log := '��������:'+ nvhcbbOrg.Text +', �а�������:'+nvedtName.Text
            +', ���֤:'+nvedtIDcard.Text+', �绰:'+nvedtContactphone.Text
            +', ��ַ:'+nvedtAdress.Text+', �а���:'+nvhelpVehicle.Text
            +', �а���ͬ���:'+nvedtContractno.Text
            +', �а����:'+nvedtMonthamount.Text
            +', �а���ʼ����:'+DateToStr(dtpStartdate.Date)
            +', �а���������:'+DateToStr(dtpEnddate.Date);
        end;
        SysLog.WriteLog('�а��ߵ�������', operationtype, log);
        log:='';
        operationtype:='';
        id := Params.ParamByName('contractorid').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('�а��ߵ������ʧ�ܣ�' + E.Message);
      end;
    end;
  end;


end;

function TfrmContractorEdt.checkInput(var msg: String): boolean;
begin
   result := False;
  if Trim(nvedtName.Text) ='' then
  begin
    msg := '��������Ϊ�գ�';
    nvedtName.SetFocus;
    exit;
  end;
  if trim(nvedtIDcard.Text)='' then
  begin
    msg := '���֤�Ų���Ϊ�գ�';
    nvedtIDcard.SetFocus;
    exit;
  end;
  if not (ValidatePID(nvedtIDcard.Text) ='') then
    begin
      msg := ValidatePID(nvedtIDcard.Text);
      nvedtIDcard.SetFocus;
      exit;
    end;

  if trim(nvedtContactphone.Text) = '' then
  begin
    msg := '��ϵ�˵绰��';
    nvedtContactphone.SetFocus;
    exit;
  end;
   if ((Trim(nvhelpVehicle.Text) = '')) and (nvhelpVehicle.Id<=0) then
  begin
    msg := '������а�������';
    nvhelpVehicle.SetFocus;
    exit;
  end;
   if nvedtContractno.Text = ''then
  begin
    msg := '������а���ͬ��ţ�';
    nvedtContractno.SetFocus;
    exit;
  end;
   result := True;
end;
procedure TfrmContractorEdt.FormCreate(Sender: TObject);
begin
  inherited;
  nvhcbbOrg.Active := False;
  nvhcbbOrg.Active := True;
  dtpStartdate.Date :=Now;
  dtpEnddate.Date := Now;
end;

end.
