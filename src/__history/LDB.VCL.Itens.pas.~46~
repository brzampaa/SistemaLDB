unit LDB.VCL.Itens;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, Vcl.Imaging.pngimage,
  Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons, Vcl.Mask, StrUtils, LDB.Item,
  Vcl.DBCtrls;

type
  TfrmItens = class(TForm)
    Image1: TImage;
    pgcItens: TPageControl;
    TabSheet1: TTabSheet;
    lblID: TLabel;
    txtID: TEdit;
    txtDescricao: TEdit;
    lblDescricao: TLabel;
    txtPrecoCusto: TEdit;
    lblCusto: TLabel;
    txtPrecoVenda: TEdit;
    lblCenda: TLabel;
    lblMargem: TLabel;
    btnCancelar: TSpeedButton;
    btnExcluir: TSpeedButton;
    btnEditar: TSpeedButton;
    btnNovo: TSpeedButton;
    btnSalvar: TSpeedButton;
    lblCifra: TLabel;
    Label1: TLabel;
    txtQuantidade: TEdit;
    lblQuantidade: TLabel;
    btnAdd: TSpeedButton;
    btnRmv: TSpeedButton;
    lblMov: TLabel;
    txtMovimentar: TEdit;
    procedure txtPrecoVendaExit(Sender: TObject);
    procedure txtPrecoVendaKeyPress(Sender: TObject; var Key: Char);
    procedure txtPrecoCustoExit(Sender: TObject);
    procedure txtPrecoCustoKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
    procedure btnEditarClick(Sender: TObject);
    procedure btnNovoClick(Sender: TObject);
    procedure btnCancelarClick(Sender: TObject);
    procedure btnSalvarClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure btnExcluirClick(Sender: TObject);
    procedure MovimentaçãoShow(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnRmvClick(Sender: TObject);
  private
    FIdItem: integer;
    Item : TItem;
    procedure SetIdItem(const Value: integer);
    procedure mostrarItem();
    procedure calcularMargem();
    procedure desativarCampos();
    procedure ativarCampos();
    procedure novoItem();
    procedure limparCampos();

  public
    property IdItem : integer read FIdItem write SetIdItem;
    { Public declarations }
  end;

var
  frmItens: TfrmItens;

implementation

uses LDB.SQL.DataModule, LDB.VCL.Estoque;
{$R *.dfm}

procedure TfrmItens.ativarCampos;
begin
  txtDescricao.Enabled := True;
  txtPrecoCusto.Enabled := True;
  txtPrecoVenda.Enabled := True;
  txtMovimentar.Enabled := True;
end;

procedure TfrmItens.btnCancelarClick(Sender: TObject);
begin
  if Assigned(item) then
  begin
    mostrarItem;
    desativarCampos;
    btnCancelar.Enabled := False;
    btnSalvar.Enabled := False;
    btnEditar.Enabled := True;
    btnNovo.Enabled := True;
    btnExcluir.Enabled := True;
    btnAdd.Enabled := False;
    btnRmv.Enabled := False;
    txtQuantidade.Text := '';
  end
  else
  begin
    ModalResult := mrCancel;
  end;
end;

procedure TfrmItens.btnEditarClick(Sender: TObject);
begin
  ativarCampos;
  btnCancelar.Enabled := True;
  btnSalvar.Enabled := True;
  btnAdd.Enabled := True;
  btnRmv.Enabled := True;
  btnEditar.Enabled := False;
  btnNovo.Enabled := False;
  btnExcluir.Enabled := False;
end;

procedure TfrmItens.btnExcluirClick(Sender: TObject);
var
  res : integer;
begin
  res := Application.MessageBox('Deseja realmente excluir o item?', 'Atenção!', MB_YESNO + mb_iconquestion + MB_SYSTEMMODAL);
  if res = mrYES then
  begin
     case TItem.Create.excluir(IdItem) of
       0: Application.MessageBox('Impossível excluir, o item possui unidades em estoque.', 'Erro!', MB_ICONERROR);
       1: Application.MessageBox('Item excluído com sucesso!', 'Concluído', MB_ICONINFORMATION);
       2: Application.MessageBox('Erro ao excluir item.', 'Erro!', MB_ICONERROR);
    end;
  end;
end;

procedure TfrmItens.btnNovoClick(Sender: TObject);
begin
  ativarCampos;
  novoItem;
  limparCampos;
  FreeAndNil(item);
end;

procedure TfrmItens.btnSalvarClick(Sender: TObject);
var
  i : TItem;
  s : string;
begin
  i := TItem.Create;
  if txtId.Text <> '' then
  begin
    i.idItem := strToInt(txtID.Text);
  end;

  i.descricao := txtDescricao.Text;
  i.precoCusto := StrToFloat(txtPrecoCusto.Text);
  i.precoVenda := StrToFloat(txtPrecoVenda.Text);
  i.fg_ativo := 1;

  if txtId.Text <> '' then
  begin
    if TItem.Create.atualizar(i) then
    begin
      messageDlg('Item atualizado com sucesso!', mtInformation, [mbOk], 0);
      desativarCampos;
      btnSalvar.Enabled := False;
      btnEditar.Enabled := True;
      btnCancelar.Enabled := False;
      btnNovo.Enabled := True;
      btnExcluir.Enabled := True;
      btnAdd.Enabled := False;
      btnRmv.Enabled := False;
      //pgcClientes.TabIndex := 0;
    end
    else
    begin
      messageDlg('Falha ao atualizar item!', mtError, [mbOk], 0);
    end;
  end
  else
  begin
    IdItem := TItem.Create.inserir(i);
    if IdItem <> -1 then
    begin
      messageDlg('Item cadastrado com sucesso!', mtInformation, [mbOk], 0);
      mostrarItem;
      desativarCampos;
      btnSalvar.Enabled := False;
      btnEditar.Enabled := True;
      btnCancelar.Enabled := False;
      btnNovo.Enabled := True;
      btnExcluir.Enabled := True;
      //pgcClientes.TabIndex := 0;
    end
    else
    begin
      messageDlg('Falha ao salvar item!', mtError, [mbOk], 0);
    end;
  end;
end;

procedure TfrmItens.calcularMargem;
var
  res : double;
begin
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

procedure TfrmItens.desativarCampos;
begin
  txtDescricao.Enabled := False;
  txtPrecoCusto.Enabled := False;
  txtPrecoVenda.Enabled := False;
  txtMovimentar.Enabled := False;
end;

procedure TfrmItens.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  TItem.Create.pesquisarTodos();
end;

procedure TfrmItens.FormCreate(Sender: TObject);
begin
  IdItem := -1;
end;

procedure TfrmItens.FormShow(Sender: TObject);
begin
  if IdItem <> -1 then
  begin
    mostrarItem;
    desativarCampos;
    btnCancelar.Enabled := False;
    btnSalvar.Enabled := False;
    btnEditar.Enabled := True;
    btnNovo.Enabled := True;
    btnExcluir.Enabled := True;
    calcularMargem;
  end
  else
  begin
    novoItem;
  end;
  
end;

procedure TfrmItens.limparCampos;
begin
  txtID.Text := '';
  txtDescricao.Text := '';
  txtPrecoCusto.Text := '';
  txtPrecoVenda.Text := '';
  lblMargem.Caption := '';
  txtMovimentar.Text := '';
  txtQuantidade.Text := '';
end;

procedure TfrmItens.mostrarItem;
begin
  Item := TItem.Create.pesquisar(IdItem);
  txtID.Text := IntToStr(Item.idItem);
  txtDescricao.Text := Item.descricao;
  txtPrecoCusto.Text := FloatToStr(Item.precoCusto);
  txtPrecoVenda.Text := FloatToStr(Item.precoVenda);
  txtQuantidade.Text := IntToStr(Item.quantidade);
end;

procedure TfrmItens.MovimentaçãoShow(Sender: TObject);
begin
  LDB.SQL.DataModule.dm.QueryMov.Open();
end;

procedure TfrmItens.novoItem;
begin
  pgcItens.TabIndex := 0;
  btnNovo.Enabled := False;
  btnSalvar.Enabled := True;
  btnEditar.Enabled := False;
  btnCancelar.Enabled := True;
  btnExcluir.Enabled := False;
  btnAdd.Enabled := False;
  btnRmv.Enabled := False;
  ativarCampos;
  txtMovimentar.Enabled := False;
  txtDescricao.SetFocus;
end;

procedure TfrmItens.SetIdItem(const Value: integer);
begin
  FIdItem := Value;
end;

procedure TfrmItens.btnAddClick(Sender: TObject);
var
  res : integer;
begin
  if (txtMovimentar.Enabled) AND (txtMovimentar.Text <> '') then
  begin
      res := Application.MessageBox(PChar('Deseja adicionar ' + txtMovimentar.Text + ' unidade(s) ao estoque do item ' + Item.descricao + '?'), 'Atenção!', MB_YESNO + mb_iconquestion + MB_SYSTEMMODAL);
      if res = mrYES then
      begin
        if Item.movimentarEstoque(0,strToInt(txtMovimentar.Text)) then
        begin
          mostrarItem;
          txtMovimentar.Text := '';
          txtDescricao.SetFocus;
        end
        else
        begin
          Application.MessageBox('Falha ao movimentar o estoque!', 'Erro!', MB_ICONERROR);
        end;
      end;
  end;
end;


procedure TfrmItens.btnRmvClick(Sender: TObject);
var
  res : integer;
begin
  if (txtMovimentar.Enabled) AND (txtMovimentar.Text <> '') then
  begin
    if (strToInt(txtQuantidade.Text)-strToInt(txtMovimentar.Text))<0 then
    begin
      Application.MessageBox('Estoque insuficiente para realizar a operação!', 'Atenção!', MB_ICONERROR);
    end
    else
    begin
      res := Application.MessageBox(PChar('Deseja remover ' + txtMovimentar.Text + ' unidade(s) do estoque do item ' + Item.descricao + '?'), 'Atenção!', MB_YESNO + mb_iconquestion + MB_SYSTEMMODAL);
      if res = mrYES then
      begin
        if Item.movimentarEstoque(1,strToInt(txtMovimentar.Text)) then
        begin
          mostrarItem;
          txtMovimentar.Text := '';
          txtDescricao.SetFocus;
        end
        else
        begin
          Application.MessageBox('Falha ao movimentar o estoque!', 'Erro!', MB_ICONERROR);
        end;
      end;
    end;
  end;
end;

procedure TfrmItens.txtPrecoCustoExit(Sender: TObject);
begin
  if txtPrecoCusto.Text <> '' then
  begin
    txtPrecoCusto.Text := formatfloat('#0,.00',(strToFloat(txtPrecoCusto.Text)));
  end;
  calcularMargem;
end;

procedure TfrmItens.txtPrecoCustoKeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key,['0'..'9',',',#8]) then Key := #0;
  if Key = ',' then
  begin
    if pos(',',txtPrecoCusto.Text) > 0 then Key := #0 ;
  end;
end;

procedure TfrmItens.txtPrecoVendaExit(Sender: TObject);
begin
  if txtPrecoVenda.Text <> '' then
  begin
    txtPrecoVenda.Text := formatfloat('#0,.00',(strToFloat(txtPrecoVenda.Text)));
  end;
  calcularMargem;
end;

procedure TfrmItens.txtPrecoVendaKeyPress(Sender: TObject; var Key: Char);
begin
  if not CharInSet(Key,['0'..'9',',',#8]) then Key := #0;
  if Key = ',' then
  begin
    if pos(',',txtPrecoVenda.Text) > 0 then Key := #0 ;
  end;
end;

end.
