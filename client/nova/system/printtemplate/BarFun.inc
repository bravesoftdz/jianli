// =============================================================================
//
// Barcode VCL Component
//
// For Delphi 4/5/6/7, C++ Builder 4/5/6, BDS 2005/2005, Turbo Delphi 2006
//
// Copyright (c) 2001, 2007  Han-soft Software, all rights reserved.
//
// $Rev: 44 $   $Id: BarFun.inc 44 2007-01-16 01:16:04Z hanjy $
//
// =============================================================================

{*******************}
{    For Display    }
{*******************}

{ Rotate a Point by Angle 'alpha' }
function Rotate2D(p:TPoint; alpha:double): TPoint;
var
  sinus, cosinus : Extended;
begin
  SinCos(alpha, sinus, cosinus);
  result.x := Round(p.x*cosinus + p.y*sinus);
  result.y := Round(-p.x*sinus + p.y*cosinus);
end;

{Move Point "a" by Vector "b"}
function Translate2D(a, b:TPoint): TPoint;
begin
  result.x := a.x + b.x;
  result.y := a.y + b.y;
end;

(*
{ Rotate a array}
procedure Rotate2Darray(p:array of TPoint; alpha:double);
var
   i : Integer;
begin
   for i:=Low(p) to High(p) do
      p[i] := Rotate2D(p[i], alpha);
end;

{ Move a array }
procedure Translate2Darray(p:array of TPoint; shift:TPoint);
var
   i : Integer;
begin
   for i:=Low(p) to High(p) do
      p[i] := Translate2D(p[i], shift);
end;
*)

{ Move the orgin }
function TranslateQuad2D(const alpha :double; const orgin, point :TPoint): TPoint;
var
   alphacos: Extended;
   alphasin: Extended;
   moveby:   TPoint;
begin
   SinCos(alpha, alphasin, alphacos);

   if alphasin >= 0 then
   begin
      if alphacos >= 0 then
      begin
         { 1. Quadrant }
         moveby.x := 0;
         moveby.y := Round(alphasin*point.x);
      end
      else
      begin
         { 2. Quadrant }
         moveby.x := -Round(alphacos*point.x);
         moveby.y := Round(alphasin*point.x - alphacos*point.y);
      end;
   end
   else
   begin
      if alphacos >= 0 then
      begin
         { 4. Quadrant }
         moveby.x := -Round(alphasin*point.y);
         moveby.y := 0;
      end
      else
      begin
         { 3. Quadrant }
         moveby.x := -Round(alphacos*point.x) - Round(alphasin*point.y);
         moveby.y := -Round(alphacos*point.y);
      end;
   end;
   Result := Translate2D(orgin, moveby);
end;

{*******************}
{     For Print     }
{*******************}

{ Get printer paramter }
function GetPrinterRes(const pobj: TPrinter; Horz: Boolean): integer;
var
   Index: Integer;
begin
   if Horz then
      Index:=LOGPIXELSX
   else
      Index:=LOGPIXELSY;
   Result:=GetDeviceCaps(pobj.Handle, Index);
end;

{ Conver millimeter to pixels at X }
function ConvertMMtoPixelsX(const Value:Double):Integer;
begin
   Result := Round(Value*GetPrinterRes(Printer, True) / mmPerInch);
end;

{ Conver millimeter to pixels at Y }
function ConvertMMtoPixelsY(const Value:Double):Integer;
begin
   Result := Round(Value*GetPrinterRes(Printer, False) / mmPerInch);
end;

{ Conver inch to pixels at X }
function ConvertInchtoPixelsX(const Value:Double):Integer;
begin
   Result := Round(Value*GetPrinterRes(Printer, True));
end;

{ Conver inch to pixels at Y }
function ConvertInchtoPixelsY(const Value:Double):Integer;
begin
   Result := Round(Value*GetPrinterRes(Printer, False));
end;

{ Conver pixels to millimeter at X }
function ConvertPixelstoMMX(const Value:Double):Integer;
begin
   Result := Round(Value * mmPerInch / GetPrinterRes(Printer, True));
end;

{ Conver pixels to millimeter at Y }
function ConvertPixelstoMMY(const Value:Double):Integer;
begin
   Result := Round(Value * mmPerInch / GetPrinterRes(Printer, False));
end;

{ Conver pixels to inch at X }
function ConvertPixelstoInchX(const Value:Double):Integer;
begin
   Result := Round(Value / GetPrinterRes(Printer, True));
end;

{ Conver pixels to inch at Y }
function ConvertPixelstoInchY(const Value:Double):Integer;
begin
   Result := Round(Value / GetPrinterRes(Printer, False));
end;

