unit UFrmVehiclespacesoldpicture;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, UFrmVehiclespacesoldpictureEdit, NovaHComboBox;

type
  TFrmVehiclespacesoldpicture = class(TSimpleCRUDForm)
    jcdsdelete: TjsonClientDataSet;
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure dbgrdhResultColumns14AdvDrawDataCell(Sender: TCustomDBGridEh;
      Cell, AreaCell: TGridCoord; Column: TColumnEh; const ARect: TRect;
      var Params: TColCellParamsEh; var Processed: Boolean);
    procedure dbgrdhResultGetRowHeight(Sender: TObject; var RowHeight: Integer);
    procedure tbtnFilterClick(Sender: TObject);
  private
    log : String;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmVehiclespacesoldpicture: TFrmVehiclespacesoldpicture;

implementation

uses Services, PubFn, UDMPublic, jpeg, Math;
{$R *.dfm}

procedure TFrmVehiclespacesoldpicture.dbgrdhResultColumns14AdvDrawDataCell(
  Sender: TCustomDBGridEh; Cell, AreaCell: TGridCoord; Column: TColumnEh;
  const ARect: TRect; var Params: TColCellParamsEh; var Processed: Boolean);
var
  HexStr: String;
  jpg:TJPEGImage;
begin
  inherited;
  HexStr := jcdsResult.FieldByName('soldpicture').AsString;
  Sender.Canvas.FillRect(ARect);
  if HexStr<>'' then
  begin
    jpg:=HexStrToJpg(HexStr);
    Sender.Canvas.Draw(ARect.Left,max(ARect.Top,trunc(ARect.Top+(ARect.Bottom-ARect.Top-jpg.Height)/2)),jpg);
  end;
  Processed:=true;
end;

procedure TFrmVehiclespacesoldpicture.dbgrdhResultGetRowHeight(Sender: TObject;
  var RowHeight: Integer);
var
  HexStr: String;
  jpg:TJPEGImage;
begin
  inherited;
  HexStr := jcdsResult.FieldByName('soldpicture').AsString;
//  SysDialogs.ShowMessage('getrowheight');;
  if HexStr<>'' then
  begin
    jpg:=HexStrToJpg(HexStr);
    if RowHeight<jpg.Height then
    begin
      RowHeight:=jpg.Height;
    end;
  end;
end;

procedure TFrmVehiclespacesoldpicture.tbtnDeleteClick(Sender: TObject);
begin
  inherited;
  if (jcdsResult.Active=True) and (jcdsResult.RecNo>=0) then
  begin
    if not SysDialogs.Confirm('提示','确定要删除该车辆座位空间售出图片吗？') then
    begin
      exit;
    end;
    with jcdsdelete do
    begin
      Params.ParamValues['vehiclespacesoldpicture.id']:=jcdsResult.FieldByName('id').AsString;
      Execute;
      if Params.ParamValues['msg']<>'' then
      begin
        SysDialogs.ShowMessage(Params.ParamValues['msg']);
      end;
      if Params.ParamValues['flag']=1 then
      begin
        log := '删除车辆座位空间售出图片：车辆内部空间名称='+jcdsResult.FieldByName('spacename').AsString+
        ',票种名称='+jcdsResult.FieldByName('typename').AsString;
        SysLog.WriteLog('业务管理——>车辆座位空间售出图片','删除',log);
        tbtnFilter.Click;
      end;
    end;
//    jcdsResult.Delete;
//    jcdsResult.ApplyUpdates(0);
  end
  else
  begin
    SysDialogs.ShowError('请先选择需要删除的记录！');
  end;
end;

procedure TFrmVehiclespacesoldpicture.tbtnEditClick(Sender: TObject);
var id:Integer;
begin
  inherited;
  if (jcdsResult.Active=True) and (jcdsResult.RecNo>=0) then
  begin
    FrmVehiclespacesoldpictureEdit:=TFrmVehiclespacesoldpictureEdit.Create(self,self.functionItem);
    try
      with FrmVehiclespacesoldpictureEdit do
      begin
        Caption:='修改车辆座位空间售出图片';
        edittype:=Tedittype.update;
        cbbvehiclespace.Text:=jcdsResult.FieldByName('spacename').AsString;
        cbbticket.Text := jcdsResult.FieldByName('typename').AsString;
        id:=jcdsResult.FieldByName('id').AsInteger;
        typeid:=jcdsResult.FieldByName('ticktypeid').AsString;
        spaceid:=jcdsResult.FieldByName('vehiclespaceid').AsString;
        picture:=jcdsResult.FieldByName('soldpicture').AsString;
        isactive:=jcdsResult.FieldByName('isactive').AsString;
        islocaldelete:=jcdsResult.FieldByName('islocaldelete').AsString;
        createby:=jcdsResult.FieldByName('createby').AsString;
        createtime:=jcdsResult.FieldByName('createtime').AsString;
        cbbvehiclespace.Enabled:=false;
        cbbticket.Enabled:=false;
      end;
      if SysMainForm.showFormModal(FrmVehiclespacesoldpictureEdit,false)=mrok then
      begin
        id := FrmVehiclespacesoldpictureEdit.operationid;
        tbtnFilter.Click;
        jcdsResult.Locate('id',inttostr(id),[]);
      end;
    finally
      FreeAndNil(FrmVehiclespacesoldpictureEdit);
    end;
  end
  else
  begin
    SysDialogs.ShowError('请先选择需要修改的记录！');
  end;
end;

procedure TFrmVehiclespacesoldpicture.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active := False;
    Active := True;
  end;
end;

procedure TFrmVehiclespacesoldpicture.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  try
    FrmVehiclespacesoldpictureEdit := TFrmVehiclespacesoldpictureEdit.Create(Self);
    FrmVehiclespacesoldpictureEdit.Caption := '车辆座位空间售出图片';
    if SysMainForm.showFormModal(FrmVehiclespacesoldpictureEdit,false)=mrOk then
    begin
      tbtnFilter.Click;
    end;
  finally
    FreeAndNil(FrmVehiclespacesoldpictureEdit);
  end;
end;

end.
