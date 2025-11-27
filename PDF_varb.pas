unit PDF_varb;

interface

uses
  SysUtils;

const
  FitPDFVersionStr = 'FitPDF (2013-2025)';
  NN = 5000;
  MaxSteps = 2500;
  FitPDFVersion = '2.9.1';
  zero         = 0;
  zerofloat    = 0.0;
  DefaultZeroLimit = 1.0e-14;
  Cutoff = 0.975;
  nt100Percent = '100';
  ntTrueProbability = '1';
  MaxBins = 200;
  GraphTypeC = 'C';
  GraphTypeS = 'S';
  GraphTypeM = 'M';
  NoDataValue = -999.99;

var
  Filename    : string[8];
  Title       : string[40];
  tempstr     : string[10];
  //N, M        : integer;
  NPts        : integer;
  Total       : double;
  DefaultMinimum : double;
  NormalisationType : string;
  PDFType : string;
  Steps, UserSpecifiedSteps : integer;
  GlobalChosenStyle : string;

var
   done                  : boolean;
   Lst                   : TextFile;
   AnyKey                : char;
   Toggle100             : byte;
   FilePrepared          : boolean;
   FullFileName         : string;
   IniFileName,
   IniFilePath,
   CommonFilePath,
   //LocalFilePath,
   ProgramFilePath,
   FlexTemplatePath,
   ExportPath,
   DataPath   : string;
   TotalRecs                   : Integer;
   AssocCol,
   ImportSheetNumber,
   SampleNoCol, FracCol,
   DataCol, SigmaCol, UnitAgeCol,
   ExtraVarCol : integer;
   AssocColStr,
   SampleNoColStr, FracColStr,
   DataColStr, SigmaColStr, UnitAgeColStr,
   ExtraVarColStr     : string;
   FromRowValueString, ToRowValueString : string;
   DefaultMinimumSigmaStr : string;
   FromRow, ToRow : integer;
   NumBins : integer;
   FromAge, ToAge : double;
   FromAgeLeft, ToAgeLeft : double;
   From3D, To3D : double;
   MinimumUncertainty : double;
   OptimumBinWidth : double;
   Cutoff1, Cutoff2, Cutoff3, Cutoff4, Cutoff5, Cutoff6 : double;
   Min3D, Max3D, Cutoff3D1, Cutoff3D2, Cutoff3D3, Cutoff3D4 : double;
   ChosenMultiCutoff : double;
   ShowOnly50Rows : boolean;
   Formatted : boolean;

function ConvertCol2Int(AnyString : string) : integer;

implementation


function ConvertCol2Int(AnyString : string) : integer;
var
  itmp    : integer;
  tmpStr  : string;
  tmpANSIstr : ANSIstring;
  tmpANSIChar : ANSIchar;
begin
    AnyString := UpperCase(AnyString);
    tmpStr := AnyString;
    Trim(tmpStr);
    //ClearNull(tmpStr);
    tmpANSIstr := ANSIstring(tmpStr);
    if (length(tmpANSIstr) = 2) then
    begin
      tmpANSIChar := tmpANSIstr[1];
      itmp := (ord(tmpANSIChar)-64)*26;
      tmpANSIChar := tmpANSIstr[2];
      Result := itmp+(ord(tmpANSIChar)-64);
    end else
    begin
      tmpANSIChar := tmpANSIstr[1];
      Result := (ord(tmpANSIChar)-64);
    end;
end;


end.