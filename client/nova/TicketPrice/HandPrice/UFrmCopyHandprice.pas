unit UFrmCopyHandprice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, NovaEdit,
  ComCtrls, NovaListView, DB, DBClient, jsonClientDataSet, DBGridEhGrouping,
  GridsEh, DBGridEh, NvDbgridEh;

type
  TFrmCopyHandprice = class(TSimpleEditForm)
    grp1: TGroupBox;
    grp2: TGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    NovaEdtRoute: TNovaEdit;
    NovaEditSchedule: TNovaEdit;
    NovaEdtTime: TNovaEdit;
    jcsdQrySchedule: TjsonClientDataSet;
    nvdbgrdh1: TNvDbgridEh;
    ds1: TDataSource;
    grp3: TGroupBox;
    grp4: TGroupBox;
    chkCheckAll: TCheckBox;
    nvdbgrdh2: TNvDbgridEh;
    nvdbgrdh3: TNvDbgridEh;
    ds2: TDataSource;
    ds3: TDataSource;
    jcsdQryVehicletype: TjsonClientDataSet;
    jscdQryStation: TjsonClientDataSet;
    jsonCopyHandprice: TjsonClientDataSet;
    procedure FormShow(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure chkCheckAllClick(Sender: TObject);
  private
    { Private declarations }
    function getIds(jscdQryDate:TjsonClientDataSet):String;
  public
    { Public declarations }
        createby,routeid: Int64;
  end;

var
  FrmCopyHandprice: TFrmCopyHandprice;

implementation
uses PubFn, Services, UDMPublic;
{$R *.dfm}

procedure TFrmCopyHandprice.bbtnSaveClick(Sender: TObject);
var
  scheduleids,vehicletypeids,stationids:string;
  nResult: integer;
  sResult: string;
begin
  inherited;
  if jcsdQrySchedule.RecordCount=0 then
    exit;
      if jcsdQryVehicletype.RecordCount=0 then
    exit;
      if jscdQryStation.RecordCount=0 then
    exit;
   vehicletypeids:='';
  scheduleids:='';
  stationids:='';
   vehicletypeids:= getIds(jcsdQryVehicletype);
   if vehicletypeids='' then
   begin
     SysDialogs.ShowMessage('请选择车型！');
     exit;
   end;
   stationids:= getIds(jscdQryStation);
   if stationids='' then
   begin
     SysDialogs.ShowMessage('请选择停靠站点！');
     exit;
   end;
    scheduleids:= getIds(jcsdQrySchedule);
   if scheduleids='' then
   begin
     SysDialogs.ShowMessage('请选择班次！');
     exit;
   end;
   vehicletypeids:='('+vehicletypeids+')';
   stationids:='('+stationids+')';

   try
     with jsonCopyHandprice do
     begin
       Active:=false;
       Params.ParamValues['scheduleid']:= NovaEditSchedule.Id;
       Params.ParamValues['vehicletypeids']:= vehicletypeids;
       Params.ParamValues['stationids']:= stationids;
       Params.ParamValues['scheduleids']:= scheduleids;
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
      SysLog.WriteErr('复制平时票价信息失败：' + E.Message);
    end;
  end;
end;

procedure TFrmCopyHandprice.chkCheckAllClick(Sender: TObject);
begin
  inherited;
  if chkCheckAll.Checked then
  begin
     if (jcsdQrySchedule.Active)
        and (jcsdQrySchedule.RecordCount>0) then
     begin
       with jcsdQrySchedule do
       begin
         First;
         while not Eof do
         begin
           Edit;
           FieldValues['isselect']:=true;
           Next;
         end;
       end;
     end;
  end
  else
  begin
     if (jcsdQrySchedule.Active)
        and (jcsdQrySchedule.RecordCount>0) then
     begin
       with jcsdQrySchedule do
       begin
         First;
         while not Eof do
         begin
           Edit;
           FieldValues['isselect']:=false;
           Next;
         end;
       end;
     end;
  end;
end;

procedure TFrmCopyHandprice.FormShow(Sender: TObject);
begin
  inherited;
  with jcsdQrySchedule do
  begin
    Active:=false;
    Params.ParamValues['routeid']:=routeid;
    Params.ParamValues['scheduleid']:=NovaEditSchedule.Id;
    Active:=true;
  end;
  with jcsdQryVehicletype do
  begin
    Active:=false;
    Params.ParamValues['scheduleid']:=NovaEditSchedule.Id;
    Active:=true;
  end;
  with jscdQryStation do
  begin
    Active:=false;
    Params.ParamValues['scheduleid']:=NovaEditSchedule.Id;
    Active:=true;
  end;


end;

function TFrmCopyHandprice.getIds(jscdQryDate: TjsonClientDataSet): String;
var
  ids:string;
begin
  ids:='';
  with jscdQryDate do
  begin
    First;
    while not Eof do
    begin
       if(FieldByName('isselect').AsBoolean) then
       begin
          ids:=ids+','+FieldByName('id').AsString;
       end;
       next;
    end;
  end;
  if Length(ids)>0 then
  begin
    ids:=Copy(ids,2, Length(ids)) ;
    result:=ids;
  end
  else
    Result:='';
end;

end.
