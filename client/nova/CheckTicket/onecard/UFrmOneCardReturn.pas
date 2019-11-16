unit UFrmOneCardReturn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls,UICcardRW, DB,
  DBClient, jsonClientDataSet,UDMPublic, DBGridEhGrouping, GridsEh, DBGridEh,
  NvDbgridEh;

type
  TFrmOneCardReturn = class(TSimpleEditForm,Ivipcardfound)
    grp1: TGroupBox;
    grpvip: TGroupBox;
    bvlvip: TBevel;
    lbl10: TLabel;
    lbl13: TLabel;
    lbl14: TLabel;
    lbl15: TLabel;
    lbl16: TLabel;
    lbl17: TLabel;
    lblvipcardno: TLabel;
    lblvipcardtype: TLabel;
    lblviplastamount: TLabel;
    lblviplastmoney: TLabel;
    lblvipname: TLabel;
    lblviptel: TLabel;
    jcdsreturncheckandsell: TjsonClientDataSet;
    jcdsvipinfo: TjsonClientDataSet;
    jcdsfindTicket: TjsonClientDataSet;
    dsticketselect: TDataSource;
    nvdbgrdhTicketSelect: TNvDbgridEh;
    lbl1: TLabel;
    lbl2: TLabel;
    lblmoney: TLabel;
    lblreturnnum: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure jcdsfindTicketAfterOpen(DataSet: TDataSet);
    procedure dsticketselectDataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
    curvipCard: TVipCard;
    FSelectTicketNos:Tstringlist; //选择要退检退票的票号列表
    procedure clearvipinfo;
    function checkTicketSelect: Currency;
  public
    { Public declarations }
    procedure vipcardfound(vipCard:TVipCard);
  end;

var
  FrmOneCardReturn: TFrmOneCardReturn;

implementation
uses Services;

{$R *.dfm}

procedure TFrmOneCardReturn.bbtnSaveClick(Sender: TObject);
var vipcardwriteresult:integer;
    reutrnmoney:Currency;
    _curvipCard:TVipCard;
begin
  inherited;
  reutrnmoney:=checkTicketSelect;
  if reutrnmoney=0 then
  begin
    SysDialogs.Warning('请选择需要退检退票的车票');
    nvdbgrdhTicketSelect.SetFocus;
    exit;
  end;

  if(curvipCard<>nil) then
  begin
    with jcdsreturncheckandsell do
    begin
      Close;
      _curvipCard:=curvipCard;
      Params.ParamValues['checkstationid']:=SysInfo.LoginUserInfo.StationID;
      Params.ParamValues['ticketnos']:=FSelectTicketNos.CommaText;
      Params.ParamValues['vipcardno']:=_curvipCard.cardNo;
      Params.ParamValues['vipgrade']:=IntToStr(Integer(_curvipCard.cardGrade));
      Params.ParamValues['vipmoney']:=_curvipCard.money;
      Params.ParamValues['vippoint']:=_curvipCard.amount;
      try
        Execute;
        if Params.ParamValues['flag']=1 then
        begin
          bbtnSave.Enabled:=false;
          _curvipCard.incrementmoney(reutrnmoney);
          _curvipCard.decrementamount(reutrnmoney);
          vipcardwriteresult:=_curvipCard.writeCard;
          while (vipcardwriteresult<>0) do
          begin
//            if SysDialogs.Ask('警告','写卡失败：'+_curvipCard.getErrorInfo(vipcardwriteresult)+'。请放好VIP卡，按确定重新写卡。') then
//            begin
//              vipcardwriteresult:=_curvipCard.writeCard;
//            end
//            else
//            begin
//              { TODO : 记录异常日志 }
//              Break;
//            end;
            SysDialogs.Warning('写卡失败：'+_curvipCard.getErrorInfo(vipcardwriteresult)+'。请放好VIP卡，按确定重新写卡。');
            vipcardwriteresult:=_curvipCard.writeCard;
          end;
          if (Params.ParamValues['msg']<>null) and (Trim(Params.ParamValues['msg'])<>'') then
            SysDialogs.ShowMessage(Params.ParamValues['msg'])
          else
            SysDialogs.ShowMessage('退检退票成功');
          self.ModalResult:=mrOk;
        end
        else
        begin
          if (Params.ParamValues['msg']<>null) and (Trim(Params.ParamValues['msg'])<>'') then
            SysDialogs.Warning(Params.ParamValues['msg'])
          else
            SysDialogs.Warning('退检退票失败，未知错误！');
        end;
      except
        on e:Exception do
        begin
          SysDialogs.Warning('退检退票失败，'+e.Message);
        end;
      end;
    end;
  end
  else
  begin
    SysDialogs.Warning('没有VIP卡！');
  end;
end;

procedure TFrmOneCardReturn.FormCreate(Sender: TObject);
begin
  inherited;
  FSelectTicketNos:=Tstringlist.Create;

  lblvipcardno.Caption:='';
  lblvipcardtype.Caption:='0';
  lblviplastmoney.Caption:='0';
  lblviplastamount.Caption:='0';
  lblvipname.Caption:='';
  lblviptel.Caption:='';
  setCardTypeNOLength(Tcardtypes.VIP,sysInfo.curBillLength.Items['Vip']);
  try
    TVipcardRW.GetInstance.addObserver(Self);
  except
    TVipcardRW.GetInstance.addObserver(Self);
    SysDialogs.Warning('读卡器初始化失败，不能读取VIP卡');
  end;
end;

procedure TFrmOneCardReturn.FormDestroy(Sender: TObject);
begin
  inherited;
  try
    TVipcardRW.GetInstance.removeObserver(Self);
  except
  end;
end;

procedure TFrmOneCardReturn.jcdsfindTicketAfterOpen(DataSet: TDataSet);
var oldOnDataChange:TDataChangeEvent;
begin
  inherited;
//  with DataSet do
//  begin
//    DisableControls;
//    First;
//    while not eof do
//    begin
//      if FieldByName('isselected').Value=0 then
//      begin
//        edit;
//        oldOnDataChange:=dsticketselect.OnDataChange;
//        dsticketselect.OnDataChange:=nil;
//        if (not canchangeafterdeparted) and fieldbyname('isdeparted').AsBoolean then
//        begin
//          FieldByName('isselected').Value:=null;
//        end
//        else
//        begin
//          FieldByName('isselected').Value:=1;
//        end;
//        dsticketselect.OnDataChange:=oldOnDataChange;
//        post;
//      end;
//      Next;
//    end;
//    First;
//    EnableControls;
//  end;
end;

procedure TFrmOneCardReturn.clearvipinfo;
begin
  curvipCard:=nil;
  lblvipcardno.Caption:='';
  lblvipname.Caption:='';
  lblvipcardtype.Caption:='';
  lblviptel.Caption:='';
  lblviplastmoney.Caption:='0';
  lblviplastamount.Caption:='0';
end;

procedure TFrmOneCardReturn.dsticketselectDataChange(Sender: TObject;
  Field: TField);
var oldOnDataChange:TDataChangeEvent;
begin
  inherited;
  if not assigned(Field) then exit;
  if (field.FieldName='isselected') then
  begin
    if (field.DataSet.FieldByName('ticketstatus').AsString<>'0')
      or (not field.DataSet.fieldbyname('ischecked').AsBoolean)
      or (field.DataSet.fieldbyname('isdepartinvoices').AsBoolean)
    then
    begin
      oldOnDataChange:=(sender as TDataSource).OnDataChange;
      (sender as TDataSource).OnDataChange:=nil;
      field.DataSet.FieldByName('isselected').Value:=null;
      (sender as TDataSource).OnDataChange:=oldOnDataChange;
    end;
    checkTicketSelect;
  end;
end;

function TFrmOneCardReturn.checkTicketSelect: Currency;
var oppositeorgid:Int64;
    selectcount:integer;
    bookmark:TBookmark;
begin
  Result:=0;
  selectcount:=0;
  FSelectTicketNos.Clear;
  bbtnSave.Enabled:=false;
  if (not jcdsfindTicket.Active) or (jcdsfindTicket.RecordCount=0) then
  begin
    lblmoney.Caption:='0';
    lblreturnnum.Caption:='0';
    exit;
  end;

  // 判断选中的记录数
  with jcdsfindTicket do
  begin
    bookmark:=GetBookmark;
    DisableControls;
    First;
    while not eof do
    begin
      if fieldbyname('isselected').AsBoolean then
      begin
        Result:=Result+fieldbyname('price').AsCurrency;
        FSelectTicketNos.Add(FieldByName('ticketno').AsString);
        Inc(selectcount);
      end;
      next;
    end;
    GotoBookmark(bookmark);
    EnableControls;
  end;
  lblmoney.Caption:=CurrToStr(result);
  lblreturnnum.Caption:=IntToStr(selectcount);
  bbtnSave.Enabled:=(selectcount>0) and (result>0)
end;

procedure TFrmOneCardReturn.vipcardfound(vipCard: TVipCard);
begin
  FSelectTicketNos.Clear;
  curvipCard:=vipCard;
  bbtnSave.Enabled:=true;
  lblvipcardno.Caption:=vipCard.cardNo;
  lblvipcardtype.Caption:=getCardgradeName(vipCard.cardGrade);
  lblviplastmoney.Caption:=currtostr(vipCard.money);
  lblviplastamount.Caption:=currtostr(vipCard.amount);

  //查询数据库
  with jcdsvipinfo do
  begin
    Close;
    Params.ParamValues['filter_EQS_v!vipcardno']:=vipCard.cardNo;
    open;
    if RecordCount=0 then
    begin
      clearvipinfo;
      SysDialogs.Warning('找不到卡号为'+vipCard.cardNo+'的信息，可能是该卡的状态异常。');
    end
    else
    begin
      lblvipname.Caption:=FieldByName('name').AsString;
      lblviptel.Caption:=FieldByName('mobilephone').AsString;

      //查询购票信息
      with jcdsfindTicket do
      begin
        active:=false;
        Params.ParamValues['vipcardno']:=vipCard.cardNo;
        try
          active:=true;
        except
        end;
        checkTicketSelect;
      end;
    end;
  end;
end;

end.
