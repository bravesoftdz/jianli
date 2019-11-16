unit UFrmTicketPriceFormulaEdt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaHComboBox,
  NovaEdit, ComCtrls, DB, DBClient, jsonClientDataSet, ImgList;

type
  TFrmTicketPriceFormulaEdt = class(TSimpleEditForm)
    Label1: TLabel;
    NovaHCbbTicketType: TNovaHComboBox;
    Label2: TLabel;
    Label3: TLabel;
    DateTpFromDate: TDateTimePicker;
    DateTpEndDate: TDateTimePicker;
    Label4: TLabel;
    MeRemark: TMemo;
    Label5: TLabel;
    NovaEdtFormula: TNovaEdit;
    jcdsSaveFormula: TjsonClientDataSet;
    Label11: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    labIsFullType: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    NovaHCbbOrg: TNovaHComboBox;
    procedure NovaEdtFormulaKeyPress(Sender: TObject; var Key: Char);
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure NovaHCbbTicketTypeChange(Sender: TObject);
  private
    { Private declarations }
    log : String;
  public
    { Public declarations }
    id, createby,orgid: int64;
    createtime,tickettypename,relatetypename:string;
  end;

var
  FrmTicketPriceFormulaEdt: TFrmTicketPriceFormulaEdt;

implementation
uses PubFn,Services, UDMPublic;
{$R *.dfm}

procedure TFrmTicketPriceFormulaEdt.bbtnSaveClick(Sender: TObject);
var
  msg: String;
  nResult: integer;
  sResult: string;
  item,preitem:Char;
  str,result:string;
  i,leftcount,rightcount:integer;
begin
  inherited;

  if NovaHCbbTicketType.ItemIndex<0 then
  begin
    NovaHCbbTicketType.SetFocus;
    SysDialogs.Warning('��ѡ��Ʊ�֣�');
    exit;
  end;
  if (trunc(DateTpFromDate.DateTime)>trunc(DateTpEndDate.DateTime)) then
  begin
    DateTpFromDate.SetFocus;
    SysDialogs.Warning('��ʼ���ڲ��ܴ��ڽ������ڣ�');
    exit;
  end;

  if (trim(NovaEdtFormula.Text) = '') then
  begin
    NovaEdtFormula.SetFocus;
    SysDialogs.Warning('������Ʊ�۹�ʽ��');
    exit;
  end;

  if (NovaHCbbTicketType.HelpFieldValue['code']='S') then
  begin
    str:=NovaEdtFormula.Text;
    for I := 1 to length(str) do
    begin
      item:=str[i];
      if (item='Q')  then
      begin
        NovaEdtFormula.SetFocus;
        SysDialogs.Warning('����Ʊ�۹�ʽ�в��ܰ���Q����');
        exit;
      end;
    end;
  end
  else if (NovaHCbbTicketType.HelpFieldValue['code']='U') then
  begin
    str:=NovaEdtFormula.Text;
    for I := 1 to length(str) do
    begin
      item:=str[i];
      if (item='Q')  then
      begin
        NovaEdtFormula.SetFocus;
        SysDialogs.Warning('����Ʊ�۹�ʽ�в��ܰ���Q����');
        exit;
      end;
    end;
  end
  else if (NovaHCbbTicketType.HelpFieldValue['code']='Q') then
  begin
    str:=NovaEdtFormula.Text;
    for I := 1 to length(str) do
    begin
      item:=str[i];
      if (item='Q')  then
      begin
        NovaEdtFormula.SetFocus;
        SysDialogs.Warning('ȫƱ��ʽ�в��ܰ���Q����');
        exit;
      end;
    end;
  end
  else if (NovaHCbbTicketType.HelpFieldValue['code']='X') then
  begin
    str:=NovaEdtFormula.Text;
    for I := 1 to length(str) do
    begin
      item:=str[i];
      if (item='Q')  then
      begin
        NovaEdtFormula.SetFocus;
        SysDialogs.Warning('ѧ��Ʊ��ʽ�в��ܰ���Q����');
        exit;
      end;
    end;
  end
  else if (NovaHCbbTicketType.HelpFieldValue['code']='B') then
  begin
    str:=NovaEdtFormula.Text;
    for I := 1 to length(str) do
    begin
      item:=str[i];
      if (item='Q')  then
      begin
        NovaEdtFormula.SetFocus;
        SysDialogs.Warning('��Ʊ��ʽ�в��ܰ���Q����');
        exit;
      end;
    end;
  end
  else
  begin
    str:=NovaEdtFormula.Text;
    for I := 1 to length(str) do
    begin
      item:=str[i];
      if (item in ['A' .. 'Z', 'a' .. 'z'])
         and (item<>'Q')  then
      begin
        NovaEdtFormula.SetFocus;
        SysDialogs.Warning(NovaHCbbTicketType.text+'��ʽ��ֻ�ܰ���Q����');
        exit;
      end;
    end;
  end;
  leftcount:=0;
  rightcount:=0;
  if length(NovaEdtFormula.Text)>1 then
  begin
    str:=NovaEdtFormula.Text;
    for I := 1 to length(str) do
    begin
      item:=str[i];
      preitem :=str[i+1];
      if ((item in ['A' .. 'Z', 'a' .. 'z']) and (preitem in ['0'..'9']))
      or (preitem in ['A' .. 'Z', 'a' .. 'z']) and (item in ['0'..'9'])
      or ((item in ['A' .. 'Z', 'a' .. 'z']) and (preitem in  ['A' .. 'Z', 'a' .. 'z']))
      or (preitem in ['A' .. 'Z', 'a' .. 'z']) and (item in ['A' .. 'Z', 'a' .. 'z'])
      or ((item in ['+','-','/','*','.']) and (preitem in ['+','-','/','*','.']))
      then
      begin
         SysDialogs.Warning('Ʊ�۹�ʽ�����������������Ƿ���ȷ��');
         //NovaEdtFormula.Text:=copy(str,1,i)+copy(str,i+2,length(str));
         NovaEdtFormula.SetFocus;
         exit;
      end;
      if item='(' then
        leftcount:=leftcount+1;
      if item=')' then
        rightcount:=rightcount+1;

    end;
    if leftcount<>rightcount then
      begin
         SysDialogs.Warning('Ʊ�۹�ʽ�����������ԣ����������Ƿ���ȷ��');
         NovaEdtFormula.SetFocus;
         exit;
      end;
  end;



  with jcdsSaveFormula do
  begin
    close;
    Params.ParamByName('ticketpriceformula.orgid').Value := NovaHCbbOrg.HelpFieldValue
      ['id'];
    Params.ParamByName('ticketpriceformula.id').Value := id;
    Params.ParamByName('ticketpriceformula.tickettypeid').Value := NovaHCbbTicketType.HelpFieldValue['id'];
    Params.ParamByName('ticketpriceformula.isdefault').Value := NovaHCbbTicketType.HelpFieldValue['isdefault'];
    Params.ParamByName('ticketpriceformula.startdate').Value := FormatDateTime('yyyy-mm-dd', DateTpFromDate.DateTime);
    Params.ParamByName('ticketpriceformula.enddate').Value := FormatDateTime('yyyy-mm-dd', DateTpEndDate.DateTime);
    Params.ParamByName('ticketpriceformula.formula').Value := trim(NovaEdtFormula.Text);
    Params.ParamByName('ticketpriceformula.remarks').Value := trim(MeRemark.Text);
    Params.ParamByName('ticketpriceformula.createby').Value := createby;
    Params.ParamByName('ticketpriceformula.createtime').Value := createtime;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        NovaEdtFormula.SetFocus;
      end
      else
      begin
        if id > 0 then
          result := '�޸�'
        else
          result := '���';
        log := result+'Ʊ�۹�ʽ��Ʊ��='+NovaHCbbTicketType.Text+',��ʼ����='+
        FormatDateTime('yyyy-mm-dd', DateTpFromDate.DateTime)+',��������='+
        FormatDateTime('yyyy-mm-dd', DateTpEndDate.DateTime)+',��ʽ='+
        NovaEdtFormula.Text+',��ע='+MeRemark.Text;
        SysLog.WriteLog('Ʊ�۹�����>Ʊ�۹�ʽ',result,log);
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('Ʊ�۹�ʽ����ʧ�ܣ�' + E.Message);
      end;
    end;
  end;

end;

procedure TFrmTicketPriceFormulaEdt.FormShow(Sender: TObject);
begin
  inherited;
  NovaHCbbTicketType.Active:=false;
  NovaHCbbTicketType.Active:=true;
  NovaHCbbOrg.Active := false;
  NovaHCbbOrg.Active := true;
  if edittype=TEdittype.update then
  begin
    NovaHCbbTicketType.ItemIndex:=NovaHCbbTicketType.Items.IndexOf(tickettypename);
    NovaHCbbOrg.SetItemIndexByField('id',orgid);
    NovaHCbbOrg.Enabled:=false;
  end
  else
  begin
    DateTpFromDate.Date:=now;
    DateTpEndDate.Date:=now;
  end;
end;

procedure TFrmTicketPriceFormulaEdt.NovaEdtFormulaKeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if not(Key in ['0'..'9','.','A' .. 'Z', 'a' .. 'z','-','*','/','+','(',')',#8,#13]) then
    Key := #0;
end;

procedure TFrmTicketPriceFormulaEdt.NovaHCbbTicketTypeChange(Sender: TObject);
begin
  inherited;
  if (NovaHCbbTicketType.ItemIndex>=0) and
   (NovaHCbbTicketType.HelpFieldValue['code']='Q')  then
  begin
    labIsFullType.Visible:=false;
  end
  else
    labIsFullType.Visible:=true;
end;

end.
