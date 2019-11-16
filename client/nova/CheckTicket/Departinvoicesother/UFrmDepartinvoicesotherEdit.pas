unit UFrmDepartinvoicesotherEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, NovaHelp,
  ComCtrls, DB, DBClient, jsonClientDataSet, NovaHComboBox, ImgList;

type
  TFrmDepartinvoicesotherEdit = class(TSimpleEditForm)
    jcdsResultSavedepartinvoicesother: TjsonClientDataSet;
    lbl10: TLabel;
    lbl12: TLabel;
    lbl4: TLabel;
    edttotalmoney: TNovaEdit;
    lbl11: TLabel;
    rgreturntrip: TRadioGroup;
    rgoriginator: TRadioGroup;
    lbl2: TLabel;
    Label3: TLabel;
    lbl8: TLabel;
    nvhlpvehicle: TNovaHelp;
    nvhlpschedule: TNovaHelp;
    lbl1: TLabel;
    lbl9: TLabel;
    edtDepartinvoicesno: TNovaEdit;
    lbl13: TLabel;
    lbl3: TLabel;
    nvhlpdepartstation: TNovaHelp;
    lbl6: TLabel;
    Label2: TLabel;
    dtpdepartdate: TDateTimePicker;
    edtdeparttime: TDateTimePicker;
    Label1: TLabel;
    dtpselfdepartdate: TDateTimePicker;
    Label4: TLabel;
    lbl5: TLabel;
    lbldriver3id: TLabel;
    lbl7: TLabel;
    lbldriver2id: TLabel;
    lbldriver4id: TLabel;
    lblsteward2id: TLabel;
    cbbdriver1id: TNovaHelp;
    cbbdriver2id: TNovaHelp;
    cbbdriver3id: TNovaHelp;
    cbbdriver4id: TNovaHelp;
    cbbsteward1id: TNovaHelp;
    cbbsteward2id: TNovaHelp;
    nvhlptime: TNovaEdit;
    Label5: TLabel;
    Label6: TLabel;
    NvEdtTicketnum: TNovaEdit;
    Label7: TLabel;
    Label8: TLabel;
    NovaEbalancemoney: TNovaEdit;
    Label9: TLabel;
    Label10: TLabel;
    NovaEstationfee: TNovaEdit;
    Label11: TLabel;
    Label12: TLabel;
    NovaEagentfee: TNovaEdit;
    procedure FormCreate(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure nvhlpscheduleExit(Sender: TObject);
    procedure nvhlpdepartstationEnter(Sender: TObject);
    procedure rgreturntripClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edttotalmoneyChange(Sender: TObject);
    procedure NovaEstationfeeChange(Sender: TObject);
    procedure NovaEagentfeeChange(Sender: TObject);
  private
    log : String;
    { Private declarations }
  public
    { Public declarations }
    createby, createtime, orgid,
    gotoway,departway,departdate,
    vehicleno,departno,departstation,driver1,
    driver2,driver3,driver4,steward1,steward2: string;
    id, driver1id, driver2id, driver3id, departstationid,
    driver4id, steward1id, steward2id, scheduleid : Int64;
    sign : Boolean;
  end;

var
  FrmDepartinvoicesotherEdit: TFrmDepartinvoicesotherEdit;

implementation

uses Services;
{$R *.dfm}

procedure TFrmDepartinvoicesotherEdit.bbtnSaveClick(Sender: TObject);
var nResult : Integer;
    sResult,optype : string;
begin
  inherited;
  if nvhlpvehicle.Id = 0 then
  begin
    SysDialogs.Warning('�����복�ƺţ�');
    nvhlpvehicle.SetFocus;
    Exit;
  end;
  if Trim(edtDepartinvoicesno.Text) = '' then
  begin
    SysDialogs.Warning('�����뵥��');
    edtDepartinvoicesno.SetFocus;
    Exit;
  end;
  if nvhlpdepartstation.id = 0 then
  begin
    SysDialogs.Warning('�����뷢��վ');
    nvhlpdepartstation.SetFocus;
    Exit;
  end;
//  if Trim(edtbalancemoney.Text) = '' then
//  begin
//    SysDialogs.Warning('�����������������');
//    edtbalancemoney.SetFocus;
//    Exit;
//  end;
  if cbbdriver1id.Id > 0 then
  begin
    driver1id := cbbdriver1id.Id
  end;
  if cbbdriver2id.Id > 0 then
  begin
    driver2id := cbbdriver2id.id;
  end;
  if cbbdriver3id.Id > 0 then
  begin
    driver3id := cbbdriver3id.id;
  end;
  if cbbdriver4id.Id > 0 then
  begin
    driver4id := cbbdriver4id.id;
  end;
  if cbbsteward1id.Id > 0 then
  begin
    steward1id := cbbsteward1id.id;
  end;
  if cbbsteward2id.Id > 0 then
  begin
    steward2id := cbbsteward2id.id;
  end;
  if nvhlpschedule.Id > 0 then
  begin
    scheduleid := nvhlpschedule.Id;
  end;
  if Trim(nvhlpschedule.Text) = '' then
  begin
    scheduleid := 0;
  end;
  with jcdsResultSavedepartinvoicesother do
  begin
    Close;
    Params.ParamValues['departinvoicesother.id'] := id;
    Params.ParamValues['departinvoicesother.orgid'] := orgid;
    Params.ParamValues['departinvoicesother.createby'] := createby;
    Params.ParamValues['departinvoicesother.createtime'] := createtime;
    Params.ParamValues['departinvoicesother.vehicleid'] := nvhlpvehicle.Id;
    Params.ParamValues['departinvoicesother.departstationid'] := nvhlpdepartstation.Id;
    Params.ParamValues['departinvoicesother.departinvoicesno'] := edtDepartinvoicesno.Text;
    Params.ParamValues['departinvoicesother.departdate'] := DateTimeToStr(dtpdepartdate.DateTime);
    Params.ParamValues['departinvoicesother.selfdepartdate'] := DateTimeToStr(dtpselfdepartdate.DateTime);
    Params.ParamValues['departinvoicesother.departtime'] := FormatDateTime('hh:mm',edtdeparttime.DateTime);//

    Params.ParamValues['departinvoicesother.schedule.id'] := scheduleid;
    Params.ParamValues['departinvoicesother.driver1.id'] := driver1id;
    Params.ParamValues['departinvoicesother.driver2.id'] := driver2id;
    Params.ParamValues['departinvoicesother.driver3.id'] := driver3id;
    Params.ParamValues['departinvoicesother.driver4.id'] := driver4id;
    Params.ParamValues['departinvoicesother.steward1.id'] := steward1id;
    Params.ParamValues['departinvoicesother.steward2.id'] := steward2id;
    if rgreturntrip.ItemIndex = 1 then
    begin
      Params.ParamValues['departinvoicesother.isreturntrip'] := 'true';
    end else
    begin
      Params.ParamValues['departinvoicesother.isreturntrip'] := 'false';
    end;
    if rgoriginator.ItemIndex = 1 then
    begin
      Params.ParamValues['departinvoicesother.isoriginator'] := 'true';
    end else
    begin
      Params.ParamValues['departinvoicesother.isoriginator'] := 'false';
    end;
    Params.ParamValues['departinvoicesother.ticketnum'] := NvEdtTicketnum.Text;
    Params.ParamValues['departinvoicesother.totalmoney'] := edttotalmoney.Text;
    Params.ParamValues['departinvoicesother.agentfee'] :=  NovaEagentfee.Text;
    Params.ParamValues['departinvoicesother.balancemoney'] :=  NovaEbalancemoney.Text;
    Params.ParamValues['departinvoicesother.stationfee'] :=  NovaEstationfee.Text;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        nvhlpvehicle.SetFocus;
      end
      else
      begin
        if id>0 then
        begin
          optype :='�޸Ľ��㵥��¼';
          log := '';
           if (gotoway = 'ȥ��') and (rgreturntrip.ItemIndex <> 0)  then
            log := log+'[ȥ��] �ĳ�  [�س�]' ;
          if (gotoway = '�س�') and (rgreturntrip.ItemIndex = 0)  then
            log := log+'[�س�] �ĳ�  [ȥ��]' ;
          if (departway = 'ʼ��') and (rgoriginator.ItemIndex = 0)  then
            log := log+' ,[ʼ��] �ĳ� [��;]' ;
          if (departway = '��;') and (rgreturntrip.ItemIndex <> 0)  then
            log := log+',[��;] �ĳ� [ʼ��]' ;
          if departdate <> DateTimeToStr(dtpdepartdate.DateTime) then
            log :=log +',[��������] �� '+departdate +'�ĳ�'+DateTimeToStr(dtpdepartdate.DateTime);
          if vehicleno <> nvhlpvehicle.Text then
            log :=log +',[����] �� '+vehicleno +' �ĳ� '+nvhlpvehicle.Text;
          if departno <> edtDepartinvoicesno.Text then
            log := log +',[�˵���] �� '+departno +' �ĳ� '+ edtDepartinvoicesno.Text;
          if departstation <> nvhlpdepartstation.Text then
            log := log+',[����վ] ��'+departstation+' �ĳ� '+  nvhlpdepartstation.Text;

        end
        else
        begin
          optype :='��ӽ��㵥��¼';
          log := '';
          if rgreturntrip.ItemIndex = 0 then
          begin
            log := log + '[����]=ȥ��';
          end else
          begin
            log := log + '[����]=�س�';
          end;
          if rgoriginator.ItemIndex = 0 then
            log := log + ',[��;]'
          else
            log := log + ',[ʼ��]';
          log := log + ',[����]='+nvhlpvehicle.Text+',[��վ���]='+nvhlpschedule.Text+
          ',[����]='+edtDepartinvoicesno.Text+',[����վ]='+nvhlpdepartstation.Text+
          ',[��վ��������]='+FormatDateTime('yyyy-mm-dd',dtpdepartdate.Date)
          +',[��վ����ʱ��]='+DateTimeToStr(edtdeparttime.DateTime)+
          ',[��վ��������]='+FormatDateTime('yyyy-mm-dd',dtpselfdepartdate.Date)
          +',[��վ����ʱ��]='+nvhlptime.Text;
        end;
        SysLog.WriteLog('��Ʊ����->���㵥��¼',optype,log);

        id := Params.ParamByName('id').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('���㵥��¼���ʧ�ܣ�' + E.Message);
        //SysDialogs.ShowMessage(E.Message);
      end;
    end;
  end;
end;

procedure TFrmDepartinvoicesotherEdit.edttotalmoneyChange(Sender: TObject);
begin
  inherited;
  if edttotalmoney.Text<>'' then
  begin
    NovaEbalancemoney.Text:=currtostr(strtocurr(edttotalmoney.Text)-
    strtocurr(NovaEstationfee.Text)-strtocurr(NovaEagentfee.Text));
  end;
end;

procedure TFrmDepartinvoicesotherEdit.FormCreate(Sender: TObject);
begin
  inherited;
  dtpdepartdate.DateTime := Now();
  dtpdepartdate.DateTime := Now();

  dtpselfdepartdate.DateTime := Now();
  dtpselfdepartdate.DateTime := Now();

  if Trim(nvhlpdepartstation.Text) = '' then
  begin
   // nvhlpdepartstation.Text := SysInfo.LoginUserInfo.OrgName;
   // nvhlpdepartstation.Id := SysInfo.LoginUserInfo.StationID;
  end;
end;

procedure TFrmDepartinvoicesotherEdit.FormShow(Sender: TObject);
begin
  inherited;
  if rgreturntrip.ItemIndex = 0 then
  begin
    nvhlpdepartstation.HelpOptions.HelpType := 'StartStationHelp';
    dtpdepartdate.Enabled := False;
    edtdeparttime.Enabled := False;
    dtpselfdepartdate.Enabled := True;
  end else
  begin
    nvhlpdepartstation.HelpOptions.HelpType := 'StationHelp';
    dtpdepartdate.Enabled := True;
    edtdeparttime.Enabled := True;
    dtpselfdepartdate.Enabled := False;
  end;
  nvhlpvehicle.SetFocus;
end;

procedure TFrmDepartinvoicesotherEdit.NovaEagentfeeChange(Sender: TObject);
begin
  inherited;
  if NovaEagentfee.Text<>'' then
  begin
    NovaEbalancemoney.Text:=currtostr(strtocurr(edttotalmoney.Text)-
    strtocurr(NovaEstationfee.Text)-strtocurr(NovaEagentfee.Text));
  end;
end;

procedure TFrmDepartinvoicesotherEdit.NovaEstationfeeChange(Sender: TObject);
begin
  inherited;
  if NovaEstationfee.Text<>'' then
  begin
    NovaEbalancemoney.Text:=currtostr(strtocurr(edttotalmoney.Text)-
    strtocurr(NovaEstationfee.Text)-strtocurr(NovaEagentfee.Text));
  end;
end;

procedure TFrmDepartinvoicesotherEdit.nvhlpdepartstationEnter(Sender: TObject);
begin
  inherited;
  if rgreturntrip.ItemIndex = 1 then
  begin
    nvhlpdepartstation.HelpOptions.HelpType := 'StationHelp';
  end;
end;

procedure TFrmDepartinvoicesotherEdit.nvhlpscheduleExit(Sender: TObject);
begin
  inherited;
  if Trim(nvhlpschedule.Text) = '' then
  else
  nvhlptime.Text := nvhlpschedule.HelpFieldValue['starttime'];
end;

procedure TFrmDepartinvoicesotherEdit.rgreturntripClick(Sender: TObject);
begin
  inherited;
  if rgreturntrip.ItemIndex = 0 then
  begin
    nvhlpdepartstation.HelpOptions.HelpType := 'StartStationHelp';
    dtpdepartdate.Enabled := False;
    edtdeparttime.Enabled := False;
    dtpselfdepartdate.Enabled := True;
  end else
  begin
    nvhlpdepartstation.HelpOptions.HelpType := 'StationHelp';
    dtpdepartdate.Enabled := True;
    edtdeparttime.Enabled := True;
    dtpselfdepartdate.Enabled := False;
  end;
end;

end.
