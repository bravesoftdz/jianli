unit UFrmSeatnumEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, DB, DBClient,
  jsonClientDataSet, ImgList, ComCtrls;

type
  TFrmSeatnumEdit = class(TSimpleEditForm)
    lblorgid: TLabel;
    lblschedule: TLabel;
    lbldepartdate: TLabel;
    edtroute: TNovaEdit;
    edtschedule: TNovaEdit;
    edtplanvehicle: TNovaEdit;
    lblplanvehicle: TLabel;
    jsonCDSSeatnumSave: TjsonClientDataSet;
    lbl2: TLabel;
    edtreservenum: TNovaEdit;
    edtsoldeatnum: TNovaEdit;
    lbl1: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    edtseatnum: TNovaEdit;
    dtp1: TDateTimePicker;
    Label3: TLabel;
    edtnum: TNovaEdit;
    edtstartdate: TDateTimePicker;
    lblseatnum: TLabel;
    edtday: TNovaEdit;
    procedure bbtnSaveClick(Sender: TObject);
    procedure edtseatnumChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    id, scheduleid : string;
    sign : Boolean;
    departdate : TDateTime;
  end;

var
  FrmSeatnumEdit: TFrmSeatnumEdit;

implementation

uses Services;
{$R *.dfm}

procedure TFrmSeatnumEdit.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult: string;
begin
  with jsonCDSSeatnumSave do
  begin
    Close;
    if StrToInt(edtseatnum.Text) < (StrToInt(edtsoldeatnum.Text) + StrToInt(edtreservenum.Text)) then
    begin
      SysDialogs.ShowMessage('调整后的座位数不能少于已售座位数加上留位数！');
      edtseatnum.SetFocus;
      Exit;
    end;

    Params.ParamByName('plan.id').Value := id;
    Params.ParamByName('plan.seatnum').Value := edtseatnum.Text;
    Params.ParamByName('day').Value := edtday.Text;
    Params.ParamByName('plan.scheduleid').Value := scheduleid;
    Params.ParamByName('plan.departdate').Value := DateTimeToStr(edtstartdate.DateTime);
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        edtseatnum.SetFocus;
      end else
      begin
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('计划座位数调整失败：' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmSeatnumEdit.edtseatnumChange(Sender: TObject);
begin
  inherited;if Trim(edtday.Text) = '' then
  begin
    dtp1.DateTime := departdate;
  end else
  begin
    dtp1.DateTime := departdate + StrToInt(edtday.Text) - 1;
  end;
end;

end.
