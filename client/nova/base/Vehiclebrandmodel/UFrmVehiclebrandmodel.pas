unit UFrmVehiclebrandmodel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  PrnDbgeh, ImgList, GridsEh, DBGridEh, StdCtrls, ComCtrls, ToolWin, ExtCtrls,
  NovaEdit, UFrmVehiclebrandmodelAdd,UDMPublic,Services,PubFn, NvPrnDbgeh,
  NvDbgridEh;

type
  TFrmVehiclebrandmodel = class(TSimpleCRUDForm)
    lblbrandname: TLabel;
    nvedtbrandmodel: TNovaEdit;
    jcdsdelete: TjsonClientDataSet;
    pnlpicture: TPanel;
    imgpicture: TImage;
    jscdIsUsed: TjsonClientDataSet;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
    procedure jcdsResultAfterClose(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure HandleAuthority(const Key:TGUID;aEnable:Boolean);override;
  end;

var
  FrmVehiclebrandmodel: TFrmVehiclebrandmodel;

implementation

{$R *.dfm}

procedure TFrmVehiclebrandmodel.HandleAuthority(const Key: TGUID;
  aEnable: Boolean);
begin
  inherited;
  if GUIDToString(key)='{3945519A-E435-4383-9105-3CEC4D72E4ED}' then //添加
  begin
    tbtnInsert.Enabled:=aEnable;
  end
  else if GUIDToString(key)='{36514235-6A8B-4044-BD10-8D061AE95ED8}' then //修改
  begin
    tbtnEdit.Enabled:=aEnable;
  end
  else if GUIDToString(key)='{7EEFBEE6-0285-41FB-8605-5F4DAF644567}' then //删除
  begin
    tbtnDelete.Enabled:=aEnable;
  end;
end;

procedure TFrmVehiclebrandmodel.jcdsResultAfterClose(DataSet: TDataSet);
begin
  inherited;
  pnlpicture.Visible:=False;
end;

procedure TFrmVehiclebrandmodel.jcdsResultAfterScroll(DataSet: TDataSet);
var
  HexStr: String;
begin
  inherited;
  HexStr := jcdsResult.FieldByName('picture').AsString;
  if HexStr<>'' then
  begin
    imgpicture.Picture.Assign(HexStrToJpg(HexStr));
    pnlpicture.Height:=imgpicture.Picture.Graphic.Height;
    pnlpicture.Width:=imgpicture.Picture.Graphic.Width;
//    pnlpicture.Top:=(dbgrdhResult.Row-dbgrdhResult.TopRow+2)*dbgrdhResult.RowHeight+dbgrdhResult.Top;
//    pnlpicture.Left:=dbgrdhResult.Left+dbgrdhResult.Width-pnlpicture.Width;
    pnlpicture.Visible:=True;
  end
  else
  begin
    imgpicture.Picture.Bitmap.Assign(nil);
    pnlpicture.Visible:=false;
  end;
end;

procedure TFrmVehiclebrandmodel.tbtnDeleteClick(Sender: TObject);
begin
  inherited;
  if (jcdsResult.Active=True) and (jcdsResult.RecNo>0) then
  begin
    if not SysDialogs.Confirm('提示','确定要删除该车辆品牌型号吗？') then
    begin
      exit;
    end;
    with jcdsdelete do
    begin
      Params.ParamValues['vehiclebrandmodel.id']:=jcdsResult.FieldByName('id').AsString;
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
//    jcdsResult.Delete;
//    jcdsResult.ApplyUpdates(0);
  end
  else
  begin
    SysDialogs.ShowInfo('请先选择需要删除的记录！');
  end;;
end;

procedure TFrmVehiclebrandmodel.tbtnEditClick(Sender: TObject);
var id:Integer;
begin
  inherited;
  if (jcdsResult.Active=True) and (jcdsResult.RecNo>0) then
  begin
    with jscdIsUsed do
    begin
      close;
      Params.ParamValues['vehiclebrandmodel.id']:=jcdsResult.FieldByName('id').AsString;
      Execute;
      if Params.ParamValues['flag']=1 then
      begin
          if not SysDialogs.Confirm('提示','该车辆品牌型号的座位数已经使用，确定还要进行修改吗？') then
          begin
            exit;
          end;
      end;
    end;
    FrmVehiclebrandmodelAdd:=TFrmVehiclebrandmodelAdd.Create(self,self.functionItem);
    try
      with FrmVehiclebrandmodelAdd do
      begin
        Caption:='修改车辆品牌型号';
        edittype:=Tedittype.update;
        nvedtbrandname.Text:=self.jcdsResult.FieldByName('BRANDNAME').AsString;
        nvedtmodelcode.Text:=self.jcdsResult.FieldByName('MODELCODE').AsString;
        nvedtrationseatnum.Text:=self.jcdsResult.FieldByName('rationseatnum').AsString;
        memremarks.Text:=self.jcdsResult.FieldByName('remarks').AsString;
        NovaHCobVehicletype.SetItemIndexByField('id',jcdsResult.FieldByName('vehicletypeid').AsLargeInt) ;
        id:=self.jcdsResult.FieldByName('id').AsString;
        orgid:=self.jcdsResult.FieldByName('orgid').AsString;
        picture:=self.jcdsResult.FieldByName('picture').AsString;
        isactive:=self.jcdsResult.FieldByName('isactive').AsString;
        islocaldelete:=self.jcdsResult.FieldByName('islocaldelete').AsString;
        createby:=self.jcdsResult.FieldByName('createby').AsString;
        createtime:=self.jcdsResult.FieldByName('createtime').AsString;
        updateby:=self.jcdsResult.FieldByName('updateby').AsString;
        updatetime:=self.jcdsResult.FieldByName('updatetime').AsString;
        synccode:=self.jcdsResult.FieldByName('synccode').AsString;
        nvedtbrandname.Enabled:=false;
        nvedtmodelcode.Enabled:=false;
      end;
      if SysMainForm.showFormModal(FrmVehiclebrandmodelAdd,false)=mrok then
      begin
        id := FrmVehiclebrandmodelAdd.operationid;
        tbtnFilter.Click;
        jcdsResult.Locate('id',inttostr(id),[]);
      end;
    finally
      FreeAndNil(FrmVehiclebrandmodelAdd);
    end;
  end
  else
  begin
    SysDialogs.ShowInfo('请先选择需要修改的记录！');
  end;
end;

procedure TFrmVehiclebrandmodel.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active:=false;
    Params.ParamValues['filter_LIKES_vb!brandname_OR_vb!modelcode_OR_vb!remarks']:=Trim(nvedtbrandmodel.Text);
    Active:=true;
    if RecordCount<=0 then
    begin
      pnlpicture.Visible:=False;
    end;
  end;
end;

procedure TFrmVehiclebrandmodel.tbtnInsertClick(Sender: TObject);
var id:Integer;
begin
  inherited;
  FrmVehiclebrandmodelAdd:=TFrmVehiclebrandmodelAdd.Create(self,self.functionItem);
  try
    FrmVehiclebrandmodelAdd.Caption:='添加车辆品牌型号';
    FrmVehiclebrandmodelAdd.edittype:=Tedittype.add;
    if SysMainForm.showFormModal(FrmVehiclebrandmodelAdd,false)=mrOk then
    begin
      id := FrmVehiclebrandmodelAdd.operationid;
      tbtnFilter.Click;
      jcdsResult.Locate('id',id,[]);
    end;
  finally
    FreeAndNil(FrmVehiclebrandmodelAdd);
  end;
end;

end.
