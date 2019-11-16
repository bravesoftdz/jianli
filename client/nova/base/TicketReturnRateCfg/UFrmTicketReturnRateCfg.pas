unit UFrmTicketReturnRateCfg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  PrnDbgeh, ImgList, GridsEh, DBGridEh, StdCtrls, ComCtrls, ToolWin, ExtCtrls,
  UFrmTicketReturnRateCfgEdit, NvPrnDbgeh, NvDbgridEh, NovaEdit,
  NovaCheckedComboBox;

type
  TFrmTicketReturnRateCfg = class(TSimpleCRUDForm)
    jcdsdel: TjsonClientDataSet;
    Label2: TLabel;
    NovaCkbOrg: TNovaCheckedComboBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmTicketReturnRateCfg: TFrmTicketReturnRateCfg;

implementation

uses Services, PubFn,UDMPublic;
{$R *.dfm}

procedure TFrmTicketReturnRateCfg.FormShow(Sender: TObject);
begin
  inherited;
  NovaCkbOrg.Active := true;
end;

procedure TFrmTicketReturnRateCfg.tbtnDeleteClick(Sender: TObject);
begin
  inherited;
  if (jcdsResult.Active=True) and (jcdsResult.RecNo>0) then
  begin
    {if self.jcdsResult.FieldByName('timepoint').AsInteger=0 then
    begin
      SysDialogs.Warning('时间点为发车时间的记录不允许删除');
      Exit;
    end;  }
    if not SysDialogs.Confirm('提示','确定要删除该退票费率吗？') then
    begin
      exit;
    end;
    with jcdsdel do
    begin
      Params.ParamValues['ticketreturnrate.id']:=jcdsResult.FieldByName('id').AsString;
      Params.ParamValues['ticketreturnrate.timepoint']:=jcdsResult.FieldByName('timepoint').AsString;
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
  end;
end;

procedure TFrmTicketReturnRateCfg.tbtnEditClick(Sender: TObject);
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;

  FrmTicketReturnRateCfgEdit := TFrmTicketReturnRateCfgEdit.Create(self);
  try
    with FrmTicketReturnRateCfgEdit do
    begin
      Caption := '修改退票费率';
      edittype:=Tedittype.update;
      id:=self.jcdsResult.FieldByName('id').AsInteger;
      NovaCbbOrg.SetItemIndexByField('id',jcdsResult.FieldByName('orgid').AsLargeInt);
      createtime:=self.jcdsResult.FieldByName('createtime').AsString;
      createby:=self.jcdsResult.FieldByName('createby').AsString;
      updatetime:=self.jcdsResult.FieldByName('updatetime').AsString;
      updateby:=self.jcdsResult.FieldByName('updateby').AsString;

      nvedtprerate.Text:=self.jcdsResult.FieldByName('prerate100').AsString;
      cbbtimepoint.ItemIndex:=Abs(self.jcdsResult.FieldByName('timepoint').AsInteger);
      if self.jcdsResult.FieldByName('timepoint').AsInteger=0 then
      begin
        cbbtimepoint.Enabled:=false;
        cbbtimetag.Enabled:=false;
      end;
      if self.jcdsResult.FieldByName('timepoint').AsInteger>0 then
        cbbtimetag.ItemIndex:=0
      else
        cbbtimetag.ItemIndex:=1;
      NovaCbbOrg.Enabled:=false;
      ShowModal;
      if ModalResult = mrok then
      begin
        tbtnFilterClick(tbtnFilter);
        jcdsResult.Locate('id',id,[] );
      end;
    end;
  finally
    FreeAndNil(FrmTicketReturnRateCfgEdit);
  end;
end;

procedure TFrmTicketReturnRateCfg.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  if (NovaCkbOrg.CheckedCount=0) then
  begin
    SysDialogs.ShowMessage('请选择机构！');
    NovaCkbOrg.SetFocus;
    exit;
  end;
  with jcdsResult do
  begin
    Active := false;
    Params.ParamValues['filter_INS_o!id'] := NovaCkbOrg.GetSelectID;
    Active := true;
  end;
end;

procedure TFrmTicketReturnRateCfg.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  FrmTicketReturnRateCfgEdit := TFrmTicketReturnRateCfgEdit.Create(self);
  try
    with FrmTicketReturnRateCfgEdit do
    begin
      Caption := '添加退票费率';
      edittype:=Tedittype.add;
      cbbtimepoint.ItemIndex:=1;
      ShowModal;
      if ModalResult = mrok then
      begin
        tbtnFilterClick(tbtnFilter);
        jcdsResult.Locate('id', id, []);
      end;
    end;
  finally
    FreeAndNil(FrmTicketReturnRateCfgEdit);
  end;
end;

end.
