unit UFrmRechargePromotion;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, DB, DBClient, jsonClientDataSet,
   ImgList, GridsEh, DBGridEh, StdCtrls, ComCtrls, ToolWin, ExtCtrls,
  NovaComboBox, NovaHelp, NovaEdit,Services,NvPrnDbgeh, NvDbgridEh,
  UFrmRechargePromotionEdit, NovaCheckedComboBox;

type
  TfrmRechargePromotion= class(TSimpleCRUDForm)
    jcdsDelete: TjsonClientDataSet;
    grp3: TGroupBox;
    grp8: TGroupBox;
    nvdbgrdhTicke: TNvDbgridEh;
    grp1: TGroupBox;
    grp2: TGroupBox;
    tlb2: TToolBar;
    btn7: TToolButton;
    btn8: TToolButton;
    btn9: TToolButton;
    btn10: TToolButton;
    btn11: TToolButton;
    btn12: TToolButton;
    nvdbgrdh1: TNvDbgridEh;
    jcdsTickeDetail: TjsonClientDataSet;
    dsTicketResult: TDataSource;
    lbldate: TLabel;
    lbl1: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    lbl3: TLabel;
    nvcbbvipgrade: TNovaCheckedComboBox;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure tbtnDeleteClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmRechargePromotion: TfrmRechargePromotion;

implementation
uses UDMPublic,PubFn;

{$R *.dfm}



procedure TfrmRechargePromotion.FormCreate(Sender: TObject);
begin
  inherited;
  nvcbbvipgrade.Active := False;
  nvcbbvipgrade.Active := True;
  dtpstartdate.Date:= Now;
  dtpenddate.Date:=Now;
end;


procedure TfrmRechargePromotion.tbtnDeleteClick(Sender: TObject);
var log:string;
begin
  inherited;
    // 删除
  if (jcdsResult.Active=True) and (jcdsResult.RecNo>=0) then
  begin
    if not SysDialogs.Confirm('提示','确定要删除该充值优惠活动吗？') then
    begin
      exit;
    end;
    with jcdsDelete do
    begin
      Params.ParamValues['id']:=jcdsResult.FieldByName('id').AsString;
      Execute;
      if Params.ParamValues['msg']<>'' then
      begin
      log := ' 删除 充值优惠活动 ：'+jcdsResult.FieldByName('name').AsString;
      SysLog.WriteLog('充值优惠活动管理', '删除', log);
      log:='';
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
//    SysDialogs.ShowError('请先选择需要删除的记录！');
  end;
end;

procedure TfrmRechargePromotion.tbtnEditClick(Sender: TObject);
var item:Integer;s:string;
List: TStrings;
begin
  inherited;
    //修改
  if (jcdsResult.Active=True) and (jcdsResult.RecNo>=0)  then
  begin
    if (jcdsResult.RecordCount <= 0) then
    begin
     SysDialogs.ShowError('请先选择需要修改的记录！');
    end;
    try
      frmRechargePromotionEdit := TfrmRechargePromotionEdit.Create(self);
      with frmRechargePromotionEdit do
      begin
        Caption:='修改充值优惠活动信息';
        isedit:= True;
        id:=  jcdsResult.FieldByName('id').AsInteger;
        createby:=jcdsResult.FieldByName('createby').AsString;
        createtime:=jcdsResult.FieldByName('createtime').AsString;
        names := jcdsResult.FieldByName('name').AsString;
        nvedtName.Text := jcdsResult.FieldByName('name').AsString;
        mmoRemark.Text:=jcdsResult.FieldByName('remarks').AsString;
        remarks := jcdsResult.FieldByName('remarks').AsString;
        edtPresentvoucher.Text :=jcdsResult.FieldByName('presentvoucher').AsString;
        presentvoucher := jcdsResult.FieldByName('presentvoucher').AsString;
        edtMount.Text:=jcdsResult.FieldByName('rechargeamount').AsString;
        mount := jcdsResult.FieldByName('rechargeamount').AsString;
        dtpstartdate.Date :=jcdsResult.FieldByName('startdate').AsDateTime;
        startdate:= jcdsResult.FieldByName('startdate').AsString;
        dtpenddate.Date :=jcdsResult.FieldByName('enddate').AsDateTime;
        enddate:= jcdsResult.FieldByName('enddate').AsString;
        vipgradename := jcdsResult.FieldByName('vipgradename').AsString;
        types := jcdsResult.FieldByName('vipgrade').AsString; //(1,2,3)
        List:= TStringList.Create;
        List.CommaText := types;

        for s in types do
        begin
         if s=',' then
          Continue;

          item := strtoint(s);
          nvcbbvipgrade.SetCheck(item,true);
        end;
        List.Free;

        if jcdsResult.FieldByName('presentoncepercard').AsString = 'True' then
          begin
            chkIsOnetime.Checked := True;
            isonetime :='1';
          end
        else
        begin
          chkIsOnetime.Checked :=False;
          isonetime :='0';
        end;

        ShowModal;
        if ModalResult = mrok then
         begin
          tbtnFilterClick(Sender);
          jcdsResult.Locate('id',id,[] );
         end;


      end;
    finally
      FreeAndNil(frmRechargePromotionEdit);
    end;
  end;
end;

procedure TfrmRechargePromotion.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date)
  then
  begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期！');
    exit;
  end;
  if nvcbbvipgrade.Text='' then
  begin
    SysDialogs.ShowMessage('请选择卡等级！');
    nvcbbvipgrade.SetFocus;
    Exit;
  end;
  //查询
//  jcdsResult.AfterScroll := nil;
  with jcdsResult do
  begin
    Active:=False;
    Params.ParamByName('startdate').Value
      := FormatDateTime('yyyy-mm-dd',dtpstartdate.Date);
    Params.ParamByName('enddate').Value
      := FormatDateTime('yyyy-mm-dd',dtpenddate.Date);
    Params.ParamValues['vipgrade']:= nvcbbvipgrade.GetSelectID;
    Active := True;
  end;
//  jcdsResult.AfterScroll := jcdsResultAfterScroll;
end;

procedure TfrmRechargePromotion.tbtnInsertClick(Sender: TObject);
begin
  inherited;
  //添加
   frmRechargePromotionEdit := TfrmRechargePromotionEdit.Create(self);
  with frmRechargePromotionEdit do
  begin
    Caption := '添加充值优惠活动';
    ShowModal;
    if ModalResult = mrok then
    begin
      tbtnFilterClick(Sender);
      jcdsResult.Locate('id',id,[] );
    end;
    end;
end;

end.
