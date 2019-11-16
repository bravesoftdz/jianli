unit UFrmQueryTicketturnover;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp, Menus;

type
  TFrmQueryTicketturnover = class(TSimpleCRUDForm)
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
    NvDbgridEh1: TNvDbgridEh;
    jcdsstatus1: TjsonClientDataSet;
    ds1: TDataSource;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure jcdsResultAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
    log : String;

  public
    { Public declarations }
  end;

var
  FrmQueryTicketturnover: TFrmQueryTicketturnover;

implementation

uses Services, PubFn,UDMPublic;
{$R *.dfm}

procedure TFrmQueryTicketturnover.FormCreate(Sender: TObject);
begin
  inherited;
  dtpstartdate.DateTime := Now();
  dtpenddate.DateTime := Now();
  //nvhlpseller.Id := SysInfo.LoginUserInfo.UserID;
 // nvhlpseller.Text := SysInfo.LoginUserInfo.UserName;

end;

procedure TFrmQueryTicketturnover.jcdsResultAfterScroll(DataSet: TDataSet);
begin
  inherited;
  with jcdsstatus1 do
  begin
    Active := False;
      Params.ParamValues['filter_EQL_t!ticketturnover.id'] := jcdsResult.FieldByName('id').AsInteger;
    Active := True;
  end;
end;

procedure TFrmQueryTicketturnover.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  if FormatDateTime('yyyymmdd', dtpstartdate.Date) > FormatDateTime('yyyymmdd',
    dtpenddate.Date) then
  begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期！');
    exit;
  end;
  if StrToInt(getParametervalue('0007', Sysinfo.LoginUserInfo.OrgID))
      <= Trunc(dtpenddate.Date-dtpstartdate.Date)
    then
  begin
      SysDialogs.Warning('选择日期的天数差超过系统设置的最大可查询天数,请重新选择');
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

end.
