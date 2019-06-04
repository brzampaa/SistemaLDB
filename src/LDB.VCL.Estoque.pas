unit LDB.VCL.Estoque;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Buttons;

type
  TfrmEstoque = class(TForm)
    imgBkpEstoque: TImage;
    DBGrid1: TDBGrid;
    btnEntrada: TSpeedButton;
    btnSaida: TSpeedButton;
    btnEstNovo: TSpeedButton;
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEstoque: TfrmEstoque;

implementation

{$R *.dfm}

uses LBD.SQL.DataModule;

procedure TfrmEstoque.FormShow(Sender: TObject);
begin
  LBD.SQL.DataModule.dm.QueryEstoque.Open();
end;

end.
