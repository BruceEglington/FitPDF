unit PDF_mn;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Grids, DBGrids, StdCtrls, Buttons, ExtCtrls, ToolWin, ComCtrls,
  Printers, Menus, Mask, IniFiles,
  ActnList,
  System.IOUtils, System.UITypes, VCL.Themes,  System.Variants,
  VCL.FlexCel.Core, FlexCel.XlsAdapter, FlexCel.Report,
  ActnMan, XPStyleActnCtrls, DBCtrls, VclTee.TeeProcs,
  VclTee.TeeHistogram, VclTee.TeEngine, VclTee.Chart, VclTee.TeeComma, VclTee.TeeEdit,
  Vcl.PlatformDefaultStyleActnCtrls, VclTee.TeeGDIPlus, System.Actions, Data.DB,
  VCLTee.StatChar, VCLTee.DBChart, VCLTee.TeeTools, VCLTee.TeeLegendScrollBar,
  VCLTee.TeePoin3,
  VCLTee.TeeVideo, VCLTee.TeeSurfa, VCLTee.TeeTriSurface, VCLTee.Series,
  System.ImageList, Vcl.ImgList, Vcl.VirtualImageList,
  PDF_varb, SVGIconVirtualImageList;

type
  TfmPDFMain = class(TForm)
    ToolBar1: TToolBar;
    sbMain: TStatusBar;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    Exit1: TMenuItem;
    pc1: TPageControl;
    tsControl: TTabSheet;
    N1: TMenuItem;
    ImportRawData1: TMenuItem;
    Help: TMenuItem;
    About1: TMenuItem;
    PrinterSetupDialog1: TPrinterSetupDialog;
    PrintDialog1: TPrintDialog;
    pOriginalDataTop: TPanel;
    SaveDialogSprdSheet: TSaveDialog;
    tsGraph: TTabSheet;
    pProbability: TPanel;
    Panel3: TPanel;
    pOriginalDataMain: TPanel;
    Panel2: TPanel;
    pDefinition: TPanel;
    ActionManager1: TActionManager;
    Splitter5: TSplitter;
    Splitter6: TSplitter;
    Panel1: TPanel;
    dbnRawData: TDBNavigator;
    CalculatePDF1: TMenuItem;
    N2: TMenuItem;
    Label6: TLabel;
    Label7: TLabel;
    eFromAge: TEdit;
    eToAge: TEdit;
    rgPDFType: TRadioGroup;
    rgNormalisationType: TRadioGroup;
    Label1: TLabel;
    eMinimumSigma: TEdit;
    ExportGraphValues1: TMenuItem;
    N3: TMenuItem;
    bbCalculate: TBitBtn;
    DBChart1: TDBChart;
    Label2: TLabel;
    Series4: THistogramSeries;
    TeeFunction1: THistogramFunction;
    Label4: TLabel;
    eNumBins: TEdit;
    UpDown1: TUpDown;
    Series1: TLineSeries;
    pHistogram: TPanel;
    Panel7: TPanel;
    pPDF: TPanel;
    Panel9: TPanel;
    dbgHistogram: TDBGrid;
    dbnHistogram: TDBNavigator;
    Label5: TLabel;
    Label3: TLabel;
    dbnPDF: TDBNavigator;
    dbgPDF: TDBGrid;
    pGrainAge: TPanel;
    bbOptimiseBinNum: TBitBtn;
    ChartEditor1: TChartEditor;
    tsVerticalView: TTabSheet;
    ChartPDF: TChart;
    PointSeries1: TPointSeries;
    Series2: TPointSeries;
    Series3: TPointSeries;
    PointSeries2: TPointSeries;
    Series5: TPointSeries;
    Series6: TLineSeries;
    Panel11: TPanel;
    TeeCommander1: TTeeCommander;
    ChartEditor2: TChartEditor;
    Panel12: TPanel;
    TeeCommander2: TTeeCommander;
    rgGraphType: TRadioGroup;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Panel5: TPanel;
    Label8: TLabel;
    dbnGrainData: TDBNavigator;
    dbgGrainData: TDBGrid;
    pGrainAgeCutoffs: TPanel;
    e5: TEdit;
    Label9: TLabel;
    e4: TEdit;
    e3: TEdit;
    e2: TEdit;
    e1: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    eGraphTitle: TEdit;
    bCheckFolders: TButton;
    Options1: TMenuItem;
    Showonlyfirst50rowsofimportspreadsheet1: TMenuItem;
    OptionsOmitNegativeData1: TMenuItem;
    Series8: TPointSeries;
    tsCumulativeProbability: TTabSheet;
    Panel8: TPanel;
    Panel10: TPanel;
    TeeCommander3: TTeeCommander;
    ChartEditor3: TChartEditor;
    ChartCum: TChart;
    Series9: TLineSeries;
    Panel13: TPanel;
    pCumulative: TPanel;
    Panel15: TPanel;
    Label17: TLabel;
    dbnCumulative: TDBNavigator;
    dbgCumulative: TDBGrid;
    Splitter3: TSplitter;
    ChartTool1: TLegendScrollBar;
    ChartTool2: TVideoTool;
    Label21: TLabel;
    Label22: TLabel;
    eFromAgeLeft: TEdit;
    eToAgeLeft: TEdit;
    Panel14: TPanel;
    Panel16: TPanel;
    Label20: TLabel;
    Label19: TLabel;
    Label18: TLabel;
    Memo1: TMemo;
    bRecordAVI: TButton;
    bShowSequence: TButton;
    eTimeDelay: TEdit;
    lTimeDelay: TLabel;
    Splitter4: TSplitter;
    ChartEditor4: TChartEditor;
    TeeCommander4: TTeeCommander;
    ChartGeotectonic: TChart;
    Series10: TPointSeries;
    Series11: TPointSeries;
    Series12: TPointSeries;
    tsHeat: TTabSheet;
    ChartHeat: TChart;
    ChartEditor5: TChartEditor;
    Panel17: TPanel;
    Panel18: TPanel;
    TeeCommander6: TTeeCommander;
    Series13: TIsoSurfaceSeries;
    OptionsSteps1: TMenuItem;
    StepsMaximum: TMenuItem;
    StepsUserSpecified: TMenuItem;
    ImportGeochronData1: TMenuItem;
    ExportProvenanceLimits1: TMenuItem;
    OptionsUseUppermostCutoffForProvenance1: TMenuItem;
    pExtraVariableDefinitions: TPanel;
    cbPlotExtraVariable: TCheckBox;
    Label16: TLabel;
    eExtraVarName: TEdit;
    pExtraVariable3DDefinitions: TPanel;
    eTo3D: TEdit;
    eFrom3D: TEdit;
    Label23: TLabel;
    e3D1: TEdit;
    e3D2: TEdit;
    e3D3: TEdit;
    e3D4: TEdit;
    Label24: TLabel;
    Series14: TPoint3DSeries;
    Series15: TPoint3DSeries;
    Series16: TPoint3DSeries;
    Series17: TPoint3DSeries;
    Series18: TPoint3DSeries;
    Series19: TPoint3DSeries;
    cb3DMajorPeaksOnly: TCheckBox;
    eExtraVarCutoffMin: TEdit;
    eExtraVarCutoffMax: TEdit;
    Label25: TLabel;
    tsSurface: TTabSheet;
    TeeCommanderSurface: TTeeCommander;
    ChartEditorSurface: TChartEditor;
    ChartSurface: TChart;
    Series20: TTriSurfaceSeries;
    Styles1: TMenuItem;
    Panel19: TPanel;
    Splitter7: TSplitter;
    TreeView1: TTreeView;
    Panel20: TPanel;
    TreeViewCum: TTreeView;
    Splitter8: TSplitter;
    bExit: TButton;
    VirtualImageListPDF: TVirtualImageList;
    ExportAssociationSampleAges1: TMenuItem;
    Splitter9: TSplitter;
    pAssoc: TPanel;
    Panel22: TPanel;
    Label26: TLabel;
    dbnAssociations: TDBNavigator;
    dbgAssociations: TDBGrid;
    Panel21: TPanel;
    Button1: TButton;
    Button2: TButton;
    Test1: TMenuItem;
    SVGIconVirtualImageList1: TSVGIconVirtualImageList;
    pOriginalData: TPanel;
    Panel24: TPanel;
    dbgRawData: TDBGrid;
    Panel4: TPanel;
    dbgAgeList: TDBGrid;
    pGraphOriginalData: TPanel;
    ChartOriginalData: TChart;
    Series7: TPointSeries;
    Panel6: TPanel;
    procedure ImportRawData1Click(Sender: TObject);
    procedure About1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var MyAction: TCloseAction);
    procedure bbExitClick(Sender: TObject);
    procedure bbOptimiseBinNumClick(Sender: TObject);
    procedure bbCalculateClick(Sender: TObject);
    procedure ExportGraphValues1Click(Sender: TObject);
    procedure bCheckFoldersClick(Sender: TObject);
    procedure tsGraphShow(Sender: TObject);
    procedure tsVerticalViewShow(Sender: TObject);
    procedure Showonlyfirst50rowsofimportspreadsheet1Click(Sender: TObject);
    procedure bShowSequenceClick(Sender: TObject);
    procedure tsControlShow(Sender: TObject);
    procedure bRecordAVIClick(Sender: TObject);
    procedure OptionsOmitNegativeData1Click(Sender: TObject);
    procedure StepsMaximumClick(Sender: TObject);
    procedure StepsUserSpecifiedClick(Sender: TObject);
    procedure ExportProvenanceLimits1Click(Sender: TObject);
    procedure OptionsUseUppermostCutoffForProvenance1Click(Sender: TObject);
    procedure rgGraphTypeClick(Sender: TObject);
    procedure ExportAssociationSampleAges1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure StyleClick(Sender: TObject);
    procedure Test1Click(Sender: TObject);
  private
    { Private declarations }
    MyCurrentStyle : string;
    procedure ExportSingleSampleProbability;
    procedure ExportMultipleSampleProbability;
    procedure ExportCumulativeClassification;
    procedure ExportProvenanceAgeLimits;
    procedure ExportAssociationSampleAges;
    procedure ApplySelectedThemeToCharts(CurrentStyle : string);
  public
    { Public declarations }
    procedure GetIniFile;
    procedure SetIniFile;
    procedure CalculatePDF(GraphType : string; NormalisationType : string; tAge : double);
    procedure Delay(ms: integer);
    procedure CalculateClusterLimits;
    procedure DetermineAssociations;
  end;

var
  fmPDFMain: TfmPDFMain;

implementation

uses
  shlobj,
  TeePNG, TeeSVGCanvas,
  TeeJPEG, TeExport,  AllSorts,
  VCLTee.TeeThemes,
  PDF_About, PDF_dm, PDF_mathproc,
  PDF_ShtImData;

{$R *.DFM}
{$D+}
var
  //ImportForm : TfmSheetImport;
  AboutForm : TAboutBox;

procedure TfmPDFMain.ImportRawData1Click(Sender: TObject);
var
  i, ii : integer;
  //DataImported : boolean;
  MaxX, MinX,
  Ke, sqrtbeta1,
  Sigma, Sigma2, Sigma3, Sigmabeta1,
  tx, Mean : double;
  tGrainAge, tAge : double;
  tAssoc, tSampleNo : string;
  tMatchingAge : double;
  tMatchingAssoc, tMatchingSampleNo : string;
  tN : integer;
begin
  sbMain.Panels[1].Text := 'Importing';
  sbMain.Refresh;
  Application.HandleMessage;
  tsGraph.TabVisible := false;
  tsVerticalView.TabVisible := false;
  tsCumulativeProbability.TabVisible := false;
  tsSurface.TabVisible := false;
  tsHeat.TabVisible := false;
  pc1.ActivePage := tsControl;
  dmPDF.DataImported := false;
  dmPDF.cdsRawData.LogChanges := false;
  dmPDF.cdsPDF.LogChanges := false;
  dmPDF.cdsHistogram.LogChanges := false;
  dmPDF.cdsAgeList.LogChanges := false;
  dmPDF.cdsAssocSampleAge.LogChanges := false;
  dmPDF.cdsAssociations.LogChanges := false;
  dmPDF.cdsSamples.LogChanges := false;
  dmPDF.cdsRawData.DisableControls;
  dmPDF.cdsAgeList.DisableControls;
  try
      dmPDF.cdsRawData.EmptyDataSet;
      dmPDF.cdsPDF.EmptyDataSet;
      dmPDF.cdsHistogram.EmptyDataSet;
      dmPDF.cdsAgeList.EmptyDataSet;
      dmPDF.cdsAssocSampleAge.EmptyDataSet;
      dmPDF.cdsAssociations.EmptyDataSet;
      dmPDF.cdsSamples.EmptyDataSet;
  finally
  end;
  fmSheetImport.pData.Visible := false;
  fmSheetImport.ShowModal;
  if dmPDF.DataImported then
  begin
    dmPDF.cdsRawData.First;
    //for i := 1 to 10 do
    //begin
    //  ShowMessage(IntToStr(i)+'  '+FormatFloat('####0.000',dmPDF.cdsRawDataData.AsFloat)+'   '+FormatFloat('####0.000',dmPDF.cdsRawDataSigma.AsFloat));
    //  dmPDF.cdsRawData.Next;
    //end;
    NPts := dmPDF.cdsRawData.RecordCount;
    sbMain.Panels[1].Text := 'Imported';
    sbMain.Panels[0].Text := Int2Str(NPts);
    sbMain.Refresh;
    Application.HandleMessage;
    //ShowMessage(IntToStr(NPts));
    //check and delete all records with zero age and zero data values
    dmPDF.cdsRawData.Filter := 'UnitAge = '+FormatFloat('###0.000',1.0*zero)+'and Data = '+FormatFloat('###0.000',1.0*zero);
    dmPDF.cdsRawData.Filtered := true;
    tN := dmPDF.cdsRawData.RecordCount;
    if (tN > 0) then
    begin
      dmPDF.cdsRawData.Last;
      repeat
        dmPDF.cdsRawData.Delete;
      until dmPDF.cdsRawData.Bof;
    end;
    dmPDF.cdsRawData.Filtered := false;
    if (OptionsOmitNegativeData1.Checked) then
    begin
      dmPDF.cdsRawData.Last;
      repeat
        if (dmPDF.cdsRawDataData.AsFloat < 0.0) then
        begin
          dmPDF.cdsRawData.Delete;
        end else
        begin
          dmPDF.cdsRawData.Prior;
        end;
      until dmPDF.cdsRawData.Bof;
    end;
    NPts := dmPDF.cdsRawData.RecordCount;
    sbMain.Panels[1].Text := 'Cleaned';
    sbMain.Panels[0].Text := Int2Str(NPts);
    sbMain.Refresh;
    Application.HandleMessage;
    //ShowMessage('6');
    if (NPts > 2) then
    begin
      dbgRawData.DataSource := nil;
      dbnRawData.DataSource := nil;
      dmPDF.cdsRawData.First;
      dbgAgeList.DataSource := nil;
      Mean := 0.0;
      MaxX := dmPDF.cdsRawDataData.AsFloat;
      MinX := dmPDF.cdsRawDataData.AsFloat;
      for i := 1 to NPts do
      begin
        Mean := Mean +  dmPDF.cdsRawDataData.AsFloat;
        if (dmPDF.cdsRawDataData.AsFloat > MaxX) then MaxX := dmPDF.cdsRawDataData.AsFloat;
        if (dmPDF.cdsRawDataData.AsFloat < MinX) then MinX := dmPDF.cdsRawDataData.AsFloat;
        dmPDF.cdsRawData.Next;
      end;
      Mean := Mean / (1.0*NPts);
      dmPDF.cdsRawData.First;
      Sigma2 := 0.0;
      Sigma3 := 0.0;
      for i := 1 to NPts do
      begin
        tx := dmPDF.cdsRawDataData.AsFloat - Mean;
        Sigma2 := Sigma2 +  (tx*tx);
        Sigma3 := Sigma3 + (tx*tx*tx);
        dmPDF.cdsRawData.Next;
      end;
      tx := LogBase(1.0*Npts,2.0);
      //ShowMessage('log2(Npts) is '+FormatFloat('####0.0000',tx));
      Sigma := sqrt(sigma2/(1.0*NPts-1.0));
      sqrtbeta1 := Sigma3/(power(3.0/2.0,Sigma2));
      sigmabeta1 := sqrt((6.0*(Npts-2))/(1.0*(Npts+1)*(Npts+3)));
      Ke := 1.0 + sqrtbeta1/sigmabeta1;
      //ShowMessage('Ke before log2 is '+FormatFloat('####0.0000',Ke));
      Ke := LogBase(1.0 + sqrtbeta1/sigmabeta1,2.0);
      //ShowMessage('Ke after log2 is '+FormatFloat('####0.0000',Ke));
      OptimumBinWidth := (MaxX - MinX)/(1.0+LogBase(1.0*Npts,2.0)+Ke);
      //ShowMessage('Doane Optimum bin width is '+FormatFloat('####0.0000',OptimumBinWidth));
      tx := power(-1.0/3.0,1.0*NPts);
      OptimumBinWidth := 3.49 * Sigma * power(-1.0/3.0,1.0*NPts);
      //ShowMessage('Max is '+FormatFloat('####0.0000',MaxX));
      //ShowMessage('Min is '+FormatFloat('####0.0000',MinX));
      //ShowMessage('Mean is '+FormatFloat('####0.0000',Mean));
      //ShowMessage('Sigma is '+FormatFloat('####0.0000',Sigma));
      //ShowMessage('Sigma2 is '+FormatFloat('####0.0000',Sigma2));
      //ShowMessage('Sigma3 is '+FormatFloat('####0.0000',Sigma3));
      //ShowMessage('sqrtbeta1 is '+FormatFloat('####0.0000',sqrtbeta1));
      //ShowMessage('sigmabeta1 is '+FormatFloat('####0.0000',sigmabeta1));
      //ShowMessage('power is '+FormatFloat('####0.0000',tx));
      //ShowMessage('Optimum bin width is '+FormatFloat('####0.0000',OptimumBinWidth));

      //transfer all unique ages in the RawData set into the AgeList set
      //initialise the AgeList contents with default values for Cawood classification colours
      dmPDF.cdsAgeList.EmptyDataSet;
      dmPDF.cdsRawData.First;
      ChartOriginalData.Series[0].BeginUpdate;
      ChartOriginalData.Series[0].Clear;
      repeat
        tAge := dmPDF.cdsRawDataUnitAge.AsFloat;
        tGrainAge := dmPDF.cdsRawDataData.AsFloat;
        dmPDF.cdsAgeList.Locate('UnitAge',tAge,[]);
        tMatchingAge := dmPDF.cdsAgeListUnitAge.AsFloat;
        if (tAge <> tMatchingAge) then
        begin
          try
            if (tAge > NoDataValue) then
            begin
              dmPDF.cdsAgeList.Append;
              dmPDF.cdsAgeListUnitAge.AsFloat := tAge;
              dmPDF.cdsAgeListClassification.AsString := 'nd';
              dmPDF.cdsAgeListClassNum.AsInteger := 0;
              dmPDF.cdsAgeList.Post;
            end;
          except
          end;
        end;
        ChartOriginalData.Series[0].AddXY(tGrainAge,tAge);
        dmPDF.cdsRawData.Next;
      until (dmPDF.cdsRawData.Eof);
      ChartOriginalData.Series[0].EndUpdate;
      if (dmPDF.cdsRawData.ChangeCount > 0) then dmPDF.cdsRawData.MergeChangeLog;
      if (dmPDF.cdsAgeList.ChangeCount > 0) then dmPDF.cdsAgeList.MergeChangeLog;
    end;
    dbgRawData.DataSource := dmPDF.dsRawData;
    dbnRawData.DataSource := dmPDF.dsRawData;
    dbgAgeList.DataSource := dmPDF.dsAgeList;
    dmPDF.cdsRawData.First;
    dmPDF.cdsAgeList.First;
    fmPDFMain.Refresh;
    sbMain.Panels[1].Text := 'Data imported';
    sbMain.Refresh;
  end;
  dmPDF.cdsRawData.EnableControls;
  dmPDF.cdsAgeList.EnableControls;
  ExportAssociationSampleAges1.Visible := false;
end;

procedure TfmPDFMain.DetermineAssociations;
var
  i, ii : integer;
  //DataImported : boolean;
  tGrainAge, tAge : double;
  tAssoc, tSampleNo : string;
  tMatchingAge : double;
  tMatchingAssoc, tMatchingSampleNo : string;
begin
  sbMain.Panels[1].Text := 'Associating samples';
  sbMain.Refresh;
  Application.HandleMessage;
  dmPDF.cdsAssocSampleAge.EmptyDataSet;
  dmPDF.cdsRawData.First;
  dmPDF.cdsAssocSampleAge.DisableControls;
  repeat
    tAge := dmPDF.cdsRawDataUnitAge.AsFloat;
    tAssoc := dmPDF.cdsRawDataAssoc.AsString;
    tSampleNo := dmPDF.cdsRawDataSampleNo.AsString;
    dmPDF.cdsAssocSampleAge.Locate('Association;SampleNo;DeposAge',VarArrayOf([tAssoc,tSampleNo,tAge]),[]);
    tMatchingAge := dmPDF.cdsAssocSampleAgeDeposAge.AsFloat;
    tMatchingAssoc := dmPDF.cdsAssocSampleAgeAssociation.AsString;
    tMatchingSampleNo := dmPDF.cdsAssocSampleAgeSampleNo.AsString;
    if ((tAssoc <> tMatchingAssoc) or (tAge <> tMatchingAge) or (tSampleNo <> tMatchingSampleNo)) then
    begin
      try
        dmPDF.cdsAssocSampleAge.Append;
        dmPDF.cdsAssocSampleAgeAssociation.AsString := dmPDF.cdsRawDataAssoc.AsString;
        dmPDF.cdsAssocSampleAgeSampleNo.AsString := dmPDF.cdsRawDataSampleNo.AsString;
        dmPDF.cdsAssocSampleAgeDeposAge.AsFloat := dmPDF.cdsRawDataUnitAge.AsFloat;
        dmPDF.cdsAssocSampleAge.Post;
      except
      end;
    end;
    dmPDF.cdsRawData.Next;
  until (dmPDF.cdsRawData.Eof);
  dmPDF.cdsRawData.First;
  dmPDF.cdsAssociations.EmptyDataSet;
  dmPDF.cdsAssocSampleAge.First;
  dmPDF.cdsAssociations.DisableControls;
  repeat
    tAssoc := dmPDF.cdsAssocSampleAgeAssociation.AsString;
    dmPDF.cdsAssociations.Locate('Association',VarArrayOf([tAssoc]),[]);
    tMatchingAssoc := dmPDF.cdsAssociationsAssociation.AsString;
    if ((tAssoc <> tMatchingAssoc)) then
    begin
      try
        dmPDF.cdsAssociations.Append;
        dmPDF.cdsAssociationsAssociation.AsString := dmPDF.cdsAssocSampleAgeAssociation.AsString;
        dmPDF.cdsAssociations.Post;
      except
      end;
    end;
    dmPDF.cdsAssocSampleAge.Next;
  until (dmPDF.cdsAssocSampleAge.Eof);
  dmPDF.cdsAssociations.EnableControls;
  dmPDF.cdsAssociations.First;
  dmPDF.cdsSamples.EmptyDataSet;
  dmPDF.cdsAssocSampleAge.First;
  repeat
    tSampleNo := dmPDF.cdsAssocSampleAgeSampleNo.AsString;
    dmPDF.cdsSamples.Locate('SampleNo',VarArrayOf([tSampleNo]),[]);
    tMatchingSampleNo := dmPDF.cdsSamplesSampleNo.AsString;
    if ((tSampleNo <> tMatchingSampleNo)) then
    begin
      try
        dmPDF.cdsSamples.Append;
        dmPDF.cdsSamplesSampleNo.AsString := dmPDF.cdsAssocSampleAgeSampleNo.AsString;
        dmPDF.cdsSamples.Post;
      except
      end;
    end;
    dmPDF.cdsAssocSampleAge.Next;
  until (dmPDF.cdsAssocSampleAge.Eof);
  dmPDF.cdsSamples.First;
  dmPDF.cdsAssocSampleAge.Filtered := false;
  dmPDF.cdsAssocSampleAge.First;
  dmPDF.cdsAssocSampleAge.EnableControls;
  dmPDF.cdsRawData.First;
  dmPDF.cdsAgeList.First;
  fmPDFMain.Refresh;
  sbMain.Panels[1].Text := 'Associations prepared';
  sbMain.Refresh;
  dmPDF.cdsRawData.EnableControls;
  dmPDF.cdsAgeList.EnableControls;
  ExportAssociationSampleAges1.Visible := true;
end;

procedure TfmPDFMain.OptionsOmitNegativeData1Click(Sender: TObject);
begin
  OptionsOmitNegativeData1.Checked := not OptionsOmitNegativeData1.Checked;
end;

procedure TfmPDFMain.OptionsUseUppermostCutoffForProvenance1Click(
  Sender: TObject);
var
  iCode : integer;
begin
  Val(e5.Text,Cutoff5,iCode);
  if (iCode = 0) then dmPDF.ChosenCutoff := Cutoff5;
  if (OptionsUseUppermostCutoffForProvenance1.Checked) then
  begin
    OptionsUseUppermostCutoffForProvenance1.Checked := false;
    dmPDF.ChosenCutoff := 0.0;
  end else
  begin
    OptionsUseUppermostCutoffForProvenance1.Checked := true;
    Val(e5.Text,Cutoff5,iCode);
    if (iCode = 0) then dmPDF.ChosenCutoff := Cutoff5;
  end;
  MessageDlg('Cluster cutoff set to '+FormatFloat('###0.000',dmPDF.ChosenCutoff),mtInformation,[mbOK],0);
end;

procedure TfmPDFMain.rgGraphTypeClick(Sender: TObject);
begin
  if (rgGraphType.ItemIndex = 0) then
  begin
    pGrainAgeCutoffs.Visible := false;
    pExtraVariableDefinitions.Visible := false;
    pExtraVariable3DDefinitions.Visible := false;
  end;
  if (rgGraphType.ItemIndex = 1) then
  begin
    pGrainAgeCutoffs.Visible := true;
    pExtraVariableDefinitions.Visible := true;
    pExtraVariable3DDefinitions.Visible := false;
  end;
  if (rgGraphType.ItemIndex = 2) then
  begin
    pGrainAgeCutoffs.Visible := false;
    pExtraVariableDefinitions.Visible := false;
    pExtraVariable3DDefinitions.Visible := false;
  end;
  if (rgGraphType.ItemIndex = 3) then
  begin
    pGrainAgeCutoffs.Visible := true;
    pExtraVariableDefinitions.Visible := false;
    pExtraVariable3DDefinitions.Visible := true;
  end;
end;

procedure TfmPDFMain.CalculateClusterLimits;
var
  i, iStep, iPreviousStep : integer;
  iCluster : integer;
  StepIncrement : integer;
  tMinAge, tMaxAge : double;
  tUnitAge, tPreviousUnitAge : double;
begin
  // calculate minimum and maximum ages for each sample's major peak
  // clusters and output to spreadsheet for matching to provenence
  // localities from downloads of information in DateView
  dmPDF.cdsGrainData.First;
  dmPDF.cdsSelectedGrainData.EmptyDataSet;
  dmPDF.cdsSelectedGrainData.First;
  dmPDF.cdsClusterLimits.EmptyDataSet;
  dmPDF.cdsClusterLimits.First;
  repeat
    iStep := dmPDF.cdsSelectedGrainDataStepID.AsInteger;
    if (dmPDF.cdsGrainDataPDFvalue.AsFloat >= dmPDF.ChosenCutoff) then
    begin
      dmPDF.cdsSelectedGrainData.Append;
      dmPDF.cdsSelectedGrainDataUnitAge.AsFloat := dmPDF.cdsGrainDataUnitAge.AsFloat;
      dmPDF.cdsSelectedGrainDataStepID.AsInteger := dmPDF.cdsGrainDataStepID.AsInteger;
      dmPDF.cdsSelectedGrainDataGrainAge.AsFloat := dmPDF.cdsGrainDataGrainAge.AsFloat;
      dmPDF.cdsSelectedGrainDataPDFValue.AsFloat := dmPDF.cdsGrainDataPDFvalue.AsFloat;
      dmPDF.cdsSelectedGrainDataClusterID.AsInteger := 0;
      dmPDF.cdsSelectedGrainData.Post;
    end;
    dmPDF.cdsGrainData.Next;
  until dmPDF.cdsGrainData.Eof;
  dmPDF.cdsGrainData.First;
  dmPDF.cdsSelectedGrainData.First;
  iCluster := 0;
  StepIncrement := 1;
  iPreviousStep := 1;
  tUnitAge := 0.0;
  tPreviousUnitAge := 0.0;
  repeat
    iStep := dmPDF.cdsSelectedGrainDataStepID.AsInteger;
    tUnitAge := dmPDF.cdsSelectedGrainDataUnitAge.AsFloat;
    if ((tUnitAge <> tPreviousUnitAge) or (Abs(iStep - iPreviousStep) <> 1)) then
    begin
      iCluster := iCluster + 1;
    end;
    dmPDF.cdsSelectedGrainData.Edit;
    dmPDF.cdsSelectedGrainDataClusterID.AsInteger := iCluster;
    dmPDF.cdsSelectedGrainData.Post;
    iPreviousStep := iStep;
    tPreviousUnitAge := tUnitAge;
    dmPDF.cdsSelectedGrainData.Next;
  until dmPDF.cdsSelectedGrainData.Eof;
  dmPDF.cdsSelectedGrainData.First;
  dmPDF.cdsClusterLimits.First;
  i := 1;
  repeat
    dmPDF.cdsSelectedGrainData.Filter := 'ClusterID = '+IntToStr(i);
    dmPDF.cdsSelectedGrainData.Filtered := true;
    tUnitAge := dmPDF.cdsSelectedGrainDataUnitAge.AsFloat;
    dmPDF.cdsSelectedGrainData.First;
    tMinAge := dmPDF.cdsSelectedGrainDataGrainAge.AsFloat;
    dmPDF.cdsSelectedGrainData.Last;
    tMaxAge := dmPDF.cdsSelectedGrainDataGrainAge.AsFloat;
    if (tMaxAge <= tMinAge) then tMaxAge := tMinAge + 1.0;
    dmPDF.cdsClusterLimits.Append;
    dmPDF.cdsClusterLimitsUnitAge.AsFloat := tUnitAge;
    dmPDF.cdsClusterLimitsClusterID.AsInteger := i;
    dmPDF.cdsClusterLimitsClusterMinAge.AsFloat := tMinAge;
    dmPDF.cdsClusterLimitsClusterMaxAge.AsFloat := tMaxAge;
    dmPDF.cdsClusterLimits.Post;
    i := i + 1;
  until (i > iCluster);
  dmPDF.cdsSelectedGrainData.Filtered := false;
  dmPDF.cdsSelectedGrainData.First;
  dmPDF.cdsClusterLimits.First;
end;

procedure TfmPDFMain.ExportGraphValues1Click(Sender: TObject);
begin
  if (rgGraphType.ItemIndex = 0) then
  begin
    ExportSingleSampleProbability;
  end;
  if (rgGraphType.ItemIndex = 1) then
  begin
    ChosenMultiCutoff := Cutoff1;
    if (not PointSeries1.Visible) then
    begin
      //ShowMessage('Cutoff2');
      ChosenMultiCutoff := Cutoff2;
    end;
    if (not Series2.Visible) then
    begin
      //ShowMessage('Cutoff3');
      ChosenMultiCutoff := Cutoff3;
    end;
    if (not Series3.Visible) then
    begin
      //ShowMessage('Cutoff4');
      ChosenMultiCutoff := Cutoff4;
    end;
    if (not PointSeries2.Visible) then
    begin
      //ShowMessage('Cutoff5');
      ChosenMultiCutoff := Cutoff5;
    end;
    //ShowMessage('ChosenMultiCutoff = '+FormatFloat('###0.000000',ChosenMultiCutoff));
    ExportMultipleSampleProbability;
  end;
  if (rgGraphType.ItemIndex = 2) then
  begin
    ExportCumulativeClassification;
    //ShowMessage('Exporting of results curves to spreadsheet not yet implemented');
  end;
  //ShowMessage('after write file');
end;

procedure TfmPDFMain.ExportMultipleSampleProbability;
var
  fr: TFlexCelReport;
  frTemplateStr, frFileNameStr : string;
begin
  frTemplateStr := FlexTemplatePath+'pdf_grainpdf.xlsx';
  SaveDialogSprdSheet.InitialDir := ExportPath;
  SaveDialogSprdSheet.FileName := 'FitPDF_results_multiplesample';
  if SaveDialogSprdSheet.Execute then
  begin
    frFileNameStr := SaveDialogSprdSheet.FileName;
    ExportPath := ExtractFilePath(SaveDialogSprdSheet.FileName);
    fr := TFlexCelReport.Create(true);
    try
      fr.AddTable('cdsGrainData',dmPDF.cdsGrainData);
      if (ChosenMultiCutoff > 0.000000) then
      begin
        dmPDF.cdsGrainData.Filter := 'PDFValue > '+FormatFloat('###0.0000',ChosenMultiCutoff);
        dmPDF.cdsGrainData.Filtered := true;
      end;
      fr.Run(
         frTemplateStr,frFileNameStr
        //TPath.Combine(TPath.GetDocumentsPath, 'report.template.xlsx'),
        //              TPath.Combine(TPath.GetDocumentsPath, 'result.xlsx')
      );
    finally
      dmPDF.cdsGrainData.Filtered := false;
      fr.Free;
    end;
  end;
end;

procedure TfmPDFMain.ExportProvenanceAgeLimits;
var
  fr: TFlexCelReport;
  frTemplateStr, frFileNameStr : string;
begin
  frTemplateStr := FlexTemplatePath+'pdf_clusterlimits.xlsx';
  SaveDialogSprdSheet.InitialDir := ExportPath;
  SaveDialogSprdSheet.FileName := 'FitPDF_results_provenanceagelimits';
  if SaveDialogSprdSheet.Execute then
  begin
    frFileNameStr := SaveDialogSprdSheet.FileName;
    ExportPath := ExtractFilePath(SaveDialogSprdSheet.FileName);
    fr := TFlexCelReport.Create(true);
    try
      fr.AddTable('cdsClusterLimits',dmPDF.cdsClusterLimits);
      fr.Run(
         frTemplateStr,frFileNameStr
        //TPath.Combine(TPath.GetDocumentsPath, 'report.template.xlsx'),
        //              TPath.Combine(TPath.GetDocumentsPath, 'result.xlsx')
      );
    finally
      fr.Free;
    end;
  end;
end;

procedure TfmPDFMain.ExportProvenanceLimits1Click(Sender: TObject);
var
  i, iStep, iPreviousStep : integer;
  iCluster : integer;
  StepIncrement : integer;
  tMinAge, tMaxAge : double;
  tUnitAge, tPreviousUnitAge : double;
begin
  // calculate minimum and maximum ages for each sample's major peak
  // clusters and output to spreadsheet for matching to provenence
  // localities from downloads of information in DateView
  CalculateClusterLimits;
  ExportProvenanceAgeLimits;
end;

procedure TfmPDFMain.ExportAssociationSampleAges1Click(Sender: TObject);
begin
  // export links between associations, samples and depositin ages
  ExportAssociationSampleAges;
end;

procedure TfmPDFMain.ExportCumulativeClassification;
var
  fr: TFlexCelReport;
  frTemplateStr, frFileNameStr : string;
begin
  frTemplateStr := FlexTemplatePath+'pdf_cumclassification.xlsx';
  SaveDialogSprdSheet.InitialDir := ExportPath;
  SaveDialogSprdSheet.FileName := 'FitPDF_results_cumulative_classification';
  frFileNameStr := SaveDialogSprdSheet.FileName;
  if SaveDialogSprdSheet.Execute then
  begin
    frFileNameStr := SaveDialogSprdSheet.FileName;
    ExportPath := ExtractFilePath(SaveDialogSprdSheet.FileName);
    fr := TFlexCelReport.Create(true);
    try
      fr.AddTable('cdsAgeList',dmPDF.cdsAgeList);
      fr.Run(
         frTemplateStr,frFileNameStr
        //TPath.Combine(TPath.GetDocumentsPath, 'report.template.xlsx'),
        //              TPath.Combine(TPath.GetDocumentsPath, 'result.xlsx')
      );
    finally
      fr.Free;
    end;
  end;
end;

procedure TfmPDFMain.ExportAssociationSampleAges;
var
  fr: TFlexCelReport;
  frTemplateStr, frFileNameStr : string;
begin
  frTemplateStr := FlexTemplatePath+'pdf_AssocSampleDeposAges.xlsx';
  SaveDialogSprdSheet.InitialDir := ExportPath;
  SaveDialogSprdSheet.FileName := 'FitPDF_results_association_sample_depositionages';
  frFileNameStr := SaveDialogSprdSheet.FileName;
  //ShowMessage(frTemplateStr);
  //ShowMessage(frFileNameStr);
  if SaveDialogSprdSheet.Execute then
  begin
    frFileNameStr := SaveDialogSprdSheet.FileName;
    ExportPath := ExtractFilePath(SaveDialogSprdSheet.FileName);
    fr := TFlexCelReport.Create(true);
    try
      fr.AddTable('cdsAssocSampleAge',dmPDF.cdsAssocSampleAge);
      fr.Run(
         frTemplateStr,frFileNameStr
        //TPath.Combine(TPath.GetDocumentsPath, 'report.template.xlsx'),
        //              TPath.Combine(TPath.GetDocumentsPath, 'result.xlsx')
      );
    finally
      fr.Free;
    end;
  end;
end;

procedure TfmPDFMain.About1Click(Sender: TObject);
begin
  AboutForm := TAboutBox.Create(self);
  try
    AboutForm.ShowModal;
  finally
    AboutForm.Free;
  end;
end;

procedure TfmPDFMain.GetIniFile;
var
  AppIni   : TIniFile;
  tmpStr   : string;
  iCode    : integer;
  SigmaFactorStr : string;
  ExtraVarCutoffStr : string;
  ExtraVarCutoffMinStr, ExtraVarCutoffMaxStr : string;
  HomePath : string;
  UserSpecifiedStepsStr : string;
  StepsSelectionStr : string;
  tSteps : integer;
  ChosenCutoffStr : string;
  GrainAgeCutoff1Str, GrainAgeCutoff2Str,
  GrainAgeCutoff3Str,GrainAgeCutoff4Str,
  GrainAgeCutoff5Str : string;
  ExtraCutoff1Str, ExtraCutoff2Str,
  ExtraCutoff3Str, ExtraCutoff4Str : string;
  //CurrentStyle : string;
begin
  // stored settings in per user folder
  {$IFDEF MACOS}
    HomePath := TPath.GetLibraryPath;
  {$ELSE}
    HomePath := TPath.GetHomePath;
  {$ENDIF}
  //CommonFilePath := IncludeTrailingPathDelimiter(HomePath) + 'EggSoft\';
  CommonFilePath := TPath.Combine(HomePath,'EggSoft');
  IniFilename := TPath.Combine(CommonFilePath,'FitPDF.ini');
  //ShowMessage(IniFilename);
  IniFilePath := CommonFilePath;
  ProgramFilePath := TPath.Combine(IniFilePath,'FitPDF');
  AppIni := TIniFile.Create(IniFilename);
  try
    DataPath := AppIni.ReadString('Paths','Data path',CommonFilePath);
    ExportPath := AppIni.ReadString('Paths','Spreadsheet exports path',CommonFilePath);
    FlexTemplatePath := AppIni.ReadString('Paths','Spreadsheet template path',TPath.Combine(CommonFilePath,'FitPDF','Templates'));
    {$IFDEF MACOS}
      GlobalChosenStyle = '';
    {$ELSE}
      //MyCurrentStyle := AppIni.ReadString('MyStyle','MyCurrentStyle','Windows10');
      GlobalChosenStyle := AppIni.ReadString('Styles','Chosen style','Windows');
      if (GlobalChosenStyle = '') then GlobalChosenStyle := 'Windows';
    {$ENDIF}
    dmPDF.ChosenStyle := GlobalChosenStyle;
    DataColStr := UpperCase(AppIni.ReadString('ColumnDefinitions','DataColStr','A'));
    SigmaColStr := UpperCase(AppIni.ReadString('ColumnDefinitions','SigmaColStr','B'));
    UnitAgeColStr := UpperCase(AppIni.ReadString('ColumnDefinitions','UnitAgeColStr','C'));
    ExtraVarColStr := UpperCase(AppIni.ReadString('ColumnDefinitions','ExtraVarColStr','D'));
    SampleNoColStr := UpperCase(AppIni.ReadString('ColumnDefinitions','SampleNoColStr','E'));
    FracColStr := UpperCase(AppIni.ReadString('ColumnDefinitions','FracColStr','F'));
    AssocColStr := UpperCase(AppIni.ReadString('ColumnDefinitions','AssocColStr','G'));
    dmPDF.ExtraVarName := AppIni.ReadString('ColumnDefinitions','ExtraVarName','Th/U');
    SigmaFactorStr := AppIni.ReadString('Uncertainties','SigmaFactor',FormatFloat('##0.000',1.0/1.96));
    Val(SigmaFactorStr,dmPDF.SigmaFactor,iCode);
    if (iCode <> 0) then
    begin
      dmPDF.SigmaFactor := 1.0/1.96;
    end;
    //ExtraVarCutoffStr := AppIni.ReadString('Uncertainties','ExtraVarCutoff',FormatFloat('##0.000',0.1));
    //Val(ExtraVarCutoffStr,dmPDF.ExtraVarCutoff,iCode);
    //if (iCode <> 0) then
    //begin
    //  dmPDF.ExtraVarCutoff := 0.1;
    //end;
    ExtraVarCutoffMinStr := AppIni.ReadString('Uncertainties','ExtraVarCutoffMin',FormatFloat('##0.000',0.1));
    Val(ExtraVarCutoffMinStr,dmPDF.ExtraVarCutoffMin,iCode);
    if (iCode <> 0) then
    begin
      dmPDF.ExtraVarCutoffMin := 0.1;
    end;
    ExtraVarCutoffMaxStr := AppIni.ReadString('Uncertainties','ExtraVarCutoffMax',FormatFloat('##0.000',1.1));
    Val(ExtraVarCutoffMaxStr,dmPDF.ExtraVarCutoffMax,iCode);
    if (iCode <> 0) then
    begin
      dmPDF.ExtraVarCutoffMax := 1.1;
    end;
    UserSpecifiedStepsStr := AppIni.ReadString('PDF','Steps',IntToStr(MaxSteps));
    tSteps := StrToInt(UserSpecifiedStepsStr);
    if (tSteps > MaxSteps) then tSteps := MaxSteps;
    UserSpecifiedSteps := tSteps;
    Steps := UserSpecifiedSteps;
    StepsMaximum.Caption := 'Maximum = '+IntToStr(MaxSteps);
    StepsUserSpecified.Caption := 'User specified = '+IntToStr(UserSpecifiedSteps);
    StepsSelectionStr := AppIni.ReadString('PDF','Steps selection','User');
    if (StepsSelectionStr = 'User') then
    begin
      StepsUserSpecified.Checked := true;
      StepsMaximum.Checked := false;
      Steps := UserSpecifiedSteps;
    end else
    begin
      StepsUserSpecified.Checked := false;
      StepsMaximum.Checked := true;
      Steps := MaxSteps;
    end;
    dmPDF.ChosenCutoff := 80.0;
    ChosenCutoffStr := AppIni.ReadString('PDF','ChosenCutoff','80.0');
    Val(ChosenCutoffStr,dmPDF.ChosenCutoff,iCode);
    if (iCode <> 0) then
    begin
      dmPDF.ChosenCutoff := 80.0;
    end;
    //DefaultMinimumSigmaStr := AppIni.ReadString('Uncertainties','Default Minimum Sigma',FormatFloat('##0.000',5.0));
    //Val(DefaultMinimumSigmaStr,DefaultMinimum,iCode);
    //if (iCode <> 0) then
    //begin
    //  DefaultMinimum := 5.0;
    //end;
    GrainAgeCutoff1Str := UpperCase(AppIni.ReadString('Cutoffs','GrainAgeCutoff1Str','0.1'));
    Val(GrainAgeCutoff1Str,Cutoff1,iCode);
    if (iCode <> 0) then
    begin
      Cutoff1 := 0.1;
    end;
    GrainAgeCutoff2Str := UpperCase(AppIni.ReadString('Cutoffs','GrainAgeCutoff2Str','10.0'));
    Val(GrainAgeCutoff2Str,Cutoff2,iCode);
    if (iCode <> 0) then
    begin
      Cutoff1 := 10.0;
    end;
    GrainAgeCutoff3Str := UpperCase(AppIni.ReadString('Cutoffs','GrainAgeCutoff3Str','40.0'));
    Val(GrainAgeCutoff3Str,Cutoff3,iCode);
    if (iCode <> 0) then
    begin
      Cutoff1 := 40.0;
    end;
    GrainAgeCutoff4Str := UpperCase(AppIni.ReadString('Cutoffs','GrainAgeCutoff4Str','60.0'));
    Val(GrainAgeCutoff4Str,Cutoff4,iCode);
    if (iCode <> 0) then
    begin
      Cutoff1 := 60.0;
    end;
    GrainAgeCutoff5Str := UpperCase(AppIni.ReadString('Cutoffs','GrainAgeCutoff5Str','80.0'));
    Val(GrainAgeCutoff5Str,Cutoff5,iCode);
    if (iCode <> 0) then
    begin
      Cutoff1 := 80.0;
    end;
    ExtraCutoff1Str := UpperCase(AppIni.ReadString('Cutoffs','ExtraCutoff1Str','200.0'));
    Val(ExtraCutoff1Str,Cutoff3D1,iCode);
    if (iCode <> 0) then
    begin
      Cutoff3D1 := 200.0;
    end;
    ExtraCutoff2Str := UpperCase(AppIni.ReadString('Cutoffs','ExtraCutoff2Str','500.0'));
    Val(ExtraCutoff2Str,Cutoff3D2,iCode);
    if (iCode <> 0) then
    begin
      Cutoff3D2 := 500.0;
    end;
    ExtraCutoff3Str := UpperCase(AppIni.ReadString('Cutoffs','ExtraCutoff3Str','1000.0'));
    Val(ExtraCutoff3Str,Cutoff3D3,iCode);
    if (iCode <> 0) then
    begin
      Cutoff3D3 := 1000.0;
    end;
    ExtraCutoff4Str := UpperCase(AppIni.ReadString('Cutoffs','ExtraCutoff4Str','2000.0'));
    Val(ExtraCutoff4Str,Cutoff3D4,iCode);
    if (iCode <> 0) then
    begin
      Cutoff3D4 := 2000.0;
    end;
  finally
    AppIni.Free;
  end;
end;

procedure TfmPDFMain.SetIniFile;
var
  AppIni   : TIniFile;
  SigmaFactorStr : string;
  ExtraVarCutoffStr : string;
  ExtraVarCutoffMinStr, ExtraVarCutoffMaxStr : string;
  UserSpecifiedStepsStr : string;
  StepsSelectionStr : string;
  HomePath : string;
  DateAsString : string;
  TimeAsString : string;
begin
  {$IFDEF MACOS}
    HomePath := TPath.GetLibraryPath;
  {$ELSE}
    HomePath := TPath.GetHomePath;
  {$ENDIF}
  CommonFilePath := TPath.Combine(HomePath,'EggSoft');
  IniFilename := TPath.Combine(CommonFilePath,'FitPDF.ini');
  UserSpecifiedStepsStr := IntToStr(UserSpecifiedSteps);
  SigmaFactorStr := FormatFloat('##0.000',dmPDF.SigmaFactor);
  //ExtraVarCutoffStr := FormatFloat('##0.000',dmPDF.ExtraVarCutoff);
  ExtraVarCutoffMinStr := FormatFloat('##0.000',dmPDF.ExtraVarCutoffMin);
  ExtraVarCutoffMaxStr := FormatFloat('##0.000',dmPDF.ExtraVarCutoffMax);
  //DefaultMinimumSigmaStr := FormatFloat('##0.000',DefaultMinimum);
  DateAsString := DateToStr(Now);
  TimeAsString := TimeToStr(Now);
  AppIni := TIniFile.Create(IniFileName);
  try
    AppIni.WriteString('Paths','Data path',DataPath);
    AppIni.WriteString('Paths','Spreadsheet exports path',ExportPath);
    //AppIni.WriteString('Paths','Spreadsheet template path',FlexTemplatePath);
    //AppIni.WriteString('Paths','INI file path',IniFilePath);
    //AppIni.WriteString('MyStyle','MyCurrentStyle',MyCurrentStyle);
    AppIni.WriteString('Styles','Chosen style',GlobalChosenStyle);
    AppIni.WriteString('MyStyle','MyCurrentDate',DateAsString);
    AppIni.WriteString('MyStyle','MyCurrentTime',TimeAsString);
    AppIni.WriteString('ColumnDefinitions','DataColStr',DataColStr);
    AppIni.WriteString('ColumnDefinitions','SigmaColStr',SigmaColStr);
    AppIni.WriteString('ColumnDefinitions','UnitAgeColStr',UnitAgeColStr);
    AppIni.WriteString('ColumnDefinitions','ExtraVarColStr',ExtraVarColStr);
    AppIni.WriteString('ColumnDefinitions','SampleNoColStr',SampleNoColStr);
    AppIni.WriteString('ColumnDefinitions','FracColStr',FracColStr);
    AppIni.WriteString('ColumnDefinitions','AssocColStr',AssocColStr);
    AppIni.WriteString('ColumnDefinitions','ExtraVarName',dmPDF.ExtraVarName);
    AppIni.WriteString('Uncertainties','SigmaFactor',SigmaFactorStr);
    //AppIni.WriteString('Uncertainties','ExtraVarCutoff',ExtraVarCutoffStr);
    AppIni.WriteString('Uncertainties','ExtraVarCutoffMin',ExtraVarCutoffMinStr);
    AppIni.WriteString('Uncertainties','ExtraVarCutoffMax',ExtraVarCutoffMaxStr);
    //AppIni.WriteString('Uncertainties','Default Minimum Sigma',DefaultMinimumSigmaStr);
    AppIni.WriteString('PDF','Steps',UserSpecifiedStepsStr);
    if (StepsUserSpecified.Checked) then
    begin
      AppIni.WriteString('PDF','Steps selection','User');
    end else
    begin
      AppIni.WriteString('PDF','Steps selection','Maximum');
    end;
    AppIni.WriteString('PDF','ChosenCutoff',FormatFloat('##0.000',dmPDF.ChosenCutoff));
    AppIni.WriteString('Cutoffs','GrainAgeCutoff1Str',FormatFloat('###0.000',Cutoff1));
    AppIni.WriteString('Cutoffs','GrainAgeCutoff2Str',FormatFloat('###0.000',Cutoff2));
    AppIni.WriteString('Cutoffs','GrainAgeCutoff3Str',FormatFloat('###0.000',Cutoff3));
    AppIni.WriteString('Cutoffs','GrainAgeCutoff4Str',FormatFloat('###0.000',Cutoff4));
    AppIni.WriteString('Cutoffs','GrainAgeCutoff5Str',FormatFloat('###0.000',Cutoff5));
    AppIni.WriteString('Cutoffs','ExtraCutoff1Str',FormatFloat('###0.000',Cutoff3D1));
    AppIni.WriteString('Cutoffs','ExtraCutoff2Str',FormatFloat('###0.000',Cutoff3D2));
    AppIni.WriteString('Cutoffs','ExtraCutoff3Str',FormatFloat('###0.000',Cutoff3D3));
    AppIni.WriteString('Cutoffs','ExtraCutoff4Str',FormatFloat('###0.000',Cutoff3D4));
  finally
    AppIni.Free;
  end;
end;

procedure TfmPDFMain.Showonlyfirst50rowsofimportspreadsheet1Click(
  Sender: TObject);
begin
  ShowOnlyFirst50RowsOfImportSpreadsheet1.Checked := not ShowOnlyFirst50RowsOfImportSpreadsheet1.Checked;
  ShowOnly50Rows := ShowOnlyFirst50RowsOfImportSpreadsheet1.Checked;
end;

procedure TfmPDFMain.StepsMaximumClick(Sender: TObject);
begin
  Steps := MaxSteps;
  StepsMaximum.Checked := true;
  StepsUserSpecified.Checked := false;
end;

procedure TfmPDFMain.StepsUserSpecifiedClick(Sender: TObject);
begin
  Steps := UserSpecifiedSteps;
  StepsMaximum.Checked := false;
  StepsUserSpecified.Checked := true;
end;

procedure TfmPDFMain.StyleClick(Sender: TObject);
var
  StyleName : String;
  i : integer;
begin
  //get style name
  StyleName := TMenuItem(Sender).Caption;
  StyleName := StringReplace(StyleName, '&', '',
    [rfReplaceAll,rfIgnoreCase]);
  GlobalChosenStyle := StyleName;
  dmPDF.ChosenStyle := GlobalChosenStyle;
  //set active style
  Application.HandleMessage;
  TStyleManager.SetStyle(GlobalChosenStyle);
  dmPDF.ChosenStyle := GlobalChosenStyle;
  Application.HandleMessage;
  //check the currently selected menu item
  (Sender as TMenuItem).Checked := true;
  //uncheck all other style menu items
  for i := 0 to Styles1.Count-1 do
  begin
    if not Styles1.Items[i].Equals(Sender) then
      Styles1.Items[i].Checked := false;
  end;
  for i := 0 to Styles1.Count-1 do
  begin
    if Styles1.Items[i].Checked then GlobalChosenStyle := StringReplace(Styles1.Items[i].Caption, '&', '',
    [rfReplaceAll,rfIgnoreCase]);
  end;
  TStyleManager.SetStyle(GlobalChosenStyle);
  try
    dmPDF.ChosenStyle := GlobalChosenStyle;
  finally
    dmPDF.ChosenStyle := GlobalChosenStyle;
  end;
  ApplySelectedThemeToCharts(StyleName);
end;

procedure TfmPDFMain.Test1Click(Sender: TObject);
var
  CurrentStyle : string;
begin
  CurrentStyle := GlobalChosenStyle;
  //ShowMessage(CurrentStyle);
  //ShowMessage(dmGDWtmp.ChosenStyle);
end;

procedure TfmPDFMain.tsControlShow(Sender: TObject);
begin
  eFromAge.Text := FormatFloat('###0.00',FromAge);
  eToAge.Text := FormatFloat('###0.00',ToAge);
  eFromAgeLeft.Text := FormatFloat('###0.00',FromAgeLeft);
  eToAgeLeft.Text := FormatFloat('###0.00',ToAgeLeft);
  eMinimumSigma.Text := FormatFloat('###0.00',MinimumUncertainty);
  //eExtraVarCutoff.Text := FormatFloat('###0.00',dmPDF.ExtraVarCutoff);
  eExtraVarCutoffMin.Text := FormatFloat('###0.000',dmPDF.ExtraVarCutoffMin);
  eExtraVarCutoffMax.Text := FormatFloat('###0.000',dmPDF.ExtraVarCutoffMax);
  eExtraVarName.Text := dmPDF.ExtraVarName;
  ShowOnly50Rows := ShowOnlyFirst50RowsOfImportSpreadsheet1.Checked;
  eNumBins.Text := IntToStr(NumBins);
  if (PDFType = 'OR') then rgPDFType.ItemIndex := 1
                      else rgPDFType.ItemIndex := 0;
  if (NormalisationType = nt100Percent) then rgNormalisationType.ItemIndex := 0
                                        else rgNormalisationType.ItemIndex := 1;
  e1.Text := FormatFloat('##0.0',Cutoff1);
  e2.Text := FormatFloat('##0.0',Cutoff2);
  e3.Text := FormatFloat('##0.0',Cutoff3);
  e4.Text := FormatFloat('##0.0',Cutoff4);
  e5.Text := FormatFloat('##0.0',Cutoff5);
end;

procedure TfmPDFMain.tsGraphShow(Sender: TObject);
begin
  dmPDF.cdsRawData.EnableControls;
  dmPDF.cdsRawData.Filtered := false;
  dmPDF.cdsRawData.Last;
  dmPDF.cdsRawData.First;
end;

procedure TfmPDFMain.tsVerticalViewShow(Sender: TObject);
begin
  dmPDF.cdsRawData.EnableControls;
  dmPDF.cdsRawData.Filtered := false;
  dmPDF.cdsRawData.Last;
  dmPDF.cdsRawData.First;
end;

procedure TfmPDFMain.ExportSingleSampleProbability;
var
  fr: TFlexCelReport;
  frTemplateStr, frFileNameStr : string;
begin
  frTemplateStr := FlexTemplatePath+'pdf_fitpdf.xlsx';
  SaveDialogSprdSheet.InitialDir := ExportPath;
  SaveDialogSprdSheet.FileName := 'FitPDF_results_singlesample';
  frFileNameStr := SaveDialogSprdSheet.FileName;
  if SaveDialogSprdSheet.Execute then
  begin
    frFileNameStr := SaveDialogSprdSheet.FileName;
    ExportPath := ExtractFilePath(SaveDialogSprdSheet.FileName);
    fr := TFlexCelReport.Create(true);
    try
      fr.AddTable('cdsPDF',dmPDF.cdsPDF);
      fr.AddTable('cdsHistogram',dmPDF.cdsHistogram);
      fr.AddTable('MainHistogram',dmPDF.cdsHistogram);
      fr.Run(
         frTemplateStr,frFileNameStr
        //TPath.Combine(TPath.GetDocumentsPath, 'report.template.xlsx'),
        //              TPath.Combine(TPath.GetDocumentsPath, 'result.xlsx')
      );
    finally
      fr.Free;
    end;
  end;
end;

procedure TfmPDFMain.FormShow(Sender: TObject);
var
  ii, j : integer;
begin
  //CurrentStyle := 'Windows10';
  //TStyleManager.TrySetStyle(CurrentStyle);
  tsGraph.TabVisible := false;
  tsVerticalView.TabVisible := false;
  tsCumulativeProbability.TabVisible := false;
  tsSurface.TabVisible := false;
  tsHeat.TabVisible := false;
  pc1.ActivePage := tsControl;
  ExportGraphValues1.Visible := false;
  ExportProvenanceLimits1.Visible := false;
  ExportAssociationSampleAges1.Visible := false;
  //GetIniFile;
  FromRowValueString := '2';
  ToRowValueString := '2';
  FromAge := 0.0;
  ToAge := 4500.0;
  FromAgeLeft := 0.0;
  ToAgeLeft := 4500.0;
  MinimumUncertainty := 5.0;
  NumBins := 100;
  pGrainAgeCutoffs.Visible := false;
  pExtraVariableDefinitions.Visible := false;
  pExtraVariable3DDefinitions.Visible := false;
  eFromAge.Text := FormatFloat('###0.00',FromAge);
  eToAge.Text := FormatFloat('###0.00',ToAge);
  eFromAgeLeft.Text := FormatFloat('###0.00',FromAgeLeft);
  eToAgeLeft.Text := FormatFloat('###0.00',ToAgeLeft);
  eMinimumSigma.Text := FormatFloat('###0.00',MinimumUncertainty);
  //eExtraVarCutoff.Text := FormatFloat('###0.00',dmPDF.ExtraVarCutoff);
  eExtraVarCutoffMin.Text := FormatFloat('###0.000',dmPDF.ExtraVarCutoffMin);
  eExtraVarCutoffMax.Text := FormatFloat('###0.000',dmPDF.ExtraVarCutoffMax);
  eExtraVarName.Text := dmPDF.ExtraVarName;
  eNumBins.Text := IntToStr(NumBins);
  ShowOnly50Rows := ShowOnlyFirst50RowsOfImportSpreadsheet1.Checked;
  Formatted := true;
  //Cutoff1 := 0.1;
  //Cutoff2 := 10.0;
  //Cutoff3 := 40.0;
  //Cutoff4 := 60.0;
  //Cutoff5 := 80.0;
  e1.Text := FormatFloat('##0.0',Cutoff1);
  e2.Text := FormatFloat('##0.0',Cutoff2);
  e3.Text := FormatFloat('##0.0',Cutoff3);
  e4.Text := FormatFloat('##0.0',Cutoff4);
  e5.Text := FormatFloat('##0.0',Cutoff5);
  e3D1.Text := FormatFloat('###0.00',Cutoff3D1);
  e3D2.Text := FormatFloat('###0.00',Cutoff3D2);
  e3D3.Text := FormatFloat('###0.00',Cutoff3D3);
  e3D4.Text := FormatFloat('###0.00',Cutoff3D4);
  dmPDF.cdsRawData.LogChanges := false;
  dmPDF.cdsPDF.LogChanges := false;
  dmPDF.cdsCum.LogChanges := false;
  dmPDF.cdsHistogram.LogChanges := false;
  dmPDF.cdsGrainData.LogChanges := false;
  dmPDF.cdsAgeList.LogChanges := false;
  dmPDF.cdsAssocSampleAge.LogChanges := false;
  dmPDF.cdsAssociations.LogChanges := false;
  dmPDF.cdsSamples.LogChanges := false;
end;

procedure TfmPDFMain.FormClose(Sender: TObject; var MyAction: TCloseAction);
begin
  SetIniFile;
end;

procedure TfmPDFMain.FormCreate(Sender: TObject);
var
  Style: String;
  Item: TMenuItem;
begin
  GlobalChosenStyle := 'Windows';
  //UncheckAllThemes;
  //Windows101.Checked := true;
  //MyCurrentStyle := 'Windows10';
  //TStyleManager.TrySetStyle(MyCurrentStyle);
  GetIniFile;
  TStyleManager.TrySetStyle(GlobalChosenStyle);
  //Add child menu items based on available styles.
  for Style in TStyleManager.StyleNames do
  begin
    Item := TMenuItem.Create(Styles1);
    Item.Caption := Style;
    Item.OnClick := StyleClick;
    if TStyleManager.ActiveStyle.Name = Style then
      Item.Checked := true;
    Styles1.Add(Item);
  end;
end;

procedure TfmPDFMain.bbCalculateClick(Sender: TObject);
var
  iCode : integer;
  iRec : integer;
  tmpStr : string;
  i : integer;
  tClassNum : integer;
  tAge, x2, y2, z2 : double;
  tAssoc, tSampleNo : string;
  MaxHistogramCount : integer;
  tmp : double;
  Trip05pc, Trip30pc : boolean;
  tmpUnitAgeStr, tmpAgeMinStr, tmpAgeMaxStr : string;
  Node : TTreeNode;
begin
  // single, all-inclusive PDF and histogram
  if (rgGraphType.ItemIndex = 0) then
  begin
    NormalisationType := nt100Percent;
    rgNormalisationType.ItemIndex := 0;
  end;
  // multiple pdf, vertical view
  if (rgGraphType.ItemIndex = 1) then
  begin
    NormalisationType := nt100Percent;
    rgNormalisationType.ItemIndex := 0;
  end;
  // cumulative probability
  if (rgGraphType.ItemIndex = 2) then
  begin
    //NormalisationType := ntTrueProbability;
    //rgNormalisationType.ItemIndex := 1;
    NormalisationType := nt100Percent;
    rgNormalisationType.ItemIndex := 0;
  end;
  // 3D extra variable view
  if (rgGraphType.ItemIndex = 3) then
  begin
    NormalisationType := nt100Percent;
    rgNormalisationType.ItemIndex := 0;
  end;
  // heat map
  if (rgGraphType.ItemIndex = 4) then
  begin
    //NormalisationType := ntTrueProbability;
    //rgNormalisationType.ItemIndex := 1;
    NormalisationType := nt100Percent;
    rgNormalisationType.ItemIndex := 0;
  end;
  iRec := dmPDF.cdsRawData.RecordCount;
  if (iRec > 0) then
  begin
    //dmPDF.ExtraVarGTLT := '<=';
    if ((cbPlotExtraVariable.Checked) and (rgGraphType.ItemIndex = 1)) then
    begin
      dmPDF.ExtraVarName := eExtraVarName.Text;
      //if (cbExtraGTLT.ItemIndex=0) then dmPDF.ExtraVarGTLT := '<=';
      //if (cbExtraGTLT.ItemIndex=1) then dmPDF.ExtraVarGTLT := '>=';
      //Val(eExtraVarCutoff.Text,dmPDF.ExtraVarCutoff,iCode);
      //ShowMessage(dmPDF.ExtraVarGTLT+'  '+FormatFloat('###0.000',dmPDF.ExtraVarCutoff));
      //if (iCode <> 0) then
      //begin
      //  dmPDF.ExtraVarCutoff := 0.1;
      //  MessageDlg('Extra variable cutoff value is not a number',mtWarning,[mbOK],0);
      //end;
      Val(eExtraVarCutoffMin.Text,dmPDF.ExtraVarCutoffMin,iCode);
      if (iCode <> 0) then
      begin
        dmPDF.ExtraVarCutoffMin := 0.1;
        MessageDlg('Extra variable minimum cutoff value is not a number',mtWarning,[mbOK],0);
      end;
      Val(eExtraVarCutoffMax.Text,dmPDF.ExtraVarCutoffMax,iCode);
      if (iCode <> 0) then
      begin
        dmPDF.ExtraVarCutoffMax := 0.1;
        MessageDlg('Extra variable maximum cutoff value is not a number',mtWarning,[mbOK],0);
      end;
    end;
    sbMain.Panels[1].Text := 'Calculating';
    sbMain.Refresh;
    pc1.ActivePage := tsControl;
    tsGraph.TabVisible := false;
    tsVerticalView.TabVisible := false;
    tsCumulativeProbability.TabVisible := false;
    tsHeat.TabVisible := false;
    tsSurface.TabVisible := false;
    dbgRawData.DataSource := nil;
    dbnRawData.DataSource := nil;
    dbgHistogram.DataSource := nil;
    dbnHistogram.DataSource := nil;
    dbgPDF.DataSource := nil;
    dbnPDF.DataSource := nil;
    dbgCumulative.DataSource := nil;
    dbnCumulative.DataSource := nil;
    DBChart1.Series[1].DataSource := nil;
    sbMain.Refresh;
    dmPDF.cdsRawData.First;
    Val(eFromAge.Text,FromAge,iCode);
    if (iCode <> 0) then MessageDlg('From Age value for Bottom axis is not correct',mtWarning,[mbOK],0);
    if (iCode = 0) then
    begin
      Val(eToAge.Text,ToAge,iCode);
      if (iCode <> 0) then MessageDlg('To Age value for Bottom axis is not correct',mtWarning,[mbOK],0);
    end;
    Val(eFromAgeLeft.Text,FromAgeLeft,iCode);
    if (iCode <> 0) then MessageDlg('From Age value for Left axis is not correct',mtWarning,[mbOK],0);
    if (iCode = 0) then
    begin
      Val(eToAgeLeft.Text,ToAgeLeft,iCode);
      if (iCode <> 0) then MessageDlg('To Age value for Left axis is not correct',mtWarning,[mbOK],0);
    end;
    Val(eFrom3D.Text,From3D,iCode);
    if (iCode <> 0) then MessageDlg('From Age value for 3D depth axis is not correct',mtWarning,[mbOK],0);
    if (iCode = 0) then
    begin
      Val(eTo3D.Text,To3D,iCode);
      if (iCode <> 0) then MessageDlg('To Age value for 3D depth axis is not correct',mtWarning,[mbOK],0);
    end;
    //ShowMessage(FormatFloat('###0.00',FromAgeLeft)+'   '+FormatFloat('###0.00',ToAgeLeft));
    if (iCode = 0) then
    begin
      Val(eMinimumSigma.Text,MinimumUncertainty,iCode);
      if (iCode <> 0) then MessageDlg('Minimum Uncertainty value is not correct',mtWarning,[mbOK],0);
    end;
    if (iCode = 0) then
    begin
      Val(eNumBins.Text,NumBins,iCode);
      if (iCode <> 0) then MessageDlg('Number of bins value is not correct',mtWarning,[mbOK],0);
    end;
    if (NumBins > MaxBins) then
    begin
      NumBins := MaxBins;
      eNumBins.Text := IntToStr(NumBins);
      MessageDlg('Number of bins exceeds maximum permitted! Number reduced.',mtWarning,[mbOK],0);
    end;
    PDFType := 'any';
    if (rgPDFType.ItemIndex=0) then PDFType := 'AND';
    if (rgPDFType.ItemIndex=1) then PDFType := 'OR';
    //if (rgPDFType.ItemIndex=2) then ShowMessage('rgPDFType 2 '+PDFType);
    //if (rgGraphType.ItemIndex=2) then ShowMessage('rgGraphType 0 '+PDFType);
    if ((rgPDFType.ItemIndex=2) and (rgGraphType.ItemIndex = 0)) then PDFType := 'ANDEXTRA'
                                                                 else PDFType := 'AND';
    if (rgPDFType.ItemIndex=0) then PDFType := 'AND';
    if (rgPDFType.ItemIndex=1) then PDFType := 'OR';
    if (rgNormalisationType.ItemIndex=0) then NormalisationType := nt100Percent
                                         else NormalisationType := ntTrueProbability;
    if (PDFType = 'ANDEXTRA') then NormalisationType := nt100Percent;
    if (iCode = 0) then
    begin
      //-------------------------------------------------------------------
      //Combined probability graph for all samples
      //-------------------------------------------------------------------
      if (rgGraphType.ItemIndex = 0) then
      begin
        DBChart1.Series[0].Clear;
        DBChart1.Series[1].Clear;
        dmPDF.cdsGrainData.EmptyDataSet;
        MaxHistogramCount := 0;
        dmPDF.cdsAgeList.First;
        tAge := 0.0;
        CalculatePDF(GraphTypeS,NormalisationType,tAge);
        DBChart1.Series[1].DataSource := dmPDF.cdsPDF;
        sbMain.Panels[1].Text := 'Complete';
        sbMain.Refresh;
        dmPDF.cdsPDF.EnableControls;
        tsGraph.TabVisible := true;
        sbMain.Panels[0].Text := Int2Str(NPts) + ' data';
        sbMain.Panels[1].Text := ' ';
        sbMain.Refresh;
        Series1.Visible := true;
        Series4.Visible := true;
        Series1.CheckDataSource;
        Series4.CheckDataSource;
        dmPDF.cdsHistogram.First;
        repeat
          if (dmPDF.cdsHistogramNumCount.AsInteger > MaxHistogramCount) then MaxHistogramCount := dmPDF.cdsHistogramNumCount.AsInteger;
          dmPDF.cdsHistogram.Next;
        until dmPDF.cdsHistogram.Eof;
        dmPDF.cdsHistogram.First;
        if (MaxHistogramCount <=1) then DBChart1.LeftAxis.Increment := 1;
        if ((MaxHistogramCount > 10) and (MaxHistogramCount <= 20)) then DBChart1.LeftAxis.Increment := 2;
        if ((MaxHistogramCount > 20) and (MaxHistogramCount <= 50)) then DBChart1.LeftAxis.Increment := 5;
        if ((MaxHistogramCount > 20) and (MaxHistogramCount <= 50)) then DBChart1.LeftAxis.Increment := 5;
        if ((MaxHistogramCount > 50) and (MaxHistogramCount <= 100)) then DBChart1.LeftAxis.Increment := 10;
        if ((MaxHistogramCount > 100) and (MaxHistogramCount <= 1000)) then DBChart1.LeftAxis.Increment := 100;
        if ((MaxHistogramCount > 1000) and (MaxHistogramCount <= 10000)) then DBChart1.LeftAxis.Increment := 1000;
        if ((MaxHistogramCount > 10000) and (MaxHistogramCount <= 100000)) then DBChart1.LeftAxis.Increment := 10000;
        DBChart1.BottomAxis.SetMinMax(FromAge,ToAge);
        DBChart1.Title.Caption := eGraphTitle.Text;
        if PDFType='AND' then
        begin
          tmpStr := 'Gaussian AND ';
        end;
        if PDFType='OR' then
        begin
          tmpStr := 'Gaussian OR ';
        end;
        if PDFType='ANDEXTRA' then
        begin
          tmpStr := 'Gaussian AND weighted by Extra variable ';
        end;
        DBChart1.SubFoot.Text[0] := tmpStr;
        DBChart1.SubFoot.Text[1] := 'Minimum age uncertainty = '+FormatFloat('###0.00',MinimumUncertainty)+' Ma';
        if NormalisationType=nt100Percent then
        begin
          tmpStr := 'Maximum peak normalised to 100%';
        end;
        if NormalisationType=ntTrueProbability then
        begin
          tmpStr := 'True probability';
        end;
        DBChart1.SubFoot.Text[2] := tmpStr;
        dmPDF.cdsRawData.EnableControls;
        dbgRawData.DataSource := dmPDF.dsRawData;
        dbnRawData.DataSource := dmPDF.dsRawData;
        dmPDF.cdsHistogram.EnableControls;
        dbgHistogram.DataSource := dmPDF.dsHistogram;
        dbnHistogram.DataSource := dmPDF.dsHistogram;
        dmPDF.cdsHistogram.First;
        dmPDF.cdsPDF.EnableControls;
        dbgPDF.DataSource := dmPDF.dsPDF;
        dbnPDF.DataSource := dmPDF.dsPDF;
        dmPDF.cdsPDF.First;
        dbgGrainData.DataSource := nil;
        dbnGrainData.DataSource := nil;
        dmPDF.cdsGrainData.First;
        tsGraph.TabVisible := true;
        tsHeat.TabVisible := false;
        pc1.ActivePage := tsGraph;
        ExportGraphValues1.Visible := true;
        DBChart1.Foot.Caption := FitPDFVersionStr;
      end;
      //-------------------------------------------------------------------
      //Multiple probability graph viewed from above
      //-------------------------------------------------------------------
      if (rgGraphType.ItemIndex = 1) then
      begin
        ChartPDF.View3D := false;
        ChartPDF.Axes.Depth.Visible := false;
        ChartPDF.Series[0].Visible := true;
        ChartPDF.Series[1].Visible := true;
        ChartPDF.Series[2].Visible := true;
        ChartPDF.Series[3].Visible := true;
        ChartPDF.Series[4].Visible := true;
        ChartPDF.Series[5].Visible := true;
        ChartPDF.Series[6].Visible := true;
        ChartPDF.Series[0].ShowInLegend := true;
        ChartPDF.Series[1].ShowInLegend := true;
        ChartPDF.Series[2].ShowInLegend := true;
        ChartPDF.Series[3].ShowInLegend := true;
        ChartPDF.Series[4].ShowInLegend := true;
        ChartPDF.Series[5].ShowInLegend := true;
        ChartPDF.Series[6].ShowInLegend := true;
        Series14.Visible := false;
        Series15.Visible := false;
        Series16.Visible := false;
        Series17.Visible := false;
        Series18.Visible := false;
        Series19.Visible := false;
        Series14.Legend.Visible := false;
        Series15.Legend.Visible := false;
        Series16.Legend.Visible := false;
        Series17.Legend.Visible := false;
        Series18.Legend.Visible := false;
        Series19.Legend.Visible := false;
        if (dmPDF.cdsAgeList.RecordCount = 0) then
        begin
           MessageDlg('No deposition ages have been specified',mtWarning,[mbOK],0);
           Exit;
        end;
        ChartPDF.Series[0].Clear;
        ChartPDF.Series[1].Clear;
        ChartPDF.Series[2].Clear;
        ChartPDF.Series[3].Clear;
        ChartPDF.Series[4].Clear;
        ChartPDF.Series[5].Clear;
        ChartPDF.Series[6].Clear;
        ChartHeat.Series[0].Clear;
        Val(e1.Text,Cutoff1,iCode);
        Val(e2.Text,Cutoff2,iCode);
        Val(e3.Text,Cutoff3,iCode);
        Val(e4.Text,Cutoff4,iCode);
        Val(e5.Text,Cutoff5,iCode);
        Cutoff6 := 100.0;
        ChartPDF.Series[5].Title := Trim(e1.Text)+' - '+Trim(e2.Text);
        ChartPDF.Series[4].Title := Trim(e2.Text)+' - '+Trim(e3.Text);
        ChartPDF.Series[3].Title := Trim(e3.Text)+' - '+Trim(e4.Text);
        ChartPDF.Series[2].Title := Trim(e4.Text)+' - '+Trim(e5.Text);
        ChartPDF.Series[1].Title := Trim(e5.Text)+' - '+Trim('100.0');
        dmPDF.cdsRawData.Filtered := false;
        dmPDF.cdsGrainData.DisableControls;
        dmPDF.cdsGrainData.EmptyDataSet;
        dmPDF.cdsRawData.First;
        dmPDF.cdsAgeList.First;
        //ShowMessage('1');
        repeat
          tAge := dmPDF.cdsAgeListUnitAge.AsFloat;
          //ShowMessage(FormatFloat('###0.000',tAge));
          CalculatePDF(GraphTypeM,NormalisationType,tAge);
          //ShowMessage(FormatFloat('####0.00',tAge)+' PDF complete');
          dmPDF.cdsPDF.First;
          repeat
            if (dmPDF.cdsPDFPDFValue.AsFloat > 0.0001) then
            begin
              dmPDF.cdsGrainData.Append;
              dmPDF.cdsGrainDataUnitAge.AsFloat := dmPDF.cdsPDFUnitAge.AsFloat;
              dmPDF.cdsGrainDataStepID.AsInteger := dmPDF.cdsPDFStep.AsInteger;
              dmPDF.cdsGrainDataGrainAge.AsFloat := dmPDF.cdsPDFPDFDataValue.AsFloat;
              dmPDF.cdsGrainDataPDFvalue.AsFloat := dmPDF.cdsPDFPDFValue.AsFloat;
              dmPDF.cdsGrainData.Post;
            end;
            dmPDF.cdsPDF.Next;
          until (dmPDF.cdsPDF.Eof);
          //ShowMessage(FormatFloat('####0.00',tAge)+' GrainData added');
          dmPDF.cdsAgeList.Next;
        until (dmPDF.cdsAgeList.Eof);
        dmPDF.cdsGrainData.First;
        //ShowMessage('2');
        repeat
          x2 := dmPDF.cdsGrainDataGrainAge.AsFloat;
          y2 := dmPDF.cdsGrainDataPDFvalue.AsFloat;
          tAge := dmPDF.cdsGrainDataUnitAge.AsFloat;
          z2 := dmPDF.cdsGrainDataUnitAge.AsFloat;
          if ((y2 < Cutoff2) and (y2 >= Cutoff1)) then ChartPDF.Series[5].AddXY(x2,tAge);
          if ((y2 < Cutoff3) and (y2 >= Cutoff2)) then ChartPDF.Series[4].AddXY(x2,tAge);
          if ((y2 < Cutoff4) and (y2 >= Cutoff3)) then ChartPDF.Series[3].AddXY(x2,tAge);
          if ((y2 < Cutoff5) and (y2 >= Cutoff4)) then ChartPDF.Series[2].AddXY(x2,tAge);
          if (y2 >= Cutoff5) then ChartPDF.Series[1].AddXY(x2,tAge);
          //if ((y2 < Cutoff2) and (y2 >= Cutoff1)) then Series14.AddXYZ(x2,tAge,y2);
          //if ((y2 < Cutoff3) and (y2 >= Cutoff2)) then Series15.AddXYZ(x2,tAge,y2);
          //if ((y2 < Cutoff4) and (y2 >= Cutoff3)) then Series16.AddXYZ(x2,tAge,y2);
          //if ((y2 < Cutoff5) and (y2 >= Cutoff4)) then Series17.AddXYZ(x2,tAge,y2);
          //if (y2 >= Cutoff5) then Series18.AddXYZ(x2,tAge,y2);
          //Series13.AddXYZ(x2,tAge,y2);    //for heat graph but not yet working
          //if ((y2 > 0.0) and (tAge > 1590.0)) then Series20.AddXYZ(x2,tAge,y2);    //for 3D probability surface
          dmPDF.cdsGrainData.Next;
        until (dmPDF.cdsGrainData.Eof);
        dmPDF.cdsGrainData.First;
        //ShowMessage('3');
        tmp:= 1.0*Trunc(FromAge);
        repeat
          x2 := 1.0*tmp;
          ChartPDF.Series[6].AddXY(x2,x2);
          tmp := tmp + (ToAge-FromAge)/100.0;
        until (tmp > ToAge);
        //ShowMessage('4');
        dmPDF.cdsGrainData.First;
        //Series20.IrregularGrid := true;
        //ShowMessage(FormatFloat('###0.00',FromAgeLeft)+'   '+FormatFloat('###0.00',ToAgeLeft));
        ChartPDF.LeftAxis.SetMinMax(FromAgeLeft,ToAgeLeft);
        ChartPDF.BottomAxis.SetMinMax(FromAge,ToAge);
        ChartPDF.Title.Caption := eGraphTitle.Text;
        ChartHeat.LeftAxis.SetMinMax(FromAgeLeft,ToAgeLeft);
        ChartHeat.BottomAxis.SetMinMax(FromAge,ToAge);
        ChartHeat.Title.Caption := eGraphTitle.Text;
        if PDFType='AND' then
        begin
          tmpStr := 'Gaussian AND ';
        end;
        if PDFType='OR' then
        begin
          tmpStr := 'Gaussian OR ';
        end;
        ChartPDF.SubFoot.Text[0] := tmpStr;
        ChartPDF.SubFoot.Text[1] := 'Minimum age uncertainty = '+FormatFloat('###0.00',MinimumUncertainty)+' Ma';
        ChartHeat.SubFoot.Text[0] := tmpStr;
        ChartHeat.SubFoot.Text[1] := 'Minimum age uncertainty = '+FormatFloat('###0.00',MinimumUncertainty)+' Ma';
        if NormalisationType=nt100Percent then
        begin
          tmpStr := 'Maximum peak normalised to 100%';
        end;
        if NormalisationType=ntTrueProbability then
        begin
          tmpStr := 'True probability';
        end;
        ChartPDF.SubFoot.Text[2] := tmpStr;
        ChartHeat.SubFoot.Text[2] := tmpStr;
        dbgHistogram.DataSource := nil;
        dbnHistogram.DataSource := nil;
        dbgPDF.DataSource := nil;
        dbnPDF.DataSource := nil;
        dmPDF.cdsGrainData.EnableControls;
        dbgGrainData.DataSource := dmPDF.dsGrainData;
        dbnGrainData.DataSource := dmPDF.dsGrainData;
        dmPDF.cdsGrainData.First;
        ChartPDF.SubFoot.Text[3] := '';
        ChartHeat.SubFoot.Text[3] := '';
        if ((cbPlotExtraVariable.Checked) and (rgGraphType.ItemIndex = 1)) then
        begin
          dmPDF.cdsRawData.Filtered := false;
          dmPDF.cdsRawData.First;
          repeat
            x2 := dmPDF.cdsRawDataData.AsFloat;
            tAge := dmPDF.cdsRawDataUnitAge.AsFloat;
            z2 := dmPDF.cdsRawDataExtra.AsFloat;
            {
            if (dmPDF.ExtraVarGTLT = '<=') then
            begin
              if ((z2 <= dmPDF.ExtraVarCutoff) and (z2 > NoDataValue)) then
              begin
                ChartPDF.Series[6].AddXY(x2,tAge);
                //ShowMessage(FormatFloat('###0.00',x2)+'   '+FormatFloat('###0.00',tAge));
              end;
            end;
            if (dmPDF.ExtraVarGTLT = '>=') then
            begin
              if ((z2 >= dmPDF.ExtraVarCutoff) and (z2 > NoDataValue)) then
              begin
                ChartPDF.Series[6].AddXY(x2,tAge);
                //ShowMessage(FormatFloat('###0.00',x2)+'   '+FormatFloat('###0.00',tAge));
              end;
            end;
            }
            if ((z2 >= dmPDF.ExtraVarCutoffMin) and (z2 <= dmPDF.ExtraVarCutoffMax) and (z2 > NoDataValue)) then
            begin
              ChartPDF.Series[0].AddXY(x2,tAge);
              //ShowMessage(FormatFloat('###0.00',x2)+'   '+FormatFloat('###0.00',tAge));
            end;
            dmPDF.cdsRawData.Next;
          until dmPDF.cdsRawData.Eof;
          dmPDF.cdsRawData.First;
          //tmpStr := 'Extra variable: '+dmPDF.ExtraVarName+' '+dmPDF.ExtraVarGTLT+' '+FormatFloat('###0.000',dmPDF.ExtraVarCutoff);
          tmpStr := 'Extra variable: '+dmPDF.ExtraVarName+' '+FormatFloat('###0.000',dmPDF.ExtraVarCutoffMin)+' - '+FormatFloat('###0.000',dmPDF.ExtraVarCutoffMax);
          ChartPDF.SubFoot.Text[3] := tmpStr;
        end;
        ChartPDF.Foot.Caption := FitPDFVersionStr;
        tsVerticalView.TabVisible := true;
        //tsHeat.TabVisible := true;
        pc1.ActivePage := tsVerticalView;
        ExportGraphValues1.Visible := true;
        ExportProvenanceLimits1.Visible := true;
      end;
      //-------------------------------------------------------------------
      //Cumulative probability graph
      //-------------------------------------------------------------------
      if (rgGraphType.ItemIndex = 2) then
      begin
        if (dmPDF.cdsAgeList.RecordCount = 0) then
        begin
           MessageDlg('No deposition ages have been specified',mtWarning,[mbOK],0);
           Exit;
        end;
        ExportAssociationSampleAges1.Visible := true;
        DetermineAssociations;
        dmPDF.cdsAgeList.IndexFieldNames := 'UnitAge';
        ChartGeotectonic.Series[0].Clear;
        ChartGeotectonic.Series[1].Clear;
        ChartGeotectonic.Series[2].Clear;
        ChartCum.SeriesList.Clear;
        dmPDF.cdsCum.Filtered := false;
        dmPDF.cdsCum.DisableControls;
        dmPDF.cdsCum.EmptyDataSet;
        dmPDF.cdsRawData.First;
        dmPDF.cdsAgeList.First;
        //ShowMessage('1');
        i := 0;
        repeat
          tAge := dmPDF.cdsAgeListUnitAge.AsFloat;
          dmPDF.cdsCum.Filtered := false;
          //ShowMessage(FormatFloat('###0.000',tAge));
          CalculatePDF(GraphTypeC,NormalisationType,tAge);
          //ShowMessage(FormatFloat('####0.00',tAge)+' PDF complete');
          //ShowMessage(FormatFloat('####0.00',tAge)+' GrainData added');
          dmPDF.cdsCum.Filter := 'UnitAge='+FormatFloat('###0.0000',tAge);
          dmPDF.cdsCum.Filtered := true;
          ChartCum.AddSeries(TLineSeries.Create(Self));
          ChartCum.Series[i].Title := FormatFloat('####0.00',tAge);
          ChartCum.Series[i].Pen.Width := 2;
          ChartCum.Series[i].Pen.Color := clGray;
          ChartCum.Series[i].Color := clGray;
          //ChartCum.Series[i].Create(ChartCum);
          Trip05pc := false;
          Trip30pc := false;
          repeat
            x2 := dmPDF.cdsCumPDFDataValue.AsFloat-tAge;
            y2 := dmPDF.cdsCumCumValue.AsFloat;
            if ((y2 >= 5.0) and (not Trip05pc)) then
            begin
              Trip05pc := true;
              if (x2 > 150) then
              begin
                ChartCum.Series[i].Pen.Color := clGreen;
                ChartCum.Series[i].Color := clGreen;
                Trip30pc := true;
              end;
            end;
            if ((y2 >= 5.0) and (Trip05pc) and (not Trip30pc)) then
            begin
              if ((y2 >= 30.0) and (not Trip30pc)) then
              begin
                Trip30pc := true;
                if (x2 < 100) then
                begin
                  ChartCum.Series[i].Pen.Color := clRed;
                  ChartCum.Series[i].Color := clRed;
                end else
                begin
                  ChartCum.Series[i].Pen.Color := clBlue;
                  ChartCum.Series[i].Color := clBlue;
                end;
              end;
            end;
            if (X2 >=0.0) then
            begin
              if (y2 < 100.0) then ChartCum.Series[i].AddXY(x2,y2);
            end;
            dmPDF.cdsCum.Next;
          until (dmPDF.cdsCum.Eof);
          dmPDF.cdsAgeList.Edit;
          tClassNum := 0;
          if (ChartCum.Series[i].Color = clRed) then
          begin
            dmPDF.cdsAgeListClassification.AsString := 'Red';
            dmPDF.cdsAgeListClassNum.AsInteger := 1;
            tClassNum := 1;
            ChartGeotectonic.Series[0].AddXY(tClassNum,tAge);
          end;
          if (ChartCum.Series[i].Color = clBlue) then
          begin
            dmPDF.cdsAgeListClassification.AsString := 'Blue';
            dmPDF.cdsAgeListClassNum.AsInteger := 2;
            tClassNum := 2;
            ChartGeotectonic.Series[1].AddXY(tClassNum,tAge);
          end;
          if (ChartCum.Series[i].Color = clGreen) then
          begin
            dmPDF.cdsAgeListClassification.AsString := 'Green';
            dmPDF.cdsAgeListClassNum.AsInteger := 3;
            tClassNum := 3;
            ChartGeotectonic.Series[2].AddXY(tClassNum,tAge);
          end;
          dmPDF.cdsAgeList.Post;
          dmPDF.cdsCum.Filtered := false;
          i := i + 1;
          dmPDF.cdsAgeList.Next;
        until (dmPDF.cdsAgeList.Eof);
        i := i + 1;
        //ShowMessage('2');
        ChartCum.Title.Caption := eGraphTitle.Text;
        if PDFType='AND' then
        begin
          tmpStr := 'Gaussian AND ';
        end;
        if PDFType='OR' then
        begin
          tmpStr := 'Gaussian OR ';
        end;
        ChartCum.SubFoot.Text[0] := tmpStr;
        ChartCum.SubFoot.Text[1] := 'Minimum age uncertainty = '+FormatFloat('###0.00',MinimumUncertainty)+' Ma';
        if NormalisationType=nt100Percent then
        begin
          tmpStr := 'Maximum peak normalised to 100%';
        end;
        if NormalisationType=ntTrueProbability then
        begin
          tmpStr := 'True probability';
        end;
        ChartCum.SubFoot.Text[2] := tmpStr;
        dbgHistogram.DataSource := nil;
        dbnHistogram.DataSource := nil;
        dbgPDF.DataSource := nil;
        dbnPDF.DataSource := nil;
        dmPDF.cdsCum.EnableControls;
        dmPDF.cdsCum.First;
        ChartCum.SubFoot.Text[3] := '';
        ChartCum.Foot.Caption := FitPDFVersionStr;
        tsVerticalView.TabVisible := false;
        tsHeat.TabVisible := false;
        tsGraph.TabVisible := false;
        tsCumulativeProbability.TabVisible := true;
        pc1.ActivePage := tsCumulativeProbability;
        ExportGraphValues1.Visible := true;
        TreeViewCum.Items.Clear;
        dmPDF.cdsAssociations.First;
        dmPDF.cdsAssocSampleAge.First;
        //Node := TreeView1.Items.Add(TreeView1.Selected,'Data');
        TreeViewCum.SetFocus;
        repeat
          tAssoc := dmPDF.cdsAssociationsAssociation.AsString;
          Node := TreeViewCum.Items.Add(TreeViewCum.Selected,tAssoc);
          dmPDF.cdsAssocSampleAge.Filter := 'Association = '+''''+tAssoc+'''';
          //dmPDF.cdsAssocSampleAge.Filter := 'Association = '+tAssoc+' and SampleNo = '+tmpAgeMinStr+' and Data <= '+tmpAgeMaxStr;
          dmPDF.cdsAssocSampleAge.Filtered := true;
          Node.Selected := true;
          if (dmPDF.cdsAssocSampleAge.RecordCount > 0) then
          begin
            dmPDF.cdsAssocSampleAge.First;
            tSampleNo := dmPDF.cdsAssocSampleAgeSampleNo.AsString;
            //ShowMessage('Sample = '+tSampleNo);
            repeat
              tSampleNo := dmPDF.cdsAssocSampleAgeSampleNo.AsString;
              Node := TreeViewCum.Items.AddChild(TreeViewCum.Selected,tSampleNo);
              dmPDF.cdsAssocSampleAge.Next;
            until dmPDF.cdsAssocSampleAge.Eof;
          end;
          dmPDF.cdsAssocSampleAge.Filtered := false;
          dmPDF.cdsAssociations.Next;
        until dmPDF.cdsAssociations.Eof;
      end;
      //-------------------------------------------------------------------
      //3D Multiple probability graph with extra variable on 3rd dimension
      //-------------------------------------------------------------------
      if (rgGraphType.ItemIndex = 3) then
      begin
        ChartPDF.View3D := true;
        ChartPDF.Axes.Depth.Visible := true;
        Series14.Visible := true;
        Series15.Visible := true;
        Series16.Visible := true;
        Series17.Visible := true;
        Series18.Visible := true;
        Series19.Visible := true;
        Series14.Legend.Visible := true;
        Series15.Legend.Visible := true;
        Series16.Legend.Visible := true;
        Series17.Legend.Visible := true;
        Series18.Legend.Visible := true;
        Series19.Legend.Visible := true;
        Series14.ShowInLegend := true;
        Series15.ShowInLegend := true;
        Series16.ShowInLegend := true;
        Series17.ShowInLegend := true;
        Series18.ShowInLegend := true;
        Series19.ShowInLegend := true;
        if (dmPDF.cdsAgeList.RecordCount = 0) then
        begin
           MessageDlg('No deposition ages have been specified',mtWarning,[mbOK],0);
           Exit;
        end;
        ChartPDF.Series[0].Clear;
        ChartPDF.Series[1].Clear;
        ChartPDF.Series[2].Clear;
        ChartPDF.Series[3].Clear;
        ChartPDF.Series[4].Clear;
        ChartPDF.Series[5].Clear;
        ChartPDF.Series[6].Clear;
        Series14.Clear;
        Series15.Clear;
        Series16.Clear;
        Series17.Clear;
        Series18.Clear;
        Series19.Clear;
        ChartHeat.Series[0].Clear;
        ChartPDF.Series[0].Visible := false;
        ChartPDF.Series[1].Visible := false;
        ChartPDF.Series[2].Visible := false;
        ChartPDF.Series[3].Visible := false;
        ChartPDF.Series[4].Visible := false;
        ChartPDF.Series[5].Visible := false;
        ChartPDF.Series[6].Visible := false;
        ChartPDF.Series[0].ShowInLegend := false;
        ChartPDF.Series[1].ShowInLegend := false;
        ChartPDF.Series[2].ShowInLegend := false;
        ChartPDF.Series[3].ShowInLegend := false;
        ChartPDF.Series[4].ShowInLegend := false;
        ChartPDF.Series[5].ShowInLegend := false;
        ChartPDF.Series[6].ShowInLegend := false;
        Val(e1.Text,Cutoff1,iCode);
        Val(e2.Text,Cutoff2,iCode);
        Val(e3.Text,Cutoff3,iCode);
        Val(e4.Text,Cutoff4,iCode);
        Val(e5.Text,Cutoff5,iCode);
        Cutoff6 := 100.0;
        ChartPDF.Series[4].Title := Trim(e1.Text)+' - '+Trim(e2.Text);
        ChartPDF.Series[3].Title := Trim(e2.Text)+' - '+Trim(e3.Text);
        ChartPDF.Series[2].Title := Trim(e3.Text)+' - '+Trim(e4.Text);
        ChartPDF.Series[1].Title := Trim(e4.Text)+' - '+Trim(e5.Text);
        ChartPDF.Series[0].Title := Trim(e5.Text)+' - '+Trim('100.0');
        Val(e3D1.Text,Cutoff3D1,iCode);
        Val(e3D2.Text,Cutoff3D2,iCode);
        Val(e3D3.Text,Cutoff3D3,iCode);
        Val(e3D4.Text,Cutoff3D4,iCode);
        Series14.Title := '< '+Trim(e3D1.Text);
        Series15.Title := Trim(e3D1.Text)+' - '+Trim(e3D2.Text);
        Series16.Title := Trim(e3D2.Text)+' - '+Trim(e3D3.Text);
        Series17.Title := Trim(e3D3.Text)+' - '+Trim(e3D4.Text);
        Series18.Title := '>= '+Trim(e3D4.Text);
        Series19.Title := 'Major age peaks';
        dmPDF.cdsRawData.Filtered := false;
        dmPDF.cdsGrainData.DisableControls;
        dmPDF.cdsGrainData.EmptyDataSet;
        dmPDF.cdsRawData.First;
        dmPDF.cdsAgeList.First;
        //ShowMessage('1');
        repeat
          tAge := dmPDF.cdsAgeListUnitAge.AsFloat;
          //ShowMessage(FormatFloat('###0.000',tAge));
          CalculatePDF(GraphTypeM,NormalisationType,tAge);
          //ShowMessage(FormatFloat('####0.00',tAge)+' PDF complete');
          dmPDF.cdsPDF.First;
          repeat
            if (dmPDF.cdsPDFPDFValue.AsFloat > 0.0001) then
            begin
              dmPDF.cdsGrainData.Append;
              dmPDF.cdsGrainDataUnitAge.AsFloat := dmPDF.cdsPDFUnitAge.AsFloat;
              dmPDF.cdsGrainDataStepID.AsInteger := dmPDF.cdsPDFStep.AsInteger;
              dmPDF.cdsGrainDataGrainAge.AsFloat := dmPDF.cdsPDFPDFDataValue.AsFloat;
              dmPDF.cdsGrainDataPDFvalue.AsFloat := dmPDF.cdsPDFPDFValue.AsFloat;
              dmPDF.cdsGrainData.Post;
            end;
            dmPDF.cdsPDF.Next;
          until (dmPDF.cdsPDF.Eof);
          //ShowMessage(FormatFloat('####0.00',tAge)+' GrainData added');
          dmPDF.cdsAgeList.Next;
        until (dmPDF.cdsAgeList.Eof);
        //Series19.Clear;
        dmPDF.cdsGrainData.First;
        //ShowMessage('2');
        repeat
          x2 := dmPDF.cdsGrainDataGrainAge.AsFloat;
          y2 := dmPDF.cdsGrainDataPDFvalue.AsFloat;
          tAge := dmPDF.cdsGrainDataUnitAge.AsFloat;
          z2 := From3D;
          //if ((y2 < Cutoff2) and (y2 >= Cutoff1)) then ChartPDF.Series[4].AddXY(x2,tAge);
          //if ((y2 < Cutoff3) and (y2 >= Cutoff2)) then ChartPDF.Series[3].AddXY(x2,tAge);
          //if ((y2 < Cutoff4) and (y2 >= Cutoff3)) then ChartPDF.Series[2].AddXY(x2,tAge);
          //if ((y2 < Cutoff5) and (y2 >= Cutoff4)) then ChartPDF.Series[1].AddXY(x2,tAge);
          //if (y2 >= Cutoff5) then ChartPDF.Series[0].AddXY(x2,tAge);
          if (y2 >= Cutoff4) then Series19.AddXYZ(x2,tAge,z2);
          dmPDF.cdsGrainData.Next;
        until (dmPDF.cdsGrainData.Eof);
        dmPDF.cdsGrainData.First;
        if (cb3DMajorPeaksOnly.Checked) then
        begin
          CalculateClusterLimits;
          dmPDF.cdsClusterLimits.First;
          repeat
            tmpUnitAgeStr := FormatFloat('####0.000',dmPDF.cdsClusterLimitsUnitAge.AsFloat);
            tmpAgeMinStr := FormatFloat('####0.000',dmPDF.cdsClusterLimitsClusterMinAge.AsFloat);
            tmpAgeMaxStr := FormatFloat('####0.000',dmPDF.cdsClusterLimitsClusterMaxAge.AsFloat);
            dmPDF.cdsRawData.Filter := 'UnitAge = '+tmpUnitAgeStr+' and Data >= '+tmpAgeMinStr+' and Data <= '+tmpAgeMaxStr;
            dmPDF.cdsRawData.Filtered := true;
            dmPDF.cdsRawData.First;
              repeat
                x2 := dmPDF.cdsRawDataData.AsFloat;
                y2 := dmPDF.cdsRawDataUnitAge.AsFloat;
                tAge := dmPDF.cdsRawDataUnitAge.AsFloat;
                z2 := dmPDF.cdsRawDataExtra.AsFloat;
                if ((z2 < Cutoff3D1) and (z2 > NoDataValue)) then Series14.AddXYZ(x2,y2,z2);
                if ((z2 < Cutoff3D2) and (z2 >= Cutoff3D1)) then Series15.AddXYZ(x2,y2,z2);
                if ((z2 < Cutoff3D3) and (z2 >= Cutoff3D2)) then Series16.AddXYZ(x2,y2,z2);
                if ((z2 < Cutoff3D4) and (z2 >= Cutoff3D3)) then Series17.AddXYZ(x2,y2,z2);
                if (z2 >= Cutoff3D4) then Series18.AddXYZ(x2,y2,z2);
                dmPDF.cdsRawData.Next;
              until (dmPDF.cdsRawData.Eof);
            dmPDF.cdsClusterLimits.Next;
          until dmPDF.cdsClusterLimits.Eof;
          dmPDF.cdsRawData.Filtered := false;
        end else
        begin
          dmPDF.cdsRawData.Filtered := false;
          dmPDF.cdsRawData.First;
          repeat
            x2 := dmPDF.cdsRawDataData.AsFloat;
            y2 := dmPDF.cdsRawDataUnitAge.AsFloat;
            tAge := dmPDF.cdsRawDataUnitAge.AsFloat;
            z2 := dmPDF.cdsRawDataExtra.AsFloat;
            if ((z2 < Cutoff3D1) and (z2 > NoDataValue)) then Series14.AddXYZ(x2,y2,z2);
            if ((z2 < Cutoff3D2) and (z2 >= Cutoff3D1)) then Series15.AddXYZ(x2,y2,z2);
            if ((z2 < Cutoff3D3) and (z2 >= Cutoff3D2)) then Series16.AddXYZ(x2,y2,z2);
            if ((z2 < Cutoff3D4) and (z2 >= Cutoff3D3)) then Series17.AddXYZ(x2,y2,z2);
            if (z2 >= Cutoff3D4) then Series18.AddXYZ(x2,y2,z2);
            //Series13.AddXYZ(x2,tAge,y2);    //for heat graph but not yet working
            dmPDF.cdsRawData.Next;
          until (dmPDF.cdsRawData.Eof);
        end;
        dmPDF.cdsGrainData.First;
        //ShowMessage('3');
        tmp:= 1.0*Trunc(FromAge);
        repeat
          x2 := 1.0*tmp;
          ChartPDF.Series[5].AddXY(x2,x2);
          tmp := tmp + (ToAge-FromAge)/100.0;
        until (tmp > ToAge);
        //ShowMessage('4');
        //ShowMessage(FormatFloat('###0.00',FromAgeLeft)+'   '+FormatFloat('###0.00',ToAgeLeft));
        ChartPDF.LeftAxis.SetMinMax(FromAgeLeft,ToAgeLeft);
        ChartPDF.BottomAxis.SetMinMax(FromAge,ToAge);
        ChartPDF.Title.Caption := eGraphTitle.Text;
        ChartHeat.LeftAxis.SetMinMax(FromAgeLeft,ToAgeLeft);
        ChartHeat.BottomAxis.SetMinMax(FromAge,ToAge);
        ChartHeat.Title.Caption := eGraphTitle.Text;
        if PDFType='AND' then
        begin
          tmpStr := 'Gaussian AND ';
        end;
        if PDFType='OR' then
        begin
          tmpStr := 'Gaussian OR ';
        end;
        ChartPDF.SubFoot.Text[0] := tmpStr;
        ChartPDF.SubFoot.Text[1] := 'Minimum age uncertainty = '+FormatFloat('###0.00',MinimumUncertainty)+' Ma';
        ChartHeat.SubFoot.Text[0] := tmpStr;
        ChartHeat.SubFoot.Text[1] := 'Minimum age uncertainty = '+FormatFloat('###0.00',MinimumUncertainty)+' Ma';
        if NormalisationType=nt100Percent then
        begin
          tmpStr := 'Maximum peak normalised to 100%';
        end;
        if NormalisationType=ntTrueProbability then
        begin
          tmpStr := 'True probability';
        end;
        ChartPDF.SubFoot.Text[2] := tmpStr;
        ChartHeat.SubFoot.Text[2] := tmpStr;
        dbgHistogram.DataSource := nil;
        dbnHistogram.DataSource := nil;
        dbgPDF.DataSource := nil;
        dbnPDF.DataSource := nil;
        dmPDF.cdsGrainData.EnableControls;
        dbgGrainData.DataSource := dmPDF.dsGrainData;
        dbnGrainData.DataSource := dmPDF.dsGrainData;
        dmPDF.cdsGrainData.First;
        ChartPDF.SubFoot.Text[3] := '';
        ChartHeat.SubFoot.Text[3] := '';
        ChartPDF.SubFoot.Text[3] := 'Chosen cutoff = '+FormatFloat('####0.00000',dmPDF.ChosenCutoff);;
        if ((cbPlotExtraVariable.Checked) and (rgGraphType.ItemIndex = 3)) then
        begin
          dmPDF.cdsRawData.Filtered := false;
          dmPDF.cdsRawData.First;
          repeat
            x2 := dmPDF.cdsRawDataData.AsFloat;
            tAge := dmPDF.cdsRawDataUnitAge.AsFloat;
            z2 := dmPDF.cdsRawDataExtra.AsFloat;
            //if (dmPDF.ExtraVarGTLT = '<=') then
            //begin
            //  if ((z2 <= dmPDF.ExtraVarCutoff) and (z2 > NoDataValue)) then
            //  begin
            //    ChartPDF.Series[6].AddXY(x2,tAge);
            //    //ShowMessage(FormatFloat('###0.00',x2)+'   '+FormatFloat('###0.00',tAge));
            //  end;
            //end;
            //if (dmPDF.ExtraVarGTLT = '>=') then
            //begin
            //  if ((z2 >= dmPDF.ExtraVarCutoff) and (z2 > NoDataValue)) then
            //  begin
            //    ChartPDF.Series[6].AddXY(x2,tAge);
            //    //ShowMessage(FormatFloat('###0.00',x2)+'   '+FormatFloat('###0.00',tAge));
            //  end;
            //end;
            dmPDF.cdsRawData.Next;
          until dmPDF.cdsRawData.Eof;
          dmPDF.cdsRawData.First;
        end;
        tsVerticalView.TabVisible := true;
        tsHeat.TabVisible := false;
        pc1.ActivePage := tsVerticalView;
        ChartPDF.DepthAxis.SetMinMax(From3D,To3D);
        ChartPDF.Foot.Caption := FitPDFVersionStr;
        ExportGraphValues1.Visible := true;
      end;
      //-------------------------------------------------------------------
      //Multiple sample probability surface
      //-------------------------------------------------------------------
      if (rgGraphType.ItemIndex = 4) then
      begin
        //ShowMessage('tsSurface 1');
        ChartSurface.View3D := true;
        if (dmPDF.cdsAgeList.RecordCount = 0) then
        begin
           MessageDlg('No deposition ages have been specified',mtWarning,[mbOK],0);
           Exit;
        end;
        Series20.Visible := true;
        Series20.Legend.Visible := true;
        Series20.ShowInLegend := true;
        Series20.Clear;
        Series20.Title := 'Probability surface';
        //ShowMessage('tsSurface 2');

        dmPDF.cdsRawData.Filtered := false;
        dmPDF.cdsGrainData.DisableControls;
        dmPDF.cdsGrainData.EmptyDataSet;
        dmPDF.cdsRawData.First;
        dmPDF.cdsAgeList.First;
        //ShowMessage('tsSurface 3');
        repeat
          tAge := dmPDF.cdsAgeListUnitAge.AsFloat;
          CalculatePDF(GraphTypeM,NormalisationType,tAge);
          dmPDF.cdsPDF.First;
          repeat
            if (dmPDF.cdsPDFPDFValue.AsFloat > 0.0001) then
            begin
              dmPDF.cdsGrainData.Append;
              dmPDF.cdsGrainDataUnitAge.AsFloat := dmPDF.cdsPDFUnitAge.AsFloat;
              dmPDF.cdsGrainDataStepID.AsInteger := dmPDF.cdsPDFStep.AsInteger;
              dmPDF.cdsGrainDataGrainAge.AsFloat := dmPDF.cdsPDFPDFDataValue.AsFloat;
              dmPDF.cdsGrainDataPDFvalue.AsFloat := dmPDF.cdsPDFPDFValue.AsFloat;
              dmPDF.cdsGrainData.Post;
            end;
            dmPDF.cdsPDF.Next;
          until (dmPDF.cdsPDF.Eof);
          dmPDF.cdsAgeList.Next;
        until (dmPDF.cdsAgeList.Eof);
        //ShowMessage('tsSurface 4');
        dmPDF.cdsGrainData.First;
        repeat
          x2 := dmPDF.cdsGrainDataGrainAge.AsFloat;
          y2 := dmPDF.cdsGrainDataPDFvalue.AsFloat;
          tAge := dmPDF.cdsGrainDataUnitAge.AsFloat;
          z2 := dmPDF.cdsGrainDataUnitAge.AsFloat;
          if (y2 > 1.0) then Series20.AddXYZ(x2,y2,z2);    //for 3D probability surface
          dmPDF.cdsGrainData.Next;
        until (dmPDF.cdsGrainData.Eof);
        dmPDF.cdsGrainData.First;
        dmPDF.cdsGrainData.First;
        //ShowMessage('tsSurface 5');
        //Series20.IrregularGrid := true;
        //ChartSurface.LeftAxis.SetMinMax(0.0,200.0);
        ChartSurface.DepthAxis.SetMinMax(FromAgeLeft,ToAgeLeft);
        ChartSurface.BottomAxis.SetMinMax(FromAge,ToAge);
        ChartSurface.Title.Caption := eGraphTitle.Text;
        if PDFType='AND' then
        begin
          tmpStr := 'Gaussian AND ';
        end;
        if PDFType='OR' then
        begin
          tmpStr := 'Gaussian OR ';
        end;
        ChartSurface.SubFoot.Text[0] := tmpStr;
        ChartSurface.SubFoot.Text[1] := 'Minimum age uncertainty = '+FormatFloat('###0.00',MinimumUncertainty)+' Ma';
        if NormalisationType=nt100Percent then
        begin
          tmpStr := 'Maximum peak normalised to 100%';
        end;
        if NormalisationType=ntTrueProbability then
        begin
          tmpStr := 'True probability';
        end;
        ChartSurface.SubFoot.Text[2] := tmpStr;
        dbgHistogram.DataSource := nil;
        dbnHistogram.DataSource := nil;
        dbgPDF.DataSource := nil;
        dbnPDF.DataSource := nil;
        dmPDF.cdsGrainData.EnableControls;
        dbgGrainData.DataSource := dmPDF.dsGrainData;
        dbnGrainData.DataSource := dmPDF.dsGrainData;
        dmPDF.cdsGrainData.First;
        ChartSurface.SubFoot.Text[3] := '';
        ChartSurface.Foot.Caption := FitPDFVersionStr;
        tsSurface.TabVisible := true;
        pc1.ActivePage := tsSurface;
      end;
    end;
    //ShowMessage('5');
    dmPDF.cdsAgeList.First;
    dmPDF.cdsRawData.Filtered := false;
    dmPDF.cdsRawData.EnableControls;
    dbgRawData.DataSource := dmPDF.dsRawData;
    dbnRawData.DataSource := dmPDF.dsRawData;
    dmPDF.cdsRawData.EnableControls;
    dmPDF.cdsRawData.Filtered := false;
    dmPDF.cdsRawData.First;
  end else
  begin
    MessageDlg('No data available',mtWarning,[mbOK],0);
  end;
  dmPDF.cdsRawData.EnableControls;
  dmPDF.cdsRawData.Filter := '';
  dmPDF.cdsRawData.Filtered := false;
  dmPDF.cdsRawData.First;
  dbgRawData.DataSource := dmPDF.dsRawData;
  dbnRawData.DataSource := dmPDF.dsRawData;
  dmPDF.cdsPDF.EnableControls;
  dmPDF.cdsPDF.Filter := '';
  dmPDF.cdsPDF.Filtered := false;
  dmPDF.cdsPDF.First;
  dbgPDF.DataSource := dmPDF.dsPDF;
  dbnPDF.DataSource := dmPDF.dsPDF;
  dmPDF.cdsCum.EnableControls;
  dmPDF.cdsCum.Filter := '';
  dmPDF.cdsCum.Filtered := false;
  dmPDF.cdsCum.First;
  dbgCumulative.DataSource := dmPDF.dsCum;
  dbnCumulative.DataSource := dmPDF.dsCum;
  dmPDF.cdsGrainData.EnableControls;
  dmPDF.cdsGrainData.Filter := '';
  dmPDF.cdsGrainData.Filtered := false;
  dmPDF.cdsGrainData.First;
  dbgGrainData.DataSource := dmPDF.dsGrainData;
  dbnGrainData.DataSource := dmPDF.dsGrainData;
  dmPDF.cdsHistogram.EnableControls;
  dmPDF.cdsHistogram.Filter := '';
  dmPDF.cdsHistogram.Filtered := false;
  dmPDF.cdsHistogram.First;
  dbgHistogram.DataSource := dmPDF.dsHistogram;
  dbnHistogram.DataSource := dmPDF.dsHistogram;
  fmPDFMain.Refresh;
  sbMain.Panels[0].Text := Int2Str(NPts) + ' data';
  sbMain.Panels[1].Text := ' ';
  sbMain.Panels[2].Text := ' ';
  sbMain.Panels[3].Text := ' ';
  sbMain.Refresh;
  Application.ProcessMessages;
end;

procedure TfmPDFMain.bbExitClick(Sender: TObject);
begin
  dmPDF.cdsPDF.EmptyDataSet;
  dmPDF.cdsHistogram.EmptyDataSet;
  dmPDF.cdsGrainData.EmptyDataSet;
  dmPDF.cdsSelectedGrainData.EmptyDataSet;
  dmPDF.cdsAgeList.EmptyDataSet;
  dmPDF.cdsClusterLimits.EmptyDataSet;
  dmPDF.cdsCum.EmptyDataSet;
  dmPDF.cdsRawData.EmptyDataSet;
  dmPDF.cdsAssocSampleAge.EmptyDataSet;
  dmPDF.cdsAssociations.EmptyDataSet;
  dmPDF.cdsSamples.EmptyDataSet;
  SetIniFile;
  Close;
end;

procedure TfmPDFMain.bbOptimiseBinNumClick(Sender: TObject);
var
  iCode : integer;
begin
  Val(eFromAge.Text,FromAge,iCode);
  if (iCode <> 0) then MessageDlg('From Age value is not correct',mtWarning,[mbOK],0);
  if (iCode = 0) then
  begin
    Val(eToAge.Text,ToAge,iCode);
    if (iCode <> 0) then MessageDlg('To Age value is not correct',mtWarning,[mbOK],0);
  end;
  NumBins := Round((ToAge - FromAge)/OptimumBinWidth);
  eNumBins.Text := IntToStr(NumBins);
end;

procedure TfmPDFMain.bCheckFoldersClick(Sender: TObject);
begin
  //ShowMessage('Local AppData folder is '+LocalFilePath);
  ShowMessage('Common AppData folder is '+CommonFilePath);
  ShowMessage('Program File folder is '+ProgramFilePath);
  ShowMessage('Templates folder is '+FlexTemplatePath);
end;

procedure TfmPDFMain.bShowSequenceClick(Sender: TObject);
var
  i, j : integer;
  iTimeDelay : integer;
begin
  i := ChartCum.SeriesList.Count;
  iTimeDelay := 200;
  try
    iTimeDelay := StrToInt(Trim(eTimeDelay.Text));
  except
    iTimeDelay := 200;
  end;
  eTimeDelay.Text := IntToStr(iTimeDelay);
  eTimeDelay.Refresh;
  for j := 0 to i-1 do
  begin
    ChartCum.Series[j].Visible := false;
  end;
  {
  for j := 0 to i-1 do
  begin
    ChartCum.Series[j].Visible := true;
    Delay(iTimeDelay);
  end;
  }
  for j := i-1 downto 0 do
  begin
    ChartCum.Series[j].Visible := true;
    Delay(iTimeDelay);
  end;
end;

procedure TfmPDFMain.Button1Click(Sender: TObject);
var
  Node : TTreeNode;
  tAssoc, tSampleNo : string;
  tAge : double;
  tAgeStr : string;
  parentindex : integer;
begin
  TreeViewCum.Items.Clear;
  dmPDF.cdsAssociations.First;
  dmPDF.cdsAgeList.First;
  dmPDF.cdsAssocSampleAge.First;
  TreeViewCum.SetFocus;
  repeat
    tAssoc := dmPDF.cdsAssociationsAssociation.AsString;
    Node := TreeViewCum.Items.Add(TreeViewCum.Selected,tAssoc);
    dmPDF.cdsAgeList.First;
    repeat
      tAge := dmPDF.cdsAgeListUnitAge.AsFloat;
      tAgeStr := FloatToStr(tAge);
      //dmPDF.cdsAssocSampleAge.Filter := 'Association = '+''''+tAssoc+'''';
      dmPDF.cdsAssocSampleAge.Filter := 'Association = '+''''+tAssoc+''''+' and DeposAge = '+tAgeStr;
      //dmPDF.cdsAssocSampleAge.Filter := 'Association = '+tAssoc+' and SampleNo = '+tmpAgeMinStr+' and Data <= '+tmpAgeMaxStr;
      dmPDF.cdsAssocSampleAge.Filtered := true;
      Node.Selected := true;
      if (dmPDF.cdsAssocSampleAge.RecordCount > 0) then
      begin
        Node := TreeViewCum.Items.AddChild(TreeViewCum.Selected,tAgeStr);
        Node.Selected := true;
        dmPDF.cdsAssocSampleAge.First;
        repeat
          tSampleNo := dmPDF.cdsAssocSampleAgeSampleNo.AsString;
          Node := TreeViewCum.Items.AddChild(TreeViewCum.Selected,tSampleNo);
          dmPDF.cdsAssocSampleAge.Next;
        until dmPDF.cdsAssocSampleAge.Eof;
        parentindex := Node.AbsoluteIndex;
      end;
      dmPDF.cdsAssocSampleAge.Filtered := false;
      //Node := TreeView1.Items.AddChild(TreeView1.Selected,dmGdwtmp.cdsRegRFlag.AsString);
      //Node := TreeView1.Items.AddChild(TreeView1.Selected,dmGdwtmp.cdsRegPFlag.AsString);
      dmPDF.cdsAgeList.Next;
    until dmPDF.cdsAgeList.Eof;
    dmPDF.cdsAssociations.Next;
  until dmPDF.cdsAssociations.Eof;
  dmPDF.cdsAssocSampleAge.Filtered := false;
end;

procedure TfmPDFMain.Button2Click(Sender: TObject);
begin
  SetIniFile;
end;

procedure TfmPDFMain.bRecordAVIClick(Sender: TObject);
var
  i, j : integer;
  iTimeDelay : integer;
  Video : TVideoTool;
begin
  i := ChartCum.SeriesList.Count;
  iTimeDelay := 200;
  try
    iTimeDelay := StrToInt(Trim(eTimeDelay.Text));
  except
    iTimeDelay := 200;
  end;
  eTimeDelay.Text := IntToStr(iTimeDelay);
  eTimeDelay.Refresh;
  for j := 0 to i-1 do
  begin
    ChartCum.Series[j].Visible := false;
  end;
  try
    Video := TVideoTool.Create(Self);
    Video.StartRecording('TestCumulative.avi');
    for j := i-1 downto 0 do
    begin
      ChartCum.Series[j].Visible := true;
      Delay(iTimeDelay);
    end;
    Video.StopRecording;
  finally
     //Video.FreeOnRelease;
  end;
end;

procedure TfmPDFMain.Delay(ms: integer);
var
  now: integer;
begin
  now := GetTickCount + ms;
  while GetTickCount < now do Application.ProcessMessages;
end;

procedure TfmPDFMain.CalculatePDF(GraphType : string; NormalisationType : string; tAge : double);
var
  i, k, l : integer;
  X1, X2, Y2 : double;
  tempmax : double;
  Spectrum2d : array[0..MaxSteps,1..2] of double;
  BinLimits : array[0..MaxBins] of double;
  BinCount : array[0..MaxBins] of integer;
  tx, tx1 : double;
  MinimumCurveValue : double;
  tempGauss : double;
  ExtraFactor : double;
  tmpBinWidth, tmpBinCentre : double;
  CumProb, MaxCumProb : double;
begin
  // GraphType = 'S' for single (all combined) probability distributions and histograms
  // GraphType = 'M' for multi-sample probability distributions
  // GraphType = 'C' for cumulate probability distributions
  dmPDF.cdsPDF.EmptyDataSet;
  dmPDF.cdsCum.EmptyDataSet;
  MinimumCurveValue := 0.0;
  for k := 0 to MaxSteps do
  begin
    Spectrum2d[k,1] := 0.0;
    Spectrum2d[k,2] := 0.0;
  end;
  sbMain.Panels[0].Text := Int2Str(NPts) + ' data';
  sbMain.Panels[3].Text := FormatFloat('###0.000',tAge);
  sbMain.Refresh;
  dmPDF.cdsRawData.DisableControls;
  dmPDF.cdsRawData.Filtered := false;
  if ((tAge >= 0.00) and (GraphType <> 'S')) then
  begin
    dmPDF.cdsRawData.Filter := 'UnitAge = '+FormatFloat('###0.000',tAge);
    dmPDF.cdsRawData.Filtered := true;
  end else
  begin
    dmPDF.cdsRawData.Filtered := false;
  end;
  dmPDF.cdsRawData.First;
  tmpBinWidth := (ToAge-FromAge)/(1.0*NumBins);
  BinLimits[0] := FromAge;
  for i := 1 to NumBins do
  begin
     BinLimits[i] := FromAge + tmpBinWidth*(1.0*i);
     BinCount[i] := 0;
  end;
  repeat
    tx := dmPDF.cdsRawDataData.AsFloat;
    tx1 := dmPDF.cdsRawDataSigma.AsFloat;
    if (tx1 < MinimumUncertainty) then tx1 := MinimumUncertainty;
    ExtraFactor := dmPDF.cdsRawDataExtra.AsFloat;
    if (ExtraFactor < zerofloat) then ExtraFactor := 1.0;
    for l := 0 to Steps do
    begin
      x1 := FromAge + 1.0*l*(ToAge-FromAge)/Steps;
      Spectrum2d[l,1] := x1;
      tempGauss := Gauss(x1,tx,tx1);
      if (PDFType = 'AND') then Spectrum2d[l,2] := Spectrum2d[l,2] + tempGauss;
      if (PDFType = 'ANDEXTRA') then Spectrum2d[l,2] := Spectrum2d[l,2] + tempGauss*ExtraFactor;
      if (PDFType = 'OR') then
      begin
        if (Spectrum2d[l,2] < tempGauss) then Spectrum2d[l,2] := tempGauss;
      end;
    end;
    i := NumBins;
    repeat
       if (tx >= BinLimits[i]) then
       begin
         BinCount[i+1] := BinCount[i+1] + 1;
       end;
       i := i - 1;
    until ((tx >= BinLimits[i+1]) or (i = 0));
    dmPDF.cdsRawData.Next;
  until dmPDF.cdsRawData.EOF;
  dmPDF.cdsHistogram.EmptyDataSet;
  //GraphTypeS - all samples together
  if (GraphType='S') then
  begin
    for i := 1 to NumBins do
    begin
      if (BinCount[i] < 0) then BinCount[i] := 0;
    end;
    dmPDF.cdsHistogram.DisableControls;
    i := 0;
    dmPDF.cdsHistogram.Append;
    dmPDF.cdsHistogramUnitAge.AsFloat := tAge;
    dmPDF.cdsHistogramStepSize.AsFloat := (BinLimits[2]-BinLimits[1]);
    dmPDF.cdsHistogramStep.AsInteger := i;
    dmPDF.cdsHistogramBinCentre.AsFloat := FromAge;
    dmPDF.cdsHistogramNumCount.AsInteger := 0;
    dmPDF.cdsHistogram.Post;
    i := 1;
    repeat
       dmPDF.cdsHistogram.Append;
       dmPDF.cdsHistogramUnitAge.AsFloat := tAge;
       dmPDF.cdsHistogramStepSize.AsFloat := (BinLimits[i]-BinLimits[i-1]);
       dmPDF.cdsHistogramStep.AsInteger := i;
       tmpBinCentre := BinLimits[i-1]+(BinLimits[i]-BinLimits[i-1])/2.0;
       dmPDF.cdsHistogramBinCentre.AsFloat := tmpBinCentre;
       dmPDF.cdsHistogramNumCount.AsInteger := BinCount[i];
       dmPDF.cdsHistogram.Post;
       i := i + 1;
    until i >= NumBins;
    i := NumBins;
    dmPDF.cdsHistogram.Append;
    dmPDF.cdsHistogramUnitAge.AsFloat := tAge;
    dmPDF.cdsHistogramStepSize.AsFloat := (BinLimits[2]-BinLimits[1]);
    dmPDF.cdsHistogramStep.AsInteger := i;
    dmPDF.cdsHistogramBinCentre.AsFloat := ToAge;
    dmPDF.cdsHistogramNumCount.AsInteger := 0;
    dmPDF.cdsHistogram.Post;
    dmPDF.cdsHistogram.First;
    sbMain.Panels[0].Text := Int2Str(NPts) + ' data';
    sbMain.Panels[1].Text := 'Histogram calculated';
  end;
  sbMain.Refresh;
  tempmax := 0.0;
  for k := 0 to Steps do
  begin
    if (tempmax < Spectrum2d[k,2]) then tempmax := Spectrum2d[k,2];
  end;
  if (tempmax <= 0.0) then tempmax := 1.0e-9;
  if (NormalisationType = nt100Percent) then
  begin
    tempmax := 100.0/tempmax;
  end;
  if (NormalisationType = ntTrueProbability) then
  begin
    tempmax := 1.0*Npts;
    if (PDFType = 'AND') then
    begin
      tempmax := 1.0/tempmax;
    end;
    if (PDFType = 'OR') then
    begin
      tempmax := 1.0;
    end;
    if (PDFType = 'ANDEXTRA') then
    begin
      tempmax := 1.0/tempmax;
    end;
  end;
  if (tempmax <= 0.0) then tempmax := 1.0e-9;
  //ShowMessage(NormalisationType+'  '+FormatFloat('####0.000000',tempmax));
  dmPDF.cdsRawData.First;
  dmPDF.cdsPDF.DisableControls;
  dmPDF.cdsCum.DisableControls;
  sbMain.Panels[0].Text := Int2Str(NPts) + ' data';
  sbMain.Panels[1].Text := 'Creating PDF';
  sbMain.Refresh;
  //output to clientdataset
  for k := 0 to Steps do
  begin
    dmPDF.cdsPDF.Append;
    dmPDF.cdsPDFUnitAge.AsFloat := tAge;
    dmPDF.cdsPDFStep.AsInteger := k;
    x2 := Spectrum2d[k,1];
    y2 := Spectrum2d[k,2] * tempmax;
    if (y2 < MinimumCurveValue) then y2 := 0.0;
    dmPDF.cdsPDFPDFDataValue.AsFloat := x2;
    dmPDF.cdsPDFPDFValue.AsFloat := y2;
  end;
  dmPDF.cdsPDF.First;
  //GraphTypeC - cumulate probability
  if (GraphType='C') then
  begin
    CumProb := 0.0;
    MaxCumProb := 0.0;
    for k := 0 to Steps do
    begin
      dmPDF.cdsCum.Append;
      dmPDF.cdsCumUnitAge.AsFloat := tAge;
      dmPDF.cdsCumStep.AsInteger := k;
      x2 := Spectrum2d[k,1];
      y2 := Spectrum2d[k,2] * tempmax;
      if (y2 < MinimumCurveValue) then y2 := 0.0;
      CumProb := CumProb + y2;
      if (CumProb > MaxCumProb) then MaxCumProb := CumProb;
      dmPDF.cdsCumPDFDataValue.AsFloat := x2;
      dmPDF.cdsCumCumValue.AsFloat := CumProb;
    end;
    dmPDF.cdsPDF.First;
    dmPDF.cdsCum.First;
    repeat
      dmPDF.cdsCum.Edit;
      dmPDF.cdsCumCumValue.AsFloat := dmPDF.cdsCumCumValue.AsFloat*100.0/MaxCumProb;
      dmPDF.cdsCum.Post;
      dmPDF.cdsCum.Next;
    until dmPDF.cdsCum.Eof;
    dmPDF.cdsCum.First;
    dmPDF.cdsRawData.EnableControls;
    dmPDF.cdsHistogram.EnableControls;
    dmPDF.cdsPDF.EnableControls;
    dmPDF.cdsCum.EnableControls;
  end;
end;

procedure TfmPDFMain.ApplySelectedThemeToCharts(CurrentStyle : string);
begin
  pc1.ActivePage := tsControl;
  //TStyleManager.TrySetStyle(MyCurrentStyle);
  TSystemTheme.ApplyStyle(ChartOriginalData);
  TSystemTheme.ApplyStyle(DBChart1);
  TSystemTheme.ApplyStyle(ChartPDF);
  TSystemTheme.ApplyStyle(ChartCum);
  TSystemTheme.ApplyStyle(ChartGeotectonic);
  TSystemTheme.ApplyStyle(ChartHeat);
end;

end.


