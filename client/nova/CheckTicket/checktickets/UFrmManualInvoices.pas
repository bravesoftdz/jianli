unit UFrmManualInvoices;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, NovaEdit,
  NovaHelp;

type
  TFrmManualInvoices = class(TSimpleEditForm)
    Label1: TLabel;
    NovaEdtInvoicesNO: TNovaEdit;
    Label2: TLabel;
    Label3: TLabel;
    NovaHPrintBy: TNovaHelp;
    Label4: TLabel;
    EdtTicketnum: TEdit;
    Label5: TLabel;
    EdtTotalPrice: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    EdtDepartdate: TEdit;
    EdtSchCode: TEdit;
    Label10: TLabel;
    EdtRoute: TEdit;
    EdtBustable: TEdit;
    Label11: TLabel;
    EdtDepartTime: TEdit;
    EdtUnitName: TEdit;
  private
    { Private declarations }
  public
    { Public declarations }
    scheduleplanid,vehiclereportid:int64;
  end;

var
  FrmManualInvoices: TFrmManualInvoices;

implementation

{$R *.dfm}

end.
