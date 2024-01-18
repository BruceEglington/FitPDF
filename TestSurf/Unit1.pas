unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, VclTee.TeeGDIPlus, VCLTee.TeEngine,
  VCLTee.TeeSurfa, VCLTee.TeeEdit, VCLTee.TeeComma, Vcl.ExtCtrls,
  VCLTee.TeeProcs, VCLTee.Chart, VCLTee.TeePoin3, VCLTee.TeeTriSurface;

type
  TForm1 = class(TForm)
    Chart1: TChart;
    TeeCommander1: TTeeCommander;
    ChartEditor1: TChartEditor;
    Series1: TTriSurfaceSeries;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.FormShow(Sender: TObject);
var
  x, y, z : double;
  x1, y1, z1 : double;
  x2, y2, z2 : double;
  y1start : double;
  i : integer;
begin
  Series1.Clear;
  //Series1.IrregularGrid := true;
  //Series2.Clear;
  y1start := 0.0;
  x1 := 0.0;
  y1 := 0.0;
  z1 := 0.0;
  x2 := 50.0;
  y2 := 50.0;
  z2 := 0.0;
  repeat
    z1 := sin(x1 * pi/180.0);
    y1 := y1start;
    repeat
      y1 := y1 + 1;
      Series1.AddXYZ(x1,z1,y1);
    until y1 > 50.0;;
    //Series2.AddXY(x1,z1);
    x1 := x1 + 10.0;
    //y1 := y;
    z2 := cos(x2);
    x2 := x2 + 1.0;
    y2 := y2 + 1.0;
    x := x1;
    y := y2;
    z := z1 + z2;
  until x1 > 360.0;

end;

end.
