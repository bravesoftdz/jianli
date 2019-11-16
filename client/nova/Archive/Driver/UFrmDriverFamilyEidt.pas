unit UFrmDriverFamilyEidt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, ComCtrls, NovaComboBox,
  NovaEdit, DB, DBClient, jsonClientDataSet,Services, ImgList;

type
  TfrmDriverFamily = class(TSimpleEditForm)
    grp1: TGroupBox;
    lbl1: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl13: TLabel;
    nvedtName: TNovaEdit;
    nvedtWorkUnit: TNovaEdit;
    dtpBirthdate: TDateTimePicker;
    nvcbbPoliticsstatus: TNovaComboBox;
    nvedtPosition: TNovaEdit;
    rbMan: TRadioButton;
    rbGrile: TRadioButton;
    jcdsSaveFamily: TjsonClientDataSet;
    lbl2: TLabel;
    nvedtRelation: TNovaEdit;
    lbl11: TLabel;
    lbl3: TLabel;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    driverid,createby,createtime :String;
    id:Integer;
    isedt:boolean;
  end;

var
  frmDriverFamily: TfrmDriverFamily;

implementation
 uses UDMPublic;
{$R *.dfm}


procedure TfrmDriverFamily.bbtnSaveClick(Sender: TObject);
 var
  msg: String;
  nResult: integer;
  sResult: string;
begin
  inherited;
  with jcdsSaveFamily do
  begin
    close;
    Params.ParamByName('familyer.id').Value := id;
    Params.ParamByName('familyer.createby').Value := createby;
    Params.ParamByName('familyer.createtime').Value := createtime;
      if Trim(nvedtName.Text) ='' then
       begin
        SysDialogs.Warning('姓名不能为空');
        nvedtName.SetFocus;
        exit;
       end
      else
       Params.ParamByName('familyer.name').Value := nvedtName.Text;

      if Trim(nvedtRelation.Text) ='' then
      begin
        SysDialogs.Warning('请填写与驾驶员的关系');
        nvedtRelation.SetFocus;
        exit;
      end
      else
        Params.ParamByName('familyer.relation').Value := nvedtRelation.Text;

    if rbMan.Checked then
    Params.ParamByName('familyer.sex').Value := '男';
    if rbGrile.Checked then
    Params.ParamByName('familyer.sex').Value := '女';

    if nvcbbPoliticsstatus.GetSelectID > 0 then
    Params.ParamByName('familyer.politicsstatus').Value :=nvcbbPoliticsstatus.GetSelectCode
    else
    Params.ParamByName('familyer.politicsstatus').Value :='';

    Params.ParamByName('familyer.driverid').Value := driverid;
    Params.ParamByName('familyer.position').Value := nvedtPosition.Text;
    Params.ParamByName('familyer.workunit').Value := nvedtWorkUnit.Text;
    Params.ParamByName('familyer.birthday').Value := formatdatetime('c',dtpBirthdate.Date);
      try
        Execute;
        nResult := Params.ParamByName('flag').Value;
        sResult := Params.ParamByName('msg').Value;
        SysDialogs.ShowMessage(sResult);
        if (nResult <= 0) then
        begin
        nvedtName.SetFocus;
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



procedure TfrmDriverFamily.FormCreate(Sender: TObject);
begin
  inherited;
  if not isedt then
  begin
    dtpBirthdate.Date := now;
    nvcbbPoliticsstatus.Active :=  False;
    nvcbbPoliticsstatus.Active := True;
  end;

end;

end.





