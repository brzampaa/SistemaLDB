program SistemaLDB;

uses
  Vcl.Forms,
  LDB.VCL.Menu in 'src\LDB.VCL.Menu.pas' {FrmMenu},
  Vcl.Themes,
  Vcl.Styles,
  LDB.VCL.Clientes in 'src\LDB.VCL.Clientes.pas' {FrmClientes},
  LDB.SQL.DataModule in 'src\LDB.SQL.DataModule.pas' {dm: TDataModule},
  LDB.Cliente in 'src\LDB.Cliente.pas',
  LDB.VCL.Estoque in 'src\LDB.VCL.Estoque.pas' {frmEstoque},
  LDB.Item in 'src\LDB.Item.pas',
  LDB.VCL.Itens in 'src\LDB.VCL.Itens.pas' {frmItens};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  TStyleManager.TrySetStyle('Iceberg Classico');
  Application.CreateForm(TFrmMenu, FrmMenu);
  Application.CreateForm(TFrmClientes, FrmClientes);
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TfrmEstoque, frmEstoque);
  Application.CreateForm(TfrmItens, frmItens);
  Application.Run;
end.
