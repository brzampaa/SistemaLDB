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
    procedure txtPesquisarKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
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

procedure TFrmClientes.txtPesquisarKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  with LBD.SQL.DataModule.dm.Query do
  begin
    Close;
    SQL.Clear;
    case cbxCategoria.ItemIndex of
      0://Nome
      begin  
        SQL.Add('SELECT id_cliente AS ID, CONCAT(nome, " ", sobrenome) AS Cliente, endereco AS Endere�o, fone_fixo AS Telefone FROM tb_cliente WHERE nome LIKE "' + txtPesquisar.Text + '%"');
      end;
      1://Endere�o
      begin
        SQL.Add('SELECT id_cliente AS ID, CONCAT(nome, " ", sobrenome) AS Cliente, endereco AS Endere�o, fone_fixo AS Telefone FROM tb_cliente WHERE endereco LIKE "' + txtPesquisar.Text + '%"');
      end;
      2://Telefone
      begin
        SQL.Add('SELECT id_cliente AS ID, CONCAT(nome, " ", sobrenome) AS Cliente, endereco AS Endere�o, fone_fixo AS Telefone FROM tb_cliente WHERE fone_fixo LIKE "' + txtPesquisar.Text + '%"');
      end;
    end;
    Open;
  end;
end;

end.
