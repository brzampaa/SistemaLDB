program SistemaLDB;

uses
  Vcl.Forms,
  LDB.VCL.Menu in 'src\LDB.VCL.Menu.pas' {FrmMenu},
  Vcl.Themes,
  Vcl.Styles,
  LDB.VCL.Clientes in 'src\LDB.VCL.Clientes.pas' {FrmClientes},
  LBD.SQL.DataModule in 'src\LBD.SQL.DataModule.pas' {dm: TDataModule},
  LDB.Cliente in 'src\LDB.Cliente.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Iceberg Classico');
  Application.CreateForm(TFrmMenu, FrmMenu);
  Application.CreateForm(TFrmClientes, FrmClientes);
  Application.CreateForm(Tdm, dm);
  Application.Run;
end.
