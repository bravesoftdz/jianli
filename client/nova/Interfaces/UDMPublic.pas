unit UDMPublic;

interface

uses
  SysUtils, Classes, DB, DBClient, jsonConnection, WinSkinData;

type
  TEditType=(view,add,update);
  TDMPublic = class(TDataModule)
    jcon: TjsonConnection;
    SkinData1: TSkinData;
  private
    { Private declarations }
  public
    { Public declarations }
    constructor Create(AOwner: TComponent); override;
  end;

var
  DMPublic: TDMPublic;
  SkinData: TSkinData;
implementation

{$R *.dfm}

{ TDMPublic }

constructor TDMPublic.Create(AOwner: TComponent);
begin
  inherited;
  Self.SkinData1.Free;
  Self.SkinData1:=SkinData;
end;

end.
