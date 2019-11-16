unit UFrmSecuritycheckitemEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaComboBox, NovaEdit,
  DB, DBClient, jsonClientDataSet, ImgList;

type
  TFrmSecuritycheckitemEdit = class(TSimpleEditForm)
    nvcbbcategorycode: TNovaComboBox;
    Label1: TLabel;
    Label3: TLabel;
    nvedtname: TNovaEdit;
    Label5: TLabel;
    jsonCDSSecutiryitemSave: TjsonClientDataSet;
    Label6: TLabel;
    Label2: TLabel;
    chkroutinecheck: TCheckBox;
    mmodescribe: TMemo;
    lbl1: TLabel;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure nvcbbcategorycodeChange(Sender: TObject);
  private
    log : String;
    { Private declarations }
  public
    { Public declarations }
    createby, routinecheck: string;
    flag : boolean;
    id : Int64;
    createtime : string;
  end;

var
  FrmSecuritycheckitemEdit: TFrmSecuritycheckitemEdit;

implementation

uses Services, PubFn;
{$R *.dfm}

procedure TFrmSecuritycheckitemEdit.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult: string;
begin
  inherited;
  if (nvcbbcategorycode.ItemIndex < 0) then
  begin
    SysDialogs.Warning('��ѡ�񰲼����');
    nvcbbcategorycode.SetFocus;
    exit;
  end;
  if (trim(mmodescribe.Text) = '') then
  begin
    SysDialogs.Warning('����д������Ŀ��������Ϣ');
    nvedtname.SetFocus;
    exit;
  end;
  with jsonCDSSecutiryitemSave do
  begin
    Close;
    if chkroutinecheck.Checked then
    begin
      routinecheck := 'true';
    end else
    begin
      routinecheck := 'false';
    end;
    Params.ParamByName('securitycheckitem.isroutinecheck').Value := routinecheck;
    Params.ParamByName('securitycheckitem.id').Value := id;
    Params.ParamByName('securitycheckitem.createby').Value := createby;
    Params.ParamByName('securitycheckitem.createtime').Value := createtime;
    Params.ParamByName('securitycheckitem.name').Value := nvedtname.Text;
    Params.ParamByName('securitycheckitem.describe').Value := mmodescribe.Text;
    Params.ParamByName('securitycheckitem.categorycode').Value := IntToStr(nvcbbcategorycode.ItemIndex);
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        nvedtname.SetFocus;
      end
      else
      begin
        if id > 0 then
        begin
          log := '�޸İ�����Ŀ����������='+nvcbbcategorycode.Text+',������Ŀ='+
          nvedtname.Text + ',��������='+mmodescribe.Text;
          if chkroutinecheck.Checked then
          begin
            log := log + ',����';
          end;
          SysLog.WriteLog('�������->����������Ŀ','�޸�',log);
        end else
        begin
          log := '��Ӱ�����Ŀ����������='+nvcbbcategorycode.Text+',������Ŀ='+
          nvedtname.Text + ',��������='+mmodescribe.Text;
          if chkroutinecheck.Checked then
          begin
            log := log + ',����';
          end;
          SysLog.WriteLog('�������->����������Ŀ','���',log);
        end;
        id := Params.ParamByName('id').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('������Ŀ���ʧ�ܣ�' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmSecuritycheckitemEdit.FormCreate(Sender: TObject);
begin
  inherited;
  nvcbbcategorycode.Active:= false;
  nvcbbcategorycode.Active:= true;
end;

procedure TFrmSecuritycheckitemEdit.nvcbbcategorycodeChange(Sender: TObject);
begin
  inherited;
  nvedtname.Text := nvcbbcategorycode.Text;

end;

end.
