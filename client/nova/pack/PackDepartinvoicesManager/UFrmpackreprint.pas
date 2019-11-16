unit UFrmpackreprint;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls;

type
  TFrmpackreprint = class(TSimpleEditForm)
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
  Frmpackreprint: TFrmpackreprint;

implementation

{$R *.dfm}

procedure TFrmpackreprint.bbtncancelClick(Sender: TObject);
begin
  inherited;
  isprintbynewbillno := 3;
  ModalResult := mrok;
end;

procedure TFrmpackreprint.bbtnnewbillnoClick(Sender: TObject);
begin
  inherited;
  isprintbynewbillno := 2;
  ModalResult := mrok;
end;

procedure TFrmpackreprint.bbtnoldbillnoClick(Sender: TObject);
begin
  inherited;
  isprintbynewbillno := 1;
  ModalResult := mrok;
end;

end.
