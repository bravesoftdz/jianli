unit UFrmNetScheduleStation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, NovaComboBox,
  NovaEdit, DB, DBClient, jsonClientDataSet, NovaHComboBox;

type
  TFrmNetScheduleStation = class(TSimpleEditForm)
    Label1: TLabel;
    Label2: TLabel;
    EdtRoute: TEdit;
    jscdSaveSchedulestop: TjsonClientDataSet;
    Label3: TLabel;
    NEdtOrderno: TNovaEdit;
    NvSchedulestop: TNovaHComboBox;
    procedure FormShow(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    netscheduleid,operationid:int64;
  end;

var
  FrmNetScheduleStation: TFrmNetScheduleStation;

implementation

uses UDMPublic, Services, PubFn;
{$R *.dfm}

procedure TFrmNetScheduleStation.bbtnSaveClick(Sender: TObject);
var
  endno: LongWord;
  nResult: Integer;
  sResult: string;
begin
  inherited;
  if NvSchedulestop.ItemIndex<0 then
  begin
    SysDialogs.ShowMessage('��ѡ��ͣ���㣡');
    NvSchedulestop.SetFocus;
    Exit;
  end;

  if Trim(NEdtOrderno.Text) = '' then
  begin
    SysDialogs.ShowMessage('������ͣ������ţ�');
    NEdtOrderno.SetFocus;
    Exit;
  end;

  with jscdSaveSchedulestop do
  begin
    Close;
    Params.ParamValues['netschedulestop.orderno'] := NEdtOrderno.Text;
    Params.ParamValues['netschedulestop.stationid'] := NvSchedulestop.HelpFieldValue['id'];
    Params.ParamValues['netschedulestop.netscheduleid'] := netscheduleid;
    try
      Execute;
      nResult := Params.ParamByName('actionResult').Value;
      sResult := Params.ParamByName('actionResultStr').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        NEdtOrderno.SetFocus;
      end
      else
      begin
         operationid:=Params.ParamByName('netschedulestopid').Value;
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
        SysLog.WriteErr('�������ͣ�������ʧ�ܣ�' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmNetScheduleStation.FormShow(Sender: TObject);
begin
  inherited;
  NvSchedulestop.Active:=false;
  NvSchedulestop.Params.ParamValues['netscheduleid'] := netscheduleid;
  NvSchedulestop.Active:=true;
end;

end.
