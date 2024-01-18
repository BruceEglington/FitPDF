program Project41;

uses
  Vcl.Forms,
  Unit22 in 'Unit22.pas' {Form22},
  UCellReader in 'UCellReader.pas',
  USparseArray in 'USparseArray.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm22, Form22);
  Application.Run;
end.
