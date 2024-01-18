unit Unit22;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, VCL.FlexCel.Core, FlexCel.XlsAdapter,
  UCellReader, USparseArray, Generics.Collections, Vcl.ComCtrls, Vcl.Grids;

const
  BaseFileName = '..\..\test';
type
  TForm22 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    TabControl1: TTabControl;
    SheetData: TDrawGrid;
    cbXlsx: TCheckBox;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure TabControl1Change(Sender: TObject);
    procedure SheetDataDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Button2Click(Sender: TObject);
  private
    CellData: TObjectList<TSparseCellArray>;
    procedure FillTabControl;
    procedure FillGrid;
    function FileName: string;
    function GetCellValue(const aCol, aRow: integer): string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form22: TForm22;

implementation

{$R *.dfm}

procedure TForm22.Button1Click(Sender: TObject);
var
  xls: TXlsFile;
  CellReader: TCellReader;
begin
  xls := TXlsFile.Create(true);
  try
    xls.IgnoreFormulaText := true;
    xls.VirtualMode := true;
    CellReader := TCellReader.Create(true, CellData, true);
    try
      xls.VirtualCellStartReading := CellReader.OnStartReading;
      xls.VirtualCellRead := CellReader.OnCellRead;
      xls.Open(FileName);
    finally
      CellReader.Free;
    end;

    FillTabControl;
    TabControl1.TabIndex := xls.ActiveSheet - 1;
    FillGrid;

  finally
    xls.Free;
  end;
end;

procedure TForm22.FillTabControl;
var
  i: Integer;
begin
  TabControl1.Tabs.Clear;
  for i := 0 to CellData.Count - 1 do
  begin
    TabControl1.Tabs.Add(CellData[i].SheetName);
  end;
end;

procedure TForm22.FormCreate(Sender: TObject);
begin
  CellData := TObjectList<TSparseCellArray>.Create;
end;

procedure TForm22.FormDestroy(Sender: TObject);
begin
  CellData.Free;
end;

procedure TForm22.SheetDataDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  SheetData.Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 2, GetCellValue(ACol, ARow));
end;

function TForm22.GetCellValue(const aCol, aRow: integer): string;
begin
if ACol = 0 then
  begin
    if ARow = 0 then exit('');
    exit (IntToStr(aRow));
  end;
  if ARow = 0 then exit(TCellAddress.EncodeColumn(aCol));
  if (TabControl1.TabIndex < 0) or (TabControl1.TabIndex >= CellData.Count) then exit('');

  if CellData[TabControl1.TabIndex] = nil then exit('');
  exit(CellData[TabControl1.TabIndex].GetValue(ARow, aCol));
end;
procedure TForm22.TabControl1Change(Sender: TObject);
begin
  FillGrid;
end;

procedure TForm22.Button2Click(Sender: TObject);
var
  xls: TXlsFile;
begin
  //In this case we could just get the data from CellData
  //But we are going to read the full file.
  xls := TXlsFile.Create(FileName, true);
  try
    if (TabControl1.TabIndex < 0) or(TabControl1.TabIndex >= xls.SheetCount) then
    begin
      ShowMessage('There is no sheet selected. Press button 1');
      exit;
    end;

    xls.ActiveSheet := TabControl1.TabIndex + 1;
    ShowMessage(xls.GetCellValue(1, 1).ToString);
  finally
    xls.Free;
  end;
end;

function TForm22.FileName: string;
begin
  if cbXlsx.Checked then exit(BaseFileName + '.xlsx');
  exit(BaseFileName + '.xls')
end;

procedure TForm22.FillGrid;
var
  sheet: integer;
begin
  sheet := TabControl1.TabIndex;
  if (sheet < 0) or (sheet >= CellData.Count) then
  begin
    SheetData.ColCount := 1;
    SheetData.RowCount := 1;
    SheetData.Invalidate;
    exit;
  end;

  if CellData[sheet] <> nil then
  begin
    SheetData.ColCount := CellData[sheet].ColCount + 1;
    SheetData.RowCount := CellData[sheet].RowCount + 1;
  end
  else
  begin
    SheetData.ColCount := 1;
    SheetData.RowCount := 1;
  end;
  if (SheetData.ColCount > 1) and (SheetData.RowCount > 1) then
  begin
    SheetData.FixedRows := 1;
    SheetData.FixedCols := 1;
  end;

  SheetData.Invalidate;

end;


end.
