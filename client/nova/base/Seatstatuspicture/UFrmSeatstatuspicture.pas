unit UFrmSeatstatuspicture;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, UFrmSeatstatuspictureEdit, UDMPublic, NovaComboBox;

type
  TFrmSeatstatuspicture = class(TSimpleCRUDForm)
    jcdsdelete: TjsonClientDataSet;
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure dbgrdhResultColumns12AdvDrawDataCell(Sender: TCustomDBGridEh;
      Cell, AreaCell: TGridCoord; Column: TColumnEh; const ARect: TRect;
      var Params: TColCellParamsEh; var Processed: Boolean);
    procedure dbgrdhResultGetRowHeight(Sender: TObject; var RowHeight: Integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSeatstatuspicture: TFrmSeatstatuspicture;

implementation

uses Services, PubFn, Math;
{$R *.dfm}

procedure TFrmSeatstatuspicture.dbgrdhResultColumns12AdvDrawDataCell(
  Sender: TCustomDBGridEh; Cell, AreaCell: TGridCoord; Column: TColumnEh;
  const ARect: TRect; var Params: TColCellParamsEh; var Processed: Boolean);
var
  HexStr: String;
  jpg:TBitmap;
begin
  inherited;
  HexStr := jcdsResult.FieldByName('picture').AsString;
  Sender.Canvas.FillRect(ARect);
  if HexStr<>'' then
  begin
    jpg:=HexStrToGraphic(HexStr);
    Sender.Canvas.Draw(ARect.Left,max(ARect.Top,trunc(ARect.Top+(ARect.Bottom-ARect.Top-jpg.Height)/2)),jpg);
  end;
  Processed:=true;
end;

procedure TFrmSeatstatuspicture.dbgrdhResultGetRowHeight(Sender: TObject;
  var RowHeight: Integer);
var
  HexStr: String;
  bmp:TBitmap;
begin
  inherited;
  HexStr := jcdsResult.FieldByName('picture').AsString;
//  SysDialogs.ShowMessage('getrowheight');;
  if HexStr<>'' then
  begin
    bmp:=HexStrToGraphic(HexStr);
    if RowHeight<bmp.Height then
    begin
      RowHeight:=bmp.Height;
    end;
  end;
end;

procedure TFrmSeatstatuspicture.tbtnDeleteClick(Sender: TObject);
begin
  inherited;
  if (jcdsResult.Active=True) and (jcdsResult.RecNo>=0) then
  begin
    if not SysDialogs.Confirm('提示','确定要删除车辆默认座位状态图片？') then
    begin
      exit;
    end;
    with jcdsdelete do
    begin
      Params.ParamValues['seatstatuspicture.seatstatus']:=jcdsResult.FieldByName('seatstatus').AsString;
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
    SysDialogs.ShowError('请先选择需要删除的记录！');
  end;
end;

procedure TFrmSeatstatuspicture.tbtnEditClick(Sender: TObject);
var i, id:Integer;
begin
  inherited;
  if (jcdsResult.Active=True) and (jcdsResult.RecNo>=0) then
  begin
    FrmSeatstatuspictureEdit:=TFrmSeatstatuspictureEdit.Create(self,self.functionItem);
    try
      with FrmSeatstatuspictureEdit do
      begin
        Caption:='修改默认座位状态图片';
        edittype:=Tedittype.update;
        //cbbseatstatus.Text:=self.jcdsResult.FieldByName('seatstatusname').AsString;
        for i := 0 to cbbseatstatus.Items.Count - 1 do
        begin
          try
            if TCommInfo(cbbseatstatus.Items.Objects[i]).Value= jcdsResult.FieldByName('seatstatus').AsString then
            begin
              cbbseatstatus.ItemIndex:= i;
              break;
            end;
          except

          end;
        end;

        orgid:=self.jcdsResult.FieldByName('orgid').AsString;
        picture:=self.jcdsResult.FieldByName('picture').AsString;
        isactive:=self.jcdsResult.FieldByName('isactive').AsString;
        islocaldelete:=self.jcdsResult.FieldByName('islocaldelete').AsString;
        createby:=self.jcdsResult.FieldByName('createby').AsString;
        createtime:=self.jcdsResult.FieldByName('createtime').AsString;
        cbbseatstatus.Enabled:=false;
      end;
      if SysMainForm.showFormModal(FrmSeatstatuspictureEdit,false)=mrok then
      begin
        id := FrmSeatstatuspictureEdit.seatstatus;
        tbtnFilter.Click;
        jcdsResult.Locate('seatstatus',inttostr(id),[]);
      end;
    finally
      FreeAndNil(FrmSeatstatuspictureEdit);
    end;
  end
  else
  begin
    SysDialogs.ShowError('请先选择需要修改的记录！');
  end;
end;

procedure TFrmSeatstatuspicture.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active := false;
    Active := true;
  end;
end;

procedure TFrmSeatstatuspicture.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  FrmSeatstatuspictureEdit:=TFrmSeatstatuspictureEdit.Create(self,self.functionItem);
  try
    FrmSeatstatuspictureEdit.Caption:='默认座位状态图片';
    FrmSeatstatuspictureEdit.edittype:=Tedittype.add;
    if SysMainForm.showFormModal(FrmSeatstatuspictureEdit,false)=mrOk then
    begin
      tbtnFilter.Click;
    end;
  finally
    FreeAndNil(FrmSeatstatuspictureEdit);
  end;
end;

end.
