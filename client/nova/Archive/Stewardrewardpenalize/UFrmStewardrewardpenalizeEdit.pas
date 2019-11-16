unit UFrmStewardrewardpenalizeEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, USimpleEditForm, StdCtrls, Buttons, ExtCtrls, NovaHComboBox,
  NovaComboBox, ComCtrls, NovaEdit, DB, DBClient, jsonClientDataSet,Services,
  NovaHelp, ImgList;

type
  TfrmStewardrewardpenalizeEdt = class(TSimpleEditForm)
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lblWorkstatus: TLabel;
    lbl6: TLabel;
    nvedtResion: TNovaEdit;
    dtpRewarddate: TDateTimePicker;
    nvcbbType: TNovaComboBox;
    lbl11: TLabel;
    lbl1: TLabel;
    lbl5: TLabel;
    lbl7: TLabel;
    jcdsSave: TjsonClientDataSet;
    nvhelpSteward: TNovaHelp;
    mmoContent: TMemo;
    procedure bbtnSaveClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
    isedit:boolean;
   id:Integer;createby, createtime,code,
    tname,types,content,reason,redate,typenames: string;
  end;

var
  frmStewardrewardpenalizeEdt: TfrmStewardrewardpenalizeEdt;

implementation

{$R *.dfm}

procedure TfrmStewardrewardpenalizeEdt.bbtnSaveClick(Sender: TObject);
var  msg: String;
  nResult: integer;
  sResult,log,optype: String;
begin
  inherited;
    with  jcdsSave do
    begin
     close;
      if ((Trim(nvhelpSteward.Text) = '')) and (nvhelpSteward.Id<=0) then
      begin
          SysDialogs.ShowMessage('请输入乘务员姓名!');
          nvhelpSteward.SetFocus;
        exit;
      end;
      if nvcbbType.ItemIndex<0 then
      begin
          SysDialogs.ShowMessage('请选择奖惩类型!');
          nvcbbType.SetFocus;
        exit;
      end;
      if Trim(nvedtResion.Text)='' then
      begin
        SysDialogs.ShowMessage('请输入奖惩原因!');
        nvedtResion.SetFocus;
        exit;
      end;
      if Trim(mmoContent.Text)='' then
      begin
         SysDialogs.ShowMessage('请输入奖惩内容!');
         mmoContent.SetFocus;
        exit;
      end;
     Params.ParamByName('stewardrp.id').Value := id;
     Params.ParamByName('stewardrp.createtime').Value := createtime;
     Params.ParamByName('stewardrp.createby').Value := createby;
     Params.ParamByName('stewardrp.stewardid').Value := nvhelpSteward.Id;
     Params.ParamByName('stewardrp.content').Value :=mmoContent.Text;
     Params.ParamByName('stewardrp.reason').Value := nvedtResion.Text;
     Params.ParamByName('stewardrp.rewarddate').Value := formatdatetime('yyyy-mm-dd',dtpRewarddate.Date);
     Params.ParamByName('stewardrp.type').Value := nvcbbType.GetSelectCode;


      try
      Execute;
      nResult := Params.ParamByName('flag').Value;
      sResult := Params.ParamByName('msg').Value;
      SysDialogs.ShowMessage(sResult);
      if (nResult <= 0) then
      begin
        nvhelpSteward.SetFocus;
      end
      else
      begin
        if id>0 then
        begin
           optype:='修改';

            log := ' 乘务员姓名:'+tname+',';

            if typenames <> nvcbbType.Text then
           begin
              log := log+' ,[奖惩类型]由 '+typenames+'改成'+nvcbbType.Text+',';
           end;
           if content <> mmoContent.Text then
           begin
              log := log+' ,[内容]由 '+content+'改成'+mmoContent.Text+',';
           end;
           if reason <> nvedtResion.Text then
           begin
              log := log+' ,[原因]由 '+reason+'改成'+nvedtResion.Text+',';
           end;
           if redate <> DateToStr(dtpRewarddate.Date) then
           begin
              log := log+' ,[奖惩日期]由 '+redate+'改成'+DateToStr(dtpRewarddate.Date)+',';
           end;
        end
        else
        begin
           optype:='添加';
            log := ' 乘务员姓名：'+nvhelpSteward.Text+' [奖惩类型]：'+nvcbbType.Text
                  +' [内容]：'+mmoContent.Text+' [原因]：'+nvedtResion.Text
                   +'[奖惩日期]：'+DateToStr(dtpRewarddate.Date);
        end;
        SysLog.WriteLog('档案管理->乘务员奖惩管理', optype, log);
        log:='';
        optype:='';
        id := Params.ParamByName('srewardid').Value;
        ModalResult := mrok;
      end;
      except
      on E: Exception do
      begin
        SysLog.WriteErr('操作失败：' + E.Message);
      end;
     end;

    end;
end;

procedure TfrmStewardrewardpenalizeEdt.FormCreate(Sender: TObject);
begin
  inherited;
   nvcbbType.Active := False;
   nvcbbType.Active := True;
   dtpRewarddate.Date:=Now;
end;

end.
