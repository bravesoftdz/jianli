unit UFrmSellerDepartinvoices;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp, NovaCheckedComboBox;

type
  TFrmSellerDepartinvoices = class(TSimpleCRUDForm)
    Label2: TLabel;
    lbl2: TLabel;
    dtpstartdate: TDateTimePicker;
    dtpenddate: TDateTimePicker;
    Label1: TLabel;
    cbborg: TNovaCheckedComboBox;
    nvhlpseller: TNovaHelp;
    Label3: TLabel;
    procedure tbtnFilterClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmSellerDepartinvoices: TFrmSellerDepartinvoices;

implementation
uses Services,UDMPublic;
{$R *.dfm}

procedure TFrmSellerDepartinvoices.FormShow(Sender: TObject);
begin
  inherited;
  dtpstartdate.DateTime := Now;
  dtpenddate.DateTime := Now;
  cbborg.Active := False;
  cbborg.Active := True;
end;

procedure TFrmSellerDepartinvoices.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  if FormatDateTime('yyyy-mm-dd', dtpstartdate.Date) > FormatDateTime('yyyy-mm-dd',
    dtpenddate.Date) then
  begin
    SysDialogs.ShowMessage('开始日期不能大于结束日期！');
    exit;
  end;
  with jcdsResult do
  begin
    Active := False;
    Params.ParamValues['departstartdate'] := FormatDateTime('yyyy-mm-dd', dtpstartdate.DateTime);
    Params.ParamValues['departenddate'] := FormatDateTime('yyyy-mm-dd', dtpenddate.DateTime);
    Params.ParamValues['orgids'] := cbborg.GetSelectID;
    Params.ParamValues['sellerid'] := nvhlpseller.Id;
    Active := True;
  end;
end;

end.
