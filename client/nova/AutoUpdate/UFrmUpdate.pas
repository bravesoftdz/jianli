Unit UFrmUpdate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Buttons, ExtCtrls, inifiles, ScktComp, Gauges,
  ShellAPI, NativeXml, msxml,
  IdBaseComponent, IdComponent, IdTCPConnection, IdTCPClient, IdHTTP, Tlhelp32,
  WinSkinData, jpeg;

const
  applicationCfgName = 'App.ini';
  applicationName = 'NvBus.exe';
  xmltitle = '<?xml version="1.0" encoding="UTF-8"?>';

type
  TFrmUpdate = class(TForm)
    IdHTTPDownFile: TIdHTTP;
    ProgressBar1: TProgressBar;
    Timer1: TTimer;
    SkinData1: TSkinData;
    mmo_Loading: TMemo;
    img1: TImage;
    Label1: TLabel;
    // 主要的更新过程
    Procedure MainDownProc;
    procedure IdHTTPDownFileWorkEnd(Sender: TObject; AWorkMode: TWorkMode);
    procedure Timer1Timer(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    function GetFileModifyDate(FileName: String): TDateTime;
    Function downloadFile(frompath, topath: string): boolean;
    procedure loading(const msg: String);
    // 运行程序
    Procedure RunMainProc;
   // procedure ShowMsg(msg: String);
    procedure WriteLog(msg: String);
    { Private declarations }
  public
    { Public declarations }
    constructor Create();
  end;

var
  FrmUpdate: TFrmUpdate;
  LocalFilePath: String;
  LocalTempPath: string; // 本地临时文件所在目录
  // NowDownFile:String;
  // ConnInfo :TConnectStr;
  // UpdateURL: String; // 下载更新程序的URL
  // UpdateFileName: String;

implementation

// uses UntSetUpdate;
{$R *.dfm}

function FindProcess(AFileName: string): boolean;
var
  hSnapshot: THandle; // 用于获得进程列表
  lppe: TProcessEntry32; // 用于查找进程
  Found: boolean; // 用于判断进程遍历是否完成
  // KillHandle: THandle; // 用于杀死进程
begin
  Result := False;
  hSnapshot := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0); // 获得系统进程列表
  lppe.dwSize := SizeOf(TProcessEntry32); // 在调用Process32First API之前，需要初始化lppe记录的大小
  Found := Process32First(hSnapshot, lppe); // 将进程列表的第一个进程信息读入ppe记录中
  while Found do
  begin
    if ((UpperCase(ExtractFileName(lppe.szExeFile)) = UpperCase(AFileName)) or
        (UpperCase(lppe.szExeFile) = UpperCase(AFileName))) then
    begin
      Result := True;
      Break;
    end;
    Found := Process32Next(hSnapshot, lppe); // 将进程列表的下一个进程信息读入lppe记录中
  end;
end;

procedure killApplication(ExeFileName: String);
const
  PROCESS_TERMINATE = $0001; // 进程的PROCESS_TERMINATE访问权限
var
  ContinueLoop: BOOL;
  FSnapshotHandle: THandle;
  FProcessEntry32: TProcessEntry32;
begin
  FSnapshotHandle := CreateToolhelp32Snapshot(TH32CS_SNAPPROCESS, 0);
  // 获取系统所有进程快照
  FProcessEntry32.dwSize := SizeOf(FProcessEntry32);
  // 调用Process32First前用Sizeof(FProcessEntry32)填充FProcessEntry32.dwSize
  ContinueLoop := Process32First(FSnapshotHandle, FProcessEntry32);
  // 获取快照中第一个进程信息并保存到FProcessEntry32结构体中
  while integer(ContinueLoop) <> 0 do
  // 循环枚举快照中所有进程信息
  begin
    if ((UpperCase(ExtractFileName(FProcessEntry32.szExeFile)) = UpperCase
          (ExeFileName)) or (UpperCase(FProcessEntry32.szExeFile) = UpperCase
          (ExeFileName))) then
      // 找到要中止的进程名
      TerminateProcess(OpenProcess(PROCESS_TERMINATE, BOOL(0),
          FProcessEntry32.th32ProcessID), 0);
    //CloseHandle(FSnapshotHandle);
    // 中止进程
    ContinueLoop := Process32Next(FSnapshotHandle, FProcessEntry32);
    // 查找下一个符合条件进程
  end;
end;

/// //////////////////////////////////////////////////////////////

procedure TFrmUpdate.MainDownProc;
var
  downUrl,updateurl: string;
  FileName,FileNameWin,FileNamesubstr,resultstr,ExecPath: string;
  LocalFileDatetime, lastModifyDatetime: TDateTime;
  topath,dirpath, frompath,topathbak: String;
  FXmlHttp: IXMLHTTPREQUEST;
  Ini: Tinifile;
  sResultJSON, resultXML: WideString;
  nodeList: TsdNodeList;
  node: TXmlNode;
  i,nCount: integer;
  xml: TNativeXml;
begin
  if FindProcess(applicationName) then
    killApplication(applicationName);
  sleep(500);
 //WriteLog('sleep500...');
  // 主要更新过程
  // 取得更新文件
  ExecPath := ExtractFilePath(Application.ExeName);
  if FileExists(ExtractFilePath(Paramstr(0)) + applicationCfgName) then
  begin
    Ini := Tinifile.Create(ExtractFilePath(Paramstr(0)) + applicationCfgName);
    try
      try
        downUrl := 'http://127.0.0.1:8080/download/';
        updateurl := 'http://127.0.0.1:8080/NvBusWeb/system/updatefile';
        updateurl:= Ini.ReadString('server', 'updateurl', updateurl);
        downUrl:= Ini.ReadString('server', 'download', downUrl);
        FXmlHttp := CoXMLHTTP.Create();
        // IdHTTPDownFile := TIdHTTP.Create(nil);
        FXmlHttp.open('POST', updateurl, False, '', '');
        FXmlHttp.setRequestHeader('Content-Type',
          'application/x-www-form-urlencoded;charset=utf-8');
        FXmlHttp.send('');
        sResultJSON := FXmlHttp.responseText;
        resultXML := Copy(sResultJSON, Pos('<', sResultJSON),
          Pos(',', sResultJSON) - 1 - Pos('<', sResultJSON));
        resultXML := StringReplace(resultXML, '#', '/', [rfReplaceAll]);
        resultXML := StringReplace(resultXML, '''', '"', [rfReplaceAll]);
        resultXML := xmltitle + resultXML;
        xml := TNativeXml.Create(nil);
        xml.XmlFormat := xfReadable;
        xml.ReadFromString(resultXML);
        node := xml.Root;
        nodeList := TsdNodeList.Create(False);
        node.FindNodes('file', nodeList);
        ProgressBar1.Max := nodeList.Count;
        for i := 0 to nodeList.Count - 1 do
        begin
          node := nodeList[i];
          ProgressBar1.Position := i + 1;
          FileName := node.AttributeByName['name'].Value;
          lastModifyDatetime := node.AttributeByName['lastmodify']
            .ValueAsDateTime;
          frompath := downUrl + FileName;
          if (pos('/',FileName)>0) then
          begin
             FileNameWin:=StringReplace(FileName,'/','\',[rfReplaceAll]);
             topath := ExecPath + FileNameWin;
             nCount:= pos('\',FileNameWin);
             FileNamesubstr := FileNameWin;
             dirpath := ExecPath;
             while nCount>0 do
             begin
                resultstr := Copy(FileNamesubstr,1,nCount);
                FileNamesubstr := Copy(FileNamesubstr,nCount+1,Length(FileNameWin));
                dirpath := dirpath + resultstr;
                nCount:=pos('\',FileNamesubstr);
             end;
             topathbak:= ExecPath + FileNameWin+'.bak';
             //如： filename=log.bpl   images/left.bmp  images/menu/right.bmp
             //创建目录
            if not (DirectoryExists(dirpath)) then
             begin
                ForceDirectories(dirpath);
             end;
          end
          else
          begin
             topath := ExecPath + FileName;
             topathbak:= ExecPath + FileName+'.bak';
          end;

          if FileExists(topath) then
          begin
            LocalFileDatetime := GetFileModifyDate(topath);
            if lastModifyDatetime > LocalFileDatetime then
            begin
              try
                 if downloadFile(frompath, topathbak) then
                  begin
                    loading(FileName + '包下载成功...');
                    WriteLog(FileName + '包下载成功...');
                    if deletefile(PChar(topath)) then
                    begin
                      if renamefile(FileName+'.bak',FileName) then
                      begin
                        loading(FileName + '.bak包重命名成功...');
                        WriteLog(FileName + '.bak包重命名成功...');
                      end
                      else
                      begin
                        loading(FileName + '.bak包重命名失败...');
                        WriteLog(FileName + '.bak包重命名失败...');
                      end;
                    end
                    else
                    begin
                      loading(FileName + '包删除失败...');
                      WriteLog(FileName + '包删除失败...');
                      {sleep(100);
                      killApplication(applicationName);
                      if deletefile(PChar(topath)) then
                      begin
                        loading(FileName + '包删除成功...');
                        WriteLog(FileName + '包删除成功...');
                      end; }
                    end;
                  end
                  else
                  begin
                    loading(FileName + '包下载失败...');
                    WriteLog(FileName + '包下载失败...');
                  end;
              except
                on E: Exception do
                begin
                  WriteLog('下载文件：' + FileName + '失败...');
                end;
              end;
            end;
          end
          else
          begin
            loading('正在下载' + FileName + '文件...');
            if downloadFile(frompath, topath) then
            begin
              loading(FileName + '文件下载成功...');
              WriteLog(FileName + '文件下载成功...');
            end
            else
            begin
              loading(FileName + '文件下载失败...');
              WriteLog(FileName + '文件下载失败...');
            end;
          end;
        end;
        nodeList.Free;
        xml.Free;
      except
        on E: Exception do
        begin
          WriteLog(FileName + '文件更新异常...'+E.Message);
        end;
      end;
    finally
      Ini.Free;
      IdHTTPDownFile.Free;
      ///showmessage('下载完成，请重新登录系统！');
    end;
  end
  else
  begin
    WriteLog('找不到系统配置文件！' + applicationCfgName);
    Application.Terminate;
  end;
  sleep(1000);
  RunMainProc;
  close;
end;

// 运行程序
procedure TFrmUpdate.RunMainProc;
begin
  // 等待原进程结束
  while FindProcess(applicationName) do
  begin
    sleep(10);
  end;
  ShellExecute(Handle, nil, PChar(applicationName), nil, nil, SW_SHOWNORMAL)
end;

constructor TFrmUpdate.Create;
begin

end;



function TFrmUpdate.GetFileModifyDate(FileName: String): TDateTime;
var
  FileHandle: THandle;
  LocalFileTime: TFileTime;
  DosFileTime: DWORD;
  LastModifyTime: TDateTime;
  FindData: TWin32FindData;
  afile: Tinifile;
begin
  Result := Date;
  try
    FileHandle := FindFirstFile(PChar(FileName), FindData);
    if FileHandle <> INVALID_HANDLE_VALUE then
    begin
      Windows.FindClose(FileHandle);
      if (FindData.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY) = 0 then
      begin
        FileTimeToLocalFileTime(FindData.ftLastWriteTime, LocalFileTime);
        FileTimeToDosDateTime(LocalFileTime, LongRec(DosFileTime).Hi,
          LongRec(DosFileTime).Lo);
        LastModifyTime := FileDateToDateTime(DosFileTime);
        Result := LastModifyTime;
      end;
    end;
  except
    on E: Exception do
    begin
      Result := Date - 365;
    end;
  end;

end;

function TFrmUpdate.downloadFile(frompath, topath: string): boolean;
var
  t: tmemorystream;
begin
  try
    t := tmemorystream.Create;
    IdHTTPDownFile.Get(frompath, t);
    t.SaveToFile(topath);
    t.Free;
    Result := True;
  except
    Result := False;
  end;

end;

procedure TFrmUpdate.FormShow(Sender: TObject);
begin
  WriteLog('开始下载^');
  //Timer1.Enabled := true;
  MainDownProc;
end;

procedure TFrmUpdate.IdHTTPDownFileWorkEnd(Sender: TObject;
  AWorkMode: TWorkMode);
begin
  Label1.Caption := '下载成功！';
end;

procedure TFrmUpdate.loading(const msg: String);
begin
  mmo_Loading.Lines.Add('   ' + msg);
  mmo_Loading.Update;
end;

procedure TFrmUpdate.Timer1Timer(Sender: TObject);
begin
  //WriteLog('Timer1Timer...');
  //MainDownProc;
  //Timer1.Enabled := False;
  //close;
end;

procedure TFrmUpdate.WriteLog(msg: String);
var
  FileName: String;
  FileHandle: TextFile;
begin
  FileName := ExtractFilePath(Application.ExeName) + 'error\' + FormatDateTime
    ('YYYY-MM-DD', Now) + '.txt';
  assignfile(FileHandle, FileName);
  try
    if FileExists(FileName) then
      append(FileHandle) // Reset(FileHandle)
    else
      ReWrite(FileHandle);
    WriteLn(FileHandle, FormatDateTime('[HH:MM:SS]', Now) + ' '+Application.ExeName + msg);
  finally
    CloseFile(FileHandle);
  end;
end;

end.
