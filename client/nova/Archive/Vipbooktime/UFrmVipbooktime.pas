unit UFrmVipbooktime;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
  PrnDbgeh, ImgList, GridsEh, DBGridEh, StdCtrls, ComCtrls, ToolWin, ExtCtrls,
  UFrmVipbooktimeEdit, NvPrnDbgeh, NvDbgridEh, NovaEdit,
  NovaCheckedComboBox;

type
  TFrmVipbooktime = class(TSimpleCRUDForm)
    jcdsdel: TjsonClientDataSet;
    Label2: TLabel;
    NovaCkbOrg: TNovaCheckedComboBox;
    lbl3: TLabel;
    nvcbbvipgradename: TNovaCheckedComboBox;
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
  FrmVipbooktime: TFrmVipbooktime;

implementation

uses Services, PubFn,UDMPublic;
{$R *.dfm}

procedure TFrmVipbooktime.FormShow(Sender: TObject);
begin
  inherited;
  NovaCkbOrg.Active := true;
  nvcbbvipgradename.Active :=true;
end;

procedure TFrmVipbooktime.tbtnDeleteClick(Sender: TObject);
begin
  inherited;
  if (jcdsResult.Active=True) and (jcdsResult.RecNo>0) then
  begin
    if not SysDialogs.Confirm('提示','确定要删除该记录吗？') then
    begin
      exit;
    end;
    with jcdsdel do
    begin
      Params.ParamValues['vipbooktime.id']:=jcdsResult.FieldByName('id').AsString;
      Params.ParamValues['vipbooktime.orgid']:=jcdsResult.FieldByName('orgid').AsString;
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

procedure TFrmVipbooktime.tbtnEditClick(Sender: TObject);
begin
  inherited;
  if not dsResult.DataSet.Active then
    exit;
  if dsResult.DataSet.RecordCount < 1 then
    exit;

  FrmVipbooktimeEdit := TFrmVipbooktimeEdit.Create(self);
  try
    with FrmVipbooktimeEdit do
    begin
      Caption := '修改会员订票时间设置';
      edittype:=Tedittype.update;
      id:=self.jcdsResult.FieldByName('id').AsInteger;
      createtime:=self.jcdsResult.FieldByName('createtime').AsString;
      createby:=self.jcdsResult.FieldByName('createby').AsString;
//      updatetime:=self.jcdsResult.FieldByName('updatetime').AsString;
//      updateby:=self.jcdsResult.FieldByName('updateby').AsString;
      NovaCbbOrg.Text := self.jcdsResult.FieldByName('orgname').AsString;
      orgid := self.jcdsResult.FieldByName('orgid').AsInteger;
      NovaCbbOrg.Enabled :=false;
      nvtype.Text:=self.jcdsResult.FieldByName('vipgrade').AsString;
      nvtype.Visible := true;
      nvtype.Enabled :=false;
      nvcbbVipgrade.Visible:=false;
      nvedtTime.Text := self.jcdsResult.FieldByName('booktime').AsString;
      ShowModal;
      if ModalResult = mrok then
      begin
        tbtnFilterClick(tbtnFilter);
        jcdsResult.Locate('id',id,[] );
      end;
    end;
  finally
    FreeAndNil(FrmVipbooktimeEdit);
  end;
end;

procedure TFrmVipbooktime.tbtnFilterClick(Sender: TObject);
var vipgradename,tempstring:string;
i:integer;
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
    Params.ParamValues['filter_INS_vb!orgid'] := NovaCkbOrg.GetSelectID;
    tempstring := nvcbbvipgradename.Text;
    //将 （一卡通；普卡；金卡 ） 转换为( '一卡通',' 普卡','金卡')
    for i:=0 to length(tempstring) do begin
        if Pos(';',tempstring)>0 then begin
           vipgradename := vipgradename+''''+copy(tempstring,0,pos(';',tempstring)-1)+''',';
           tempstring := copy(tempstring,pos(';',tempstring)+2,length(tempstring));
         end;
    end;
    vipgradename :='('+vipgradename+''''+tempstring+''''+')';
    Params.ParamValues['filter_INS_vb!vipgrade'] := vipgradename;
    Active := true;
  end;
end;

procedure TFrmVipbooktime.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  FrmVipbooktimeEdit := TFrmVipbooktimeEdit.Create(self);
  try
    with FrmVipbooktimeEdit do
    begin
      Caption := '会员订票时间设置';
      edittype:=Tedittype.add;
      ShowModal;
      if ModalResult = mrok then
      begin
        tbtnFilterClick(tbtnFilter);
        jcdsResult.Locate('id', id, []);
      end;
    end;
  finally
    FreeAndNil(FrmVipbooktimeEdit);
  end;
end;

end.
