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
    FSelectTicketNos:Tstringlist; //ѡ��Ҫ�˼���Ʊ��Ʊ���б�
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
    SysDialogs.Warning('��ѡ����Ҫ�˼���Ʊ�ĳ�Ʊ');
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
//            if SysDialogs.Ask('����','д��ʧ�ܣ�'+_curvipCard.getErrorInfo(vipcardwriteresult)+'����ź�VIP������ȷ������д����') then
//            begin
//              vipcardwriteresult:=_curvipCard.writeCard;
//            end
//            else
//            begin
//              { TODO : ��¼�쳣��־ }
//              Break;
//            end;
            SysDialogs.Warning('д��ʧ�ܣ�'+_curvipCard.getErrorInfo(vipcardwriteresult)+'����ź�VIP������ȷ������д����');
            vipcardwriteresult:=_curvipCard.writeCard;
          end;
          if (Params.ParamValues['msg']<>null) and (Trim(Params.ParamValues['msg'])<>'') then
            SysDialogs.ShowMessage(Params.ParamValues['msg'])
          else
            SysDialogs.ShowMessage('�˼���Ʊ�ɹ�');
          self.ModalResult:=mrOk;
        end
        else
        begin
          if (Params.ParamValues['msg']<>null) and (Trim(Params.ParamValues['msg'])<>'') then
            SysDialogs.Warning(Params.ParamValues['msg'])
          else
            SysDialogs.Warning('�˼���Ʊʧ�ܣ�δ֪����');
        end;
      except
        on e:Exception do
        begin
          SysDialogs.Warning('�˼���Ʊʧ�ܣ�'+e.Message);
        end;
      end;
    end;
  end
  else
  begin
    SysDialogs.Warning('û��VIP����');
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
    SysDialogs.Warning('��������ʼ��ʧ�ܣ����ܶ�ȡVIP��');
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

  // �ж�ѡ�еļ�¼��
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

  //��ѯ���ݿ�
  with jcdsvipinfo do
  begin
    Close;
    Params.ParamValues['filter_EQS_v!vipcardno']:=vipCard.cardNo;
    open;
    if RecordCount=0 then
    begin
      clearvipinfo;
      SysDialogs.Warning('�Ҳ�������Ϊ'+vipCard.cardNo+'����Ϣ�������Ǹÿ���״̬�쳣��');
    end
    else
    begin
      lblvipname.Caption:=FieldByName('name').AsString;
      lblviptel.Caption:=FieldByName('mobilephone').AsString;

      //��ѯ��Ʊ��Ϣ
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
