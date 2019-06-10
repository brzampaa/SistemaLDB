unit LDB.VCL.Estoque;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.Imaging.pngimage, Vcl.ExtCtrls, Vcl.Buttons, Vcl.StdCtrls;

type
  TfrmEstoque = class(TForm)
    imgBkpEstoque: TImage;
    dbgItens: TDBGrid;
    btnEstNovo: TSpeedButton;
    txtProduto: TEdit;
    lblEstoquePesquisa: TLabel;
    procedure FormShow(Sender: TObject);
    procedure txtProdutoKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnEstNovoClick(Sender: TObject);
    procedure dbgItensDblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmEstoque: TfrmEstoque;

implementation

{$R *.dfm}

uses LDB.SQL.DataModule, LDB.VCL.Itens;

procedure TfrmEstoque.btnEstNovoClick(Sender: TObject);
begin
  frmItens := TfrmItens.Create(self);
  frmItens.ShowModal;
end;

procedure TfrmEstoque.dbgItensDblClick(Sender: TObject);
begin
  frmItens := TfrmItens.Create(self);
  frmItens.IdItem := strToInt(dbgItens.Columns.Items[0].Field.Text);
  frmItens.ShowModal;
end;

procedure TfrmEstoque.FormShow(Sender: TObject);
begin
  LDB.SQL.DataModule.dm.QueryEstoque.Open();
end;

procedure TfrmEstoque.txtProdutoKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  with LDB.SQL.DataModule.dm.QueryEstoque do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT i.id_item AS ID, i.ds_item AS Descrição, REPLACE(FORMAT(i.preco_custo,2),".",",") AS "Preço Custo", REPLACE(FORMAT(i.preco_venda,2),".",",") AS "Preço Venda", e.quantidade AS Quantidade');
    SQL.Add('FROM tb_item AS i INNER JOIN tb_estoque as e ON (i.id_item = e.id_item) WHERE i.fg_ativo = 1 AND i.ds_item LIKE "' + txtProduto.Text + '%";');
    Open;
  end;
end;

end.
