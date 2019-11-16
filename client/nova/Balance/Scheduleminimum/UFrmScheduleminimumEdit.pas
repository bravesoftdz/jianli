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
      SysDialogs.ShowMessage('请输入班次!');
      nvhlpschedule.SetFocus;
      Exit;
    end;
    if Trim(edtminimum.Text) = '' then
    begin
      SysDialogs.ShowMessage('请输入保底人数！');
      edtminimum.SetFocus;
      Exit;
    end;
    if nvhlpcode.Id=0 then
    begin
      SysDialogs.ShowMessage('请输入车牌号！');
      nvhlpcode.SetFocus;
      Exit;
    end;
//    if self.edittype=TEdittype.update then
    //如果车号不为空，则是修改操作，
    if vehicleno <> ''  then
    begin
      //如果车号相等，没有修改车号，
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
      SysDialogs.ShowMessage('保底人数不能为负！');
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
          result := '修改班次保底数';
          log := '班次='+nvhlpschedule.Text+',原车牌号='+ vehicleno+',保底人数='+inttostr(nums)+',新';
        end
        else
        begin
          result := '添加班次保底数';
          log := '班次='+nvhlpschedule.Text+',';
        end;
        log := log +'车牌号='+
        nvhlpcode.Text+',保底人数='+edtminimum.Text;
        SysLog.WriteLog('结算管理->班次保底数',result,log);
        ModalResult := mrok;
        id:= Params.ParamByName('id').Value;
      end;
    except
      on E: Exception do
      begin
        SysLog.WriteErr('班次保底数添加失败：' + E.Message);
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
