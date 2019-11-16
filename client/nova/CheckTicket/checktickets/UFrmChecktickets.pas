unit UFrmChecktickets;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, DB, DBClient,
  jsonClientDataSet, ImgList;

type
  TFrmChecktickets = class(TSimpleEditForm)
    Label1: TLabel;
    Label2: TLabel;
    NovaEdtStartNo: TNovaEdit;
    NovaEdtEndNo: TNovaEdit;
    jscdChecktickets: TjsonClientDataSet;
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    vehiclereportid: int64;
    inputdepartstationid:string;
  end;

var
  FrmChecktickets: TFrmChecktickets;

implementation

uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmChecktickets.bbtnSaveClick(Sender: TObject);
var
  nResult, count,templen,ticketlength: integer;
  sResult: string;
begin

  inherited;
  if trim(NovaEdtStartNo.Text) = '' then
  begin
    SysDialogs.Warning('��������ʼƱ�ţ�');
    NovaEdtStartNo.SetFocus;
    exit;
  end;
  if trim(NovaEdtEndNo.Text) = '' then
  begin
    SysDialogs.Warning('���������Ʊ�ţ�');
    NovaEdtEndNo.SetFocus;
    exit;
  end;

  ticketlength := Sysinfo.curBillLength.Items['Ticket'] ;
  if length(trim(NovaEdtStartNo.text)) > ticketlength then
  begin
   //�����ȡ�ĳ�Ʊ���ȴ���ϵͳƱ�ݳ��ȣ���Ӻ����ȡ������ϵͳ��Ʊ�ݳ���
    templen := length(trim(NovaEdtStartNo.text)) - ticketlength;
    NovaEdtStartNo.text := copy(NovaEdtStartNo.text, templen+1,
    length(NovaEdtStartNo.text));
  end;
  if length(trim(NovaEdtEndNo.text)) > ticketlength then
  begin
   //�����ȡ�ĳ�Ʊ���ȴ���ϵͳƱ�ݳ��ȣ���Ӻ����ȡ������ϵͳ��Ʊ�ݳ���
    templen := length(trim(NovaEdtEndNo.text)) - ticketlength;
    NovaEdtEndNo.text := copy(NovaEdtEndNo.text, templen+1,
        length(NovaEdtEndNo.text));
  end;
  if strtoint64(trim(NovaEdtEndNo.Text)) < strtoint64
    (trim(NovaEdtStartNo.Text)) then
  begin
    SysDialogs.Warning('����Ʊ�Ų���С����ʼƱ�ţ�');
    NovaEdtEndNo.SetFocus;
    exit;
  end;

  try
    with jscdChecktickets do
    begin
      active := false;
      Params.ParamValues['checkstationid'] := SysInfo.LoginUserInfo.StationID;
      Params.ParamValues['vehiclereportid'] := vehiclereportid;
      Params.ParamValues['stratticketno'] := trim(NovaEdtStartNo.Text);
      Params.ParamValues['endticketno'] := trim(NovaEdtEndNo.Text);
      if (inputdepartstationid <> '') then
      begin
        Params.ParamValues['filter_INS_t!departstationid'] := inputdepartstationid;
      end
      else
      begin
        Params.ParamValues['filter_INS_t!departstationid'] := null;
      end;
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult = 1) then
      begin
        count := Params.ParamByName('checktickets').Value;
        SysDialogs.ShowMessage('����ɹ���һ������'+inttostr(count)+'��Ʊ��');
        ModalResult := mrok;
      end
      else if (nResult = 0) then
      begin
        SysDialogs.Warning(sResult);
        ModalResult := mrok;
      end
      else
      begin
        SysDialogs.Warning(sResult);
        NovaEdtEndNo.SetFocus;
      end;
    end;
  except
    on E: Exception do
    begin
      SysLog.WriteErr('�������ʧ�ܣ�' + E.Message);
    end;
  end;

end;

end.
