unit UFrmPlusScheduleStation;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls,
  DBGridEhGrouping, GridsEh, DBGridEh, NvDbgridEh, NovaEdit, DB, DBClient,
  jsonClientDataSet;

type
  TFrmPlusScheduleStaion = class(TSimpleEditForm)
    grp4: TGroupBox;
    nvdbgrdh3: TNvDbgridEh;
    jscdQryStation: TjsonClientDataSet;
    ds3: TDataSource;
    jscdUpdateSchedulestop: TjsonClientDataSet;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
     scheduleid,endstationid: Int64;
  end;

var
  FrmPlusScheduleStaion: TFrmPlusScheduleStaion;

implementation
uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmPlusScheduleStaion.bbtnSaveClick(Sender: TObject);
var
  stationids:string;
  nResult: integer;
  sResult: string;
begin
  inherited;
  if jscdQryStation.RecordCount=0 then
    exit;
   stationids:='';
   with jscdQryStation do
  begin
    First;
    while not Eof do
    begin
       if (FieldByName('stationid').AsLargeInt=endstationid)
         and (not (FieldByName('isselect').AsBoolean)) then
       begin
         SysDialogs.ShowMessage('终点站必须选中！');
         exit;
       end;

       if not (FieldByName('isselect').AsBoolean) then
       begin
          stationids:=stationids+','+FieldByName('id').AsString;
       end;
       next;
    end;
  end;
  if Length(stationids)>0 then
  begin
    stationids:=Copy(stationids,2, Length(stationids)) ;
  end ;

   try
     with jscdUpdateSchedulestop do
     begin
       Active:=false;
       Params.ParamValues['scheduleid']:= scheduleid;
       Params.ParamValues['stationids']:= stationids;
       Execute;
       nResult:=Params.ParamValues['flag'];
       sResult:=Params.ParamValues['msg'];
       if nResult=1 then
       begin
         SysDialogs.ShowMessage(sResult);
         ModalResult := mrok;
       end
       else
       begin
        SysDialogs.Warning(sResult);
       end;
     end;
   except
    on E: Exception do
    begin
      SysLog.WriteErr('修改加班班次停靠站点信息'+e.Message);
    end;
  end;

end;

procedure TFrmPlusScheduleStaion.FormShow(Sender: TObject);
begin
  inherited;
  with jscdQryStation do
  begin
    Active:=false;
    Params.ParamValues['scheduleid']:=scheduleid;
    Active:=true;
  end;
end;
end.
