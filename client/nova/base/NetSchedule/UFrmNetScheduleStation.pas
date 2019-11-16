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
    SysDialogs.ShowMessage('请选择停靠点！');
    NvSchedulestop.SetFocus;
    Exit;
  end;

  if Trim(NEdtOrderno.Text) = '' then
  begin
    SysDialogs.ShowMessage('请输入停靠点序号！');
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
       { log := '坏票登记：登记人=' + SysInfo.LoginUserInfo.UserName + ',票据类型=' +
          edtbilltype.Text + ',使用票号=' + edtstartno.Text + ',结束票号=' +
          edtendno.Text + ',登记数量=' + edtamount.Text + ',剩余票数=' +
          edtavailablecount.Text + ',损坏描述' + mmodscribe.Text;
        SysLog.WriteLog('售票管理—>坏票登记', '坏票登记', log);  }
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('联网班次停靠点添加失败：' + E.Message);
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
