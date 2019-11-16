unit UFrmCardValidate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, GridsEh,
  DBGridEh, NvDbgridEh, DB, DBClient, jsonClientDataSet, DBGridEhGrouping;

type
  TFrmCardValidate = class(TSimpleEditForm)
    dbgrdhResult: TNvDbgridEh;
    dsResult: TDataSource;
    jcdsCercate: TClientDataSet;
    jcdsCercatecardName: TWideStringField;
    jcdsCercatecardNo: TWideStringField;
    jcdsCercateendate: TDateField;
    jcdsCercatedays: TLargeintField;
    procedure FormResize(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmCardValidate: TFrmCardValidate;

implementation

{$R *.dfm}

procedure TFrmCardValidate.FormResize(Sender: TObject);
begin
//  inherited;

end;

procedure TFrmCardValidate.FormShow(Sender: TObject);
begin
  inherited;
  bbtnClose.Left:=((FrmCardValidate.Width) div 2)-35;
end;

end.
