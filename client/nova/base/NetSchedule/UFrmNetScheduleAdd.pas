unit UFrmNetScheduleAdd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, NovaEdit,
  NovaHelp, DB, DBClient, jsonClientDataSet;

type
  TFrmNetScheduleAdd = class(TSimpleEditForm)
    Label3: TLabel;
    Label4: TLabel;
    NovaHOverOrg: TNovaHelp;
    jscdSaveNetSchedule: TjsonClientDataSet;
    NovaHOverSch: TNovaHelp;
    Label1: TLabel;
    Label2: TLabel;
    NovaHStartOrg: TNovaHelp;
    nvhlpschedule: TNovaHelp;
    procedure NovaHOverOrgIdChange(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    operationid: int64;
    createtime:String;
    orderno:integer;
  end;

var
  FrmNetScheduleAdd: TFrmNetScheduleAdd;

implementation

uses UDMPublic, Services, PubFn;
{$R *.dfm}

procedure TFrmNetScheduleAdd.bbtnSaveClick(Sender: TObject);
var
  endno: LongWord;
  nResult: Integer;
  sResult: string;
begin
  inherited;
 { if Trim(NovaHStartOrg.Text) ='' then
  begin
    SysDialogs.ShowMessage('������ʼ����λ�����');
    NovaHStartOrg.SetFocus;
    Exit;
  end;

  if Trim(nvhlpschedule.Text) = '' then
  begin
    SysDialogs.ShowMessage('������ʼ����κţ�');
    nvhlpschedule.SetFocus;
    Exit;
  end;   }
  if Trim(NovaHOverOrg.Text) ='' then
  begin
    SysDialogs.ShowMessage('��������Ͱ�λ�����');
    NovaHOverOrg.SetFocus;
    Exit;
  end;

  if Trim(NovaHOverSch.Text) = '' then
  begin
    SysDialogs.ShowMessage('��������Ͱ�κţ�');
    NovaHOverSch.SetFocus;
    Exit;
  end;

{ if Trim(NovaHStartOrg.Text)=Trim(NovaHOverOrg.Text) then
 begin
    SysDialogs.ShowMessage('ʼ����λ�������Ͱ�λ�����������ͬ��');
    NovaHOverOrg.SetFocus;
    Exit;
 end;
 if nvhlpschedule.id=NovaHOverSch.id then
 begin
    SysDialogs.ShowMessage('ʼ���������Ͱ�β�������ͬ��');
    NovaHOverSch.SetFocus;
    Exit;
 end;  }
  with jscdSaveNetSchedule do
  begin
    Close;
    Params.ParamValues['netschedule.id'] := operationid;
    Params.ParamValues['netschedule.createby'] := Sysinfo.LoginUserInfo.UserID;
    Params.ParamValues['netschedule.createtime'] := createtime;
    Params.ParamValues['netschedule.orderno'] := orderno;
    Params.ParamValues['netschedule.scheduleid'] := NovaHOverSch.Id;
    Params.ParamValues['netschedule.startscheduleid'] := nvhlpschedule.Id;
    Params.ParamValues['netschedule.updateby'] := Sysinfo.LoginUserInfo.UserID;

    try
      Execute;
      nResult := Params.ParamByName('actionResult').Value;
      sResult := Params.ParamByName('actionResultStr').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        NovaHOverSch.SetFocus;
      end
      else
      begin
         operationid:=Params.ParamByName('netscheduleid').Value;
         //SysDialogs.ShowMessage(inttostr(operationid));
       { log := '��Ʊ�Ǽǣ��Ǽ���=' + SysInfo.LoginUserInfo.UserName + ',Ʊ������=' +
          edtbilltype.Text + ',ʹ��Ʊ��=' + edtstartno.Text + ',����Ʊ��=' +
          edtendno.Text + ',�Ǽ�����=' + edtamount.Text + ',ʣ��Ʊ��=' +
          edtavailablecount.Text + ',������' + mmodscribe.Text;
        SysLog.WriteLog('��Ʊ����>��Ʊ�Ǽ�', '��Ʊ�Ǽ�', log);  }
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('����������ʧ�ܣ�' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmNetScheduleAdd.NovaHOverOrgIdChange(Sender: TObject);
begin
  inherited;

  if NovaHOverOrg.id > 0 then
  begin
    NovaHOverSch.Params.ParamValues['filter_EQL_t!orgid'] := NovaHOverOrg.id
  end
  else
  begin
    NovaHOverSch.Params.ParamValues['filter_EQL_t!orgid'] := null;
  end;
end;

end.
