unit UFrmVehiclespace;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  PrnDbgeh, ImgList, GridsEh, DBGridEh, StdCtrls, ComCtrls, ToolWin, ExtCtrls,
  NovaEdit, UFrmVehiclespaceAdd,Services,UDMPublic,PubFn,jpeg,Math, NvPrnDbgeh,
  NvDbgridEh;

type
  TFrmVehiclespace = class(TSimpleCRUDForm)
    lblname: TLabel;
    nvedtname: TNovaEdit;
    cbispassengerseat: TCheckBox;
    cbisnotpassengerseat: TCheckBox;
    jcdsVehiclespacedelete: TjsonClientDataSet;
    jcdsseattype: TjsonClientDataSet;
    jcdsResultid: TLargeintField;
    jcdsResultname: TWideStringField;
    jcdsResultISPASSENGERSEAT: TBooleanField;
    jcdsResultseattype: TWideStringField;
    jcdsResultisactive: TBooleanField;
    jcdsResultislocaldelete: TBooleanField;
    jcdsResultorgid: TLargeintField;
    jcdsResultseattypename: TWideStringField;
    jcdsResultroadupdateby: TLargeintField;
    jcdsResultroadcreateby: TLargeintField;
    jcdsResultupdatetime: TDateTimeField;
    jcdsResultcreatetime: TDateTimeField;
    jcdsResultpicture: TBlobField;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure dbgrdhResultColumns2AdvDrawDataCell(Sender: TCustomDBGridEh; Cell,
      AreaCell: TGridCoord; Column: TColumnEh; const ARect: TRect;
      var Params: TColCellParamsEh; var Processed: Boolean);
    procedure dbgrdhResultGetRowHeight(Sender: TObject; var RowHeight: Integer);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure HandleAuthority(const Key:TGUID;aEnable:Boolean);override;
  end;

var
  FrmVehiclespace: TFrmVehiclespace;

implementation

{$R *.dfm}

procedure TFrmVehiclespace.dbgrdhResultColumns2AdvDrawDataCell(
  Sender: TCustomDBGridEh; Cell, AreaCell: TGridCoord; Column: TColumnEh;
  const ARect: TRect; var Params: TColCellParamsEh; var Processed: Boolean);
var
  HexStr: String;
  jpg:TJPEGImage;
begin
  inherited;
  HexStr := jcdsResult.FieldByName('picture').AsString;
  Sender.Canvas.FillRect(ARect);
  if HexStr<>'' then
  begin
    jpg:=HexStrToJpg(HexStr);
    Sender.Canvas.Draw(ARect.Left,max(ARect.Top,trunc(ARect.Top+(ARect.Bottom-ARect.Top-jpg.Height)/2)),jpg);
  end;
  Processed:=true;
end;

procedure TFrmVehiclespace.dbgrdhResultGetRowHeight(Sender: TObject;
  var RowHeight: Integer);
var
  HexStr: String;
  jpg:TJPEGImage;
begin
  inherited;
  HexStr := jcdsResult.FieldByName('picture').AsString;
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

procedure TFrmVehiclespace.FormShow(Sender: TObject);
begin
  inherited;
  jcdsseattype.Active:=true;
end;

procedure TFrmVehiclespace.HandleAuthority(const Key: TGUID; aEnable: Boolean);
begin
  inherited;
  if GUIDToString(key)='{E78BD50A-E88C-4F2D-A05E-296E6DAABCB0}' then //添加
  begin
    tbtnInsert.Enabled:=aEnable;
  end
  else if GUIDToString(key)='{C2F19A6E-6E35-4FF3-9ABE-0D45C93AFA2E}' then //修改
  begin
    tbtnEdit.Enabled:=aEnable;
  end
  else if GUIDToString(key)='{139B7492-705B-4607-89F0-C492625F4A53}' then //删除
  begin
    tbtnDelete.Enabled:=aEnable;
  end;
end;

procedure TFrmVehiclespace.tbtnDeleteClick(Sender: TObject);
begin
  inherited;
  if (jcdsResult.Active=True) and (jcdsResult.RecNo>0) then
  begin
    if not SysDialogs.Confirm('提示','确定要删除该车辆内部空间类型吗？') then
    begin
      exit;
    end;
    with jcdsVehiclespacedelete do
    begin
      Params.ParamValues['vehiclespace.id']:=jcdsResult.FieldByName('id').AsString;
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
    SysDialogs.ShowInfo('请先选择需要删除的记录！');
  end;;
end;

procedure TFrmVehiclespace.tbtnEditClick(Sender: TObject);
var id:integer;
begin
  inherited;
  if (jcdsResult.Active=True) and (jcdsResult.RecNo>0) then
  begin
    FrmVehiclespaceAdd:=TFrmVehiclespaceAdd.Create(self,self.functionItem);
    try
      with FrmVehiclespaceAdd do
      begin
        Caption:='修改车辆内部空间类型';
        edittype:=Tedittype.update;
        id := self.jcdsResult.FieldByName('id').AsString;
        orgid := self.jcdsResult.FieldByName('orgid').AsString;
        isactive := self.jcdsResult.FieldByName('isactive').AsString;
        islocaldelete := self.jcdsResult.FieldByName('islocaldelete').AsString;
        createby := self.jcdsResult.FieldByName('createby').AsString;
        createtime := self.jcdsResult.FieldByName('createtime').AsString;
        updateby := self.jcdsResult.FieldByName('updateby').AsString;
        updatetime := self.jcdsResult.FieldByName('updatetime').AsString;
        picture := self.jcdsResult.FieldByName('picture').AsString;
        nvedtname.Text := self.jcdsResult.FieldByName('name').AsString;
        cbispassengerseat.Checked := StrToBool(self.jcdsResult.FieldByName('ispassengerseat').AsString);
        cbispassengerseatClick(cbispassengerseat);
        if cbispassengerseat.Checked then
        begin
          nvcbbseattype.SetItemIndexByCode(self.jcdsResult.FieldByName('seattype').AsString);
        end
        else
        begin
          nvcbbseattype.ItemIndex:=-1;
        end;
        nvedtname.Enabled:=false;
      end;
      if SysMainForm.showFormModal(FrmVehiclespaceAdd,false)=mrok then
      begin
        id := FrmVehiclespaceAdd.operationid;
        tbtnFilter.Click;
        self.jcdsResult.Locate('id',id,[]);
      end;
    finally
      FreeAndNil(FrmVehiclespaceAdd);
    end;
  end
  else
  begin
    SysDialogs.ShowInfo('请先选择需要修改的记录！');
  end;
end;

procedure TFrmVehiclespace.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active:=false;
//    if cbisnotpassengerseat.Checked then
//    begin
//      if cbispassengerseat.Checked then
//      begin
//        ;
//      end
//      else
//      begin
//        Params.ParamValues['filter_EQB_vs!ispassengerseat']:='false';
//      end;
//    end
//    else
//    begin
//      if cbispassengerseat.Checked then
//      begin
//        Params.ParamValues['filter_EQB_vs!ispassengerseat']:='true';
//      end
//      else
//      begin
//        Exit;
//      end;
//    end;

    if not cbisnotpassengerseat.Checked  and cbispassengerseat.Checked  then//是否乘客座位
      begin
         Params.ParamValues['filter_EQB_vs!ispassengerseat']:='true';
      end
      else if not cbispassengerseat.Checked  and cbisnotpassengerseat.Checked then
      begin
         Params.ParamValues['filter_EQB_vs!ispassengerseat']:='false';
      end
      else
      begin
         Params.ParamValues['filter_EQB_vs!ispassengerseat']:='';
      end;


    Params.ParamValues['filter_LIKES_vs!name']:=Trim(nvedtname.Text);
    Active:=true;
  end;
end;

procedure TFrmVehiclespace.tbtnInsertClick(Sender: TObject);
var id:integer;
begin
  inherited;
  FrmVehiclespaceAdd:=TFrmVehiclespaceAdd.Create(self,self.functionItem);
  try
    with FrmVehiclespaceAdd do
    begin
      Caption:='添加车辆内部空间类型';
      edittype:=Tedittype.add;
    end;
    if SysMainForm.showFormModal(FrmVehiclespaceAdd,false)=mrok then
    begin
      id := FrmVehiclespaceAdd.operationid;
      tbtnFilter.Click;
      self.jcdsResult.Locate('id',id,[]);
    end;
  finally
    FreeAndNil(FrmVehiclespaceAdd);
  end;
end;

end.
