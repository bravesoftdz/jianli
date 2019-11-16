unit UFrmQueryTicketturnoverSeller;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, DBGridEhGrouping, NvPrnDbgeh, DB, DBClient,
  jsonClientDataSet, ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls,
  ToolWin, ExtCtrls, NovaEdit, NovaHelp;

type
  TFrmQueryTicketturnoverSeller = class(TSimpleCRUDForm)
    lbl11: TLabel;
    dtpBdepartdate: TDateTimePicker;
    lbl4: TLabel;
    nvhlphandle: TNovaHelp;
    procedure FormCreate(Sender: TObject);
    procedure tbtnFilterClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmQueryTicketturnoverSeller: TFrmQueryTicketturnoverSeller;

implementation

{$R *.dfm}

procedure TFrmQueryTicketturnoverSeller.FormCreate(Sender: TObject);
begin
  inherited;
  dtpBdepartdate.Date := Now;
end;

procedure TFrmQueryTicketturnoverSeller.tbtnFilterClick(Sender: TObject);
begin
  inherited;
  with jcdsResult do
  begin
    Active := False;
      Params.ParamValues['seller'] := nvhlphandle.Id;
      Params.ParamValues['moneydate'] := FormatDateTime('yyyy-mm-dd',dtpBdepartdate.Date);
    Active := True;
  end;
end;

end.
