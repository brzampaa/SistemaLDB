unit LDB.VCL.Clientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls;

type
  TFrmClientes = class(TForm)
    Image1: TImage;
    pgcClientes: TPageControl;
    pgPesquisar: TTabSheet;
    pgNovo: TTabSheet;
    dbgClientes: TDBGrid;
    lblPesquisar: TLabel;
    txtPesquisar: TEdit;
    cbxCategoria: TComboBox;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmClientes: TFrmClientes;

implementation

{$R *.dfm}

uses LBD.SQL.DataModule;

end.
