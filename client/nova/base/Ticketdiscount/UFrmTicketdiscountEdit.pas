unit UFrmTicketdiscountEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, NovaComboBox,
  NovaEdit, NovaHelp, ComCtrls, DB, DBClient, jsonClientDataSet, NovaHComboBox;

type
  TFrmTicketdiscountEdit = class(TSimpleEditForm)
    lbl1: TLabel;
    cbbdata: TNovaComboBox;
    lbl2: TLabel;
    lbl3: TLabel;
    nvhlpdatatype: TNovaHelp;
    Label1: TLabel;
    lbl4: TLabel;
    cbbstartdate: TDateTimePicker;
    cbbenddate: TDateTimePicker;
    lbl6: TLabel;
    edtsellnum: TNovaEdit;
    lbl7: TLabel;
    lbl8: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    edtmindiscountrate: TNovaEdit;
    edtdefaultdiscountrate: TNovaEdit;
    Label2: TLabel;
    jcdsSaveTicketdiscount: TjsonClientDataSet;
    Label3: TLabel;
    cbbtickettype: TNovaHComboBox;
    procedure bbtnSaveClick(Sender: TObject);
    procedure cbbdataChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtmindiscountrateExit(Sender: TObject);
    procedure edtdefaultdiscountrateExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    id, createby, orgid : Int64;
    createtime : string;
  end;

var
  FrmTicketdiscountEdit: TFrmTicketdiscountEdit;

implementation

uses Services, PubFn;
{$R *.dfm}

procedure TFrmTicketdiscountEdit.bbtnSaveClick(Sender: TObject);
var sResult,result, log : string;
    nResult : Integer;
begin
  inherited;
    if cbbtickettype.ItemIndex<0 then
    begin
      ShowMessage('��ѡ��Ʊ��!');
      Exit;
    end;

  if Trim(edtmindiscountrate.Text) = '' then
  begin
    ShowMessage('����������ۿۣ�');
    Exit;
  end;
  if Trim(edtdefaultdiscountrate.Text) = '' then
  begin
    ShowMessage('������Ĭ���ۿۣ�');
    Exit;
  end;
  if Trim(edtsellnum.Text) = '' then
  begin
    ShowMessage('���������������');
    Exit;
  end;
  if nvhlpdatatype.Id = 0 then
  begin
    ShowMessage('�������������ƣ�');
    Exit;
  end;
  if FormatDateTime('yyyymmdd', cbbstartdate.Date) > FormatDateTime('yyyymmdd',
    cbbenddate.Date) then
  begin
    ShowMessage('��ʼ���ڲ��ܴ��ڽ������ڣ�');
    exit;
  end;
  with jcdsSaveTicketdiscount do
  begin
    Params.ParamValues['ticketdiscount.id'] := id;
    Params.ParamValues['ticketdiscount.mindiscountrate'] := edtmindiscountrate.Text;
    Params.ParamValues['ticketdiscount.defaultdiscountrate'] := edtdefaultdiscountrate.Text;
    Params.ParamValues['ticketdiscount.sellnum'] := edtsellnum.Text;
    Params.ParamValues['ticketdiscount.dataid'] := nvhlpdatatype.Id;
    Params.ParamValues['ticketdiscount.startdate'] := FormatDateTime('yyyy-mm-dd',cbbstartdate.Date);
    Params.ParamValues['ticketdiscount.enddate'] := FormatDateTime('yyyy-mm-dd',cbbenddate.Date);
    Params.ParamValues['ticketdiscount.createby'] := createby;
    Params.ParamValues['ticketdiscount.createtime'] := createtime;
    Params.ParamValues['ticketdiscount.orgid'] := orgid;

    if cbbdata.ItemIndex = 0 then
      Params.ParamValues['ticketdiscount.datatype'] := 0
    else if cbbdata.ItemIndex = 1 then
      Params.ParamValues['ticketdiscount.datatype'] := 1
    else if cbbdata.ItemIndex = 2 then
      Params.ParamValues['ticketdiscount.datatype'] := 2
    else
    begin
      ShowMessage('��ѡ������!');
      Exit;
    end;


   Params.ParamValues['ticketdiscount.tickettype'] := cbbtickettype.HelpFieldValue['code'];

    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if nResult < 0 then
      begin
        nvhlpdatatype.SetFocus;
      end else
      begin
        if id > 0 then
          result := '�޸�'
        else
          result := '���';
        log := 'ɾ���ۿ���Ϣ��Ʊ��='+cbbtickettype.Text+
        ',����='+cbbdata.Text+',��������='+nvhlpdatatype.Text+',��������='+
        SysInfo.LoginUserInfo.OrgName+ ',��ʼ����='+
        FormatDateTime('yyyy-mm-dd',cbbstartdate.Date)+',��������='+
        FormatDateTime('yyyy-mm-dd',cbbenddate.Date)+',����Ʊ��='+
        edtsellnum.Text+',����ۿ�='+edtmindiscountrate.Text
        + ',Ĭ���ۿ�=' + edtdefaultdiscountrate.Text;
        SysLog.WriteLog('ҵ�����->�ۿ���Ϣ',result,log);
        id := Params.ParamByName('id').Value;
        ModalResult := mrok;
      end;

    except
      on E: Exception do
      begin
        SysLog.WriteErr('�ۿ۹������ʧ�ܣ�' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmTicketdiscountEdit.cbbdataChange(Sender: TObject);
begin
  inherited;
  if cbbdata.ItemIndex = 0 then
  begin
    nvhlpdatatype.HelpOptions.HelpType := 'OrgManagerHelp';
    nvhlpdatatype.Text := '';
  end
  else if cbbdata.ItemIndex = 1 then
  begin
    nvhlpdatatype.HelpOptions.HelpType := 'RouteHelp';
    nvhlpdatatype.Text := '';
  end
  else if cbbdata.ItemIndex = 2 then
  begin
    nvhlpdatatype.HelpOptions.HelpType := 'ScheduleHelp';
    nvhlpdatatype.Text := '';
  end;
end;

procedure TFrmTicketdiscountEdit.edtdefaultdiscountrateExit(Sender: TObject);
begin
  inherited;
  if (StrToFloat(edtdefaultdiscountrate.Text) > 1) or (StrToFloat(edtdefaultdiscountrate.Text) < 0) then
  begin
    SysDialogs.ShowMessage('������0-1֮�����');
    edtdefaultdiscountrate.SetFocus;
    exit;
  end;
end;

procedure TFrmTicketdiscountEdit.edtmindiscountrateExit(Sender: TObject);
begin
  inherited;
  if (StrToFloat(edtmindiscountrate.Text) > 1) or (StrToFloat(edtmindiscountrate.Text) < 0) then
  begin
    SysDialogs.ShowMessage('������0-1֮�����');
    edtmindiscountrate.SetFocus;
    exit;
  end;
end;

procedure TFrmTicketdiscountEdit.FormCreate(Sender: TObject);
begin
  inherited;
  cbbstartdate.DateTime := Now;
  cbbenddate.DateTime := Now;
  cbbtickettype.Active:=false;
  cbbtickettype.Active:=true;

end;

end.
