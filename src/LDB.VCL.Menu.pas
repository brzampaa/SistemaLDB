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
    Sada1: TMenuItem;
    Relatrios1: TMenuItem;
    Estoque2: TMenuItem;
    Pedidos2: TMenuItem;
    Cientes1: TMenuItem;
    Image1: TImage;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    lblClientes: TLabel;
    lblPedidos: TLabel;
    lblEstoque: TLabel;
    lblRelatorios: TLabel;
    procedure Novo1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMenu: TFrmMenu;

implementation

{$R *.dfm}

procedure TFrmMenu.Novo1Click(Sender: TObject);
begin
  showMessage('Novo Pedido');
end;

end.
