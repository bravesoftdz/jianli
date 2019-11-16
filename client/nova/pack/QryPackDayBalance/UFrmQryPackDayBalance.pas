unit UFrmQryPackDayBalance;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, Services, NovaEdit;

type
  TFrmQryPackDayBalance = class(TSimpleCRUDForm)
    sendBdepartdate: TDateTimePicker;
    sendEdepartdate: TDateTimePicker;
    lbl2: TLabel;
    lbl1: TLabel;
    jcdsdatatypesname: TjsonClientDataSet;
    jcdsResultdatatype: TWideStringField;
    jcdsResultdatatypename: TWideStringField;
    jcdsResultdepartinvoicesno: TWideStringField;
    jcdsResultbalanceamount: TFloatField;
    jcdsResultshenhejine: TFloatField;
    jcdsauditsname: TjsonClientDataSet;
    departinvoicesno: TNovaEdit;
    Label4: TLabel;
    jcdsResultisaudit: TBooleanField;
    jcdspacdepardinvoiceskaudit: TjsonClientDataSet;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure departinvoicesnoExit(Sender: TObject);
    procedure departinvoicesnoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmQryPackDayBalance: TFrmQryPackDayBalance;

implementation

{$R *.dfm}

procedure TFrmQryPackDayBalance.departinvoicesnoExit(Sender: TObject);
begin
  inherited;

  // if departinvoicesno.Text <> '' then
  // begin
  // with jcdspacdepardinvoiceskaudit do
  // begin
  // Close;
  // Params.ParamValues['packdepartinvoices.departinvoicesno'] := trim
  // (departinvoicesno.Text);
  // departinvoicesno.clear;
  // Execute;
  // SysDialogs.showmessage(Params.ParamValues['msg']);
  // end ;
  // end
  // else
  // departinvoicesno.SetFocus;
  //
  //
  // tbtnFilter.Click;

end;

procedure TFrmQryPackDayBalance.departinvoicesnoKeyPress(Sender: TObject;
  var Key: Char);
var
  temp: String;
begin
  inherited;
  if Key = #13 then
  begin

    if departinvoicesno.Text <> '' then
    begin
      // temp := departinvoicesno.Text;
      with jcdspacdepardinvoiceskaudit do
      begin
        Close;
        Params.ParamValues['packdepartinvoices.departinvoicesno'] := trim
          (departinvoicesno.Text);
        departinvoicesno.clear;
        Execute;
//        tbtnFilter.Click;
        SysDialogs.showmessage(Params.ParamValues['msg']);
        tbtnFilter.Click;

        departinvoicesno.SetFocus;
        departinvoicesno.Text := temp;
        departinvoicesno.SelectAll;
      end;
    end
    else
      departinvoicesno.SetFocus;

  end;

end;

procedure TFrmQryPackDayBalance.FormShow(Sender: TObject);
begin
  inherited;
  sendBdepartdate.DateTime := now();
  sendEdepartdate.DateTime := now();
  tbtnFilter.Click;
  departinvoicesno.SetFocus;

end;

procedure TFrmQryPackDayBalance.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active := False;
    if (FormatDateTime('yyyymmdd', sendBdepartdate.Date) > FormatDateTime
        ('yyyymmdd', sendEdepartdate.Date)) then
    begin
      SysDialogs.showmessage('开始日期不能大于结束日期！');
      exit;
    end;

    Params.ParamValues['filter_GED_p!departdate'] := FormatDateTime
      ('yyyy-mm-dd', sendBdepartdate.Date);
    Params.ParamValues['filter_LED_p!departdate'] := FormatDateTime
      ('yyyy-mm-dd', sendEdepartdate.Date);
    Active := True;
  end;

end;

end.
