unit UFrmVehicleseatplan;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  PrnDbgeh, ImgList, GridsEh, DBGridEh, StdCtrls, ComCtrls, ToolWin, ExtCtrls,
  NovaEdit,UDMPublic, Grids, NvPrnDbgeh, NvDbgridEh, UFrmVehicleseatplanAdd,
  Services, SeatPlan,math;

type
  TFrmVehicleseatplan = class(TSimpleCRUDForm)
    lblbrandname: TLabel;
    nvedtbrandmodel: TNovaEdit;
    cbhasseatplan: TCheckBox;
    pnlpicture:TPanel;
    spl1: TSplitter;
    jcdsdelete: TjsonClientDataSet;
    procedure tbtnFilterClick(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure pnlpictureResize(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
  private
    { Private declarations }
    seatPlan:TSeatPlan;
    vehicleSeatPlanDecorato:TVehicleSeatPlanDecorator;
    procedure startSetSeatPlan;
  public
    { Public declarations }
    procedure HandleAuthority(const Key:TGUID;aEnable:Boolean);override;
  end;

var
  FrmVehicleseatplan: TFrmVehicleseatplan;

implementation

const
      vehicletail_picturename = 'images\vehicletail.bmp';
      vehiclehead_picturename = 'images\vehiclehead.bmp';

{$R *.dfm}

procedure TFrmVehicleseatplan.HandleAuthority(const Key: TGUID;
  aEnable: Boolean);
begin
  inherited;
  if GUIDToString(key)='{8AC7EE85-3041-4A12-BD41-B7396DE43A69}' then //添加
  begin
    tbtnInsert.Enabled:=aEnable;
  end
  else if GUIDToString(key)='{54F3A157-B9CB-4639-A8F8-8E8845046AE6}' then //设置
  begin
    tbtnEdit.Enabled:=aEnable;
  end
  else if GUIDToString(key)='{171C3EE2-DB21-422D-93AA-9F2C5E0D8F61}' then //删除
  begin
    tbtnDelete.Enabled:=aEnable;
  end;
end;

procedure TFrmVehicleseatplan.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
  if not Assigned(vehicleSeatPlanDecorato) then
  begin
    seatPlan:=TSeatPlan.Create(self);
//    seatPlan:=TSeatPlanSelect.Create(Self);
    vehicleSeatPlanDecorato:=TVehicleSeatPlanDecorator.Create(self,seatPlan);
    vehicleSeatPlanDecorato.setParent(pnlpicture);
    vehicleSeatPlanDecorato.showspacename:=false;
  end;

  if (jcdsResult.FieldByName('vehiclebrandmodelid').Value<>Null) then
  begin
    vehicleSeatPlanDecorato.brandModelid:=jcdsResult.FieldByName('vehiclebrandmodelid').AsLargeInt;
    pnlpicture.Height:=vehicleSeatPlanDecorato.actualheight;
    pnlpicture.visible:=true;
    spl1.Top:=pnlpicture.Top-spl1.Height;
    vehicleSeatPlanDecorato.Repaint;
    seatPlan.Repaint;
  end
  else
  begin
    pnlpicture.visible:=False;
  end;
end;

procedure TFrmVehicleseatplan.pnlpictureResize(Sender: TObject);
begin
  inherited;
  if Assigned(vehicleSeatPlanDecorato) then
  begin
    vehicleSeatPlanDecorato.Left:=(TWinControl(Sender).Width-vehicleSeatPlanDecorato.Width) div 2;
    vehicleSeatPlanDecorato.Top:=(TWinControl(Sender).Height-vehicleSeatPlanDecorato.Height) div 2;
  end;
end;

procedure TFrmVehicleseatplan.startSetSeatPlan;
var curid:Int64;
begin
  inherited;
  if (self.jcdsResult.Active=False) or (self.jcdsResult.RecordCount<0) then
  begin
    exit;
  end;
  curid:=self.jcdsResult.FieldByName('id').AsLargeInt;
  FrmVehicleseatplanAdd:=TFrmVehicleseatplanAdd.Create(self);
  with FrmVehicleseatplanAdd do
  begin
    try
      Caption:='设置座位图';
      brandModelid:=self.jcdsResult.FieldByName('id').AsLargeInt;
      rationseatnum:=self.jcdsResult.FieldByName('rationseatnum').AsInteger;
      nvedtbrand.Text:=self.jcdsResult.FieldByName('brandname').AsString;
      nvedtModel.Text:=self.jcdsResult.FieldByName('modelcode').AsString;
      if SysMainForm.showFormModal(FrmVehicleseatplanAdd,False)=mrOk then
      begin
        self.tbtnFilter.Click;
        self.jcdsResult.Locate('id',curid,[]);
      end;
    finally
      FreeAndNil(FrmVehicleseatplanAdd);
    end;
  end;
end;

procedure TFrmVehicleseatplan.tbtnDeleteClick(Sender: TObject);
begin
  inherited;
  if (jcdsResult.Active=True) and (jcdsResult.RecNo>0) then
  begin
    if not SysDialogs.Confirm('提示','确定要删除该座位图吗？') then
    begin
      exit;
    end;
    if (jcdsResult.FieldByName('vehiclebrandmodelid').Value<>Null) then
    begin
      with jcdsdelete do
      begin
        Params.ParamValues['vehicleseatplan.vehiclebrandmodelid']:=jcdsResult.FieldByName('vehiclebrandmodelid').AsLargeInt;
        Execute;
        if Params.ParamValues['msg']<>'' then
        begin
          SysDialogs.ShowMessage(Params.ParamValues['msg']);
        end;
        if Params.ParamValues['flag']=1 then
        begin
          tbtnFilter.Click;
        end;
      end;
    end
    else
    begin
      SysDialogs.ShowInfo('该品牌型号没有设置座位图！');
      exit;
    end;
  end
  else
  begin
    SysDialogs.ShowInfo('请先选择需要删除的记录！');
  end;;

end;

procedure TFrmVehicleseatplan.tbtnEditClick(Sender: TObject);
begin
  inherited;
  startSetSeatPlan;
end;

procedure TFrmVehicleseatplan.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active:=false;
    if cbhasseatplan.Checked then
    begin
      Params.ParamValues['filter_EQI_vs!isactive']:='1';
    end
    else
    begin
      Params.ParamValues['filter_EQI_vs!isactive']:=Null;
    end;
    Params.ParamValues['filter_LIKES_vb!brandname_OR_vb!modelcode_OR_vb!remarks']:=Trim(nvedtbrandmodel.Text);
    Active:=true;
  end;
end;

end.
