unit LDB.VCL.Menu;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.Menus, Vcl.Imaging.pngimage,
  Vcl.ExtCtrls, Vcl.Buttons, Vcl.StdCtrls;

type
  TFrmMenu = class(TForm)
    MainMenu1: TMainMenu;
    Cadastros1: TMenuItem;
    Clientes1: TMenuItem;
    Items1: TMenuItem;
    Pedidos1: TMenuItem;
    Estoque1: TMenuItem;
    Novo1: TMenuItem;
    Pesquisar1: TMenuItem;
    Entrada1: TMenuItem;
    Relatrios1: TMenuItem;
    Estoque2: TMenuItem;
    Pedidos2: TMenuItem;
    Cientes1: TMenuItem;
    imgBkp: TImage;
    btnClientes: TSpeedButton;
    btnPedidos: TSpeedButton;
    btnEstoque: TSpeedButton;
    btnRelatorios: TSpeedButton;
    lblClientes: TLabel;
    lblPedidos: TLabel;
    lblEstoque: TLabel;
    lblRelatorios: TLabel;
    Cadastraritem1: TMenuItem;
    procedure Novo1Click(Sender: TObject);
    procedure btnClientesClick(Sender: TObject);
    procedure Clientes1Click(Sender: TObject);
    procedure Items1Click(Sender: TObject);
    procedure btnEstoqueClick(Sender: TObject);
    procedure btnPedidosClick(Sender: TObject);
    procedure Pesquisar1Click(Sender: TObject);
    procedure Cadastraritem1Click(Sender: TObject);
    procedure btnRelatoriosClick(Sender: TObject);
    procedure Cientes1Click(Sender: TObject);
    procedure Estoque2Click(Sender: TObject);
    procedure Pedidos2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMenu: TFrmMenu;

implementation

{$R *.dfm}

uses LDB.VCL.Clientes, LDB.VCL.Estoque, LDB.VCL.Itens;

procedure TFrmMenu.btnClientesClick(Sender: TObject);
begin
  FrmClientes := TFrmClientes.Create(self);
  FrmClientes.ShowModal;
end;

procedure TFrmMenu.btnEstoqueClick(Sender: TObject);
begin
  frmEstoque := TfrmEstoque.Create(self);
  frmEstoque.ShowModal;
end;

procedure TFrmMenu.btnPedidosClick(Sender: TObject);
begin
  showMessage('Novo Pedido');
end;

procedure TFrmMenu.btnRelatoriosClick(Sender: TObject);
begin
  showMessage('Relatórios');
end;

procedure TFrmMenu.Cadastraritem1Click(Sender: TObject);
begin
  frmItens := TfrmItens.Create(self);
  frmItens.ShowModal;
end;

procedure TFrmMenu.Cientes1Click(Sender: TObject);
begin
  showMessage('Relatório Clientes');
end;

procedure TFrmMenu.Clientes1Click(Sender: TObject);
begin
  FrmClientes := TFrmClientes.Create(self);
  FrmClientes.novoCliente;
  FrmClientes.ShowModal;
end;

procedure TFrmMenu.Estoque2Click(Sender: TObject);
begin
  showMessage('Relatório Estoque');
end;

procedure TFrmMenu.Items1Click(Sender: TObject);
begin
  FrmClientes := TFrmClientes.Create(self);
  FrmClientes.ShowModal;
end;

procedure TFrmMenu.Novo1Click(Sender: TObject);
begin
  showMessage('Novo Pedido');
end;

procedure TFrmMenu.Pedidos2Click(Sender: TObject);
begin
  showMessage('Relatório Pedidos');
end;

procedure TFrmMenu.Pesquisar1Click(Sender: TObject);
begin
  showMessage('Buscar Pedido');
end;

end.
