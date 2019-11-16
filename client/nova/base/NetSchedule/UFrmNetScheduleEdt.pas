unit UFrmNetScheduleEdt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, NovaEdit,
  NovaHelp;

type
  TFrmNetScheduleEdt = class(TSimpleEditForm)
    Label1: TLabel;
    NovaHelp1: TNovaHelp;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmNetScheduleEdt: TFrmNetScheduleEdt;

implementation

{$R *.dfm}

end.
