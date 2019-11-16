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
    printValue: TDictionary<String, String>; // 输出单变量
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
    SysDialogs.ShowMessage('请输入缴款金额！');
    nvedtMoney.SetFocus;
    Exit;
  end;
  // 判断是否为有效金额
  try
    strtoFloat(nvedtMoney.Text);
  except
    SysDialogs.ShowMessage('请输入合法缴款金额！');
    Exit;
  end;

  if (Trim(nvhelpUserid.Text) = '') or (nvhelpUserid.id = 0) then
  begin
    SysDialogs.ShowMessage('请输入售票员！');
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
//          TNovaPrint.GetTicketModelName('手工单', '手工单'));
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
        SysLog.WriteErr('手工单缴款失败：' + E.Message);
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
        TNovaPrint.GetTicketModelName('手工单', '手工单'));
      if ReturnTicketPrinter <> nil then
        result := true
      else
        SysDialogs.ShowError('初始化手工单打印模板失败，未知错误');
    except
      on E: Exception do
        SysDialogs.ShowError('初始化手工单打印模板失败：' + E.Message);
    end;

  end;

end.
