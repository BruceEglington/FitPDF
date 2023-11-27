unit PDF_dm;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  Data.DB,
  WideStrings, FMTBcd, SqlExpr,
  midaslib, VCL.FlexCel.Core,
  Datasnap.DBClient, NumRecipes, NumRecipes_varb, Vcl.BaseImageCollection,
  Vcl.ImageCollection, SVGIconImageCollection;

type
  TdmPDF = class(TDataModule)
    cdsRawData: TClientDataSet;
    cdsRawDataData: TFloatField;
    cdsRawDataSigma: TFloatField;
    dsRawData: TDataSource;
    cdsPDF: TClientDataSet;
    cdsPDFStep: TIntegerField;
    cdsPDFPDFDataValue: TFloatField;
    cdsPDFPDFValue: TFloatField;
    dsPDF: TDataSource;
    cdsHistogram: TClientDataSet;
    dsHistogram: TDataSource;
    cdsHistogramStep: TIntegerField;
    cdsHistogramBinCentre: TFloatField;
    cdsHistogramNumCount: TIntegerField;
    cdsRawDataUnitAge: TFloatField;
    cdsPDFUnitAge: TFloatField;
    cdsHistogramUnitAge: TFloatField;
    cdsGrainData: TClientDataSet;
    cdsGrainDataStepID: TIntegerField;
    cdsGrainDataUnitAge: TFloatField;
    cdsGrainDataGrainAge: TFloatField;
    cdsGrainDataPDFvalue: TFloatField;
    dsGrainData: TDataSource;
    dsAgeList: TDataSource;
    cdsHistogramStepSize: TFloatField;
    cdsRawDatai: TIntegerField;
    cdsRawDataExtra: TFloatField;
    cdsCum: TClientDataSet;
    dsCum: TDataSource;
    cdsCumUnitAge: TFloatField;
    cdsCumStep: TIntegerField;
    cdsCumPDFDataValue: TFloatField;
    cdsCumCumValue: TFloatField;
    cdsAgeList: TClientDataSet;
    cdsAgeListUnitAge: TFloatField;
    cdsAgeListClassification: TStringField;
    cdsAgeListClassNum: TIntegerField;
    cdsSelectedGrainData: TClientDataSet;
    dsSelectedGrainData: TDataSource;
    cdsSelectedGrainDataUnitAge: TFloatField;
    cdsSelectedGrainDataStepID: TIntegerField;
    cdsSelectedGrainDataGrainAge: TFloatField;
    cdsSelectedGrainDataPDFValue: TFloatField;
    cdsSelectedGrainDataClusterID: TIntegerField;
    cdsClusterLimits: TClientDataSet;
    dsClusterLimits: TDataSource;
    cdsClusterLimitsUnitAge: TFloatField;
    cdsClusterLimitsClusterMaxAge: TFloatField;
    cdsClusterLimitsClusterMinAge: TFloatField;
    cdsClusterLimitsClusterID: TIntegerField;
    cdsRawDataSampleNo: TStringField;
    cdsRawDataFrac: TStringField;
    cdsAssocSampleAge: TClientDataSet;
    dsAssocSampleAge: TDataSource;
    cdsAssocSampleAgeAssociation: TStringField;
    cdsAssocSampleAgeSampleNo: TStringField;
    cdsAssocSampleAgeDeposAge: TFloatField;
    ImageCollection1: TImageCollection;
    cdsRawDataAssoc: TStringField;
    cdsAssociations: TClientDataSet;
    dsAssociations: TDataSource;
    cdsSamples: TClientDataSet;
    dsSamples: TDataSource;
    cdsSamplesSampleNo: TStringField;
    cdsAssociationsAssociation: TStringField;
    SVGIconImageCollection1: TSVGIconImageCollection;
  private
    { Private declarations }
  public
    { Public declarations }
    ChosenStyle : string;
    SigmaFactor : double;
    //ExtraVarCutoff : double;
    ExtraVarCutoffMin : double;
    ExtraVarCutoffMax : double;
    //ExtraVarGTLT : string;
    ExtraVarName : string;
    DataImported : boolean;
    ChosenCutoff : double;
    function kde(data : array of double; n : integer; Min,Max : double) : double;
    function densitybe(xmesh : array of double) : double;
    function SetBandwidth(xarray : narray) : double;
  end;

var
  dmPDF: TdmPDF;

implementation

uses RecError;

{$R *.DFM}


function TdmPDF.kde(data : array of double; n : integer; Min,Max : double) : double;
//Reliable and extremely fast kernel density estimator for one-dimensional data;
//        Gaussian kernel is assumed and the bandwidth is chosen automatically;
//        Unlike many other implementations, this one is immune to problems
//        caused by multimodal densities with widely separated modes (see example). The
//        estimation does not deteriorate for multimodal densities, because we never assume
//        a parametric model for the data.
// INPUTS:
//     data    - a vector of data from which the density estimate is constructed;
//          n  - the number of mesh points used in the uniform discretization of the
//               interval [MIN, MAX]; n has to be a power of two; if n is not a power of two, then
//               n is rounded up to the next power of two, i.e., n is set to n=2^ceil(log2(n));
//               the default value of n is n=2^12;
//   MIN, MAX  - defines the interval [MIN,MAX] on which the density estimate is constructed;
//               the default values of MIN and MAX are:
//               MIN=min(data)-Range/10 and MAX=max(data)+Range/10, where Range=max(data)-min(data);
// OUTPUTS:
//   bandwidth - the optimal bandwidth (Gaussian kernel assumed);
//     density - column vector of length 'n' with the values of the density
//               estimate at the grid points;
//     xmesh   - the grid over which the density estimate is computed;
//             - If no output is requested, then the code automatically plots a graph of
//               the density estimate.
//        cdf  - column vector of length 'n' with the values of the cdf
//  Reference:
// Kernel density estimation via diffusion
// Z. I. Botev, J. F. Grotowski, and D. P. Kroese (2010)
// Annals of Statistics, Volume 38, Number 5, pages 2916-2957.begin
begin
  //
end;

{
    public void setBandwidth(double[] x, boolean auto) throws Exception{
        int N = unique(x); // number of unique data points
        Arrays.sort(x);
        double[] xmesh = getMesh(x[0],x[x.length-1]);
        double R = xmesh[xmesh.length-1]-xmesh[0];
        double[] initial_data = arrayDiv(histc(x,xmesh),x.length);
        double[] a = dct1d(initial_data);
        double tstar = auto ? fsolve(a,N) : (bandwidth*bandwidth)/(R*R);
        bandwidth = Math.sqrt(tstar)*R;
}
function TdmPDF.SetBandwidth(xarray : narray) : double;
var
  yarray : narray;
  nUnique : integer;
begin
  //nUnique := GetNumUniqueRecords(xarray};
  Sort2(nUnique,xarray,yarray);
  //R := Xmax - Xmin;

end;

function TdmPDF.densitybe(xmesh : array of double) : double;
var
  n, NN : integer;
  R : double;
  a, t_star : double;
  a_t : double;
begin
  NN := n;
  R := xmesh[length(xmesh)-1]-xmesh[0];
  //a := dct1d(initial_data);
  //tstar :=
  //a_t := get+A_t(a,n,tstar);
  //density := arrayDiv(density,R);
  //bandwidth := sqrt(tstar)*R;
end;

function a_t(a : double; n : integer; tstar : double) : double;
var
  i : integer;
begin
  a_t := 1.0 * n;
  for i := 0 to n do
  begin
    //a_t[i] := a[i]*exp(-1*i*pi*pi*tstar/2.0;
  end;
end;

{
    private static double[] dct1d(double[] data) throws Exception {
        // computes the discrete cosine transform of the column vector data
        int n = data.length;
        double gamma;
        Complex[] data2 = new Complex[n];
        // Compute weights to multiply DFT coefficients
        Complex[] weight = new Complex[n];
        weight[0] = new Complex(1,0);
        for (int i=1; i<n; i++){
            gamma = -i*Math.PI/(2*n);
            weight[i] = new Complex(2*Math.cos(gamma),2*Math.sin(gamma));

        // Re-order the elements of the columns of x
        for (int i=0; i<n/2; i++)
            data2[i] = new Complex(data[2*i],0);
            data2[n/2+i] = new Complex(data[n-1-2*i],0);

        // Multiply FFT by weights:
        Complex[] fft = FFT.fft(data2);
        Complex[] weightedData = arrayMultiply(weight,fft);
        return arrayReal(weightedData);
}

{
function get_NN;
var
  i, n : integer;
begin
  //n :=length(data);
  N := 1;
  //sorteddata := data;
  for i := 1 to n do
  begin
    //if (sorteddata[i] <> sorteddata[i-1]) then NN := NN+1;
  end;
end;
}

{
procedure arrayDiv(data : array; NN : double);
var
  i, n : Integer;
begin
  n := length(data);
  nout := 1.0*n;
  for i := 0 to n do
  begin
    data[i] := data[i]/n;
  end;
end;

procedure arrayMultiply(data : array; NN : double);
var
  i: Integer;
begin
  //need to change
  n := length(data);
  nout := 1.0*n;
  for i := 0 to n do
  begin
    data[i] := data[i]/n;
  end;
end;
}


end.
