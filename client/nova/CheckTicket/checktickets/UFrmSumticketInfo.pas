unit UFrmSumticketInfo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls,
  DBGridEhGrouping, DB, DBClient, jsonClientDataSet, GridsEh, DBGridEh,
  NvDbgridEh, NovaEdit;

type
  TFrmSumticketInfo = class(TSimpleEditForm)
    grp1: TGroupBox;
    nvdbgrdh1: TNvDbgridEh;
    ds1: TDataSource;
    jscdSumtickets: TjsonClientDataSet;
    procedure FormShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
  public
    { Public declarations }
    scheduleplanid_s, vehiclereportid: Int64;
    isworkline: boolean;
  end;

var
  FrmSumticketInfo: TFrmSumticketInfo;

implementation

uses PubFn, Services, UDMPublic,UFrmNoTicketCheck;
{$R *.dfm}

procedure TFrmSumticketInfo.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
//  if Key = VK_F2 then
//  begin
//    if chkChecked.Checked then
//    begin
//      chkChecked.Checked := False;
//    end
//    else
//      chkChecked.Checked := true;
//    chkCheckedClick(Sender);
//  end
//  else if (chkNotChecked.Visible) and  (Key = VK_F3) then
//  begin
//
//    if chkNotChecked.Checked then
//    begin
//      chkNotChecked.Checked := False;
//    end
//    else
//      chkNotChecked.Checked := true;
//    chkNotCheckedClick(Sender);
//  end;

  if (Key = vk_escape) then
    Close;
end;

procedure TFrmSumticketInfo.FormShow(Sender: TObject);
begin
  inherited;
   with jscdSumtickets do
  begin
    Active := False;
      Params.ParamValues['scheduleplanid'] := scheduleplanid_s;

    Active := true;
  end;
end;


end.
