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
          SysDialogs.ShowMessage('���������Ա����!');
          nvhelpSteward.SetFocus;
        exit;
      end;
      if nvcbbType.ItemIndex<0 then
      begin
          SysDialogs.ShowMessage('��ѡ�񽱳�����!');
          nvcbbType.SetFocus;
        exit;
      end;
      if Trim(nvedtResion.Text)='' then
      begin
        SysDialogs.ShowMessage('�����뽱��ԭ��!');
        nvedtResion.SetFocus;
        exit;
      end;
      if Trim(mmoContent.Text)='' then
      begin
         SysDialogs.ShowMessage('�����뽱������!');
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
           optype:='�޸�';

            log := ' ����Ա����:'+tname+',';

            if typenames <> nvcbbType.Text then
           begin
              log := log+' ,[��������]�� '+typenames+'�ĳ�'+nvcbbType.Text+',';
           end;
           if content <> mmoContent.Text then
           begin
              log := log+' ,[����]�� '+content+'�ĳ�'+mmoContent.Text+',';
           end;
           if reason <> nvedtResion.Text then
           begin
              log := log+' ,[ԭ��]�� '+reason+'�ĳ�'+nvedtResion.Text+',';
           end;
           if redate <> DateToStr(dtpRewarddate.Date) then
           begin
              log := log+' ,[��������]�� '+redate+'�ĳ�'+DateToStr(dtpRewarddate.Date)+',';
           end;
        end
        else
        begin
           optype:='���';
            log := ' ����Ա������'+nvhelpSteward.Text+' [��������]��'+nvcbbType.Text
                  +' [����]��'+mmoContent.Text+' [ԭ��]��'+nvedtResion.Text
                   +'[��������]��'+DateToStr(dtpRewarddate.Date);
        end;
        SysLog.WriteLog('��������->����Ա���͹���', optype, log);
        log:='';
        optype:='';
        id := Params.ParamByName('srewardid').Value;
        ModalResult := mrok;
      end;
      except
      on E: Exception do
      begin
        SysLog.WriteErr('����ʧ�ܣ�' + E.Message);
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
