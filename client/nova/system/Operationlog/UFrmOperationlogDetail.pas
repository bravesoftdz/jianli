unit UFrmOperationlogDetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaEdit, ComCtrls, DB,
  DBClient, jsonClientDataSet, NovaComboBox,Services, NovaHComboBox, NovaHelp,
  ImgList;

type
  TfrmOperationlogDetail = class(TSimpleEditForm)
    lbl3: TLabel;
    lbl4: TLabel;
    jcdsSave: TjsonClientDataSet;
    lblWorkstatus: TLabel;
    edtMode: TNovaEdit;
    lbl1: TLabel;
    lbl5: TLabel;
    edtTime: TNovaEdit;
    lbl6: TLabel;
    mmoContent: TMemo;
    edtType: TNovaEdit;
    edtIP: TNovaEdit;
    edtUsername: TNovaEdit;
  private
    { Private declarations }
  public
    { Public declarations }
    id:Integer;createby,createtime:string;
  end;

var
  frmOperationlogDetail: TfrmOperationlogDetail;

implementation

{$R *.dfm}

end.
