unit UFrmCycleVehicle;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaHelp,
  NovaHComboBox, DB, DBClient, jsonClientDataSet, ComCtrls, NovaEdit, ImgList;

type
  TFrmCycleVehicle = class(TSimpleEditForm)
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    NovaEdtName: TNovaEdit;
    DateTpFromDate: TDateTimePicker;
    DateTpEndDate: TDateTimePicker;
    jcdsSaveVehicle: TjsonClientDataSet;
    Label5: TLabel;
    Label6: TLabel;
    NovaHelpUnit: TNovaHelp;
    Label7: TLabel;
    NovaHelpVehiclenoHelp: TNovaHelp;
    Label2: TLabel;
    nvhlpVehiclebrandmodel: TNovaHelp;
    procedure bbtnSaveClick(Sender: TObject);
    procedure NovaHelpVehiclenoHelpIdChange(Sender: TObject);
  private
    log : String;
    { Private declarations }
  public
    { Public declarations }
    id, createby,pid,orderno: integer;
    createtime,vehicle,vehicleunitname,vehicletype,Vehiclebrandmodel:string;
  end;

var
  FrmCycleVehicle: TFrmCycleVehicle;

implementation
uses PubFn,Services, UDMPublic;
{$R *.dfm}

procedure TFrmCycleVehicle.bbtnSaveClick(Sender: TObject);
var
  msg,types: String;
  nResult: integer;
  sResult: string;
begin
  inherited;
  if (nvhlpVehiclebrandmodel.Id<=0) or (nvhlpVehiclebrandmodel.Text='')  then
  begin
    SysDialogs.Warning('��ѡ�����ͺţ�');
    nvhlpVehiclebrandmodel.SetFocus;
    exit;
  end;


  with jcdsSaveVehicle do
  begin
    close;
    Params.ParamByName('cycleschemesvehicle.id').Value := id;
    //Params.ParamByName('cycleschemesvehicle.vehicletypeid').Value := NovaVehicletype.HelpFieldValue['id'];
    Params.ParamByName('cycleschemesvehicle.orderno').Value := orderno;
    if ((NovaHelpUnit.Text<>'') and (NovaHelpUnit.Id>0)) then
      Params.ParamByName('cycleschemesvehicle.unit.id').Value := NovaHelpUnit.Id;
    Params.ParamByName('cycleschemesvehicle.vehiclebrandmodelid').Value := nvhlpVehiclebrandmodel.id;
    if (NovaHelpVehiclenoHelp.Text<>'') and (NovaHelpVehiclenoHelp.Id>0) then
      Params.ParamByName('cycleschemesvehicle.vehicle.id').Value := NovaHelpVehiclenoHelp.Id
    else
      Params.ParamByName('cycleschemesvehicle.vehicle.id').Value := null;
    Params.ParamByName('cycleschemesvehicle.cyclescheme.id').Value := pid;
    Params.ParamByName('cycleschemesvehicle.createby').Value := createby;
    Params.ParamByName('cycleschemesvehicle.createtime').Value := createtime;
    try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      if (nResult <= 0) then
      begin
        SysDialogs.Warning(sResult);
        NovaHelpVehiclenoHelp.SetFocus;
      end
      else
      begin
        if id>0 then
        types := '�޸�'
        else
        types := '���';

        log:= 'ѭ��������='+NovaEdtName.Text
        +',ѭ����ʼ����='+FormatDateTime('yyyy-mm-dd',DateTpFromDate.Date)
        +',ѭ����ʼ����='+FormatDateTime('yyyy-mm-dd',DateTpEndDate.Date);


        if not (Vehiclebrandmodel='') then
        begin
          if not(Vehiclebrandmodel=nvhlpVehiclebrandmodel.Text) then
          begin
            log := log+',�����ͺ� �� '+ Vehiclebrandmodel+' �ĳ� '+nvhlpVehiclebrandmodel.Text;
          end
        end
        else
          log:= log+',��� �����ͺ�:'+nvhlpVehiclebrandmodel.Text;

        if not (vehicleunitname='') then
        begin
          if not (vehicleunitname=NovaHelpUnit.Text) and (not ( NovaHelpUnit.Text='')) then
            log := log+',Ӫ�˵�λ �� '+ vehicleunitname +' �ĳ� '+NovaHelpUnit.Text
          else if NovaHelpUnit.Text='' then                
            log :=log+',ɾ�� Ӫ�˵�λ ';
        end
        else
        begin
          if ((NovaHelpUnit.Text<>'') and (NovaHelpUnit.Id>0)) then
            log := log + ',��� Ӫ�˵�λ:'+NovaHelpUnit.Text;
        end;

         if not (vehicle='') then
         begin
          if not(vehicle=NovaHelpVehiclenoHelp.Text) and (not (NovaHelpVehiclenoHelp.Text='')) then
            log := log+',�ƻ������� '+ vehicle +' �ĳ� '+NovaHelpVehiclenoHelp.Text
          else if NovaHelpVehiclenoHelp.Text='' then                
            log := log+',ɾ�� �ƻ�����';
         end
        else
        begin
          if (NovaHelpVehiclenoHelp.Text<>'') and (NovaHelpVehiclenoHelp.Id>0) then
            log := log + ',��� �ƻ�����:'+NovaHelpVehiclenoHelp.Text;
        end;


        SysLog.WriteLog('���ѭ��-ѭ������',types,log);
        SysDialogs.ShowMessage(sResult);
        ModalResult := mrok;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('����ѭ����Ϣ����ʧ�ܣ�' + E.Message);
      end;
    end;
  end;
end;

procedure TFrmCycleVehicle.NovaHelpVehiclenoHelpIdChange(Sender: TObject);
var
  brandname,unitname,vehicletypename:String;
begin
  inherited;
  if NovaHelpVehiclenohelp.Id>0 then
  begin
    //NovaVehicletype.SetItemIndexByField('id',NovaHelpVehiclenohelp.HelpFieldValue['vehicletypeid']);
    //NovaVehicletypeChange(sender);
    nvhlpVehiclebrandmodel.Id:= NovaHelpVehiclenohelp.HelpFieldValue['brandid'];
//    NvHcbbVehiclebrandmodel.SetItemIndexByField('id',NovaHelpVehiclenohelp.HelpFieldValue['brandid']);
    NovaHelpUnit.text:=NovaHelpVehiclenohelp.HelpFieldValue['unitname'];
    NovaHelpUnit.id:= NovaHelpVehiclenohelp.HelpFieldValue['unitid'];
    //NovaVehicletype.Enabled:=false;
    //nvhlpVehiclebrandmodel.Enabled:=false;
    NovaHelpUnit.Enabled:=false;

    SysDialogs.Warning('���ó�����Ϣ�����ɵİ��Ӫ�˼ƻ�����λ����ȡ�ó�������λ!');

  end
  else
  begin
    //NovaVehicletype.Enabled:=true;
    nvhlpVehiclebrandmodel.Enabled:=true;
    NovaHelpUnit.Enabled:=true;
  end;
end;

end.
