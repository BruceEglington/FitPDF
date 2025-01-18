program Fitpdf;

uses
  Forms,
  PDF_mn in 'PDF_mn.pas' {fmPDFMain},
  PDF_About in 'PDF_About.pas' {AboutBox},
  PDF_varb in 'PDF_varb.pas',
  PDF_dm in 'PDF_dm.pas' {dmPDF: TDataModule},
  PDF_mathproc in 'PDF_mathproc.pas',
  UCellReader in 'VirtMode\UCellReader.pas',
  USparseArray in 'VirtMode\USparseArray.pas',
  Vcl.Themes,
  Vcl.Styles,
  Allsorts in '..\Eglington Delphi common code items\Allsorts.pas',
  NumRecipes in '..\Eglington Delphi common code items\NumRecipes.pas',
  NumRecipes_varb in '..\Eglington Delphi common code items\NumRecipes_varb.pas',
  RecError in '..\Eglington Delphi common code items\RecError.pas' {ReconcileErrorForm},
  PDF_ShtImData in 'PDF_ShtImData.pas' {fmSheetImport};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Fit PDF';
  Application.CreateForm(TdmPDF, dmPDF);
  Application.CreateForm(TfmPDFMain, fmPDFMain);
  Application.CreateForm(TfmSheetImport, fmSheetImport);
  Application.Run;
end.
