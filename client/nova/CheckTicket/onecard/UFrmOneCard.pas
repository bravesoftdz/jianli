unit UFrmOneCard;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls,UICcardRW, DB,
  DBClient, jsonClientDataSet,UDMPublic;

type
  TFrmOneCard = class(TSimpleEditForm,Ivipcardfound)
    grp1: TGroupBox;
    shp1: TShape;
    lbl1: TLabel;
    lblDepartdate: TLabel;
    bvl1: TBevel;
    bvl2: TBevel;
    bvl3: TBevel;
    lbl2: TLabel;
    lblEntrance: TLabel;
    lbl3: TLabel;
    lblvehicleno: TLabel;
    bvl5: TBevel;
    bvl6: TBevel;
    lbl4: TLabel;
    lblEndStation: TLabel;
    lbl5: TLabel;
    lblScheduleCode: TLabel;
    bvl4: TBevel;
    lbl6: TLabel;
    lblresidueseatnum: TLabel;
    lbl9: TLabel;
    lblDepartTime: TLabel;
    bvl7: TBevel;
    grpvip: TGroupBox;
    bvlvip: TBevel;
    lbl10: TLabel;
    lbl11: TLabel;
    lbl13: TLabel;
    lbl14: TLabel;
    lbl15: TLabel;
    lbl16: TLabel;
    lbl17: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lblvipamount: TLabel;
    lblvipcardno: TLabel;
    lblvipcardtype: TLabel;
    lblviplastamount: TLabel;
    lblviplastmoney: TLabel;
    lblvipname: TLabel;
    lblvipnewamount: TLabel;
    lblvipnewmoney: TLabel;
    lblviptel: TLabel;
    lbl12: TLabel;
    bvl8: TBevel;
    lblfullprice: TLabel;
    jcdsschedule: TjsonClientDataSet;
    jcdssellandcheck: TjsonClientDataSet;
    grplog: TGroupBox;
    mmolog: TMemo;
    jcdsvipinfo: TjsonClientDataSet;
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
    curvipCard: TVipCard;
    procedure clearvipinfo;
  public
    { Public declarations }
    scheduleplanid,vehiclereportid:int64;
    ticketentrance:String;
    procedure vipcardfound(vipCard:TVipCard);
  end;

var
  FrmOneCard: TFrmOneCard;

implementation
uses Services;

{$R *.dfm}

procedure TFrmOneCard.bbtnSaveClick(Sender: TObject);
var vipcardwriteresult:integer;
    selllog:string;
    _curvipCard:TVipCard;
begin
  inherited;
  selllog:=FormatDateTime('hh:nn:ss',now)+'��';
  if(curvipCard<>nil) then
  begin
    if StrToCurr(lblfullprice.Caption)>curvipCard.money then
    begin
      SysDialogs.Warning('��������֧��Ʊ�');
      exit;
    end;
    with jcdssellandcheck do
    begin
      Close;
      _curvipCard:=curvipCard;
      Params.ParamValues['scheduleplanid']:=scheduleplanid;
      Params.ParamValues['vehiclereportid']:=vehiclereportid;
      Params.ParamValues['checkstationid']:=SysInfo.LoginUserInfo.StationID;
      Params.ParamValues['vipcardno']:=_curvipCard.cardNo;
      Params.ParamValues['vipgrade']:=IntToStr(Integer(_curvipCard.cardGrade));
      Params.ParamValues['vipmoney']:=_curvipCard.money;
      Params.ParamValues['vippoint']:=_curvipCard.amount;
//      Params.ParamValues['vipcardno']:='11761389';
      Params.ParamValues['ticketentrance']:=ticketentrance;
      Params.ParamValues['carrychild']:=false;
      try
        Execute;
        if Params.ParamValues['flag']=1 then
        begin
          bbtnSave.Enabled:=false;
          jcdsschedule.Edit;
          jcdsschedule.FieldByName('residueseatnum').AsInteger:=jcdsschedule.FieldByName('residueseatnum').AsInteger-1;
          lblresidueseatnum.Caption:=jcdsschedule.FieldByName('residueseatnum').AsString;
          _curvipCard.decrementmoney(StrToCurr(lblfullprice.Caption));
          _curvipCard.incrementamount(StrToCurr(lblfullprice.Caption));
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

//          selllog:=selllog+'���ţ�'+'11761389'+Params.ParamValues['msg'];
          selllog:=selllog+'���ţ�'+_curvipCard.cardNo+Params.ParamValues['msg'];
          mmolog.Lines.Add(selllog);
          SysDialogs.ShowMessage(selllog);
        end
        else
        begin
          if Params.ParamValues['msg']<>null then
            selllog:=selllog+Params.ParamValues['msg']
          else
            selllog:=selllog+'δ֪����';
          mmolog.Lines.Add(selllog);
          SysDialogs.Warning(selllog);
        end;
      except
        on e:Exception do
        begin
          selllog:=selllog+'δ֪����'+e.Message;
          mmolog.Lines.Add(selllog);
          SysDialogs.Warning(selllog);
        end;
      end;
    end;
  end
  else
  begin
    SysDialogs.Warning('û��VIP����');
  end;
end;

procedure TFrmOneCard.FormCreate(Sender: TObject);
begin
  inherited;
  lblvipcardno.Caption:='';
  lblvipcardtype.Caption:='0';
  lblviplastmoney.Caption:='0';
  lblvipnewmoney.Caption:='0';
  lblviplastamount.Caption:='0';
  lblvipamount.Caption:='0';
  lblvipnewamount.Caption:='0';
  //��ѯ���ݿ�
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

procedure TFrmOneCard.FormDestroy(Sender: TObject);
begin
  inherited;
  try
    TVipcardRW.GetInstance.removeObserver(Self);
  except
  end;
end;

procedure TFrmOneCard.clearvipinfo;
begin
  curvipCard:=nil;
  lblvipcardno.Caption:='';
  lblvipname.Caption:='';
  lblvipcardtype.Caption:='';
  lblviptel.Caption:='';
  lblviplastmoney.Caption:='0';
  lblvipnewmoney.Caption:='0';
  lblviplastamount.Caption:='0';
  lblvipamount.Caption:='0';
  lblvipnewamount.Caption:='0';
end;

procedure TFrmOneCard.vipcardfound(vipCard: TVipCard);
begin
  curvipCard:=vipCard;
  lblvipcardno.Caption:=vipCard.cardNo;
  lblvipcardtype.Caption:=getCardgradeName(vipCard.cardGrade);
  lblviplastmoney.Caption:=currtostr(vipCard.money);
  lblvipnewmoney.Caption:='0';
  lblviplastamount.Caption:=currtostr(vipCard.amount);
  lblvipamount.Caption:='0';
  lblvipnewamount.Caption:='0';

  //��ѯ���ݿ�
  with jcdsvipinfo do
  begin
    Close;
    Params.ParamValues['filter_EQS_v!vipcardno']:=vipCard.cardNo;
    open;
    if RecordCount=0 then
    begin
      clearvipinfo;
      SysDialogs.Warning('�򲻵�����Ϊ'+vipCard.cardNo+'����Ϣ�������Ǹÿ���״̬�쳣��');
      exit;
    end
    else
    begin
      lblvipname.Caption:=FieldByName('name').AsString;
      lblviptel.Caption:=FieldByName('mobilephone').AsString;
      if StrToCurr(lblfullprice.Caption)>curvipCard.money then
      begin
        SysDialogs.ShowInfo('��ǰVIP������֧����');
        exit;
      end;
      bbtnSave.Enabled:=true;
    end;
  end;
end;

end.
