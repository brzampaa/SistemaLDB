unit LDB.VCL.Itens;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, StrUtils;

type
  TfrmItens = class(TForm)
    Image1: TImage;
    pgcItens: TPageControl;
    TabSheet1: TTabSheet;
    Movimenta��o: TTabSheet;
    lblID: TLabel;
    txtID: TEdit;
    txtDescricao: TEdit;
    lblDescricao: TLabel;
    txtPrecoCusto: TEdit;
    lblCusto: TLabel;
    txtPrecoVenda: TEdit;
    lblCenda: TLabel;
    lblMargem: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    lblCifra: TLabel;
    Label1: TLabel;
    procedure txtPrecoVendaExit(Sender: TObject);
    procedure txtPrecoVendaKeyPress(Sender: TObject; var Key: Char);
    procedure txtPrecoCustoExit(Sender: TObject);
    procedure txtPrecoCustoKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmItens: TfrmItens;

implementation

{$R *.dfm}

procedure TfrmItens.txtPrecoCustoExit(Sender: TObject);
var
  res : double;
begin
  txtPrecoCusto.Text := formatfloat('##,.00',(strToFloat(txtPrecoCusto.Text)));
  if (txtPrecoCusto.Text <> '') AND (txtPrecoVenda.Text <> '') then
  begin
    res := ((strToFloat(txtPrecoVenda.Text)*100)/strToFloat(txtPrecoCusto.Text))-100;
    if res < 0 then
    begin
      lblMargem.Caption := formatfloat('##0,.##'   , res) + '%';
      lblMargem.Font.Color := clRED;
    end
    else
    begin
      lblMargem.Caption := '+'+formatfloat('#0,.##'   , res) + '%';
      lblMargem.Font.Color := clGREEN;
    end;
  end;
end;

procedure TfrmItens.txtPrecoCustoKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9',',',#8]) then Key := #0;
  if Key = ',' then
  begin
    if pos(',',txtPrecoCusto.Text) > 0 then Key := #0 ;
  end;
end;

procedure TfrmItens.txtPrecoVendaExit(Sender: TObject);
var
  res : double;
begin
  txtPrecoVenda.Text := formatfloat('##,.00',(strToFloat(txtPrecoVenda.Text)));
  if (txtPrecoVenda.Text <> '') AND (txtPrecoCusto.Text <> '') then
  begin
    res := ((strToFloat(txtPrecoVenda.Text)*100)/strToFloat(txtPrecoCusto.Text))-100;
    if res < 0 then
    begin
      lblMargem.Caption := formatfloat('##0,.##'   , res) + '%';
      lblMargem.Font.Color := clRED;
    end
    else
    begin

      lblMargem.Caption := '+'+formatfloat('#0,.##'   , res) + '%';
      lblMargem.Font.Color := clGREEN;
    end;
  end;
end;

procedure TfrmItens.txtPrecoVendaKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in ['0'..'9',',',#8]) then Key := #0;
  if Key = ',' then
  begin
    if pos(',',txtPrecoVenda.Text) > 0 then Key := #0 ;
  end;
end;

end.