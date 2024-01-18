unit PDF_ShtIm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, Buttons, OleCtrls, ExtCtrls, StdCtrls, Mask, IniFiles,
  Grids,ToolWin,
  Vcl.Tabs,
  AxCtrls,VCL.FlexCel.Core, FlexCel.XlsAdapter, FlexCel.Render, FlexCel.Preview;


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
    Tabs: TTabSet;
    procedure bbOpenSheetClick(Sender: TObject);
    procedure bbImportClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure bbCancelClick(Sender: TObject);
    procedure sbFindLastRowClick(Sender: TObject);
    procedure cbSheetNameChange(Sender: TObject);
    procedure rgUncertaintiesClick(Sender: TObject);
    procedure TabsClick(Sender: TObject);
  private
    { Private declarations }
    Xls : TXlsFile;
    //procedure GetIniFile;
    //procedure UpdateIniFile;
    function ConvertCol2Int(AnyString : string) : integer;
    procedure FillTabs;
    procedure ClearGrid;
    procedure FillGrid(const Formatted: boolean);
    function GetStringFromCell(iRow,iCol : integer) : string;
  public
    { Public declarations }
  end;

var
  fmSheetImport: TfmSheetImport;

implementation

{$R *.DFM}

uses
  AllSorts, PDF_varb, PDF_dm;

var
  iRec, iRecCount      : integer;

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

function TfmSheetImport.GetStringFromCell(iRow,iCol : integer) : string;
begin
  Result := Xls.GetStringFromCell(iRow,iCol);
end;

procedure TfmSheetImport.bbOpenSheetClick(Sender: TObject);
var
  tmpStr    : string;
  i         : integer;
begin
  //TabControl.Tabs.Clear;
  cbSheetname.Items.Clear;
  OpenDialogSprdSheet.InitialDir := DataPath;
  if OpenDialogSprdSheet.Execute then
  begin
    DataPath := ExtractFilePath(OpenDialogSprdSheet.FileName);
    //Open the Excel file.
    if Xls = nil then Xls := TXlsFile.Create(false);
    xls.Open(OpenDialogSprdSheet.FileName);
    FillTabs;
    Tabs.TabIndex := Xls.ActiveSheet - 1;
    //FlexCelImport1.OpenFile(OpenDialogSprdSheet.FileName);
    //for i := 1 to FlexCelImport1.SheetCount do
    //begin
    //  FlexCelImport1.ActiveSheet:=i;
    //  TabControl.Tabs.Add(FlexCelImport1.ActiveSheetName);
    //  cbSheetname.Items.Add(FlexCelImport1.ActiveSheetName);
    //end;
    //FlexCelImport1.ActiveSheet:=1;
    //TabControl.TabIndex:=FlexCelImport1.ActiveSheet-1;
    //cbSheetName.ItemIndex := FlexCelImport1.ActiveSheet-1;
    //Data.LoadSheet;
    //Data.Zoom := 70;
    FillGrid(true);
    pDefinitions.Visible := true;
    Splitter1.Visible := true;
    //dblcbImportSpec.KeyValue := dmDVRD.ElemNamesImportSpecName.AsString;
    try
      sbFindLastRowClick(Sender);
    except
    end;
  end;
end;

procedure TfmSheetImport.FillTabs;
var
  s: integer;
begin
  Tabs.Tabs.Clear;
  cbSheetname.Items.Clear;
  for s := 1 to Xls.SheetCount do
  begin
    Tabs.Tabs.Add(Xls.GetSheetName(s));
    cbSheetname.Items.Add(Xls.GetSheetName(s));
  end;
end;

procedure TfmSheetImport.ClearGrid;
var
  r: integer;
begin
  for r := 1 to SheetData.RowCount do SheetData.Rows[r].Clear;
end;

procedure TfmSheetImport.FillGrid(const Formatted: boolean);
var
  r, c, cIndex: Integer;
  v: TCellValue;
begin
  if Xls = nil then exit;
  if (Tabs.TabIndex + 1 <= Xls.SheetCount) and (Tabs.TabIndex >= 0) then Xls.ActiveSheet := Tabs.TabIndex + 1 else Xls.ActiveSheet := 1;
  //Clear data in previous grid
  ClearGrid;
  SheetData.RowCount := 1;
  SheetData.ColCount := 1;
  //FmtBox.Text := '';
  SheetData.RowCount := Xls.RowCount + 1; //Include fixed row
  SheetData.ColCount := Xls.ColCount + 1; //Include fixed col. NOTE THAT COLCOUNT IS SLOW. We use it here because we really need it. See the Performance.pdf doc.
  if (SheetData.ColCount > 1) then SheetData.FixedCols := 1; //it is deleted when we set the width to 1.
  if (SheetData.RowCount > 1) then SheetData.FixedRows := 1;

  for r := 1 to Xls.RowCount do
  begin
    //Instead of looping in all the columns, we will just loop in the ones that have data. This is much faster.
    for cIndex := 1 to Xls.ColCountInRow(r) do
    begin
      c := Xls.ColFromIndex(r, cIndex); //The real column.
      if Formatted then
      begin
        SheetData.Cells[c, r] := Xls.GetStringFromCell(r, c);
      end
      else
      begin
        v := Xls.GetCellValue(r, c);
        SheetData.Cells[c, r] := v.ToString;
      end;
    end;
  end;
  //Fill the row headers
  for r := 1 to SheetData.RowCount - 1 do
  begin
    SheetData.Cells[0, r] := IntToStr(r);
    SheetData.RowHeights[r] := Round(Xls.GetRowHeight(r) / TExcelMetrics.RowMultDisplay(Xls));
  end;
  //Fill the column headers
  for c := 1 to SheetData.ColCount - 1 do
  begin
    SheetData.Cells[c, 0] := TCellAddress.EncodeColumn(c);
    SheetData.ColWidths[c] := Round(Xls.GetColWidth(c) / TExcelMetrics.ColMult(Xls));
  end;
  //SelectedCell(1,1);
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
  bbOpenSheetClick(Sender);
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

procedure TfmSheetImport.sbFindLastRowClick(Sender: TObject);
var
  iCode : integer;
  tmpStr : string;
  i,j : integer;
begin
  ImportSheetNumber := cbSheetName.ItemIndex+1;
  meToRow.Text := '';
  ToRow := 0;
  iCode := 1;
  repeat
    tmpStr := meFromRow.Text;
    Val(tmpStr, FromRow, iCode);
    if (iCode = 0) then
    begin
    end else
    begin
      ShowMessage('Incorrect value entered for From row');
      Exit;
    end;
  until (iCode = 0);
  try
    i := FromRow;
    j := ConvertCol2Int(DataColStr);
    ToRow := 0;
    repeat
      i := i + 1;
      try
        tmpStr := Xls.GetStringFromCell(i,j);
      except
        tmpStr := '0.0';
      end;
    until (tmpStr = '');
  except
    //MessageDlg('Error reading data in column '+IntToStr(Data.Col),mtwarning,[mbOK],0);
  end;
  if (i > ToRow) then ToRow := i-1;
  meToRow.Text := IntToStr(ToRow);
  //Data.Row := 1;
end;

procedure TfmSheetImport.cbSheetNameChange(Sender: TObject);
begin
  //ImportSheetNumber := cbSheetName.ItemIndex+1;
  //TabControl.TabIndex := cbSheetname.ItemIndex;
  //FlexCelImport1.ActiveSheet:= TabControl.TabIndex+1;
  //Data.ApplySheet;
  //Data.Zoom := 70;
  //Data.LoadSheet;
  Tabs.TabIndex := cbSheetname.ItemIndex;
  sbFindLastRowClick(Sender);
end;

procedure TfmSheetImport.TabsClick(Sender: TObject);
begin
  FillGrid(true);
end;

end.
