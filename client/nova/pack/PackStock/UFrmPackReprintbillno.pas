unit UFrmPackReprintbillno;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls;

type
  TFrmPackReprintbillno = class(TSimpleEditForm)
    bbtnoldbillno: TBitBtn;
    bbtnnewbillno: TBitBtn;
    bbtncancel: TBitBtn;
    procedure bbtnoldbillnoClick(Sender: TObject);
    procedure bbtnnewbillnoClick(Sender: TObject);
    procedure bbtncancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    isprintbynewbillno:integer;
  end;

var
  FrmPackReprintbillno: TFrmPackReprintbillno;

implementation

{$R *.dfm}

procedure TFrmPackReprintbillno.bbtncancelClick(Sender: TObject);
begin
  inherited;
  isprintbynewbillno := 3;
  ModalResult := mrok;
end;

procedure TFrmPackReprintbillno.bbtnnewbillnoClick(Sender: TObject);
begin
  inherited;
  isprintbynewbillno := 2;
  ModalResult := mrok;
end;

procedure TFrmPackReprintbillno.bbtnoldbillnoClick(Sender: TObject);
begin
  inherited;
  isprintbynewbillno := 1;
  ModalResult := mrok;
end;

end.
