{------------------------------------
  功能说明：主窗体接口
  创建日期：2010/11/11
  作者：ice
  版权：nova
-------------------------------------}
unit MainFormIntf;
interface

uses Forms,Classes,Graphics,FunctionItemIntf;

Type
  //主窗口实现的接口
  IMainForm=Interface
    ['{5A9D183E-D0BC-4033-BF48-D0CC5DB6270F}']
    //创建菜单,一般用于DEBUG时,注册菜单
    function CreateMenu(const Path:string;guid:TGUID;parameters:TFunctionItemParameters):TObject;overload;
    //创建菜单,一般用于RELEASE时,注册菜单
    function CreateMenu(id:Integer;name:string;guidstr:string;parameters:TFunctionItemParameters;
                        parentid:integer;isvisible:Boolean;hotkeystr:String):TObject;overload;
    //取消注册菜单
    procedure DeleteMenu(Const Path:string);
    //创建工具栏
    function CreateToolButton(const aCaption:String;onClick:TNotifyEvent;Hint:String=''):TObject;
    //显示状态
    procedure ShowStatus(PnlIndex:Integer;const Msg:string);
    //退出程序
    procedure ExitApplication;
    //给ImageList添加图标
    function AddImage(Img:TGraphic):Integer;
//    function FindForm(const FormClassName:string):TForm;
    procedure ShowForm(aform:TForm);overload;
    //FormClass:要创建的窗体类       Reference 窗体变量
    procedure ShowForm(FormClass:TFormClass;var Reference;functionItem:IFunctionItem=nil;parameter:TFunctionItemParameters=nil;checkpermission:boolean=true);overload;
    function showFormModal(FormClass:TFormClass;functionItem:IFunctionItem=nil;parameter:TFunctionItemParameters=nil;checkpermission:boolean=true): Integer;overload;
    function showFormModal(aform:TForm;autofree:Boolean=True): Integer; overload;
    procedure CloseForm(aForm:TForm);
    //根据功能及参数定位TAB页
    function locationTab(guid: TGUID;parameters: TFunctionItemParameters):boolean;
    procedure loadchrom;
    procedure setLblloginname(const loginname: string);
  End;

implementation

end.
