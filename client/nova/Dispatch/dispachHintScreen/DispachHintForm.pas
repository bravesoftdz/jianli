unit DispachHintForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGrids, DB, ADODB,StdCtrls,
  DBGridEh, Sockets,ActiveX, ScktComp, jpeg, ImgList, NovaEdit, WinSkinData;

type
  TMiniScreenMSG=(LISTSCHEDULE,//��ʾ�����Ϣ
                  FINISH,//��Ʊ�����ʾ�ȴ�����
                  EXITSELL //�˳���Ʊʱ
                  );
type
  TDispachForm = class(TForm)
    ImageList: TImageList;
    ImageList1: TImageList;
    pnlEditBox: TPanel;
    Bevel1: TBevel;
    pnl1: TPanel;
    grp1: TGroupBox;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    grp2: TGroupBox;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    editSeatnum: TNovaEdit;
    editDeparttime: TNovaEdit;
    grp3: TGroupBox;
    lbl7: TLabel;
    lbl8: TLabel;
    editReportDateTime: TNovaEdit;
    grp4: TGroupBox;
    lbl9: TLabel;
    mmoResult: TMemo;
    editVehicleNo: TNovaEdit;
    editScheduleCode: TNovaEdit;
    editReachStation: TNovaEdit;
    editUnit: TNovaEdit;
    editCardNo: TNovaEdit;
    ServerSocket1: TServerSocket;
    SkinData1: TSkinData;
    procedure FormCreate(Sender: TObject);
    procedure ServerSocket1ClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
  private
    { Private declarations }
    procedure handmsg(msg:TMiniScreenMSG;info:String);

  public
    { Public declarations }
    procedure MyError(Sender: TObject; E:Exception) ;
  end;

var
  DispachForm: TDispachForm;
  procedure ShowDispachForm;
  procedure FrmmainShow;
implementation

{$R *.dfm}

procedure TDispachForm.FormCreate(Sender: TObject);
begin
  Application.OnException := MyError ;
end;

procedure TDispachForm.MyError(Sender: TObject; E: Exception);
begin
   Application.Terminate ;
end;

procedure TDispachForm.ServerSocket1ClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var revmsg:string;
    curcmd:string;
begin
  revmsg:=Socket.ReceiveText;
  while Pos(#13,revmsg)>0 do
  begin
    if Trim(Copy(revmsg,Pos(#13,revmsg)+1,Length(revmsg)-Pos(#13,revmsg)))<>'' then
    begin
//      ShowMessage(revmsg);
      try
        curcmd:=Copy(revmsg,1,Pos(#13,revmsg)-1);
        handmsg(TMiniScreenMSG(StrToInt(trim(Copy(curcmd,1,Pos(';',curcmd)-1))))
                ,trim(Copy(curcmd,Pos(';',curcmd)+1,Length(curcmd)-Pos(';',curcmd)))
                );
      except
    //    ShowMessage(revmsg);
      end;
      revmsg:=Copy(revmsg,Pos(#13,revmsg)+1,Length(revmsg)-Pos(#13,revmsg));
    end
    else
    begin
      Break;
    end;
  end;
  try
    curcmd:=revmsg;
    handmsg(TMiniScreenMSG(StrToInt(trim(Copy(curcmd,1,Pos(';',curcmd)-1))))
            ,trim(Copy(curcmd,Pos(';',curcmd)+1,Length(curcmd)-Pos(';',curcmd)))
            );
  except
//    ShowMessage(revmsg);
  end;
end;

procedure FrmmainShow;
var
  hWndClose: HWnd;// �洢ָ�����ⲿӦ�ó��򴰿ھ��
  str: String;// �洢ָ�����ⲿӦ�ó���Ĵ�����
begin
   str := '���������Ϣ����ϵͳ';
   hWndClose := FindWindow(nil, PChar(str));  //���ݴ���������Ҫ���ھ��
   if hWndClose <> 0 then  //���ҳɹ�,��ʾ��ǰ��
   begin
       SetForeGroundWindow(hWndClose);
   end;
end;

procedure TDispachForm.handmsg(msg: TMiniScreenMSG;info:String);
var tmpinfo:String;
begin
  editCardNo.Text :='';
  editVehicleNo.Text :='';
  editScheduleCode.Text :='';
  editReachStation.Text :='';
  editSeatnum.Text :='';
  editDeparttime.Text :='';
  editUnit.text :='';
  editReportDateTime.Text :='';
  mmoResult.Lines.Clear;

  tmpinfo:=info;
    editCardNo.Text :=Copy(tmpinfo,1,Pos(',',tmpinfo)-1);
    tmpinfo:=Copy(tmpinfo,Pos(',',tmpinfo)+1,Length(tmpinfo)-Pos(',',tmpinfo));
    editVehicleNo.Text :=Copy(tmpinfo,1,Pos(',',tmpinfo)-1);
    tmpinfo:=Copy(tmpinfo,Pos(',',tmpinfo)+1,Length(tmpinfo)-Pos(',',tmpinfo));
    editScheduleCode.Text :=Copy(tmpinfo,1,Pos(',',tmpinfo)-1);
    tmpinfo:=Copy(tmpinfo,Pos(',',tmpinfo)+1,Length(tmpinfo)-Pos(',',tmpinfo));
    editReachStation.Text :=Copy(tmpinfo,1,Pos(',',tmpinfo)-1);
    tmpinfo:=Copy(tmpinfo,Pos(',',tmpinfo)+1,Length(tmpinfo)-Pos(',',tmpinfo));
    editSeatnum.Text :=Copy(tmpinfo,1,Pos(',',tmpinfo)-1);
    tmpinfo:=Copy(tmpinfo,Pos(',',tmpinfo)+1,Length(tmpinfo)-Pos(',',tmpinfo));
    editDeparttime.Text :=Copy(tmpinfo,1,Pos(',',tmpinfo)-1);
    tmpinfo:=Copy(tmpinfo,Pos(',',tmpinfo)+1,Length(tmpinfo)-Pos(',',tmpinfo));
    editUnit.text :=Copy(tmpinfo,1,Pos(',',tmpinfo)-1);
    tmpinfo:=Copy(tmpinfo,Pos(',',tmpinfo)+1,Length(tmpinfo)-Pos(',',tmpinfo));
    editReportDateTime.Text :=Copy(tmpinfo,1,Pos(',',tmpinfo)-1);
    tmpinfo:=Copy(tmpinfo,Pos(',',tmpinfo)+1,Length(tmpinfo)-Pos(',',tmpinfo));
//    lbltotalprice.Caption :=Copy(tmpinfo,1,Pos(',',tmpinfo)-1);
//    tmpinfo:=Copy(tmpinfo,Pos(',',tmpinfo)+1,Length(tmpinfo)-Pos(',',tmpinfo));
//    lbltotalpricesum.Caption :=Copy(tmpinfo,1,Pos(',',tmpinfo)-1);
//    tmpinfo:=Copy(tmpinfo,Pos(',',tmpinfo)+1,Length(tmpinfo)-Pos(',',tmpinfo));
//    lblrecive.Caption :=Copy(tmpinfo,1,Pos(',',tmpinfo)-1);
//    tmpinfo:=Copy(tmpinfo,Pos(',',tmpinfo)+1,Length(tmpinfo)-Pos(',',tmpinfo));
//    lblchange.Caption :=Copy(tmpinfo,1,Pos(',',tmpinfo)-1);
//    tmpinfo:=Copy(tmpinfo,Pos(',',tmpinfo)+1,Length(tmpinfo)-Pos(',',tmpinfo));
    mmoResult.Lines.Add(tmpinfo);
//    DispachForm.Show;
end;

procedure ShowDispachForm;
begin
   if Screen.MonitorCount<=1 then  //��ֻ��һ����ʾ����ʱ�� ��ʾ������ʾ����
   begin
     Application.Terminate; //����û�и���ʱ��ֱ�Ӳ��򿪸���

     DispachForm.DefaultMonitor := dmMainForm;
     DispachForm.Visible := true ;
   end
   else       //�������ʾ����ʱ�� ��ʾ�ڵڶ���ʾ����
   begin

     DispachForm.Visible := true;
     DispachForm.Left := Screen.Monitors[1].Left;
     DispachForm.Top := Screen.Monitors[1].Top;
     DispachForm.Width := Screen.Monitors[1].Width;
     DispachForm.Height := Screen.Monitors[1].Height;

   end ;
   DispachForm.Show;
end;

end.
