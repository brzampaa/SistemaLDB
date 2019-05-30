program SistemaLDB;

uses
  Vcl.Forms,
  LDB.VCL.Menu in 'src\LDB.VCL.Menu.pas' {FrmMenu},
  Vcl.Themes,
  Vcl.Styles,
  LDB.VCL.Clientes in 'src\LDB.VCL.Clientes.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Iceberg Classico');
  Application.CreateForm(TFrmMenu, FrmMenu);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
