unit UFrmHolidayEdt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaComboBox, DB,
  DBClient, jsonClientDataSet, NovaEdit, ComCtrls, ImgList;

type
  TFrmHolidayEdt = class(TSimpleEditForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label11: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    DateTpFromDate: TDateTimePicker;
    DateTpEndDate: TDateTimePicker;
    NovaEdtHoliday: TNovaEdit;
    jcdsSaveHoliday: TjsonClientDataSet;
    NovaCbbHolidayType: TNovaComboBox;
    procedure FormShow(Sender: TObject);
    procedure bbtnSaveClick(Sender: TObject);
    procedure NovaCbbHolidayTypeChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DateTpFromDateChange(Sender: TObject);
  private
    { Private declarations }
    log : String;
  public
    { Public declarations }
    id, createby,orgid: int64;
    createtime,holidaytypename,synccode:string;
  end;

var
  FrmHolidayEdt: TFrmHolidayEdt;

implementation
uses PubFn,Services, UDMPublic;
{$R *.dfm}

procedure TFrmHolidayEdt.bbtnSaveClick(Sender: TObject);
var
  nResult: integer;
  sResult, result: string;
begin
  inherited;

  if NovaCbbHolidayType.ItemIndex<0 then
  begin
    NovaCbbHolidayType.SetFocus;
    SysDialogs.Warning('��ѡ����գ�');
    exit;
  end;
  if (trunc(DateTpFromDate.DateTime)>trunc(DateTpEndDate.DateTime)) then
  begin
    DateTpFromDate.SetFocus;
    SysDialogs.Warning('��ʼ���ڲ��ܴ��ڽ������ڣ�');
    exit;
  end;
    if trunc(DateTpEndDate.DateTime)<trunc(now) then
  begin
    DateTpFromDate.SetFocus;
    SysDialogs.Warning('�������ڲ���С�ڵ�ǰ���ڣ�');
    exit;
  end;
  if trim(NovaEdtHoliday.Text)='' then
  begin
    NovaEdtHoliday.SetFocus;
    SysDialogs.Warning('����д�Զ������ƣ�');
    exit;
  end;

   with jcdsSaveHoliday do
  begin
    close;
    Params.ParamByName('holiday.id').Value := id;
    Params.ParamByName('holiday.type').Value := NovaCbbHolidayType.GetSelectCode;
    Params.ParamByName('holiday.isactive').Value := true;
    Params.ParamByName('holiday.startdate').Value := FormatDateTime('yyyy-mm-dd',DateTpFromDate.DateTime);
    Params.ParamByName('holiday.enddate').Value :=FormatDateTime('yyyy-mm-dd', DateTpEndDate.DateTime);
    Params.ParamByName('holiday.fullname').Value := trim(NovaEdtHoliday.Text);
    Params.ParamByName('holiday.islocaldelete').Value := false;
    Params.ParamByName('holiday.createby').Value := createby;
    if createtime<>'' then
      Params.ParamByName('holiday.createtime').Value := createtime;
    if synccode<>'' then
      Params.ParamByName('holiday.synccode').Value := synccode;
    Params.ParamByName('holiday.orgid').Value := orgid;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        NovaCbbHolidayType.SetFocus;
      end
      else
      begin
        if id > 0 then
        begin
          result := '�޸�';
        end else
        begin
          result := '���';
        end;
        log := result+'������Ϣ���ã�����='+NovaCbbHolidayType.Text+',�Զ�������='+
        NovaEdtHoliday.Text+',��ʼ����='+
        FormatDateTime('yyyy-mm-dd',DateTpFromDate.DateTime)+',��������='+
        FormatDateTime('yyyy-mm-dd',DateTpEndDate.DateTime);
        SysLog.WriteLog('Ʊ�۹�����>������Ϣ����',result,log);
        id:=Params.ParamByName('holidayid').Value;
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('������Ϣ����ʧ�ܣ�' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmHolidayEdt.DateTpFromDateChange(Sender: TObject);
begin
  inherited;
 NovaCbbHolidayTypeChange(sender);
end;

procedure TFrmHolidayEdt.FormCreate(Sender: TObject);
begin
  inherited;
  NovaCbbHolidayType.Active:=false;
  NovaCbbHolidayType.Active:=true;
end;

procedure TFrmHolidayEdt.FormShow(Sender: TObject);
begin
  inherited;
  if(self.edittype=add) then
  begin
    DateTpFromDate.Date:=now;
    DateTpEndDate.Date:=now;
  end;
end;

procedure TFrmHolidayEdt.NovaCbbHolidayTypeChange(Sender: TObject);
begin
  inherited;
  if NovaCbbHolidayType.ItemIndex>=0 then
  begin
    NovaEdtHoliday.Text:=formatdatetime('yyyy',DateTpFromDate.date)+'��'+NovaCbbHolidayType.Text;
  end;
end;

end.
