; �ýű�ʹ�� HM VNISEdit �ű��༭���򵼲���

; ��װ�����ʼ���峣��
!define PRODUCT_NAME "���������Ϣ����ϵͳ"
!define PRODUCT_VERSION "5.0"
!define PRODUCT_PUBLISHER "NOVA, Inc."
!define PRODUCT_WEB_SITE "http://www.nova.net.cn"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

SetCompressor /SOLID lzma
SetCompressorDictSize 32

; ------ MUI �ִ����涨�� (1.67 �汾���ϼ���) ------
!include "MUI.nsh"

; MUI Ԥ���峣��
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"

; ��ӭҳ��
!insertmacro MUI_PAGE_WELCOME
; ���Э��ҳ��
!insertmacro MUI_PAGE_LICENSE "Licence.txt"
; ��װĿ¼ѡ��ҳ��
!insertmacro MUI_PAGE_DIRECTORY
; ��װ����ҳ��
!insertmacro MUI_PAGE_INSTFILES
; ��װ���ҳ��
!define MUI_FINISHPAGE_RUN "$INSTDIR\NvBUS.exe"
!insertmacro MUI_PAGE_FINISH

; ��װж�ع���ҳ��
!insertmacro MUI_UNPAGE_INSTFILES

; ��װ�����������������
!insertmacro MUI_LANGUAGE "SimpChinese"

; ��װԤ�ͷ��ļ�
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS
; ------ MUI �ִ����涨����� ------

ReserveFile "${NSISDIR}\Plugins\advsplash.dll"
ReserveFile "images\welcome.bmp"

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "Setup.exe"
InstallDir "$PROGRAMFILES\���������Ϣ����ϵͳ"
ShowInstDetails show
ShowUnInstDetails show
BrandingText "���������Ϣ����ϵͳ��װ����"
BGGradient 0000FF 000000 FFFFFF

Section "MainSection" SEC01
  SetOutPath "$INSTDIR\images"
  SetOverwrite on
  File "images\*.*"
  SetOutPath "$INSTDIR\images\menu"
  SetOverwrite on
  File "images\menu\*.*"
  SetOutPath "$INSTDIR\images\menu_1"
  SetOverwrite on
  File "images\menu_1\*.*"
  SetOutPath "$INSTDIR\locales"
  SetOverwrite on
  File "locales\*.*"
  SetOutPath "$INSTDIR"
;  SetOverwrite ifnewer
  SetOverwrite on
  File "NvBUS.exe"
  CreateShortCut "$DESKTOP\���������Ϣ����ϵͳ.lnk" "$INSTDIR\NvBUS.exe"
  File "AutoUpdate.exe"
  File "*.bpl"
  File "*.ini"
  File "*.dll"
  File "*.fr3"
  File "*.txt"
  File "*.dat"
  CreateDirectory "$INSTDIR\error"
;$SYSDIR
  RegDLL "$INSTDIR\midas.dll"
SectionEnd

Section -AdditionalIcons
  WriteIniStr "$INSTDIR\${PRODUCT_NAME}.url" "InternetShortcut" "URL" "${PRODUCT_WEB_SITE}"
  CreateDirectory "$SMPROGRAMS\���������Ϣ����ϵͳ"
  CreateShortCut "$SMPROGRAMS\���������Ϣ����ϵͳ\���������Ϣ����ϵͳ.lnk" "$INSTDIR\NvBUS.exe"
  CreateShortCut "$SMPROGRAMS\���������Ϣ����ϵͳ\�Զ�����.lnk" "$INSTDIR\AutoUpdate.exe"
  CreateShortCut "$SMPROGRAMS\���������Ϣ����ϵͳ\Website.lnk" "$INSTDIR\${PRODUCT_NAME}.url"
  CreateShortCut "$SMPROGRAMS\���������Ϣ����ϵͳ\Uninstall.lnk" "$INSTDIR\uninst.exe"
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd

#-- ���� NSIS �ű��༭�������� Function ���α�������� Section ����֮���д���Ա��ⰲװ�������δ��Ԥ֪�����⡣--#

Function .onInit
  InitPluginsDir
  File "/oname=$PLUGINSDIR\Splash_welcome.bmp" "images\welcome.bmp"
  ; ʹ�����������ʾ����
  advsplash::show 1000 600 400 -1 "$PLUGINSDIR\Splash_welcome"
  Pop $0 ; $0 ���� '1' ��ʾ�û���ǰ�ر�����, ���� '0' ��ʾ������������, ���� '-1' ��ʾ������ʾ����
FunctionEnd

/******************************
 *  �����ǰ�װ�����ж�ز���  *
 ******************************/

Section Uninstall
;$SYSDIR
  UnRegDLL "$INSTDIR\midas.dll"
  Delete "$INSTDIR\${PRODUCT_NAME}.url"
  Delete "$INSTDIR\uninst.exe"
  Delete "$INSTDIR\*.*"
  Delete "$INSTDIR\images\menu\*.*"
  Delete "$INSTDIR\images\menu_1\*.*"
  Delete "$INSTDIR\images\*.*"
  Delete "$INSTDIR\locales\*.*"
  Delete "$INSTDIR\error\*.*"

  Delete "$SMPROGRAMS\���������Ϣ����ϵͳ\Uninstall.lnk"
  Delete "$SMPROGRAMS\���������Ϣ����ϵͳ\Website.lnk"
  Delete "$SMPROGRAMS\���������Ϣ����ϵͳ\�Զ�����.lnk"
  Delete "$DESKTOP\���������Ϣ����ϵͳ.lnk"
  Delete "$SMPROGRAMS\���������Ϣ����ϵͳ\���������Ϣ����ϵͳ.lnk"

  RMDir "$SMPROGRAMS\���������Ϣ����ϵͳ"
  RMDir "$INSTDIR\images\menu"
  RMDir "$INSTDIR\images\menu_1"
  RMDir "$INSTDIR\images"
  RMDir "$INSTDIR\locales"
  RMDir "$INSTDIR\error"

  RMDir "$INSTDIR"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  SetAutoClose true
SectionEnd

#-- ���� NSIS �ű��༭�������� Function ���α�������� Section ����֮���д���Ա��ⰲװ�������δ��Ԥ֪�����⡣--#

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "��ȷʵҪ��ȫ�Ƴ� $(^Name) ���������е������" IDYES +2
  Abort
FunctionEnd

Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) �ѳɹ��ش����ļ�����Ƴ���"
FunctionEnd
