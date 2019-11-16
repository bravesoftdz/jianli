; 该脚本使用 HM VNISEdit 脚本编辑器向导产生

; 安装程序初始定义常量
!define PRODUCT_NAME "南凌客运信息管理系统"
!define PRODUCT_VERSION "5.0"
!define PRODUCT_PUBLISHER "NOVA, Inc."
!define PRODUCT_WEB_SITE "http://www.nova.net.cn"
!define PRODUCT_UNINST_KEY "Software\Microsoft\Windows\CurrentVersion\Uninstall\${PRODUCT_NAME}"
!define PRODUCT_UNINST_ROOT_KEY "HKLM"

SetCompressor /SOLID lzma
SetCompressorDictSize 32

; ------ MUI 现代界面定义 (1.67 版本以上兼容) ------
!include "MUI.nsh"

; MUI 预定义常量
!define MUI_ABORTWARNING
!define MUI_ICON "${NSISDIR}\Contrib\Graphics\Icons\modern-install.ico"
!define MUI_UNICON "${NSISDIR}\Contrib\Graphics\Icons\modern-uninstall.ico"

; 欢迎页面
!insertmacro MUI_PAGE_WELCOME
; 许可协议页面
!insertmacro MUI_PAGE_LICENSE "Licence.txt"
; 安装目录选择页面
!insertmacro MUI_PAGE_DIRECTORY
; 安装过程页面
!insertmacro MUI_PAGE_INSTFILES
; 安装完成页面
!define MUI_FINISHPAGE_RUN "$INSTDIR\NvBUS.exe"
!insertmacro MUI_PAGE_FINISH

; 安装卸载过程页面
!insertmacro MUI_UNPAGE_INSTFILES

; 安装界面包含的语言设置
!insertmacro MUI_LANGUAGE "SimpChinese"

; 安装预释放文件
!insertmacro MUI_RESERVEFILE_INSTALLOPTIONS
; ------ MUI 现代界面定义结束 ------

ReserveFile "${NSISDIR}\Plugins\advsplash.dll"
ReserveFile "images\welcome.bmp"

Name "${PRODUCT_NAME} ${PRODUCT_VERSION}"
OutFile "Setup.exe"
InstallDir "$PROGRAMFILES\南凌客运信息管理系统"
ShowInstDetails show
ShowUnInstDetails show
BrandingText "南凌客运信息管理系统安装程序"
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
  CreateShortCut "$DESKTOP\南凌客运信息管理系统.lnk" "$INSTDIR\NvBUS.exe"
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
  CreateDirectory "$SMPROGRAMS\南凌客运信息管理系统"
  CreateShortCut "$SMPROGRAMS\南凌客运信息管理系统\南凌客运信息管理系统.lnk" "$INSTDIR\NvBUS.exe"
  CreateShortCut "$SMPROGRAMS\南凌客运信息管理系统\自动升级.lnk" "$INSTDIR\AutoUpdate.exe"
  CreateShortCut "$SMPROGRAMS\南凌客运信息管理系统\Website.lnk" "$INSTDIR\${PRODUCT_NAME}.url"
  CreateShortCut "$SMPROGRAMS\南凌客运信息管理系统\Uninstall.lnk" "$INSTDIR\uninst.exe"
SectionEnd

Section -Post
  WriteUninstaller "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayName" "$(^Name)"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "UninstallString" "$INSTDIR\uninst.exe"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "DisplayVersion" "${PRODUCT_VERSION}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "URLInfoAbout" "${PRODUCT_WEB_SITE}"
  WriteRegStr ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}" "Publisher" "${PRODUCT_PUBLISHER}"
SectionEnd

#-- 根据 NSIS 脚本编辑规则，所有 Function 区段必须放置在 Section 区段之后编写，以避免安装程序出现未可预知的问题。--#

Function .onInit
  InitPluginsDir
  File "/oname=$PLUGINSDIR\Splash_welcome.bmp" "images\welcome.bmp"
  ; 使用闪屏插件显示闪屏
  advsplash::show 1000 600 400 -1 "$PLUGINSDIR\Splash_welcome"
  Pop $0 ; $0 返回 '1' 表示用户提前关闭闪屏, 返回 '0' 表示闪屏正常结束, 返回 '-1' 表示闪屏显示出错
FunctionEnd

/******************************
 *  以下是安装程序的卸载部分  *
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

  Delete "$SMPROGRAMS\南凌客运信息管理系统\Uninstall.lnk"
  Delete "$SMPROGRAMS\南凌客运信息管理系统\Website.lnk"
  Delete "$SMPROGRAMS\南凌客运信息管理系统\自动升级.lnk"
  Delete "$DESKTOP\南凌客运信息管理系统.lnk"
  Delete "$SMPROGRAMS\南凌客运信息管理系统\南凌客运信息管理系统.lnk"

  RMDir "$SMPROGRAMS\南凌客运信息管理系统"
  RMDir "$INSTDIR\images\menu"
  RMDir "$INSTDIR\images\menu_1"
  RMDir "$INSTDIR\images"
  RMDir "$INSTDIR\locales"
  RMDir "$INSTDIR\error"

  RMDir "$INSTDIR"

  DeleteRegKey ${PRODUCT_UNINST_ROOT_KEY} "${PRODUCT_UNINST_KEY}"
  SetAutoClose true
SectionEnd

#-- 根据 NSIS 脚本编辑规则，所有 Function 区段必须放置在 Section 区段之后编写，以避免安装程序出现未可预知的问题。--#

Function un.onInit
  MessageBox MB_ICONQUESTION|MB_YESNO|MB_DEFBUTTON2 "您确实要完全移除 $(^Name) ，及其所有的组件？" IDYES +2
  Abort
FunctionEnd

Function un.onUninstSuccess
  HideWindow
  MessageBox MB_ICONINFORMATION|MB_OK "$(^Name) 已成功地从您的计算机移除。"
FunctionEnd
