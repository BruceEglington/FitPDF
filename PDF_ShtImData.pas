unit PDF_ShtImData;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  VCL.FlexCel.Core, FlexCel.XlsAdapter,  Vcl.ComCtrls, Vcl.Grids,
  UCellReader, USparseArray, System.Generics.Collections, System.ImageList,
  Vcl.ImgList, Vcl.VirtualImageList, SVGIconVirtualImageList;

type
  TfmSheetImport = class(TForm)
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
    meFromRow: TEdit;
    meToRow: TEdit;
    cbOmitNegatives: TCheckBox;
    sbSheet: TStatusBar;
    Splitter1: TSplitter;
    pData: TPanel;
    OpenDialogSprdSheet: TOpenDialog;
    lShowOnly50Rows: TLabel;
    Label10: TLabel;
    eExtraVarColStr: TEdit;
    Label11: TLabel;
    Label12: TLabel;
    eExtraCutoff: TEdit;
    TabControl1: TTabControl;
    SheetData: TDrawGrid;
    Label16: TLabel;
    eSampleNoColStr: TEdit;
    Label17: TLabel;
    Label19: TLabel;
    eFracColStr: TEdit;
    Label20: TLabel;
    Label13: TLabel;
    eAssocColStr: TEdit;
    Label14: TLabel;
    VirtualImageList1: TVirtualImageList;
    SVGIconVirtualImageList1: TSVGIconVirtualImageList;
    sbFindLastRow: TSpeedButton;
    procedure bbOpenSheetClick(Sender: TObject);
    procedure bbCancelClick(Sender: TObject);
    procedure SheetDataDrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure bbImportClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure rgUncertaintiesClick(Sender: TObject);
    procedure TabControl1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure sbFindLastRowClick(Sender: TObject);
  private
    CellData : TObjectList<TSparseCellArray>;
    //CellData: TSparseCellArray; //For this demo we will store the data here,
                                //in your application you should use the data as
                                //you wish, send it to a db, etc.
    MyActiveSheetNum : integer;
    procedure OpenFile(const FileName: string);
    procedure FillTabControl;
    procedure FillGrid;
    function GetCellValue(const aCol, aRow: integer): string;
    function ConvertCol2Int(AnyString : string) : integer;
  public
    { Public declarations }
  end;

var
  fmSheetImport: TfmSheetImport;

implementation

{$R *.dfm}

uses
  AllSorts, PDF_varb, PDF_dm;

procedure TfmSheetImport.FormCreate(Sender: TObject);
begin
  CellData := TObjectList<TSparseCellArray>.Create;
end;

procedure TfmSheetImport.FormDestroy(Sender: TObject);
begin
  CellData.Free;
end;

procedure TfmSheetImport.FormShow(Sender: TObject);
begin
  lShowOnly50Rows.Visible := ShowOnly50Rows;
  Splitter1.Visible := true;
  pDefinitions.Enabled := false;
  eDataColStr.Text := UpperCase(DataColStr);
  eSigmaColStr.Text := UpperCase(SigmaColStr);
  eUnitAgeColStr.Text := UpperCase(UnitAgeColStr);
  eExtraVarColStr.Text := UpperCase(ExtraVarColStr);
  eSampleNoColStr.Text := UpperCase(SampleNoColStr);
  eFracColStr.Text := UpperCase(FracColStr);
  eAssocColStr.Text := UpperCase(AssocColStr);
  meFromRow.Text := '2';
  meToRow.Text := '3';
  bbImport.Enabled := true;
  if (dmPDF.SigmaFactor = 1.0) then rgUncertainties.ItemIndex := 0;
  if (dmPDF.SigmaFactor = 1.0/2.0) then rgUncertainties.ItemIndex := 1;
  if (dmPDF.SigmaFactor = 1.0/1.96) then rgUncertainties.ItemIndex := 2;
  //bbOpenSheetClick(Sender);
  OpenDialogSprdSheet.FileName := '';
end;

procedure TfmSheetImport.bbCancelClick(Sender: TObject);
begin
  dmPDF.DataImported := true;
  Close;
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


procedure TfmSheetImport.bbImportClick(Sender: TObject);
var
  j, k     : integer;
  iCode : integer;
  i : integer;
  FromRow, ToRow : integer;
  tmpStr : string;
  tmpAssocStr,
  tmpSampleNoStr, tmpFracStr,
  tmpDataStr, tmpSigmaStr, tmpUnitAgeStr,
  tmpExtraVarStr : string;
  tmpData, tmpSigma, tmpUnitAge,
  tmpExtraVar : double;
  WasSuccessful : boolean;
  tmpDataValue, tmpSigmaValue, tmpUnitAgeValue,
  tmpExtraVarValue : double;
  NoDataValueStr : string;
  Xls: TExcelFile;
  Formatted : boolean;
  v : TCellValue;
begin
  NoDataValueStr := FormatFloat('###0.00',NoDataValue);
  case rgUncertainties.ItemIndex of
    0 : dmPDF.SigmaFactor := 1.0;
    1 : dmPDF.SigmaFactor := 1.0/2.0;
    2 : dmPDF.SigmaFactor := 1.0/1.96;
  end;
  dmPDF.DataImported := false;
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
        ShowMessage('Incorrect values entered for import specifications');
        Exit;
      end;
  until (iCode = 0);
  //ShowMessage('1');
  tmpStr := UpperCase(eDataColStr.Text);
  DataCol := ConvertCol2Int(tmpStr);
  tmpStr := UpperCase(eSigmaColStr.Text);
  SigmaCol := ConvertCol2Int(tmpStr);
  tmpStr := UpperCase(eUnitAgeColStr.Text);
  if (Trim(tmpStr) <> '0') then
  begin
    UnitAgeCol := ConvertCol2Int(tmpStr);
  end else
  begin
    UnitAgeCol := 37000;
  end;
  tmpStr := UpperCase(eExtraVarColStr.Text);
  if (Trim(tmpStr) <> '0') then
  begin
    ExtraVarCol := ConvertCol2Int(tmpStr);
  end else
  begin
    ExtraVarCol := 37000;
  end;
  tmpStr := UpperCase(eSampleNoColStr.Text);
  if (Trim(tmpStr) <> '0') then
  begin
    SampleNoCol := ConvertCol2Int(tmpStr);
  end else
  begin
    SampleNoCol := 37000;
  end;
  tmpStr := UpperCase(eFracColStr.Text);
  if (Trim(tmpStr) <> '0') then
  begin
    FracCol := ConvertCol2Int(tmpStr);
  end else
  begin
    FracCol := 37000;
  end;
  tmpStr := UpperCase(eAssocColStr.Text);
  if (Trim(tmpStr) <> '0') then
  begin
    AssocCol := ConvertCol2Int(tmpStr);
  end else
  begin
    AssocCol := 37000;
  end;
  //ShowMessage('2');
  //ShowMessage(IntToStr(DataCol)+'   '+IntToStr(SigmaCol)+'   '+IntToStr(UnitAgeCol));
  //ShowMessage(IntToStr(FromRow)+'   '+IntToStr(ToRow));
   //Open the Excel file.
  Xls := TXlsFile.Create(false);
  try
    xls.IgnoreFormulaText := true; //bme - hard code this for this situation
    xls.VirtualMode := false;
    try
      xls.Open(OpenDialogSprdSheet.FileName);
    finally
    end;
  //ShowMessage('3');

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
    xls.ActiveSheet := MyActiveSheetNum;
    //ShowMessage('Active sheet to read is number '+Int2Str(xls.ActiveSheet));
    for i := FromRow to ToRow do
    begin
      //if (i<7) then ShowMessage('i = '+IntToStr(i));

      //if Formatted then
      //begin
      //  tmpDataStr := trim(Xls.GetStringFromCell(i,DataCol));
      //  tmpSigmaStr := trim(Xls.GetStringFromCell(i,SigmaCol));
      //  tmpUnitAgeStr := trim(Xls.GetStringFromCell(i,UnitAgeCol));
      //end
      //else
      //begin
        v := Xls.GetCellValue(i,DataCol);
        tmpDataStr := v.ToString;
        v := Xls.GetCellValue(i,SigmaCol);
        tmpSigmaStr := v.ToString;
        if (UnitAgeCol < 37000) then
        begin
          v := Xls.GetCellValue(i,UnitAgeCol);
          tmpUnitAgeStr := v.ToString;
        end else
        begin
          tmpUnitAgeStr := NoDataValueStr;
        end;
        if (ExtraVarCol < 37000) then
        begin
          v := Xls.GetCellValue(i,ExtraVarCol);
          tmpExtraVarStr := v.ToString;
        end else
        begin
          tmpExtraVarStr := NoDataValueStr;
        end;
        if (SampleNoCol < 37000) then
        begin
          v := Xls.GetCellValue(i,SampleNoCol);
          tmpSampleNoStr := v.ToString;
        end else
        begin
          tmpSampleNoStr := 'Not defined';
        end;
        if (FracCol < 37000) then
        begin
          v := Xls.GetCellValue(i,FracCol);
          tmpFracStr := v.ToString;
        end else
        begin
          tmpFracStr := 'Not defined';
        end;
        if (AssocCol < 37000) then
        begin
          v := Xls.GetCellValue(i,AssocCol);
          tmpAssocStr := v.ToString;
        end else
        begin
          tmpAssocStr := 'Not defined';
        end;
      //end;
      //if (i < 10) then
      //begin
      //  ShowMessage(IntToStr(i)+'   '+IntToStr(DataCol)+'   '+IntToStr(SigmaCol)+'   '+IntToStr(UnitAgeCol)+'   *'+tmpDataStr+'*   *'+tmpSigmaStr+'*   *'+tmpUnitAgeStr+'*   *'+tmpSampleNoStr+'*   *'+tmpFracStr+'*   *'+tmpAssocStr+'*');
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
            dmPDF.cdsRawDataData.AsString := NoDataValueStr;
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
              tmpSigmaValue := tmpSigmaValue * dmPDF.SigmaFactor;
              //if (tmpSigmaValue < DefaultMinimum) then tmpSigmaValue := DefaultMinimum;
              tmpSigmaStr := FormatFloat('######0.000000',tmpSigmaValue);
            end else
            begin
              tmpSigmaValue := tmpSigmaValue * dmPDF.SigmaFactor;
              //if (tmpSigmaValue < DefaultMinimum) then tmpSigmaValue := DefaultMinimum;
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
        if (tmpExtraVarStr <> '') then
        begin
          try
            Val(tmpExtraVarStr,tmpExtraVarValue,iCode);
            if (iCode = 0) then
            begin
              //tmpUnitAgeValue := tmpUnitAgeValue;
              tmpExtraVarStr := FormatFloat('######0.000',tmpExtraVarValue);
            end else
            begin
              tmpExtraVarValue := 0.0;
              tmpExtraVarStr := FormatFloat('######0.000',tmpExtraVarValue);
            end;
            dmPDF.cdsRawDataExtra.AsString := tmpExtraVarStr;
          except
          end;
        end else
        begin
           tmpExtraVarValue := NoDataValue;
           tmpExtraVarStr := FormatFloat('######0.000',tmpExtraVarValue);
           dmPDF.cdsRawDataExtra.AsString := tmpExtraVarStr;
        end;
        if (tmpSampleNoStr <> '') then
        begin
          try
            dmPDF.cdsRawDataSampleNo.AsString := tmpSampleNoStr;
          except
          end;
        end else
        begin
           dmPDF.cdsRawDataSampleNo.AsString := 'Not defined';
        end;
        if (tmpFracStr <> '') then
        begin
          try
            dmPDF.cdsRawDataFrac.AsString := tmpFracStr;
          except
          end;
        end else
        begin
           dmPDF.cdsRawDataFrac.AsString := 'Not defined';
        end;
        if (tmpAssocStr <> '') then
        begin
          try
            dmPDF.cdsRawDataAssoc.AsString := tmpAssocStr;
          except
          end;
        end else
        begin
           dmPDF.cdsRawDataAssoc.AsString := 'Not defined';
        end;
      except
      end;
    end;
    //ShowMessage('4');
  end;
  finally
    Xls.Free;
  end;
  //ShowMessage('5');
  if (dmPDF.cdsRawData.RecordCount > 2) then dmPDF.DataImported := true;
  dmPDF.cdsRawData.First;
  dmPDF.cdsRawData.EnableControls;
  sbSheet.SimpleText := 'Finished importing all data';
  sbSheet.Refresh;
  Application.HandleMessage;
  //if dmPDF.DataImported then  ShowMessage('Data have been imported');
  DataColStr := UpperCase(eDataColStr.Text);
  SigmaColStr := UpperCase(eSigmaColStr.Text);
  UnitAgeColStr := UpperCase(eUnitAgeColStr.Text);
  ExtraVarColStr := UpperCase(eExtraVarColStr.Text);
  SampleNoColStr := UpperCase(eSampleNoColStr.Text);
  FracColStr := UpperCase(eFracColStr.Text);
  AssocColStr := UpperCase(eAssocColStr.Text);
  Close;
end;

procedure TfmSheetImport.bbOpenSheetClick(Sender: TObject);
var
  tmpStr    : string;
  i         : integer;
begin
  OpenDialogSprdSheet.InitialDir := DataPath;
  if not OpenDialogSprdSheet.Execute then Exit;
  DataPath := ExtractFilePath(OpenDialogSprdSheet.FileName);
  OpenFile(OpenDialogSprdSheet.FileName);
end;

procedure TfmSheetImport.OpenFile(const FileName: string);
var
  //StartOpen: TDateTime;
  //EndOpen: TDateTime;
  //StartSheetSelect, EndSheetSelect: TDateTime;
  Xls: TExcelFile;
  CellReader: TCellReader;
  Formatted : boolean;
begin
  pData.Visible := true;
  Formatted := false;
  //Open the Excel file.
  Xls := TXlsFile.Create(true);
  try
    xls.IgnoreFormulaText := true; //bme - hard code this for this situation since just reading cell values
    xls.VirtualMode := true;
    CellReader := TCellReader.Create(ShowOnly50Rows, CellData, Formatted);
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
    Xls.Free;
  end;
  pDefinitions.Enabled := true;
end;

procedure TfmSheetImport.FillTabControl;
var
  i: Integer;
begin
  TabControl1.Tabs.Clear;
  for i := 0 to CellData.Count - 1 do
  begin
    TabControl1.Tabs.Add(CellData[i].SheetName);
  end;
end;

procedure TfmSheetImport.rgUncertaintiesClick(Sender: TObject);
begin
  case rgUncertainties.ItemIndex of
    0 : dmPDF.SigmaFactor := 1.0;
    1 : dmPDF.SigmaFactor := 1.0/2.0;
    2 : dmPDF.SigmaFactor := 1.0/1.96;
  end;
end;

procedure TfmSheetImport.sbFindLastRowClick(Sender: TObject);
var
  iCode : integer;
  tmpStr : string;
  i,j : integer;
  tmpColStr : string;
begin
  ImportSheetNumber := TabControl1.TabIndex;
  tmpColStr := UpperCase(eDataColStr.Text);
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
    j := ConvertCol2Int(tmpColStr);
    ToRow := 0;
    repeat
      i := i + 1;
      try
        tmpStr := Trim(CellData[TabControl1.TabIndex].GetValue(i-1,j));
        //if (i<10) then ShowMessage(tmpStr);
      except
        tmpStr := '0.0';
      end;
    until (tmpStr = '');
  except
    //MessageDlg('Error reading data in column '+IntToStr(Data.Col),mtwarning,[mbOK],0);
  end;
  if (i > ToRow) then ToRow := i-1;
  meToRow.Text := IntToStr(ToRow);
end;

procedure TfmSheetImport.SheetDataDrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  SheetData.Canvas.TextRect(Rect, Rect.Left + 2, Rect.Top + 2, GetCellValue(ACol, ARow));
end;

procedure TfmSheetImport.TabControl1Change(Sender: TObject);
begin
  FillGrid;
  //ShowMessage('Active sheet is number '+Int2Str(MyActiveSheetNum));
end;

function TfmSheetImport.GetCellValue(const aCol, aRow: integer): string;
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

procedure TfmSheetImport.FillGrid;
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
  MyActiveSheetNum := sheet+1;
  SheetData.Invalidate;
end;


end.
