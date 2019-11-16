unit UFrmModDepartTime;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls,
  DBGridEhGrouping, GridsEh, DBGridEh, NvDbgridEh, DB, DBClient,
  jsonClientDataSet, NovaEdit, ComCtrls;

type
  TFrmModDepartTime = class(TSimpleEditForm)
    GroupBox1: TGroupBox;
    NvDbgridEh1: TNvDbgridEh;
    jscdQryDepart: TjsonClientDataSet;
    DataSource1: TDataSource;
    Label1: TLabel;
    edtNvroute: TNovaEdit;
    edtstarttime: TDateTimePicker;
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    fromdate,enddate:string;
    function qryDepartime(scheduleplanid, departstationid: int64): boolean;
  end;

var
  FrmModDepartTime: TFrmModDepartTime;

implementation

uses Services, PubFn, UDMPublic;
{$R *.dfm}
{ TFrmModDepartTime }

procedure TFrmModDepartTime.bbtnSaveClick(Sender: TObject);
var
  nResult: Integer;
  sResult: string;
begin
  inherited;
  with jscdQryDepart do
  begin
    try
      First;
      while not eof do
      begin
        edtstarttime.Time:=fieldbyname('departtime').AsDateTime;
        Edit;
        jscdQryDepart.FieldByName('departtime').Value:=formatdatetime('HH:mm',edtstarttime.Time);
        next;
      end;
      //EnableControls;
    except
      on E: Exception do
      begin
        SysDialogs.ShowError('发车时间格式不对，请重新输入！');
        Edit;
        NvDbgridEh1.SetFocus;
        exit;
      end;
    end;
  end;

  with jscdQryDepart do
  begin
    try
      ApplyUpdates(-1);
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult = 1) then
      begin
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('发车时间保存失败：' + E.Message);
      end;
    end;
  end;
end;

function TFrmModDepartTime.qryDepartime(scheduleplanid, departstationid: int64): boolean;
begin
  with jscdQryDepart do
  begin
    active := false;
    Params.ParamByName('scheduleplanid').Value := scheduleplanid;
    Params.ParamByName('departstationid').Value := departstationid;
    Params.ParamByName('fromdate').Value := fromdate;
    Params.ParamByName('enddate').Value := enddate;
    active := true;
    if recordcount > 0 then
    begin
      result := true;
    end
    else
      result := false;
  end;

end;

end.
