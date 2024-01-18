unit PDF_ShtIm2;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, Buttons, OleCtrls, ExtCtrls, StdCtrls, Mask, IniFiles,
  Grids,ToolWin,
  Vcl.Tabs,
  AxCtrls,VCL.FlexCel.Core, FlexCel.XlsAdapter, FlexCel.Render, FlexCel.Preview,
  UCellReader, USparseArray;


type
  TfmSheetImport = class(TForm)
    pControl: TPanel;
    sbSheet: TStatusBar;
    bbOpenSheet: TBitBtn;
    OpenDialogSprdSheet: TOpenDialog;
    gbDefineFields: TGroupBox;
    bbCancel: TBitBtn;
    gbDefineRows: TGroupBox;
    Label2: TLabel;
    Label3: TLabel;
    meFromRow: TEdit;
    meToRow: TEdit;
    bbImport: TBitBtn;
    Label4: TLabel;
    Label5: TLabel;
    Panel2: TPanel;
    Splitter1: TSplitter;
    gbDefineTabSheet: TGroupBox;
    cbSheetName: TComboBox;
    sbFindLastRow: TSpeedButton;
    pDefinitions: TPanel;
    Panel1: TPanel;
    Label1: TLabel;
    eDataColStr: TEdit;
    eSigmaColStr: TEdit;
    cbOmitNegatives: TCheckBox;
    Label6: TLabel;
    Label7: TLabel;
    eUnitAgeColStr: TEdit;
    Label8: TLabel;
    rgUncertainties: TRadioGroup;
    Label9: TLabel;
    eDefaultMinimum: TEdit;
    pData: TPanel;
    SheetData: TStringGrid;
    procedure bbOpenSheetClick(Sender: TObject);
    procedure bbImportClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bbCancelClick(Sender: TObject);
    procedure rgUncertaintiesClick(Sender: TObject);
  private
    { Private declarations }
    Xls : TXlsFile;
    CellData: TSparseCellArray; //For this demo we will store the data here, in your application you should use the data as you wish, send it to a db, etc.
    procedure ImportFile(const FileName: string);
    function GetCellValue(const aCol, aRow: integer): string;
    //procedure GetIniFile;
    //procedure UpdateIniFile;
    function ConvertCol2Int(AnyString : string) : integer;
  public
    { Public declarations }
    destructor Destroy; override;
  end;

var
  fmSheetImport: TfmSheetImport;

implementation

{$R *.DFM}

uses
  AllSorts, PDF_varb, PDF_dm;

var
  iRec, iRecCount      : integer;

destructor TfmSheetImport.Destroy;
begin
  CellData.Free;
  inherited;
end;

function TfmSheetImport.ConvertCol2Int(AnyString : string) : integer;
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

procedure TfmSheetImport.bbOpenSheetClick(Sender: TObject);
var
  tmpStr    : string;
  i         : integer;
begin
  OpenDialogSprdSheet.InitialDir := DataPath;
  if not OpenDialogSprdSheet.Execute then Exit;
  DataPath := ExtractFilePath(OpenDialogSprdSheet.FileName);
  ImportFile(OpenDialogSprdSheet.FileName);
end;

procedure TfmSheetImport.ImportFile(const FileName: string);
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

function TfmSheetImport.GetCellValue(const aCol, aRow: integer): string;
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

procedure TfmSheetImport.bbImportClick(Sender: TObject);
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
begin
  //DefaultMinimumSigmaStr := eDefaultMinimum.Text;
  //Val(DefaultMinimumSigmaStr,DefaultMinimum,iCode);
  ImportSheetNumber := cbSheetName.ItemIndex + 1;
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
  ShowMessage(IntToStr(FromRow)+'   '+IntToStr(ToRow));
  with dmPDF do
  begin
    // import data
    sbSheet.SimpleText := 'Importing raw data';
    sbSheet.Refresh;

    // do for all rows in data spreadsheet
    // repeat through variables
    // read data value

    dmPDF.cdsRawData.DisableControls;
    j := 1;
    for i := FromRow to ToRow do
    begin
      tmpDataStr := Xls.GetStringFromCell(i,DataCol);
      tmpSigmaStr := Xls.GetStringFromCell(i,SigmaCol);
      tmpUnitAgeStr := Xls.GetStringFromCell(i,UnitAgeCol);
      //if (i < 10) then
      //begin
      //  ShowMessage(IntToStr(i)+'   '+tmpDataStr+'   '+tmpSigmaStr);
      //end;
      dmPDF.cdsRawData.Append;
      try
        if (tmpDataStr <> '') then
        begin
          try
            dmPDF.cdsRawDatai.AsInteger := i;
            dmPDF.cdsRawDataData.AsString := tmpDataStr;
            //Val(tmpDataStr,DataArray[j,1],iCode);
          except
          end;
        end else
        begin
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
        end;
        if (tmpUnitAgeStr <> '') then
        begin
          try
            Val(tmpUnitAgeStr,tmpUnitAgeValue,iCode);
            if (iCode = 0) then
            begin
              tmpUnitAgeValue := tmpUnitAgeValue;
              tmpUnitAgeStr := FormatFloat('######0.000',tmpUnitAgeValue);
            end else
            begin
              tmpUnitAgeValue := 0.0;
            end;
            dmPDF.cdsRawDataUnitAge.AsString := tmpUnitAgeStr;
          except
          end;
        end else
        begin
        end;
      except
      end;
      {
      Val(tmpDataStr,tmpDataValue,iCode);
      if (iCode = 0) then
      begin
        if (cbOmitNegatives.Checked) then
        begin
          if (tmpDataValue >= 0.0) then
          begin
            j := j+1;
          end else
          begin
            j := j;
            dmPDF.cdsRawData.Delete;
          end;
        end;
      end else
      begin
        j := j;
        dmPDF.cdsRawData.Delete;
      end;
      }
    end;
  end;
  dmPDF.cdsRawData.First;
  dmPDF.cdsRawData.EnableControls;
  sbSheet.SimpleText := 'Finished importing all data';
  sbSheet.Refresh;
  DataColStr := UpperCase(eDataColStr.Text);
  SigmaColStr := UpperCase(eSigmaColStr.Text);
  UnitAgeColStr := UpperCase(eUnitAgeColStr.Text);
end;

procedure TfmSheetImport.FormShow(Sender: TObject);
var
  i, j : integer;
begin
  Splitter1.Visible := false;
  pDefinitions.Visible := false;
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

procedure TfmSheetImport.rgUncertaintiesClick(Sender: TObject);
begin
  case rgUncertainties.ItemIndex of
    0 : dmPDF.SigmaFactor := 1.0;
    1 : dmPDF.SigmaFactor := 1.0/2.0;
    2 : dmPDF.SigmaFactor := 1.0/1.96;
  end;
end;

procedure TfmSheetImport.bbCancelClick(Sender: TObject);
begin
  ModalResult := mrNone;
  bbImport.ModalResult := mrNone;
  Close;
end;




end.
