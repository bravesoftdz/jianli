unit UFrmreturnticketend;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit,PubFn,
  Generics.Collections,math,services, ImgList,DateUtils;

type
  TFrmreturnticketend = class(TSimpleEditForm)
    pnlinsurereceipt: TPanel;
    lblinsurenum_: TLabel;
    lblinsurenum: TLabel;
    lblinsurereceivablenum_: TLabel;
    lblinsurereceivablenum: TLabel;
    pnlticketreceipt: TPanel;
    lblticketnum_: TLabel;
    lblticketnum: TLabel;
    lblticketreceivablenum_: TLabel;
    lblticketreceivablenum: TLabel;
    bvlticketreceipt: TBevel;
    pnlrr: TPanel;
    bvlrr: TBevel;
    lblreceivablenum_: TLabel;
    lblreceivablenum: TLabel;
    lblreason: TLabel;
    mmoreason: TMemo;
    pnlsetcharge: TPanel;
    lblrateflag: TLabel;
    rbrate: TRadioButton;
    rbfix: TRadioButton;
    nvedtrate: TNovaEdit;
    nvedtfix: TNovaEdit;
    lbl1: TLabel;
    Label1: TLabel;
    lbltickettotalnum: TLabel;
    Label3: TLabel;
    lblticketcharge: TLabel;
    Label5: TLabel;
    lblinsuretotalnum: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    ChkIsPrint: TCheckBox;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure rbrateClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    totalpremium,stationfee:Currency;
    returnticketsprice:Tlist<Currency>;
    returntovipcard:Boolean;
    _departdatetime:Tdatetime;
    _totalprice,_totalcharges,_ticketfee:Currency;
    _returnway,param1107:string;
  end;

var
  Frmreturnticketend: TFrmreturnticketend;

implementation

uses UFrmTicketRetrunRe;

{$R *.dfm}

procedure TFrmreturnticketend.bbtnSaveClick(Sender: TObject);
var nowrate,newcharge,charges,rate,totalprice,totalcharges:Currency;
    departdatetime:Tdatetime;
begin
  inherited;
  if pnlsetcharge.Visible then
  begin
    if rbrate.Checked then
    begin
      if StrToCurrDef(nvedtrate.Text,-1)<0 then
      begin
        SysDialogs.ShowInfo('��������Ʊ�������ʣ�');
        nvedtrate.SetFocus;
        exit;
      end
      else if StrToCurrDef(nvedtrate.Text,-1)>=100 then
      begin
        SysDialogs.Warning('��Ʊ�������ʴ��ڻ����100%��Ʊ�����壡');
        nvedtrate.SetFocus;
        exit;
      end;
    end
    else
    begin
      if StrToCurrDef(nvedtfix.Text,-1)<0 then
      begin
        SysDialogs.ShowInfo('��������Ʊ�����ѣ�');
        nvedtfix.SetFocus;
        exit;
      end;
    end;
  end;
{  if returntovipcard and (FrmTicketReturn.curvipCard=nil) then
  begin
    SysDialogs.ShowInfo('��ǰѡ�еĳ�Ʊ��Ʊʱ�����Ҫ�˵�VIP���С��뽫VIP���ŵ���������');
    exit;
  end;

  with FrmTicketReturn.jcdsResult do
  begin
    DisableControls;
    First;
    if _returnway ='0' then
    begin
      while not eof do
      begin
       if fieldbyname('isselected').AsBoolean or fieldbyname('isreturninsure').AsBoolean then
       begin
        if fieldbyname('ischecked').AsBoolean then
        begin
          SysDialogs.Warning('�ó�Ʊ�Ѿ���Ʊ����������Ʊ!');
          EnableControls;
          exit;
        end;
       end;
       if FieldValues['signcharges']<>null then
        begin
          charges:=FieldValues['signcharges'];
        end
        else if FieldByName('status').AsString = '1' then // ��ͣ
        begin
          charges:=0;
        end
        else
        begin
          departdatetime:=EncodeDateTime(YearOf(FieldByName('departdate').AsDateTime),
                                         MonthOfTheYear(FieldByName('departdate').AsDateTime),
                                         DayOfTheMonth(FieldByName('departdate').AsDateTime),
                                         StrToInt(copy(FieldByName('departtime').AsString,1,pos(':',FieldByName('departtime').AsString)-1)),
                                         StrToInt(copy(FieldByName('departtime').AsString,pos(':',FieldByName('departtime').AsString)+1)),
                                         0,
                                         0
                                         );
          rate:=FrmTicketReturn.getticketreturnrate(departdatetime);
          if FrmTicketReturn.param1107 then
          begin
            _ticketfee:=FrmTicketReturn.getticketfee(FieldByName('isselfschedule').AsBoolean,FieldByName('id').AsLargeInt);
            if _ticketfee<0 then
            begin
              SysDialogs.ShowError('ȡƱ�۷������');
              exit;
            end;
            charges:=FrmTicketReturn.carry(_ticketfee
                           +(FieldByName('price').AsCurrency-_ticketfee)
                             *rate
                           );
          end
          else
          begin
            charges:=FrmTicketReturn.carry(FieldByName('price').AsCurrency*rate);
          end;
        end;
       if fieldbyname('isselected').AsBoolean then
        begin
          totalprice:=totalprice+FieldValues['price'];
          totalcharges:=totalcharges+charges;
        end;
      next;
      end;
      if totalcharges <> _totalcharges then
      begin
        SysDialogs.Warning('��Ʊ�����ѷ����ı�,�����²�ѯ!');
        exit;
      end;
    end;

  end; }

  self.ModalResult:=mrok;
end;

procedure TFrmreturnticketend.FormCreate(Sender: TObject);
begin
  inherited;
  //returntovipcard:=false;
  returnticketsprice:=Tlist<Currency>.create;
end;

procedure TFrmreturnticketend.FormShow(Sender: TObject);
var
  isprint:string;
begin
  inherited;
  //�Ƿ��ӡ��Ʊƾ֤
  isprint:=getParametervalue('1101',SysInfo.LoginUserInfo.OrgID);
  if isprint='1' then
    ChkIsPrint.Checked:=true
  else
  begin
    ChkIsPrint.Checked:=false;
    ChkIsPrint.Enabled:=false;
  end;
end;

procedure TFrmreturnticketend.rbrateClick(Sender: TObject);
var tmpticketprice,totalticketreturn,totalticketcharge,ticketcharge:Currency;
begin
  inherited;
  totalticketreturn:=0;
  totalticketcharge:=0;
  ticketcharge :=0 ;
  if rbrate.Checked then
  begin
    nvedtrate.Enabled:=True;
    nvedtfix.Enabled:=false;
    for tmpticketprice in returnticketsprice do
    begin
        //��Ȩ��Ʊ���漰վ���
      ticketcharge :=FrmTicketRetrunRe.carry(tmpticketprice * StrToCurrDef(nvedtrate.Text,0)/100);
      totalticketreturn:=totalticketreturn+tmpticketprice-ticketcharge;
      totalticketcharge:= totalticketcharge + ticketcharge;
//      if getParametervalue('1179',SysInfo.LoginUserInfo.OrgID)='1' then
//         totalticketcharge:=totalticketcharge+FrmTicketRetrunRe.carry((tmpticketprice-4)*StrToCurrDef(nvedtrate.Text,0)/100+4)
//      else
//         totalticketcharge:=totalticketcharge+FrmTicketRetrunRe.carry(tmpticketprice*StrToCurrDef(nvedtrate.Text,0)/100);
//       //����Ӧ�˸��˿͵�Ǯ

    end;
  end
  else
  begin
    nvedtrate.Enabled:=false;
    nvedtfix.Enabled:=True;
    for tmpticketprice in returnticketsprice do
    begin
      totalticketreturn:=totalticketreturn+tmpticketprice-min(StrToCurrDef(nvedtfix.Text,0),tmpticketprice);
      totalticketcharge:=totalticketcharge+min(StrToCurrDef(nvedtfix.Text,0),tmpticketprice);
    end;
  end;
  lblticketreceivablenum.Caption:=CurrToStr(totalticketreturn);
  lblticketcharge.Caption:=CurrToStr(totalticketcharge);
  lblreceivablenum.Caption:=CurrToStr(totalticketreturn+totalpremium);
end;


end.
