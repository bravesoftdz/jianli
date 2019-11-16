unit UFrmSystemLog;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  PrnDbgeh, ImgList, GridsEh, DBGridEh, ComCtrls, ToolWin, ExtCtrls, StdCtrls,
  Mask, DBCtrlsEh, NovaEdit, NovaHelp, NvPrnDbgeh, NvDbgridEh,
  NovaCheckedComboBox;

type
  TFrmSystemLog = class(TSimpleCRUDForm)
    lblUserIp: TLabel;
    lblUserId: TLabel;
    dtpBegindate: TDateTimePicker;
    lblBegintimes: TLabel;
    lblEndtimes: TLabel;
    dtpEnddate: TDateTimePicker;
    lblOrg: TLabel;
    jsonCDSInitOrg: TjsonClientDataSet;
    dtpEndtime: TDateTimePicker;
    dtpBegintime: TDateTimePicker;
    nvedtUsername: TNovaEdit;
    lblTableName: TLabel;
    nvedtModule: TNovaEdit;
    nvedtIP: TNovaEdit;
    nvckbOrg: TNovaCheckedComboBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSystemLog: TFrmSystemLog;

implementation
uses UDMPublic,PubFn;
{$R *.dfm}

procedure TFrmSystemLog.FormCreate(Sender: TObject);
begin
  inherited;
  //dtpBegindate.Date :=Now;
  //dtpEnddate.Date :=Now;
end;

procedure TFrmSystemLog.FormShow(Sender: TObject);
begin
  inherited;
   nvckbOrg.Active := False;
   nvckbOrg.Active := True;
   dtpBegindate.Date :=Now;
   dtpEnddate.Date :=Now;
end;

procedure TFrmSystemLog.tbtnFilterClick(Sender: TObject);
var endtime,begintime:String;orgid:Integer;
begin
  inherited;
    with jcdsResult do
     begin
     Active := false;
     Params.ParamByName('orgname').Value := nvckbOrg.GetSelectID;
     Params.ParamByName('usernames').Value :=nvedtUsername.Text;
     Params.ParamByName('ip').Value :=  nvedtIP.Text;
     Params.ParamByName('module').Value :=  nvedtModule.Text;
     Params.ParamByName('begindate').Value := formatdatetime('c',dtpBegindate.Date)+' '+ formatdatetime('tt',dtpBegintime.Time);
     Params.ParamByName('enddate').Value := formatdatetime('c',dtpEnddate.Date)+' '+formatdatetime('tt',dtpEndtime.Time);


      Active := true;
     end;
end;


end.
