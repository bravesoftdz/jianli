unit UFrmRechargePromotionEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, ComCtrls, NovaHelp,
  NovaComboBox, NovaEdit, DB, DBClient, jsonClientDataSet,Services,
  NovaHComboBox, ImgList, NovaCheckedComboBox;

type
  TfrmRechargePromotionEdit = class(TSimpleEditForm)
    jcdsSave: TjsonClientDataSet;
    lbl1: TLabel;
    nvedtName: TNovaEdit;
    lbl14: TLabel;
    lbl4: TLabel;
    dtpstartdate: TDateTimePicker;
    lbl10: TLabel;
    edtPresentvoucher: TNovaEdit;
    lbl3: TLabel;
    lbl5: TLabel;
    mmoRemark: TMemo;
    lbl2: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    lbl11: TLabel;
    edtMount: TNovaEdit;
    lbl15: TLabel;
    dtpenddate: TDateTimePicker;
    chkIsOnetime: TCheckBox;
    nvcbbvipgrade: TNovaCheckedComboBox;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    Foperationid:Integer;
    function checkSchedule(var msg: String): boolean;
  public
    { Public declarations }
   isedit,isontime:boolean;
   id:integer;
   createby,createtime,names,presentvoucher, mount, isonetime,
   types,remarks,startdate,enddate,vipgradename: string;
    property operationid:Integer read Foperationid;
  end;

var
  frmRechargePromotionEdit: TfrmRechargePromotionEdit;

implementation
  uses UDMPublic,PubFn;
{$R *.dfm}

procedure TfrmRechargePromotionEdit.FormCreate(Sender: TObject);
begin
  inherited;
   nvcbbvipgrade.Active :=False;
   nvcbbvipgrade.Active :=True;
   dtpstartdate.Date:= Now;
   dtpenddate.Date:=Now;
end;

procedure TfrmRechargePromotionEdit.bbtnSaveClick(Sender: TObject);
 var  msg: String;
  nResult: integer;
  sResult,log,optype: String;
begin
  inherited;
   if (not checkSchedule(msg)) then
  begin
    SysDialogs.ShowMessage(msg);
    exit;
  end;

  with jcdsSave do
  begin
    close;
     Params.ParamByName('rechargepromotion.id').Value := id;
     Params.ParamByName('rechargepromotion.createtime').Value := createtime;
     Params.ParamByName('rechargepromotion.createby').Value := createby;
    Params.ParamByName('rechargepromotion.name').Value := nvedtName.Text;
    if chkIsOnetime.Checked then
     Params.ParamByName('rechargepromotion.presentoncepercard').Value := 'true'
    else
    Params.ParamByName('rechargepromotion.presentoncepercard').Value := 'false';


    Params.ParamByName('rechargepromotion.rechargeamount').Value := edtMount.Text;
    Params.ParamByName('rechargepromotion.presentvoucher').Value := edtPresentvoucher.Text;
    Params.ParamByName('rechargepromotion.startdate').Value
    := FormatDateTime('yyyy-mm-dd',dtpstartdate.Date);
    Params.ParamByName('rechargepromotion.enddate').Value
    := FormatDateTime('yyyy-mm-dd',dtpenddate.Date);


    Params.ParamByName('vipgrade').Value :=nvcbbvipgrade.GetSelectID;


    Params.ParamByName('rechargepromotion.remarks').Value :=  mmoRemark.Text;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        nvedtName.SetFocus;
      end
      else
      begin
       if id>0 then
        begin
           optype:='修改';
            if names <> nvedtname.Text then
           begin
              log := log+' 活动名称 由'+names+' 改成'+nvedtname.Text;
           end;
           if startdate <> DateToStr(dtpstartdate.Date )then
           begin
              log := log+' 活动开始日期 由 '+startdate+' 改成'+DateToStr(dtpstartdate.Date);
           end;
            if enddate <> DateToStr(dtpenddate.Date) then
           begin
              log := log+' 活动结束日期 由 '+enddate+' 改成'+DateToStr(dtpenddate.Date);
           end;
           if mount<>edtMount.Text then
           begin
              log := log+' 充值金额 由 '+mount+' 改成'+edtMount.Text;
           end;
           if presentvoucher <> edtPresentvoucher.Text then
           begin
              log := log+' 赠送金额 由'+presentvoucher+' 改成'+edtPresentvoucher.Text;
           end;
           if (isonetime='0') and (chkIsOnetime.Checked)then
           begin
              log := log+' 由不可赠送一次改为只赠送一次';
           end;
           if ( not (chkIsOnetime.Checked)) and (isonetime ='1')  then
           begin
              log := log+' 由可赠送一次 改为 不可赠送一次';
           end;
           if vipgradename<>nvcbbvipgrade.Text then
            log:= log+' 可参与卡等级 由 '+vipgradename+' 改成 '+ nvcbbvipgrade.Text;

        end
        else
        begin
           optype:='添加';
            log := ' 活动名称:'+nvedtname.Text+', 活动开始日期:'+
                DateToStr(dtpstartdate.Date)+', 结束日期:'+DateToStr(dtpenddate.Date )
                + ' 充值金额为'+edtMount.Text
                +' 赠送金额为'+edtPresentvoucher.Text
                +' 备注;'+mmoRemark.Text
        end;
        SysLog.WriteLog('充值优惠活动管理', optype, log);
        log:='';
        optype:='';
        id := Params.ParamByName('id').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('添加失败：' + E.Message);
      end;
    end;
  end;



end;

function TfrmRechargePromotionEdit.checkSchedule(var msg: String): boolean;
begin
   result := False;
  if Trim(nvedtName.Text) ='' then
  begin
    msg := '活动名称不能为空！';
    nvedtName.SetFocus;
    exit;
  end;

  if nvcbbvipgrade.GetSelectID ='' then
  begin
    msg := '请选择可参与卡等级!';
    nvcbbvipgrade.SetFocus;
    exit;
  end;

  if trim(edtMount.Text) = '' then
  begin
    msg := '请输入充值金额!';
    edtMount.SetFocus;
    exit;
  end;
  if Trim(edtPresentvoucher.Text)='' then
  begin
    msg:= '请输入赠送代金卷!';
    edtPresentvoucher.SetFocus;
    Exit;
  end;
  if (FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date) )then
  begin
    msg := '开始日期不能大于结束日期！';
    dtpstartdate.SetFocus;
    exit;
  end;

   result := True;
end;





end.
