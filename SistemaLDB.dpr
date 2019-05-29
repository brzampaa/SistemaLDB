program SistemaLDB;

uses
  Vcl.Forms,
  LDB.VCL.Menu in 'src\LDB.VCL.Menu.pas' {FrmMenu},
  Vcl.Themes,
  Vcl.Styles;

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Iceberg Classico');
  Application.CreateForm(TFrmMenu, FrmMenu);
  Application.Run;
end.
