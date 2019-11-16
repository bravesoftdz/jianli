unit UFrmStewarworkexperienceEdt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, ComCtrls, NovaComboBox,
  NovaEdit, DB, DBClient, jsonClientDataSet,Services, ImgList;

type
  TfrmStewadworkexperience = class(TSimpleEditForm)
    nvedtPosition: TNovaEdit;
    lbl11: TLabel;
    lbl15: TLabel;
    nvedtWorkunit: TNovaEdit;
    lbl16: TLabel;
    lbl17: TLabel;
    dtpBegindate: TDateTimePicker;
    dtpEnddate: TDateTimePicker;
    jcdsSaveWork: TjsonClientDataSet;
    mmoMeResume: TMemo;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    Foperationid:Integer;
  public
    { Public declarations }
    id, stewardid,createtime,createby:String;
    property operationid:Integer read Foperationid;
  end;

var
  frmStewadworkexperience: TfrmStewadworkexperience;

implementation
uses UDMPublic;
{$R *.dfm}





procedure TfrmStewadworkexperience.bbtnSaveClick(Sender: TObject);
var
  msg: String;
  nResult :integer;
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
       Params.ParamByName('stewardworkexperience.workunit').Value := nvedtWorkunit.Text;

    if Trim(nvedtPosition.Text) ='' then
      begin
        SysDialogs.Warning('职位不能为空');
        nvedtPosition.SetFocus;
        exit;
      end
      else
         Params.ParamByName('stewardworkexperience.position').Value := nvedtPosition.Text;
    Params.ParamByName('stewardworkexperience.id').Value := id;
    Params.ParamByName('stewardworkexperience.stewardid').Value := stewardid;
    Params.ParamByName('stewardworkexperience.startdate').Value := formatdatetime('yyyy-mm-dd',dtpBegindate.Date);
    Params.ParamByName('stewardworkexperience.enddate').Value := formatdatetime('yyyy-mm-dd',dtpEnddate.Date);
    Params.ParamByName('stewardworkexperience.resume').Value :=  mmoMeResume.Text;
    Params.ParamByName('stewardworkexperience.createby').Value :=  createby;
    Params.ParamByName('stewardworkexperience.createtime').Value :=  createtime;

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

procedure TfrmStewadworkexperience.FormCreate(Sender: TObject);
begin
  inherited;
  dtpBegindate.Date := Now;
  dtpEnddate.Date :=Now;
end;

end.
