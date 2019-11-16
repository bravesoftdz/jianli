unit UFrmScheduleminimumEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaHComboBox,
  NovaEdit, NovaHelp, DB, DBClient, jsonClientDataSet, ImgList;

type
  TFrmScheduleminimumEdit = class(TSimpleEditForm)
    lblschedule: TLabel;
    lblvehicle: TLabel;
    nvhlpschedule: TNovaHelp;
    jsonCDSBalancescheduleSave: TjsonClientDataSet;
    lbl1: TLabel;
    Label1: TLabel;
    nvhlpcode: TNovaHelp;
    lbl4: TLabel;
    Label3: TLabel;
    edtminimum: TNovaEdit;
    procedure nvhlpscheduleChange(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
  private
    { Private declarations }
    log : String;
  public
    { Public declarations }
    sign : Boolean;
    id ,nums: Int64;
     createby, vehicleid,vehicleno : string;
    createtime, departdate : TDateTime;
  end;

var
  FrmScheduleminimumEdit: TFrmScheduleminimumEdit;

implementation

uses Services, PubFn, UDMPublic;
{$R *.dfm}

procedure TFrmScheduleminimumEdit.bbtnSaveClick(Sender: TObject);
var nResult : LongWord;
    sResult,result : string;
begin
  inherited;
  with jsonCDSBalancescheduleSave do
  begin
    Close;
    if nvhlpschedule.Id=0 then
    begin
      SysDialogs.ShowMessage('��������!');
      nvhlpschedule.SetFocus;
      Exit;
    end;
    if Trim(edtminimum.Text) = '' then
    begin
      SysDialogs.ShowMessage('�����뱣��������');
      edtminimum.SetFocus;
      Exit;
    end;
    if nvhlpcode.Id=0 then
    begin
      SysDialogs.ShowMessage('�����복�ƺţ�');
      nvhlpcode.SetFocus;
      Exit;
    end;
//    if self.edittype=TEdittype.update then
    //������Ų�Ϊ�գ������޸Ĳ�����
    if vehicleno <> ''  then
    begin
      //���������ȣ�û���޸ĳ��ţ�
      if vehicleno = nvhlpcode.Text  then
        Params.ParamByName('minimum.vehicleid').Value := vehicleid
      else
        Params.ParamByName('minimum.vehicleid').Value := nvhlpcode.HelpFieldValue['id'];
    end else
    begin
      Params.ParamByName('minimum.vehicleid').Value := nvhlpcode.HelpFieldValue['id'];
    end;
    if StrToInt(edtminimum.Text) < 0 then
    begin
      SysDialogs.ShowMessage('������������Ϊ����');
      edtminimum.SetFocus;
      Exit;
    end;
    Params.ParamByName('minimum.id').Value := id;
    Params.ParamByName('minimum.createby').Value := createby;
    Params.ParamByName('minimum.createtime').Value := DateTimeToStr(createtime);
    Params.ParamByName('minimum.num').Value := edtminimum.Text;
    Params.ParamByName('minimum.scheduleid').Value := nvhlpschedule.Id;

    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        edtminimum.SetFocus;
      end else
      begin
        if id > 0 then
        begin
          result := '�޸İ�α�����';
          log := '���='+nvhlpschedule.Text+',ԭ���ƺ�='+ vehicleno+',��������='+inttostr(nums)+',��';
        end
        else
        begin
          result := '��Ӱ�α�����';
          log := '���='+nvhlpschedule.Text+',';
        end;
        log := log +'���ƺ�='+
        nvhlpcode.Text+',��������='+edtminimum.Text;
        SysLog.WriteLog('�������->��α�����',result,log);
        ModalResult := mrok;
        id:= Params.ParamByName('id').Value;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('��α��������ʧ�ܣ�' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmScheduleminimumEdit.nvhlpscheduleChange(Sender: TObject);
begin
  inherited;
  nvhlpcode.Text:= '';
end;

end.
