unit LDB.VCL.Clientes;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Data.DB, Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.Mask, LDB.Cliente,
  Vcl.Buttons, System.ImageList, Vcl.ImgList;

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
    btnSalvar: TSpeedButton;
    btnEditar: TSpeedButton;
    btnCancelar: TSpeedButton;
    btnNovo: TSpeedButton;
    procedure txtPesquisarKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure dbgClientesDblClick(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure pgPesquisarShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    procedure mostrarCliente;
    procedure desativarCampos;
    procedure ativarCampos;
  public
    procedure novoCliente;
    { Public declarations }
  end;

var
  FrmClientes: TFrmClientes;
  c : TCliente;

implementation

{$R *.dfm}

uses LBD.SQL.DataModule;

procedure TFrmClientes.ativarCampos;
begin
  cbxTitulo.Enabled := True;
  txtNome.Enabled := True;
  txtSobrenome.Enabled := True;
  txtTelefone.Enabled := True;
  txtCelular.Enabled := True;
  txtEndereco.Enabled := True;
  txtNumero.Enabled := True;
  txtComplemento.Enabled := True;
  txtCidade.Enabled := True;
  cbxEstado.Enabled := True;
  txtCEP.Enabled := True;
end;

procedure TFrmClientes.btnCancelarClick(Sender: TObject);
begin
  if c <> nil then
  begin
    mostrarCliente;
    desativarCampos;
    btnCancelar.Enabled := False;
    btnSalvar.Enabled := False;
    btnEditar.Enabled := True;
    btnNovo.Enabled := True;
  end
  else
  begin
    ModalResult := mrOk;
  end;
end;

procedure TFrmClientes.btnEditarClick(Sender: TObject);
begin
  ativarCampos;
  btnCancelar.Enabled := True;
  btnSalvar.Enabled := True;
  btnEditar.Enabled := False;
  btnNovo.Enabled := False;
end;

procedure TFrmClientes.btnSalvarClick(Sender: TObject);
var
  Cli : TCliente;
begin
  Cli := TCliente.Create;
  Cli.IdCliente := strToInt(txtID.Text);
  Cli.Titulo := cbxTitulo.Items[cbxTitulo.ItemIndex];
  Cli.Nome := txtNome.Text;
  Cli.Sobrenome := txtSobrenome.Text;
  Cli.Telefone := txtTelefone.Text;
  Cli.Celular := txtCelular.Text;
  Cli.Endereco := txtEndereco.Text;
  Cli.Numero := txtNumero.Text;
  Cli.Complemento := txtComplemento.Text;
  Cli.Cidade := txtCidade.Text;
  Cli.Estado := cbxEstado.Items[cbxEstado.ItemIndex];
  Cli.CEP := txtCEP.Text;

  if TCliente.Create.atualizar(Cli) then
  begin
    messageDlg('Cliente atualizado com sucesso!', mtInformation, [mbOk], 0);
    desativarCampos;
    btnSalvar.Enabled := False;
    btnEditar.Enabled := True;
    btnCancelar.Enabled := False;
    btnNovo.Enabled := True;
  end;
end;

procedure TFrmClientes.dbgClientesDblClick(Sender: TObject);
begin
  c := TCliente.Create.pesquisar(strToInt(dbgClientes.Columns.Items[0].Field.Text));
  mostrarCliente;
end;

procedure TFrmClientes.desativarCampos;
begin
  cbxTitulo.Enabled := False;
  txtNome.Enabled := False;
  txtSobrenome.Enabled := False;
  txtTelefone.Enabled := False;
  txtCelular.Enabled := False;
  txtEndereco.Enabled := False;
  txtNumero.Enabled := False;
  txtComplemento.Enabled := False;
  txtCidade.Enabled := False;
  cbxEstado.Enabled := False;
  txtCEP.Enabled := False;
end;

procedure TFrmClientes.FormClose(Sender: TObject; var Action: TCloseAction);
begin
if c <> nil then
begin
  c.Free;
end;
end;

procedure TFrmClientes.FormCreate(Sender: TObject);
var
  bmp: TBitmap;
begin
  pgcClientes.TabIndex := 0;
  dbgClientes.EditorMode := False;
end;

procedure TFrmClientes.mostrarCliente;
var
  i : Integer;
begin
  txtID.Text := intToStr(c.IdCliente);
  cbxTitulo.ItemIndex := cbxTitulo.Items.IndexOf(c.Titulo);
  txtNome.Text := c.Nome;
  txtSobrenome.Text := c.Sobrenome;
  txtTelefone.Text := c.Telefone;
  txtCelular.Text := c.Celular;
  txtEndereco.Text := c.Endereco;
  txtNumero.Text := c.Numero;
  txtComplemento.Text := c.Complemento;
  txtCidade.Text := c.Cidade;
  cbxEstado.ItemIndex := cbxEstado.Items.IndexOf(c.Estado);
  txtCEP.Text := c.CEP;
  pgcClientes.TabIndex := 1;
end;

procedure TFrmClientes.novoCliente;
begin
  pgcClientes.TabIndex := 1;
  btnNovo.Enabled := False;
  btnSalvar.Enabled := True;
  btnEditar.Enabled := False;
  btnCancelar.Enabled := True;
  ativarCampos;
end;

procedure TFrmClientes.pgPesquisarShow(Sender: TObject);
begin
  with LBD.SQL.DataModule.dm.Query do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT id_cliente AS ID, CONCAT(nome, " ", sobrenome) AS Cliente, endereco AS Endere�o, fone_fixo AS Telefone FROM tb_cliente');
    Open;
  end;
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
