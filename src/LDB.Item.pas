unit LDB.Item;

interface
type
TItem = class
private
    FidItem: integer;
    FprecoCusto: double;
    Fdescricao: String;
    FprecoVenda: double;
    Ffg_ativo: integer;
    Fquantidade: integer;
    procedure Setdescricao(const Value: String);
    procedure Setfg_ativo(const Value: integer);
    procedure SetidItem(const Value: integer);
    procedure SetprecoCusto(const Value: double);
    procedure SetprecoVenda(const Value: double);
    procedure Setquantidade(const Value: integer);
protected
public
property idItem : integer read FidItem write SetidItem;
property descricao : String read Fdescricao write Setdescricao;
property precoCusto : double read FprecoCusto write SetprecoCusto;
property precoVenda : double read FprecoVenda write SetprecoVenda;
property fg_ativo : integer read Ffg_ativo write Setfg_ativo;
property quantidade : integer read Fquantidade write Setquantidade;
function pesquisar(id : integer):TItem;
function inserir(i : TItem):integer;
function atualizar(i : TItem):boolean;
function excluir(id : integer):integer;
procedure pesquisarTodos();
procedure quantidadeEstoque(id : integer);
function movimentarEstoque(op : integer; qtd : integer):boolean;
published
end;
implementation

uses LDB.SQL.DataModule;

{ TItem }

function TItem.atualizar(i: TItem): boolean;
begin
  with LDB.SQL.DataModule.dm.QueryEstoque do
  begin
    Close;
    SQL.Clear;
    SQL.Add('UPDATE tb_item');
    SQL.Add('SET ds_item = :ds_item');
    SQL.Add(',preco_custo = :preco_custo');
    SQL.Add(',preco_venda = :preco_venda');
    SQL.Add(',fg_ativo = 1');
    SQL.Add('WHERE id_item = :id');

    ParamByName('id').Value := i.idItem;
    ParamByName('ds_item').Value := i.descricao;
    ParamByName('preco_custo').Value := i.precoCusto;
    ParamByName('preco_venda').Value := i.precoVenda;

    ExecSQL;

    if RowsAffected > 0 then
    begin
      Result := True;
    end
    else
    begin
      Result := False;
    end;
  end;
end;

function TItem.excluir(id: integer): integer;
begin
  with LDB.SQL.DataModule.dm.QueryEstoque do
    begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM tb_estoque WHERE id_item = :id');
    ParamByName('id').Value := id;
    Open;
    if FieldByName('quantidade').AsInteger > 0 then
    begin
      Result := 0;
    end
    else
    begin
      Close;
      SQL.Clear;
      SQL.Add('UPDATE tb_item SET fg_ativo = 0 WHERE id_item = :id');
      ParamByName('id').Value := id;
      ExecSQL;
      if RowsAffected > 0 then
      begin
        Result := 1;
      end
      else
      begin
        Result := 2;
      end;
    end;
  end;
end;

function TItem.inserir(i: TItem): integer;
var
 id : integer;
begin
with LDB.SQL.DataModule.dm.QueryEstoque do
  begin
    Close;
    SQL.Clear;
    SQL.Add('INSERT INTO tb_item (ds_item, preco_custo, preco_venda, fg_ativo)');
    SQL.Add('VALUES (:descricao, :preco_custo, :preco_venda, :fg_ativo);');

    ParamByName('descricao').Value := i.descricao;
    ParamByName('preco_custo').Value := i.precoCusto;
    ParamByName('preco_venda').Value := i.precoVenda;
    ParamByName('fg_ativo').Value := i.fg_ativo;

    ExecSQL;

    Close;
    SQL.Clear;
    SQL.Add('SELECT LAST_INSERT_ID() as id_cliente;');
    Open;

    if RowsAffected > 0 then
    begin
      id := FieldByName('id_cliente').AsInteger;;
      Close;
      SQL.Clear;
      SQL.Add('INSERT INTO tb_estoque (id_item, quantidade)');
      SQL.Add('VALUES (:id, 0);');
      ParamByName('id').Value := id;
      ExecSQL;
      Result := id;
    end
    else
    begin
      Result := -1;
    end;
  end;
end;

function TItem.movimentarEstoque(op, qtd: integer): boolean;
begin
  with LDB.SQL.DataModule.dm.QueryMov do
  begin
    Close;
    SQL.Clear;
    case op of
      0:
      begin
        SQL.Add('UPDATE tb_estoque SET quantidade = :est + :qtd WHERE id_item = :id;');
        ParamByName('est').Value := Fquantidade;
        ParamByName('qtd').Value := qtd;
        ParamByName('id').Value := FidItem;
        ExecSQL;
        if RowsAffected > 0 then
        begin
          Result := True;
        end
        else
        begin
          Result := False;
        end;
      end;
      1:
      begin
        SQL.Add('UPDATE tb_estoque SET quantidade = :est - :qtd WHERE id_item = :id;');
        ParamByName('est').Value := Fquantidade;
        ParamByName('qtd').Value := qtd;
        ParamByName('id').Value := FidItem;
        ExecSQL;
        if RowsAffected > 0 then
        begin
          Result := True;
        end
        else
        begin
          Result := False;
        end;
      end;
    end;
  end;
end;

function TItem.pesquisar(id: integer): TItem;
begin
  with LDB.SQL.DataModule.dm.QueryEstoque do
  begin
    Close;
    SQL.Clear;
    //SQL.Add('SELECT i.id_item AS ID, i.ds_item AS Descri��o, i.preco_custo AS "Pre�o Custo", i.preco_venda AS "Pre�o Venda", e.quantidade AS Quantidade FROM tb_item AS i INNER JOIN tb_estoque as e ON (i.id_item = e.id_item) WHERE i.fg_ativo = 1 AND i.id_item ');
    SQL.Add('SELECT id_item, ds_item, REPLACE(FORMAT(preco_custo,2),".",",") AS preco_custo, REPLACE(FORMAT(preco_venda,2),".",",") AS preco_venda, fg_ativo FROM tb_item WHERE id_item = :id');
    ParamByName('id').Value := id;
    Open;
    Self.FIdItem := FieldByName('id_item').AsInteger;
    Self.FDescricao := FieldByName('ds_item').AsString;
    Self.FprecoCusto := FieldByName('preco_custo').AsFloat;
    Self.FprecoVenda := FieldByName('preco_venda').AsFloat;
    Self.Ffg_ativo := FieldByName('fg_ativo').AsInteger;
    Self.quantidadeEstoque(Self.FidItem);
    Result := Self;
  end;
end;

procedure TItem.pesquisarTodos;
begin
  with LDB.SQL.DataModule.dm.QueryEstoque do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT i.id_item AS ID, i.ds_item AS Descri��o, REPLACE(FORMAT(i.preco_custo,2),".",",") AS "Pre�o Custo", REPLACE(FORMAT(i.preco_venda,2),".",",") AS "Pre�o Venda", e.quantidade AS Quantidade');
    SQL.Add('FROM tb_item AS i INNER JOIN tb_estoque as e ON (i.id_item = e.id_item) WHERE i.fg_ativo = 1;');
    Open;
  end;
end;

procedure TItem.quantidadeEstoque(id: integer);
begin
with LDB.SQL.DataModule.dm.QueryMov do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT quantidade FROM tb_estoque WHERE id_item = :id');
    ParamByName('id').Value := id;
    Open;
    Fquantidade := FieldByName('quantidade').AsInteger;
  end;
end;

procedure TItem.Setdescricao(const Value: String);
begin
  Fdescricao := Value;
end;

procedure TItem.Setfg_ativo(const Value: integer);
begin
  Ffg_ativo := Value;
end;

procedure TItem.SetidItem(const Value: integer);
begin
  FidItem := Value;
end;

procedure TItem.SetprecoCusto(const Value: double);
begin
  FprecoCusto := Value;
end;

procedure TItem.SetprecoVenda(const Value: double);
begin
  FprecoVenda := Value;
end;

procedure TItem.Setquantidade(const Value: integer);
begin
  Fquantidade := Value;
end;

end.
