unit UCellReader;

interface
uses VCL.FlexCel.Core, Controls, USparseArray, Generics.Collections;

type
  //A simple cell reader that will get the values from FlexCel and put them into a grid.
  TCellReader = class
  private
    Only50Rows: boolean;
    FormatValues: boolean;
    SheetData: TObjectList<TSparseCellArray>;
  public
    constructor Create(const aOnly50Rows: boolean; const aSheetData: TObjectList<TSparseCellArray>; const aFormatValues: boolean);
    procedure OnStartReading(const sender: TObject; const e: TVirtualCellStartReadingEventArgs);
    procedure OnCellRead(const sender: TObject; const e: TVirtualCellReadEventArgs);

  end;
implementation
uses SysUtils;
{ TCellReader }

constructor TCellReader.Create(const aOnly50Rows: boolean; const aSheetData: TObjectList<TSparseCellArray>;
  const aFormatValues: boolean);
begin
  Only50Rows := aOnly50Rows;
  FormatValues := aFormatValues;
  SheetData := aSheetData;
end;

procedure TCellReader.OnCellRead(const sender: TObject;
  const e: TVirtualCellReadEventArgs);
var
  Clr: TUIColor;
begin
  if Only50Rows and (e.Cell.Row > 50) then
  begin
    e.NextSheet := ''; //Stop reading all sheets.
    exit;
  end;


  if FormatValues then
  begin
    SheetData[e.Cell.Sheet - 1].AddValue(e.Cell.Row, e.Cell.Col,
       TFlxNumberFormat.FormatValue(e.Cell.Value,
       TExcelFile(Sender).GetFormat(e.Cell.XF).Format, Clr, TExcelFile(Sender)));
  end
  else
  begin
    SheetData[e.Cell.Sheet - 1].AddValue(e.Cell.Row, e.Cell.Col, e.Cell.Value.ToString);
  end;
end;

procedure TCellReader.OnStartReading(const sender: TObject;
  const e: TVirtualCellStartReadingEventArgs);
var
  I: Integer;
begin
  SheetData.Clear;
  SheetData.Capacity := Length(e.SheetNames);
  for I := 0 to High(e.SheetNames) do
  begin
    SheetData.Add(TSparseCellArray.Create(e.SheetNames[i]));
  end;

end;

end.

