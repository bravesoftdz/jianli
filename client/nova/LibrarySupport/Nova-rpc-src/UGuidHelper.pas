unit UGuidHelper;

interface

uses SysUtils,ComObj;

type
  TGuidHelper = record helper for TGUID
  private
    class function GetEmpty: TGUID; static;
  public
    { record helper donnot support constructor }
    class function Create(const g: string): TGUID; overload; static;
    class function NewGuid: TGUID; static;
    function Equals(const guid: TGUID): Boolean;
    function ToString: string;
    class property Empty: TGUID read GetEmpty;
  end;

implementation

{ TGuidHelper }

class function TGuidHelper.Create(const g: string): TGUID;
begin
  Result := StringToGUID(g);
end;

function TGuidHelper.Equals(const guid: TGUID): Boolean;
begin
  Result := SysUtils.IsEqualGUID(Self, guid);
end;

class function TGuidHelper.GetEmpty: TGUID;
const
  EmptyGuid: TGUID = (D1: 0; D2: 0; D3: 0; D4: (0, 0, 0, 0, 0, 0, 0, 0); );
begin
  Result := EmptyGuid;
end;

class function TGuidHelper.NewGuid: TGUID;
begin
  ComObj.OleCheck(SysUtils.CreateGUID(Result));
end;

function TGuidHelper.ToString: string;
begin
  Result := SysUtils.GUIDToString(Self);
end;

end.
