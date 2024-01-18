unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  Vcl.Grids, Vcl.ComCtrls, ToolWin,
  VCL.FlexCel.Core, FlexCel.XlsAdapter,
  UCellReader, USparseArray;

type
  TForm1 = class(TForm)
    pControl: TPanel;
    bbOpenSheet: TBitBtn;
    bbCancel: TBitBtn;
    pDefinitions: TPanel;
    gbDefineFields: TGroupBox;
    Label9: TLabel;
    Panel1: TPanel;
    Label5: TLabel;
    Label1: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    eDataColStr: TEdit;
    eSigmaColStr: TEdit;
    eUnitAgeColStr: TEdit;
    rgUncertainties: TRadioGroup;
    eDefaultMinimum: TEdit;
    Panel2: TPanel;
    bbImport: TBitBtn;
    gbDefineRows: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    sbFindLastRow: TSpeedButton;
    meFromRow: TEdit;
    meToRow: TEdit;
    cbOmitNegatives: TCheckBox;
    sbSheet: TStatusBar;
    Splitter1: TSplitter;
    pData: TPanel;
    OpenDialogSprdSheet: TOpenDialog;
    SheetData: TDrawGrid;
    procedure bbOpenSheetClick(Sender: TObject);
    procedure bbCancelClick(Sender: TObject);
    procedure SheetDataDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure bbImportClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rgUncertaintiesClick(Sender: TObject);
  private
    { Private declarations }
    CellData: TSparseCellArray; //For this demo we will store the data here, in your application you should use the data as you wish, send it to a db, etc.
    procedure ImportFile(const FileName: string);
    function GetCellValue(const aCol, aRow: integer): string;
    function ConvertCol2Int(AnyString : string) : integer;
  public
    { Public declarations }
    destructor Destroy; override;
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

uses
  AllSorts, PDF_varb, PDF_dm;

destructor TForm1.Destroy;
begin
  CellData.Free;
  inherited;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
  Splitter1.Visible := true;
  pDefinitions.Visible := true;
  eDataColStr.Text := UpperCase(DataColStr);
  eSigmaColStr.Text := UpperCase(SigmaColStr);
  eUnitAgeColStr.Text := UpperCase(UnitAgeColStr);
  meFromRow.Text := '2';
  meToRow.Text := '3';
  bbImport.Enabled := true;
  if (dmPDF.SigmaFactor = 1.0) then rgUncertainties.ItemIndex := 0;
  if (dmPDF.SigmaFactor = 1.0/2.0) then rgUncertainties.ItemIndex := 1;
  if (dmPDF.SigmaFactor = 1.0/1.96) then rgUncertainties.ItemIndex := 2;
  //bbOpenSheetClick(Sender);
  OpenDialogSprdSheet.FileName := '';
end;

procedure TForm1.bbCancelClick(Sender: TObject);
begin
  dmPDF.DataImported := true;
  Close;
end;

function TForm1.ConvertCol2Int(AnyString : string) : integer;
var
  itmp    : integer;
  tmpStr  : string;
  tmpChar : char;
begin
    AnyString := UpperCase(AnyString);
    tmpStr := AnyString;
    ClearNull(tmpStr);
    Result := 0;
    if (length(tmpStr) = 2) then
    begin
      tmpChar := tmpStr[1];
      itmp := (ord(tmpChar)-64)*26;
      tmpChar := tmpStr[2];
      Result := itmp+(ord(tmpChar)-64);
    end else
    begin
      tmpChar := tmpStr[1];
      Result := (ord(tmpChar)-64);
    end;
end;


procedure TForm1.bbImportClick(Sender: TObject);
var
  j, k     : integer;
  iCode : integer;
  i : integer;
  FromRow, ToRow : integer;
  tmpStr : string;
  tmpDataStr, tmpSigmaStr, tmpUnitAgeStr : string;
  tmpData, tmpSigma, tmpUnitAge : double;
  WasSuccessful : boolean;
  tmpDataValue, tmpSigmaValue, tmpUnitAgeValue : double;
  Xls: TExcelFile;
begin
  iCode := 1;
  repeat
    tmpStr := meFromRow.Text;
    Val(tmpStr, FromRow, iCode);
    if (iCode = 0) then
    begin
      tmpStr := meToRow.Text;
      Val(tmpStr, ToRow, iCode);
    end else
    begin
      ShowMessage('Incorrect value entered for From row');
      Exit;
    end;
    if (iCode = 0) then
    begin
      if (ToRow >= FromRow) then iCode := 0
                            else iCode := -1;
    end else
    begin
      ShowMessage('Incorrect value entered for To row');
      Exit;
    end;
    if (iCode <> 0)
      then begin
        ShowMessage('Incorrect values entered for rows to import');
        Exit;
      end;
  until (iCode = 0);
  tmpStr := UpperCase(eDataColStr.Text);
  DataCol := ConvertCol2Int(tmpStr);
  tmpStr := UpperCase(eSigmaColStr.Text);
  SigmaCol := ConvertCol2Int(tmpStr);
  tmpStr := UpperCase(eUnitAgeColStr.Text);
  UnitAgeCol := ConvertCol2Int(tmpStr);
  //ShowMessage(IntToStr(DataCol)+'   '+IntToStr(SigmaCol)+'   '+IntToStr(UnitAgeCol));
  //ShowMessage(IntToStr(FromRow)+'   '+IntToStr(ToRow));
   //Open the Excel file.
  Xls := TXlsFile.Create(false);
  try

    //By default, FlexCel returns the formula text for the formulas, besides its calculated value.
    //If you are not interested in formula texts, you can gain a little performance by ignoring it.
    //This also works in non virtual mode.
    xls.IgnoreFormulaText := true; //bme - hard code this for this situation

    xls.VirtualMode := false;
    try
      xls.Open(OpenDialogSprdSheet.FileName);
    finally
    end;

  with dmPDF do
  begin
    // import selected data
    sbSheet.SimpleText := 'Importing data from selected columns';
    sbSheet.Refresh;

    // do for all rows in data spreadsheet
    // repeat through variables
    // read data value

    dmPDF.cdsRawData.DisableControls;
    j := 1;
    for i := FromRow to ToRow do
    begin
      tmpDataStr := trim(Xls.GetStringFromCell(i,DataCol));
      tmpSigmaStr := trim(Xls.GetStringFromCell(i,SigmaCol));
      tmpUnitAgeStr := trim(Xls.GetStringFromCell(i,UnitAgeCol));
      //if (i < 10) then
      //begin
      //  ShowMessage(IntToStr(i)+'   '+IntToStr(DataCol)+'   '+IntToStr(SigmaCol)+'   '+IntToStr(UnitAgeCol)+'   *'+tmpDataStr+'*   *'+tmpSigmaStr+'*   *'+tmpUnitAgeStr+'*');
      //end;
      dmPDF.cdsRawData.Append;
      dmPDF.cdsRawDatai.AsInteger := i;
      try
        if (tmpDataStr <> '') then
        begin
          try
            //dmPDF.cdsRawDatai.AsInteger := i;
            dmPDF.cdsRawDataData.AsString := tmpDataStr;
          except
          end;
        end else
        begin
          try
            //dmPDF.cdsRawDatai.AsInteger := i;
            dmPDF.cdsRawDataData.AsString := '-999.0';
          except
          end;
        end;
      except
      end;
      try
        if (tmpSigmaStr <> '') then
        begin
          try
            Val(tmpSigmaStr,tmpSigmaValue,iCode);
            if (iCode = 0) then
            begin
              //if (tmpSigmaValue < DefaultMinimum) then tmpSigmaValue := DefaultMinimum;
              tmpSigmaValue := tmpSigmaValue * dmPDF.SigmaFactor;
              tmpSigmaStr := FormatFloat('######0.000000',tmpSigmaValue);
            end else
            begin
              tmpSigmaValue := tmpSigmaValue * dmPDF.SigmaFactor;
              tmpSigmaStr := FormatFloat('######0.000000',tmpSigmaValue);
            end;
            dmPDF.cdsRawDataSigma.AsString := tmpSigmaStr;
            //Val(tmpSigmaStr,DataArray[j,2],iCode);
          except
          end;
        end else
        begin
              tmpSigmaValue := DefaultMinimum * dmPDF.SigmaFactor;
              tmpSigmaStr := FormatFloat('######0.000000',tmpSigmaValue);
        end;
        if (tmpUnitAgeStr <> '') then
        begin
          try
            Val(tmpUnitAgeStr,tmpUnitAgeValue,iCode);
            if (iCode = 0) then
            begin
              //tmpUnitAgeValue := tmpUnitAgeValue;
              tmpUnitAgeStr := FormatFloat('######0.000',tmpUnitAgeValue);
            end else
            begin
              tmpUnitAgeValue := 0.0;
              tmpUnitAgeStr := FormatFloat('######0.000',tmpUnitAgeValue);
            end;
            dmPDF.cdsRawDataUnitAge.AsString := tmpUnitAgeStr;
          except
          end;
        end else
        begin
              tmpUnitAgeValue := -11.0;
              tmpUnitAgeStr := FormatFloat('######0.000',tmpUnitAgeValue);
        end;
      except
      end;
    end;
  end;
  finally
    Xls.Free;
  end;
  dmPDF.DataImported := true;
  dmPDF.cdsRawData.First;
  dmPDF.cdsRawData.EnableControls;
  sbSheet.SimpleText := 'Finished importing all data';
  sbSheet.Refresh;
  Application.ProcessMessages;
  //f dmPDF.DataImported then  ShowMessage('Data have been imported');
  DataColStr := UpperCase(eDataColStr.Text);
  SigmaColStr := UpperCase(eSigmaColStr.Text);
  UnitAgeColStr := UpperCase(eUnitAgeColStr.Text);
  Close;
end;

procedure TForm1.bbOpenSheetClick(Sender: TObject);
var
  tmpStr    : string;
  i         : integer;
begin
  OpenDialogSprdSheet.InitialDir := DataPath;
  if not OpenDialogSprdSheet.Execute then Exit;
  DataPath := ExtractFilePath(OpenDialogSprdSheet.FileName);
  ImportFile(OpenDialogSprdSheet.FileName);
end;

procedure TForm1.ImportFile(const FileName: string);
var
  StartOpen: TDateTime;
  EndOpen: TDateTime;
  StartSheetSelect, EndSheetSelect: TDateTime;
  Xls: TExcelFile;
  CellReader: TCellReader;
begin
   //Open the Excel file.
  Xls := TXlsFile.Create(false);
  try
    FreeAndNil(CellData);
    CellData := TSparseCellArray.Create;
    StartOpen := Now;

    //By default, FlexCel returns the formula text for the formulas, besides its calculated value.
    //If you are not interested in formula texts, you can gain a little performance by ignoring it.
    //This also works in non virtual mode.
    xls.IgnoreFormulaText := true; //bme - hard code this for this situation

    xls.VirtualMode := true;
    CellReader := TCellReader.Create(true, CellData, true);
    try
      xls.VirtualCellStartReading := CellReader.OnStartReading;
      xls.VirtualCellRead := CellReader.OnCellRead;

      xls.Open(FileName);
      StartSheetSelect := CellReader.StartSheetSelect;
      EndSheetSelect := CellReader.EndSheetSelect;
    finally
      CellReader.Free;
    end;
    EndOpen := Now;
  finally
    Xls.Free;
  end;

  if CellData <> nil then
  begin
    SheetData.ColCount := CellData.ColCount + 1;
    SheetData.RowCount := CellData.RowCount + 1;
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

procedure TForm1.rgUncertaintiesClick(Sender: TObject);
begin
  case rgUncertainties.ItemIndex of
    0 : dmPDF.SigmaFactor := 1.0;
    1 : dmPDF.SigmaFactor := 1.0/2.0;
    2 : dmPDF.SigmaFactor := 1.0/1.96;
  end;
end;

procedure TForm1.SheetDataDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  SheetData.Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 2, GetCellValue(ACol, ARow));
end;

function TForm1.GetCellValue(const aCol, aRow: integer): string;
begin
if ACol = 0 then
  begin
    if ARow = 0 then exit('');
    exit (IntToStr(aRow));
  end;
  if ARow = 0 then exit(TCellAddress.EncodeColumn(aCol));
  if CellData = nil then exit('');
  exit(CellData.GetValue(ARow, aCol));
end;


end.
