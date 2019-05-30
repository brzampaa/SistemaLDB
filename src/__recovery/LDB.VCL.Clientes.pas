unit LDB.VCL.Clientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask;

type
  TFrmClientes = class(TForm)
    imgBkg: TImage;
    pgcClientes: TPageControl;
    pgPesquisar: TTabSheet;
    pgNovo: TTabSheet;
    dbgClientes: TDBGrid;
    lblPesquisar: TLabel;
    txtPesquisar: TEdit;
    cbxCategoria: TComboBox;
    lblID: TLabel;
    txtID: TEdit;
    cbxTitulo: TComboBox;
    lblTitulo: TLabel;
    lblNome: TLabel;
    txtNome: TEdit;
    lblSobrenome: TLabel;
    txtSobrenome: TEdit;
    lblEndereco: TLabel;
    txtEndereco: TEdit;
    lblNumero: TLabel;
    txtNumero: TEdit;
    txtComplemento: TEdit;
    lblComplemento: TLabel;
    txtCidade: TEdit;
    lblCidade: TLabel;
    cbxEstado: TComboBox;
    lblEstado: TLabel;
    lblCEP: TLabel;
    txtCEP: TMaskEdit;
    txtTelefone: TMaskEdit;
    txtCelular: TMaskEdit;
    lblTelefone: TLabel;
    lblCelular: TLabel;
    btnSalvar: TButton;
    btnEditar: TButton;
    btnCancelar: TButton;
    procedure txtPesquisarKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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

procedure TFrmClientes.FormCreate(Sender: TObject);
begin
  pgcClientes.TabIndex := 0;
end;

procedure TFrmClientes.FormShow(Sender: TObject);
begin
  LBD.SQL.DataModule.dm.Query.Open;
end;

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
        SQL.Add('SELECT id_cliente AS ID, CONCAT(nome, " ", sobrenome) AS Cliente, endereco AS Endereço, fone_fixo AS Telefone FROM tb_cliente WHERE nome LIKE "' + txtPesquisar.Text + '%"');
      end;
      1://Endereço
      begin
        SQL.Add('SELECT id_cliente AS ID, CONCAT(nome, " ", sobrenome) AS Cliente, endereco AS Endereço, fone_fixo AS Telefone FROM tb_cliente WHERE endereco LIKE "' + txtPesquisar.Text + '%"');
      end;
      2://Telefone
      begin
        SQL.Add('SELECT id_cliente AS ID, CONCAT(nome, " ", sobrenome) AS Cliente, endereco AS Endereço, fone_fixo AS Telefone FROM tb_cliente WHERE fone_fixo LIKE "' + txtPesquisar.Text + '%"');
      end;
    end;
    Open;
  end;
end;

end.