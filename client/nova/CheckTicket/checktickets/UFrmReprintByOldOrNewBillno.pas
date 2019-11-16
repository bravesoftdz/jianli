unit UFrmReprintByOldOrNewBillno;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls;

type
  TFrmReprintByOldOrNewBillno = class(TSimpleEditForm)
    bbtnoldbillno: TBitBtn;
    bbtnnewbillno: TBitBtn;
    bbtncancel: TBitBtn;
    procedure bbtnoldbillnoClick(Sender: TObject);
    procedure bbtnnewbillnoClick(Sender: TObject);
    procedure bbtncancelClick(Sender: TObject);
  private
    { Private declarations }
  public
    isprintbynewbillno:integer;
    { Public declarations }
  end;

var
  FrmReprintByOldOrNewBillno: TFrmReprintByOldOrNewBillno;

implementation

{$R *.dfm}

procedure TFrmReprintByOldOrNewBillno.bbtncancelClick(Sender: TObject);
begin
  inherited;
  isprintbynewbillno := 3;
  ModalResult := mrok;
end;

procedure TFrmReprintByOldOrNewBillno.bbtnnewbillnoClick(Sender: TObject);
begin
  inherited;
  isprintbynewbillno := 2;
  ModalResult := mrok;
end;

procedure TFrmReprintByOldOrNewBillno.bbtnoldbillnoClick(Sender: TObject);
begin
  inherited;
  isprintbynewbillno := 1;
  ModalResult := mrok;
end;

end.
