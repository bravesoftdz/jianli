unit SellerTaskReportPlugin;

interface

uses SysUtils,Classes,FunctionItemIntf,Generics.Collections;

Type
   TSellerTaskReportFunctionItem=class(TInterfacedObject,IFunctionItem)
   private
    FSubFunctionList:TList<TSubfunction>;
    function getKey:TGUID;
  public
    constructor Create();
    procedure Enter(const parameters:TFunctionItemParameters);
    procedure Leave;
    Procedure refresh(const parameters:TFunctionItemParameters);
    procedure ChangeTheme;
    function IsWorkState:Boolean;
    function getDescribe:String;
    function getSubFunctionList:TList<TSubfunction>;
    property key:TGUID read getKey;
  end;

implementation

uses Services,UFrmSellerTaskReport,MainFormIntf;


{ TFrmUser}

procedure TSellerTaskReportFunctionItem.ChangeTheme;
begin

end;

constructor TSellerTaskReportFunctionItem.Create;
begin
  FSubFunctionList:=TList<TSubfunction>.Create;
end;

 procedure TSellerTaskReportFunctionItem.Enter(const parameters: TFunctionItemParameters);
begin
//   FrmRole:=TFrmRole.Create(nil,self);
  Services.SysMainForm.ShowForm(TFrmSellerTaskReport,FrmSellerTaskReport,self);
end;
function TSellerTaskReportFunctionItem.getDescribe: String;
begin
  Result:='售票员任务表';
end;

function TSellerTaskReportFunctionItem.getKey: TGUID;
begin
  Result:=StringToGUID('{53AA1AEE-9976-4A8D-AFC1-8D776B6E16ED}');
end;

function TSellerTaskReportFunctionItem.getSubFunctionList: TList<TSubfunction>;
begin
  Result:=FSubFunctionList;
end;

function TSellerTaskReportFunctionItem.IsWorkState: Boolean;
begin
     Result:=True;
end;

procedure TSellerTaskReportFunctionItem.Leave;
begin

end;

procedure TSellerTaskReportFunctionItem.refresh(const parameters: TFunctionItemParameters);
begin

end;
end.
