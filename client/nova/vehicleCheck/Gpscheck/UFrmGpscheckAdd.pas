unit UFrmGpscheckAdd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, ImgList, StdCtrls, Buttons, ExtCtrls, ComCtrls,
  NovaEdit, NovaHelp, NovaHComboBox, DBGridEhGrouping, GridsEh, DBGridEh,
  NvDbgridEh;

type
  TFrmDepartinvoicesotherAdd = class(TSimpleEditForm)
    lbl10: TLabel;
    lbl11: TLabel;
    lbl2: TLabel;
    Label3: TLabel;
    lbl8: TLabel;
    lbl1: TLabel;
    lbl9: TLabel;
    lbl13: TLabel;
    lbl3: TLabel;
    lbl6: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    Label4: TLabel;
    lbl5: TLabel;
    lbldriver3id: TLabel;
    lbl7: TLabel;
    lbldriver2id: TLabel;
    lbldriver4id: TLabel;
    lblsteward2id: TLabel;
    rgreturntrip: TRadioGroup;
    rgoriginator: TRadioGroup;
    nvhlpvehicle: TNovaHelp;
    nvhlpschedule: TNovaHelp;
    edtDepartinvoicesno: TNovaEdit;
    nvhlpdepartstation: TNovaHelp;
    dtpdepartdate: TDateTimePicker;
    edtdeparttime: TDateTimePicker;
    dtpselfdepartdate: TDateTimePicker;
    cbbdriver1id: TNovaHelp;
    cbbdriver2id: TNovaHelp;
    cbbdriver3id: TNovaHelp;
    cbbdriver4id: TNovaHelp;
    cbbsteward1id: TNovaHelp;
    cbbsteward2id: TNovaHelp;
    nvhlptime: TNovaEdit;
    grp1: TGroupBox;
    Label5: TLabel;
    lbl4: TLabel;
    nvhlpstation: TNovaHelp;
    nvhlpendstation: TNovaHelp;
    Label6: TLabel;
    Label7: TLabel;
    cbbtickettype: TNovaHComboBox;
    edtdistance: TNovaEdit;
    Label8: TLabel;
    Label9: TLabel;
    edtticketprice: TNovaEdit;
    edtnum: TNovaEdit;
    Label11: TLabel;
    Label12: TLabel;
    edtstationservicefree: TNovaEdit;
    edtotherfee: TNovaEdit;
    Label13: TLabel;
    lbl19: TLabel;
    edtagentfee: TNovaEdit;
    edtbalanceamount: TNovaEdit;
    nvhlpstation1: TNovaHelp;
    nvhlpendstation1: TNovaHelp;
    cbbtickettype1: TNovaHComboBox;
    edtdistance1: TNovaEdit;
    edtticketprice1: TNovaEdit;
    edtnum1: TNovaEdit;
    edtstationservicefree1: TNovaEdit;
    edtotherfee1: TNovaEdit;
    edtagentfee1: TNovaEdit;
    edtbalanceamount1: TNovaEdit;
    procedure edtticketpriceChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmDepartinvoicesotherAdd: TFrmDepartinvoicesotherAdd;

implementation

{$R *.dfm}

procedure TFrmDepartinvoicesotherAdd.edtticketpriceChange(Sender: TObject);
begin
  inherited;
  edtbalanceamount.Text := formatfloat('0.00',StrToFloat(edtticketprice.Text)*StrToInt(edtnum.Text)-
  StrToFloat(edtstationservicefree.Text)-StrToFloat(edtotherfee.Text)-StrToFloat(edtagentfee.Text));
end;

end.
