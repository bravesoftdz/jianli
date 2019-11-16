unit UFrmScheduleSellDays;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, NvPrnDbgeh, DB, DBClient, jsonClientDataSet,
  ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls, ToolWin, ExtCtrls,
  NovaCheckedComboBox, DBGridEhGrouping, NovaComboBox, NovaHComboBox;

type
  TFrmScheduleSellDays = class(TSimpleCRUDForm)
    lbl2: TLabel;
    lblSelltype: TLabel;
    nvcbbSelltype: TNovaComboBox;
    nvdbgrdh1: TNvDbgridEh;
    nvdbgrdh2: TNvDbgridEh;
    jcdsDelPerselldays: TjsonClientDataSet;
    nvHcbbOrg: TNovaHComboBox;
    procedure FormShow(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmScheduleSellDays: TFrmScheduleSellDays;

implementation
  uses PubFn, Services,UFrmScheduleSellDaysEdit,UDMPublic;
{$R *.dfm}

procedure TFrmScheduleSellDays.FormShow(Sender: TObject);
begin
  inherited;
   nvHcbbOrg.Active := False;
  nvHcbbOrg.Active := True;
  //nvHcbbOrg.CheckById(true,sysinfo.LoginUserInfo.OrgID);
  nvcbbSelltype.Active := False;
  nvcbbSelltype.Active := True;
end;

procedure TFrmScheduleSellDays.tbtnDeleteClick(Sender: TObject);
var  nResult: integer;
  sResult,log: string;
begin
  if not jcdsResult.Active then
    exit;
  if jcdsResult.RecordCount < 1 then
    exit;

  if not SysDialogs.Confirm('信息提示', '确认要删除该记录吗!') then
    exit;

  with jcdsDelPerselldays do
    try
      close;
      Params.ParamByName('id').Value := jcdsResult.FieldByName('id').AsString;
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult = 1) then
      begin
         log := ' 删除'+jcdsResult.FieldByName('orgname').AsString
        +' , 班次类型；'+jcdsResult.FieldByName('typename').AsString;
        if jcdsResult.FieldByName('typecode').AsString='1' then
        begin
          log := log+' , 线路名称：'+jcdsResult.FieldByName('typeidname').AsString
        end;
         if jcdsResult.FieldByName('typecode').AsString='2' then
        begin
          log := log+' , 班次号：'+jcdsResult.FieldByName('typeidname').AsString
        end;
        log := log+' , 预售天数:'+ jcdsResult.FieldByName('perserlldays').AsString;
        SysLog.WriteLog('班次预售天数管理', '删除', log);
        log:='';
        tbtnFilterClick(Sender);
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('删除失败：' + E.Message);
      end;
    end;

end;

procedure TFrmScheduleSellDays.tbtnEditClick(Sender: TObject);
var tid:string;
begin
  frmScheduleSellDaysEdit := TfrmScheduleSellDaysEdit.Create(self);
  try
    with frmScheduleSellDaysEdit do
    begin
      //edittype:=Tedittype.update;
      Caption := '修改班次预售天数控制';
      id := jcdsResult.FieldByName('id').AsInteger;
      orgname := jcdsResult.FieldByName('orgname').AsString;
      nvhcbbOrgid.SetItemIndexByField('name',
      jcdsResult.FieldByName('orgname').AsString);
      nvcbbSelltype.Text := jcdsResult.FieldByName('typename').AsString;
      types := jcdsResult.FieldByName('typecode').AsString;
      nvcbbSelltype.ItemIndex := jcdsResult.FieldByName('typecode').AsInteger;
      days:=  jcdsResult.FieldByName('perserlldays').AsString;
      edtSellDays.Text := jcdsResult.FieldByName('perserlldays').AsString;
      remarks :=  jcdsResult.FieldByName('remarks').AsString;
      mmoMeRemark.Text :=  jcdsResult.FieldByName('remarks').AsString;
      createby:=jcdsResult.FieldByName('createby').AsLargeInt;
      createtime:=jcdsResult.FieldByName('createtime').AsString;
      nvcbbSelltype.Enabled:= False;
      nvhcbbOrgid.Enabled:=False;
      if jcdsResult.FieldByName('typecode').AsString <> '0' then
      begin
      with  jcdsSchedule do
        begin
           Active := false;
          Params.ParamByName('orgid').Value := nvhcbbOrgid.HelpFieldValue['id'];
          Params.ParamValues['type'] := jcdsResult.FieldByName('typecode').AsString;
          Params.ParamValues['isupdate'] := 'true';
          Params.ParamValues['id'] := id;
          Active := true;
        end;
      end;

      ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id',id,[] );
    end;
    end;
  finally
    FreeAndNil(frmScheduleSellDaysEdit);
  end;

end;

procedure TFrmScheduleSellDays.tbtnFilterClick(Sender: TObject);
begin
   if nvHcbbOrg.ItemIndex<0 then
  begin
    SysDialogs.ShowMessage('请选择机构！');
    exit;
  end;

with jcdsResult do
  begin
   Active := False;
    Params.ParamByName('filter_EQL_o!id').Value := nvHcbbOrg.HelpFieldValue['id'];


    if nvcbbSelltype.ItemIndex > 0 then
    begin
      Params.ParamValues['filter_EQS_spd!type'] := nvcbbSelltype.GetSelectCode;
    end
    else
    begin
      Params.ParamValues['filter_EQS_spd!type'] := '';
    end;
    Active := True;
  end;


end;

procedure TFrmScheduleSellDays.tbtnInsertClick(Sender: TObject);
begin
  inherited;

   frmScheduleSellDaysEdit := TfrmScheduleSellDaysEdit.Create(self);
  with frmScheduleSellDaysEdit do
  begin
    Caption := '添加班次预售天数控制';
     edittype:=add;
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id',id,[] );
    end;
  end;

end;

end.
