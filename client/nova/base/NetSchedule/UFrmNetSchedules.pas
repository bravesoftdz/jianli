unit UFrmNetSchedules;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleCRUDForm, NvPrnDbgeh, DB, DBClient, jsonClientDataSet,
  ImgList, GridsEh, DBGridEh, NvDbgridEh, StdCtrls, ComCtrls, ToolWin, ExtCtrls;

type
  TFrmNetSchedules = class(TSimpleCRUDForm)
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmNetSchedules: TFrmNetSchedules;

implementation

{$R *.dfm}

end.
