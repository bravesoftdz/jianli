unit UFrmTicketturnoverQuery;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp, Menus;

type
  TFrmTicketturnoverQuery = class(TSimpleCRUDForm)
    jcdsResultDelDepartinvoicesother: TjsonClientDataSet;
    lbl1: TLabel;
    lbl2: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    Label2: TLabel;
    nvhlpseller: TNovaHelp;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    procedure tbtnFilterClick(Sender: TObject);
    procedure tbtnEditClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure tbtnInsertClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure tbtnCloseClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
  private
    { Private declarations }
    log : String;

  public
    { Public declarations }
  end;

var
  FrmTicketturnoverQuery: TFrmTicketturnoverQuery;

implementation

uses Services, UFrmTicketturnoverReport;
{$R *.dfm}

procedure TFrmTicketturnoverQuery.FormCreate(Sender: TObject);
begin
  inherited;
  dtpstartdate.DateTime := Now();
  dtpenddate.DateTime := Now();
  nvhlpseller.Id := SysInfo.LoginUserInfo.UserID;
  nvhlpseller.Text := SysInfo.LoginUserInfo.UserName;
   dbgrdhResult.GridUser := SysInfo.LoginUserInfo.UserID;
end;

procedure TFrmTicketturnoverQuery.FormShow(Sender: TObject);
begin
  inherited;
  dtpstartdate.DateTime := Now();
  dtpenddate.DateTime := Now();
  with jcdsResult do
  begin
    Active := False;
      Params.ParamValues['filter_GED_t!receipttime'] := FormatDateTime('yyyy-mm-dd', dtpstartdate.DateTime);
      Params.ParamValues['filter_LED_t!receipttime'] := FormatDateTime('yyyy-mm-dd',dtpenddate.DateTime + 1);
      Params.ParamValues['filter_EQL_t!seller'] := nvhlpseller.Id;
    Active := True;
  end;
end;

procedure TFrmTicketturnoverQuery.N1Click(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    if active and (recordcount>0) then
    begin
       first;
       while(not eof) do
       begin
         edit;
         fieldbyname('ischoose').Value:=true;
         next;
       end;
    end;
  end;
end;

procedure TFrmTicketturnoverQuery.N2Click(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    if active and (recordcount>0) then
    begin
       first;
       while(not eof) do
       begin
         edit;
         fieldbyname('ischoose').Value:=not fieldbyname('ischoose').AsBoolean;
         next;
       end;
    end;
  end;
end;

procedure TFrmTicketturnoverQuery.N3Click(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    if active and (recordcount>0) then
    begin
       first;
       while(not eof) do
       begin
         edit;
         fieldbyname('ischoose').Value:=false;
         next;
       end;
    end;
  end;
end;

procedure TFrmTicketturnoverQuery.tbtnCloseClick(Sender: TObject);
begin
  inherited;
  FrmTicketturnoverQuery.Close;
end;

procedure TFrmTicketturnoverQuery.tbtnEditClick(Sender: TObject);
var i,  seller : Integer;
    sname,startno, endno : string;
    startdate, enddate, turntime : TDateTime;
    Tstationservicefee, Tfueladditionfee,Tcomputefee,Tcoolairfee,
    Tadditionfee,Twaterfee,Tinsurefee, Totherfee:integer;
begin
  inherited;
  if not dsResult.DataSet.Active then
    Exit;
  if dsResult.DataSet.RecordCount < 1 then
    Exit;
  with FrmTicketturnoverreport do
  begin
    FrmTicketturnoverreport := TFrmTicketturnoverreport.Create(Self);
    with jcdsResult do
    begin
      DisableControls;
      try
        First;
        i := 0;
        while not eof do
        begin
          if FieldByName('ischoose').AsBoolean then
          begin
            i := i + 1;
            //if i>1 then
            //begin
            //  SysDialogs.ShowMessage('�ش�ֻ��ѡ��һ�����ݽ��д�ӡ��');
            //  Exit;
            //end;

            //lost:=FieldByName('lost').AsString;
            //lastlost:=FieldByName('lastlost').AsString;
            seller := FieldByName('seller').AsLargeInt;
            if sname <> '' then
            begin
              if sname <> FieldByName('sellername').AsString then
              begin
                SysDialogs.ShowMessage('��ѡ��Ĳ���ͬһ���˵���Ʊ��¼��');
                Locate('id',FieldByName('id').AsString,[]);
                if not (State in [dsEdit,dsInsert]) then
                begin
                  Edit;
                end;
                Exit;
              end;
            end;
            if startdate <> 0 then
            begin
              if startdate > FieldByName('startmoneydate').AsDateTime then
              begin
                startdate := FieldByName('startmoneydate').AsDateTime;
                startno := FieldByName('startticketno').AsString;
              end;
            end else
            begin
              startdate := FieldByName('startmoneydate').AsDateTime;
              startno := FieldByName('startticketno').AsString;
            end;
            if enddate <> 0 then
            begin
              if enddate < FieldByName('endmoneydate').AsDateTime then
              begin
                enddate := FieldByName('endmoneydate').AsDateTime;
                endno := FieldByName('endticketno').AsString;
              end;
            end
            else
            begin
              enddate := FieldByName('endmoneydate').AsDateTime;
              endno := FieldByName('endticketno').AsString;
            end;
            if turntime <> 0 then
            begin
              if turntime < FieldByName('turnovertime').AsDateTime then
              begin
                turntime := FieldByName('turnovertime').AsDateTime;
                lost:=FieldByName('lost').AsString;
              end else
              begin
                lastlost:=FieldByName('lastlost').AsString;
              end;
            end
            else
            begin
              turntime := FieldByName('turnovertime').AsDateTime;
              lost:=FieldByName('lost').AsString;
              lastlost:=FieldByName('lastlost').AsString;
            end;
            startmoneydate := startdate;
            endmoneydate := enddate;
            endticketno := endno;
            startticketno := startno;

            sname := FieldByName('sellername').AsString;
            bookservicefee := bookservicefee + FieldByName('bookservicefee').AsCurrency;
            cancelnum := cancelnum + FieldByName('cancelnum').AsInteger;
            changeservicefee := changeservicefee + FieldByName('changeservicefee').AsCurrency;
            eticketnum := eticketnum + FieldByName('eticketnum').AsInteger;
            moneypayable := moneypayable + FieldByName('moneypayable').AsCurrency;
            noncashmoney := noncashmoney + FieldByName('noncashmoney').AsCurrency;
            noncashnum := noncashnum + FieldByName('noncashnum').AsInteger;
            nonvouchermoneypayable := nonvouchermoneypayable +
            FieldByName('nonvouchermoneypayable').AsCurrency;
            returnhandcharge := returnhandcharge + FieldByName('returnhandcharge').AsCurrency;
            returnmoney := returnmoney + FieldByName('returnmoney').AsCurrency;
            returnnum := returnnum + FieldByName('returnnum').AsInteger;
            sellmoney := sellmoney + FieldByName('sellmoney').AsCurrency;
            sellnum := sellnum + FieldByName('sellnum').AsInteger;
            servicefee := servicefee + FieldByName('servicefee').AsCurrency;
            money := money + FieldByName('money').AsCurrency;
            cancelmoney := cancelmoney + FieldByName('cancelmoney').AsCurrency;
            sellreturntripnum := sellreturntripnum + FieldByName('sellreturntripnum').AsInteger;
            returnprintnum := returnprintnum + FieldByName('returnprintnum').AsInteger;
            billdamagednum := billdamagednum + FieldByName('billdamagednum').AsInteger;

            orgname := FieldByName('orgname').AsString;
            receivername := FieldByName('receivername').AsString;
            remarks := FieldByName('remarks').AsString;
            sellercode := FieldByName('code').AsString;
            sellername := FieldByName('sellername').AsString;
            turnovertime := FieldByName('turnovertime').AsString;

            insuresellnum := insuresellnum + FieldByName('insuresellnum').AsInteger;
            insuresellmoney := insuresellmoney + FieldByName('insuresellmoney').AsCurrency;
            insurereturnnum := insurereturnnum + FieldByName('insurereturnnum').AsInteger;
            insurereturnmoney := insurereturnmoney + FieldByName('insurereturnmoney').AsCurrency;
            insurecancelnum := insurecancelnum + FieldByName('insurecancelnum').AsInteger;
            insurecancelmoney := insurecancelmoney + FieldByName('insurecancelmoney').AsCurrency;
            insuremoneypayable := insuremoneypayable + insuresellmoney-insurereturnmoney-insurecancelmoney;
            //���ֿ۷�
            Tstationservicefee := Tstationservicefee+FieldByName('stationservicefee').AsInteger;
            Tfueladditionfee :=Tfueladditionfee+FieldByName('fueladditionfee').AsInteger;
            Tcomputefee :=Tcomputefee+FieldByName('computefee').AsInteger;
            Tcoolairfee :=Tcoolairfee+FieldByName('coolairfee').AsInteger;
            Tadditionfee :=Tadditionfee+FieldByName('additionfee').AsInteger;
            Twaterfee :=Twaterfee+FieldByName('waterfee').AsInteger;
            Tinsurefee :=Tinsurefee+FieldByName('insurefee').AsInteger;
            Totherfee :=Totherfee +FieldByName('otherfee').AsInteger;

          end;
          Next;
        end;
      finally
        EnableControls;
      end;
      if i < 1 then
      begin
        SysDialogs.ShowMessage('��ѡ��һ�����ݽ��д�ӡ��');
        Exit;
      end;
      billnouse:= startticketno+'-'+endticketno;
      if startmoneydate=endmoneydate then
        moneydate:=DateToStr(startmoneydate)
      else
        moneydate:=DateToStr(startmoneydate)+'--'+datetostr(endmoneydate);

      log := '��ӡ�ѽɿ�ϼƣ��տ����='+FieldByName('orgname').AsString+',��ƱԱ='+
      FieldByName('sellername').AsString+',��Ʊ��='+currtostr(sellmoney)+
      ',��Ʊ��='+inttostr(sellnum)+',ʵ�ɿ�='+currtostr(money)
      +',����Ӧ�ɿ�='+currtostr(moneypayable)+',�տ���='+
      FieldByName('receivername').AsString+',�տ�IP='+FieldByName('receiptip').AsString;
      SysLog.WriteLog('�������->Ӫ�սɿ�','�ش�ɿ',log);
     // ShowReport;
    //�����ֿ۷Ѵ�����ӡ������д�ӡ
     stationservicefee := inttostr(Tstationservicefee);
     fueladditionfee :=inttostr(Tfueladditionfee);
     computefee :=inttostr(Tcomputefee);
     coolairfee :=inttostr(Tcoolairfee);
     additionfee :=inttostr(Tadditionfee);
     waterfee :=inttostr(Twaterfee);
     insurefee :=inttostr(Tinsurefee);
     otherfee :=inttostr(Totherfee);
     nostationfeemoney:=moneypayable-strtocurr(stationservicefee);
     PrintTicketturnover  ;
    end;

    ModalResult := mrok;
    FrmTicketturnoverQuery.Close;
  end;
end;

procedure TFrmTicketturnoverQuery.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  if FormatDateTime('yyyymmdd',dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date) then
    begin
      SysDialogs.ShowMessage('��ʼ���ڲ��ܴ��ڽ�������!');
      exit;
    end;

  with jcdsResult do
  begin
    Active := False;
      Params.ParamValues['filter_GED_t!receipttime'] := FormatDateTime('yyyy-mm-dd', dtpstartdate.DateTime);
      Params.ParamValues['filter_LED_t!receipttime'] := FormatDateTime('yyyy-mm-dd', dtpenddate.DateTime + 1);
      if trim(nvhlpseller.Text) = '' then
      begin
        Params.ParamValues['filter_EQL_t!seller'] := '';
      end else
      begin
        Params.ParamValues['filter_EQL_t!seller'] := nvhlpseller.Id;
      end;
    Active := True;
  end;
end;

procedure TFrmTicketturnoverQuery.tbtnInsertClick(Sender: TObject);
var i,  seller : Integer;
    sname,startno, endno : string;
    startdate, enddate : TDateTime;
begin
  inherited;
  if not dsResult.DataSet.Active then
    Exit;
  if dsResult.DataSet.RecordCount < 1 then
    Exit;
  with FrmTicketturnoverreport do
  begin
    FrmTicketturnoverreport := TFrmTicketturnoverreport.Create(Self);
    with jcdsResult do
    begin
      DisableControls;
      try
        First;
        i := 0;
        while not eof do
        begin
          if FieldByName('ischoose').AsBoolean then
          begin
            i := i + 1;
            if i>1 then
            begin
              SysDialogs.ShowMessage('�ش�ֻ��ѡ��һ�����ݽ��д�ӡ��');
              Exit;
            end;
            ticketturnoverid := FieldByName('id').AsLargeInt;
            endticketno := FieldByName('endticketno').AsString;
            startticketno := FieldByName('startticketno').AsString;
            startmoneydate := FieldByName('startmoneydate').AsDateTime;
            endmoneydate := FieldByName('endmoneydate').AsDateTime;
            lost:=FieldByName('lost').AsString;
            lastlost:=FieldByName('lastlost').AsString;
            seller := FieldByName('seller').AsLargeInt;
            if sname <> '' then
            begin
              if sname <> FieldByName('sellername').AsString then
              begin
                SysDialogs.ShowMessage('��ѡ��Ĳ���ͬһ���˵���Ʊ��¼��');
                Locate('id',FieldByName('id').AsString,[]);
                if not (State in [dsEdit,dsInsert]) then
                begin
                  Edit;
                end;
                Exit;
              end;
            end;
            //���ڹ�������ƱƱ��ѯ�ٶȺ����������ڲ�ѯ��ʱ�򣬲���Ҫ��ʾ��Ʊ�� ����Ʊ�
	   //��������Ʊ������Ʊ��Ĳ�ѯ���ڴ�ӡʱ���ݽɿ�ID ���в�ѯ����ӡ
//            if startdate <> 0 then
//            begin
//              if startdate > FieldByName('startmoneydate').AsDateTime then
//              begin
//                startdate := FieldByName('startmoneydate').AsDateTime;
//                startno := FieldByName('startticketno').AsString;
//              end;
//            end else
//            begin
//              startdate := FieldByName('startmoneydate').AsDateTime;
//              startno := FieldByName('startticketno').AsString;
//            end;
//            if enddate <> 0 then
//            begin
//              if enddate < FieldByName('endmoneydate').AsDateTime then
//              begin
//                enddate := FieldByName('endmoneydate').AsDateTime;
//                endno := FieldByName('endticketno').AsString;
//              end;
//            end
//            else
//            begin
//              enddate := FieldByName('endmoneydate').AsDateTime;
//              endno := FieldByName('endticketno').AsString;
//            end;
//            startmoneydate := startdate;
//            endmoneydate := enddate;
//            endticketno := endno;
//            startticketno := startno;
//            preprice := FieldByName('preprice').AsCurrency;
//            precount := FieldByName('precount').AsInteger;
//            sname := FieldByName('sellername').AsString;
//            bookservicefee := bookservicefee + FieldByName('bookservicefee').AsCurrency;
//            cancelnum := cancelnum + FieldByName('cancelnum').AsInteger;
//            changeservicefee := changeservicefee + FieldByName('changeservicefee').AsCurrency;
//            eticketnum := eticketnum + FieldByName('eticketnum').AsInteger;
//            moneypayable := moneypayable + FieldByName('moneypayable').AsCurrency;
//            noncashmoney := noncashmoney + FieldByName('noncashmoney').AsCurrency;
//            noncashnum := noncashnum + FieldByName('noncashnum').AsInteger;
//            nonvouchermoneypayable := nonvouchermoneypayable +
//            FieldByName('nonvouchermoneypayable').AsCurrency;
//            returnhandcharge := returnhandcharge + FieldByName('returnhandcharge').AsCurrency;
//            returnmoney := returnmoney + FieldByName('returnmoney').AsCurrency;
//            returnnum := returnnum + FieldByName('returnnum').AsInteger;
//            sellmoney := sellmoney + FieldByName('sellmoney').AsCurrency;
//            sellnum := sellnum + FieldByName('sellnum').AsInteger;
//            servicefee := servicefee + FieldByName('servicefee').AsCurrency;
//            money := money + FieldByName('money').AsCurrency;
//            cancelmoney := cancelmoney + FieldByName('cancelmoney').AsCurrency;
//            sellreturntripnum := sellreturntripnum + FieldByName('sellreturntripnum').AsInteger;
//            returnprintnum := returnprintnum + FieldByName('returnprintnum').AsInteger;
//            billdamagednum := billdamagednum + FieldByName('billdamagednum').AsInteger;
//
//            orgname := FieldByName('orgname').AsString;
//            receivername := FieldByName('receivername').AsString;
//            remarks := FieldByName('remarks').AsString;
//            sellercode := FieldByName('code').AsString;
//            sellername := FieldByName('sellername').AsString;
//            turnovertime := FieldByName('turnovertime').AsString;
//
//          stationservicefee:= FieldByName('stationservicefee').AsString;
//          fueladditionfee:= FieldByName('fueladditionfee').AsString;
//          computefee:=FieldByName('computefee').AsString;
//          coolairfee:=FieldByName('coolairfee').AsString;
//          additionfee:= FieldByName('additionfee').AsString;
//          waterfee:= FieldByName('waterfee').AsString;
//          insurefee:= FieldByName('insurefee').AsString;
//          otherfee:=FieldByName('otherfee').AsString;
//
//            insuresellnum := insuresellnum + FieldByName('insuresellnum').AsInteger;
//            insuresellmoney := insuresellmoney + FieldByName('insuresellmoney').AsCurrency;
//            insurereturnnum := insurereturnnum + FieldByName('insurereturnnum').AsInteger;
//            insurereturnmoney := insurereturnmoney + FieldByName('insurereturnmoney').AsCurrency;
//            insurecancelnum := insurecancelnum + FieldByName('insurecancelnum').AsInteger;
//            insurecancelmoney := insurecancelmoney + FieldByName('insurecancelmoney').AsCurrency;
//            insuremoneypayable := insuremoneypayable + insuresellmoney-insurereturnmoney-insurecancelmoney;
          end;
          Next;
        end;
      finally
        EnableControls;
      end;
      if i < 1 then
      begin
        SysDialogs.ShowMessage('��ѡ��һ�����ݽ��д�ӡ��');
        Exit;
      end;
      billnouse:= startticketno+'-'+endticketno;
      if startmoneydate=endmoneydate then
        moneydate:=DateToStr(startmoneydate)
      else
        moneydate:=DateToStr(startmoneydate)+'--'+datetostr(endmoneydate);

      log := '�ش�ɿ���տ����='+jcdsResult.FieldByName('orgname').AsString+',��ƱԱ='+
      jcdsResult.FieldByName('sellername').AsString+',��Ʊ��='+currtostr(sellmoney)+
      ',��Ʊ��='+inttostr(sellnum)+',ʵ�ɿ�='+currtostr(money)
      +',����Ӧ�ɿ�='+currtostr(moneypayable)+',�տ���='+
      jcdsResult.FieldByName('receivername').AsString+',�տ�IP='+jcdsResult.FieldByName('receiptip').AsString;
      SysLog.WriteLog('�������->Ӫ�սɿ�','�ش�ɿ',log);

      ShowReport        //ԭ�������£����ڸĳ� showreport
    end;
//     PrintTicketturnover  // ԭ��
    end;
    ModalResult := mrok;
    FrmTicketturnoverQuery.Close;
    end;



end.
