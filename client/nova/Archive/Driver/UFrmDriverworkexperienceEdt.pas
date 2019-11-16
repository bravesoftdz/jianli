unit UFrmDriverworkexperienceEdt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, ComCtrls, NovaComboBox,
  NovaEdit, DB, DBClient, jsonClientDataSet,Services, ImgList;

type
  TfrmDriverworkexperience = class(TSimpleEditForm)
    nvedtPosition: TNovaEdit;
    lbl11: TLabel;
    lbl15: TLabel;
    nvedtWorkunit: TNovaEdit;
    lbl16: TLabel;
    lbl17: TLabel;
    dtpBegindate: TDateTimePicker;
    dtpEnddate: TDateTimePicker;
    jcdsSaveWork: TjsonClientDataSet;
    mmoMeRemark: TMemo;
    lbl1: TLabel;
    lbl3: TLabel;
    lbl2: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    createby,createtime,driverid:String;
    id:Integer;
    isedt:boolean;

  end;

var
  frmDriverworkexperience: TfrmDriverworkexperience;

implementation

{$R *.dfm}

procedure TfrmDriverworkexperience.bbtnSaveClick(Sender: TObject);
var
  msg: String;
  nResult: integer;
  sResult: string;
begin
  inherited;
  with jcdsSaveWork do
  begin
    if Trim(nvedtWorkunit.Text) ='' then
       begin
        SysDialogs.Warning('工作单位不能为空');
        nvedtWorkunit.SetFocus;
        exit;
       end
    else
       Params.ParamByName('workexperience.workunit').Value := nvedtWorkunit.Text;

    if Trim(nvedtPosition.Text) ='' then
      begin
        SysDialogs.Warning('职位不能为空');
        nvedtPosition.SetFocus;
        exit;
      end
      else if Length(nvedtPosition.Text) >10 then
      begin
        SysDialogs.Warning('请简写职位信息');
        nvedtPosition.SetFocus;
        exit;
      end
      else
         Params.ParamByName('workexperience.position').Value := nvedtPosition.Text;

    Params.ParamByName('workexperience.id').Value := id;
    Params.ParamByName('workexperience.createby').Value := createby;
    Params.ParamByName('workexperience.createtime').Value := createtime;
    Params.ParamByName('workexperience.driverid').Value := driverid;
    Params.ParamByName('workexperience.startdate').Value := formatdatetime('yyyy-mm-dd',dtpBegindate.Date);
    Params.ParamByName('workexperience.enddate').Value := formatdatetime('yyyy-mm-dd',dtpEnddate.Date);
    Params.ParamByName('workexperience.remarks').Value :=  mmoMeRemark.Text;
   try
        Execute;
        nResult := Params.ParamByName('flag').Value;
        sResult := Params.ParamByName('msg').Value;
        SysDialogs.ShowMessage(sResult);
        if (nResult <= 0) then
        begin
        nvedtWorkunit.SetFocus;
        end
       else
       begin
         ModalResult := mrok;
       end;
       except
       on E: Exception do
       begin
         SysLog.WriteErr('失败：' + E.Message);
       end;
       end;



  end;
end;

procedure TfrmDriverworkexperience.FormCreate(Sender: TObject);
begin
  inherited;
  if not isedt then
  begin
       dtpEnddate.Date := Now;
       dtpBegindate.Date :=Now;
  end
  else
  begin

  end;
end;

end.
