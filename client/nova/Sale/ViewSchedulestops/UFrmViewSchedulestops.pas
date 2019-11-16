unit UFrmViewSchedulestops;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,UDMPublic, DBGridEhGrouping, DB, DBClient, jsonClientDataSet, GridsEh,
  DBGridEh, NvDbgridEh,FunctionItemIntf, uBaseForm;

type
  TFrmViewSchedulestops = class(TBaseForm)
    nvdbgrdhSchedulestops: TNvDbgridEh;
    jcdsSchedulestops: TjsonClientDataSet;
    dsSchedulestops: TDataSource;
    procedure FormShow(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
    { Private declarations }
    scheduleplanid:Int64;
    departstationid:Int64;
    isnet:Boolean;
    departdate:string;
    schedulesynccode:string;
    departstationcode:string;
  public
    { Public declarations }
    Constructor Create(AOwner: TComponent;functionItem:IFunctionItem=nil;parameter:TFunctionItemParameters=nil;checkpermission:boolean=true); override;
  end;

var
  FrmViewSchedulestops: TFrmViewSchedulestops;

implementation

{$R *.dfm}

constructor TFrmViewSchedulestops.Create(AOwner: TComponent;
  functionItem: IFunctionItem; parameter: TFunctionItemParameters;
  checkpermission: boolean);
begin
  inherited;
  scheduleplanid:=StrToInt64(parameter.strings[0]);
  departstationid:=StrToInt64(parameter.strings[1]);
  isnet:=StrToBoolDef(parameter.strings[2],false);
  departdate:=parameter.strings[3];
  schedulesynccode:=parameter.strings[4];
  departstationcode:=parameter.strings[5];
end;

procedure TFrmViewSchedulestops.FormKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key=VK_ESCAPE then
    self.Close;
end;

procedure TFrmViewSchedulestops.FormShow(Sender: TObject);
begin
  with jcdsSchedulestops do
  begin
    Active:=false;
    Params.ParamValues['scheduleplanid']:=scheduleplanid;
    Params.ParamValues['departstationid']:=departstationid;
    Params.ParamValues['isnet']:=isnet;
    Params.ParamValues['departdate']:=departdate;
    Params.ParamValues['schedulesynccode']:=schedulesynccode;
    Params.ParamValues['departstationcode']:=departstationcode;
    Active:=true;
  end;
end;

end.
