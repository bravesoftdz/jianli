unit UFrmTicketTurnOverOtherAdd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaHelp, NovaEdit, services, PubFn, StrUtils, UDMPublic,
  NovaPrint, FunctionItemIntf, DateUtils, math, Buttons,
  USimpleEditForm,Generics.Collections, NovaHComboBox;

type
  TFrmTicketTurnOverOtherAdd = class(TSimpleEditForm)
    jcdsSave: TjsonClientDataSet;
    lbl4: TLabel;
    Label3: TLabel;
    dtpdate: TDateTimePicker;
    nvhcbbOrg: TNovaHComboBox;
    Label9: TLabel;
    nvhelpUserid: TNovaHelp;
    Label2: TLabel;
    lbl19: TLabel;
    mmo1: TMemo;
    chkautoprint: TCheckBox;
    nvedtMoney: TNovaEdit;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    function initReturnTicketPrinter: boolean;
    procedure chkautoprintClick(Sender: TObject);
  private
    ReturnTicketPrinter: TNovaPrint;
    printValue: TDictionary<String, String>; // ���������
  public
    nResult, id: int64;
    sResult: String;
  end;

var
  FrmTicketTurnOverOtherAdd: TFrmTicketTurnOverOtherAdd;

implementation

// uses
{$R *.dfm}

procedure TFrmTicketTurnOverOtherAdd.bbtnSaveClick(Sender: TObject);
begin
  inherited;
  if (Trim(nvedtMoney.Text) = '') then
  begin
    SysDialogs.ShowMessage('������ɿ��');
    nvedtMoney.SetFocus;
    Exit;
  end;
  // �ж��Ƿ�Ϊ��Ч���
  try
    strtoFloat(nvedtMoney.Text);
  except
    SysDialogs.ShowMessage('������Ϸ��ɿ��');
    Exit;
  end;

  if (Trim(nvhelpUserid.Text) = '') or (nvhelpUserid.id = 0) then
  begin
    SysDialogs.ShowMessage('��������ƱԱ��');
    nvhelpUserid.SetFocus;
    Exit;
  end;
  with jcdsSave do
  begin
    Params.ParamValues['ticketTurnOverOther.tickettime'] := FormatDateTime
      ('yyyy-mm-dd', dtpdate.DateTime);
    Params.ParamValues['ticketTurnOverOther.orgid'] := nvhcbbOrg.HelpFieldValue
      ['id'];
    Params.ParamValues['ticketTurnOverOther.money'] := nvedtMoney.Text;
    Params.ParamValues['ticketTurnOverOther.seller'] :=
      nvhelpUserid.HelpFieldValue['id'];
    Params.ParamValues['ticketTurnOverOther.remarks'] := mmo1.Text;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        nvedtMoney.SetFocus;
      end
      else
      begin
        self.ModalResult := mrok;
        if chkautoprint.Checked  then
        begin
          printValue := TDictionary<String, String>.Create;
//          ReturnTicketPrinter := TNovaPrint.Create(self,
//          TNovaPrint.GetTicketModelName('�ֹ���', '�ֹ���'));
          printValue.Clear;
          printValue.AddOrSetValue('moneydate',FormatDateTime('yyyy-mm-dd', dtpdate.Date));
          printValue.AddOrSetValue('orgname',nvhcbbOrg.HelpFieldValue['name']);
          printValue.AddOrSetValue('money',Trim(nvedtMoney.Text));
          printValue.AddOrSetValue('seller',nvhelpUserid.Text);
          printValue.AddOrSetValue('remark',mmo1.Text);
          ReturnTicketPrinter.SingleValue := printValue;
          ReturnTicketPrinter.Print;
        end;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('�ֹ����ɿ�ʧ�ܣ�' + E.Message);
      end;
    end;

  end;
end;



  procedure TFrmTicketTurnOverOtherAdd.chkautoprintClick(Sender: TObject);
begin
  inherited;
  if chkautoprint.Checked  then
  begin
    initReturnTicketPrinter;
  end;
end;

procedure TFrmTicketTurnOverOtherAdd.FormCreate(Sender: TObject);
  begin

    nvhcbbOrg.Active := False;
    nvhcbbOrg.Active := true;
    nvhcbbOrg.SetItemIndexByField('id', SysInfo.LoginUserInfo.OrgID);
    dtpdate.DateTime := Now;
    //initReturnTicketPrinter;
  end;

  function TFrmTicketTurnOverOtherAdd.initReturnTicketPrinter: boolean;
  var
    temp: string;
  begin
    inherited;
    result := False;
    try
      ReturnTicketPrinter := TNovaPrint.Create(self,
        TNovaPrint.GetTicketModelName('�ֹ���', '�ֹ���'));
      if ReturnTicketPrinter <> nil then
        result := true
      else
        SysDialogs.ShowError('��ʼ���ֹ�����ӡģ��ʧ�ܣ�δ֪����');
    except
      on E: Exception do
        SysDialogs.ShowError('��ʼ���ֹ�����ӡģ��ʧ�ܣ�' + E.Message);
    end;

  end;

end.
