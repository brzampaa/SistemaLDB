unit LDB.Cliente;

interface
uses SysUtils, FireDAC.Stan.Param;
type

TCliente = class
  private
    FSobrenome: string;
    FTitulo: string;
    FCEP: string;
    FNumero: string;
    FComplemento: string;
    FIdCliente: integer;
    FNome: string;
    FCidade: string;
    FEndereco: string;
    FTelefone: string;
    FEstado: string;
    FFgAtivo: integer;
    FCelular: string;
    procedure SetCelular(const Value: string);
    procedure SetCEP(const Value: string);
    procedure SetCidade(const Value: string);
    procedure SetComplemento(const Value: string);
    procedure SetEndereco(const Value: string);
    procedure SetEstado(const Value: string);
    procedure SetFgAtivo(const Value: integer);
    procedure SetIdCliente(const Value: integer);
    procedure SetNome(const Value: string);
    procedure SetNumero(const Value: string);
    procedure SetSobrenome(const Value: string);
    procedure SetTelefone(const Value: string);
    procedure SetTitulo(const Value: string);
  protected
  public
  property IdCliente : integer read FIdCliente write SetIdCliente;
  property Titulo : string read FTitulo write SetTitulo;
  property Nome : string read FNome write SetNome;
  property Sobrenome : string read FSobrenome write SetSobrenome;
  property Endereco : string read FEndereco write SetEndereco;
  property Numero : string read FNumero write SetNumero;
  property Complemento : string read FComplemento write SetComplemento;
  property CEP : string read FCEP write SetCEP;
  property Cidade : string read FCidade write SetCidade;
  property Estado : string read FEstado write SetEstado;
  property Telefone : string read FTelefone write SetTelefone;
  property Celular : string read FCelular write SetCelular;
  property FgAtivo : integer read FFgAtivo write SetFgAtivo;
  function pesquisar(id : integer):TCliente;
  function atualizar(c : TCliente):boolean;
  function inserir(c : TCliente):integer;
  function deletar(id : integer):boolean;

  published
end;

implementation

uses LDB.SQL.DataModule;

{ TCliente }

function TCliente.atualizar(c: TCliente): boolean;
begin
  with LDB.SQL.DataModule.dm.Query do
  begin
    Close;
    SQL.Clear;
    SQL.Add('UPDATE tb_cliente');
    SQL.Add('SET nome = :nome');
    SQL.Add(',sobrenome = :sobrenome');
    SQL.Add(',titulo = :titulo');
    SQL.Add(',cep = :cep');
    SQL.Add(',numero = :numero');
    SQL.Add(',complemento = :complemento');
    SQL.Add(',cidade = :cidade');
    SQL.Add(',endereco = :endereco');
    SQL.Add(',fone_fixo = :fone_fixo');
    SQL.Add(',estado = :estado');
    SQL.Add(',fg_ativo = 1');
    SQL.Add(',fone_movel = :fone_movel');
    SQL.Add('WHERE id_cliente = :id');

    ParamByName('id').Value := c.IdCliente;
    ParamByName('nome').Value := c.Nome;
    ParamByName('sobrenome').Value := c.Sobrenome;
    ParamByName('titulo').Value := c.Titulo;
    ParamByName('cep').Value := c.CEP;
    ParamByName('numero').Value := c.Numero;
    ParamByName('complemento').Value := c.Complemento;
    ParamByName('cidade').Value := c.Cidade;
    ParamByName('endereco').Value := c.Endereco;
    ParamByName('fone_fixo').Value := c.Telefone;
    ParamByName('estado').Value := c.Estado;
    ParamByName('fone_movel').Value := c.Celular;

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

function TCliente.pesquisar(id : integer): TCliente;
begin
  with LDB.SQL.DataModule.dm.Query do
  begin
    Close;
    SQL.Clear;
    SQL.Add('SELECT * FROM tb_cliente WHERE id_cliente = :id AND fg_ativo = 1');
    ParamByName('id').Value := id;
    Open;
    Self.IdCliente := FieldByName('id_cliente').AsInteger;
    Self.FSobrenome := FieldByName('sobrenome').AsString;
    Self.FTitulo := FieldByName('titulo').AsString;
    Self.FCEP := FieldByName('cep').AsString;
    Self.FNumero := FieldByName('numero').AsString;
    Self.FComplemento := FieldByName('complemento').AsString;
    Self.FNome := FieldByName('nome').AsString;
    Self.FCidade := FieldByName('cidade').AsString;
    Self.FEndereco := FieldByName('endereco').AsString;
    Self.FTelefone := FieldByName('fone_fixo').AsString;
    Self.FEstado := FieldByName('estado').AsString;
    Self.FFgAtivo := FieldByName('fg_ativo').AsInteger;
    Self.FCelular := FieldByName('fone_movel').AsString;

    Result := Self;
  end;
end;

function TCliente.deletar(id: integer): boolean;
begin
with LDB.SQL.DataModule.dm.Query do
  begin
    Close;
    SQL.Clear;
    //SQL.Add('DELETE FROM tb_cliente WHERE id_cliente = :id');
    //SQL.Add('UPDATE tb_cliente SET fg_ativo = 0 WHERE id_cliente = :id');
    SQL.Add('UPDATE tb_cliente SET fg_ativo = 0 WHERE id_cliente = :id');
    ParamByName('id').Value := id;
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

function TCliente.inserir(c: TCliente): integer;
begin
  with LDB.SQL.DataModule.dm.Query do
  begin
    Close;
    SQL.Clear;
    SQL.Add('INSERT INTO tb_cliente (nome, sobrenome, titulo, cep, numero, complemento, cidade, endereco, fone_fixo, estado, fone_movel, fg_ativo)');
    SQL.Add('VALUES (:nome, :sobrenome, :titulo, :cep, :numero, :complemento, :cidade, :endereco, :fone_fixo, :estado, :fone_movel, :fg_ativo);');

    ParamByName('nome').Value := c.Nome;
    ParamByName('sobrenome').Value := c.Sobrenome;
    ParamByName('titulo').Value := c.Titulo;
    ParamByName('cep').Value := c.CEP;
    ParamByName('numero').Value := c.Numero;
    ParamByName('complemento').Value := c.Complemento;
    ParamByName('cidade').Value := c.Cidade;
    ParamByName('endereco').Value := c.Endereco;
    ParamByName('fone_fixo').Value := c.Telefone;
    ParamByName('estado').Value := c.Estado;
    ParamByName('fone_movel').Value := c.Celular;
    ParamByName('fg_ativo').Value := 1;

    ExecSQL;

    Close;
    SQL.Clear;
    SQL.Add('SELECT LAST_INSERT_ID() as id_cliente;');
    Open;

    if RowsAffected > 0 then
    begin
      Result := FieldByName('id_cliente').AsInteger;
    end
    else
    begin
      Result := -1;
    end;
  end;
end;

procedure TCliente.SetCelular(const Value: string);
begin
  if Length(Value) = 11 then
  begin
    FCelular := Value;
  end
  else
  begin
    raise Exception.Create('O número do celular ' + Value +' é inválido.');
  end;
end;

procedure TCliente.SetCEP(const Value: string);
begin
  if Length(Value) = 8 then
  begin
    FCelular := Value;
  end
  else
  begin
    raise Exception.Create('O CEP ' + Value +' é inválido.');
  end;
end;

procedure TCliente.SetCidade(const Value: string);
begin
  if Value <> '' then
  begin
    FCidade := Value;
  end
  else
  begin
    raise Exception.Create('Cidade não informada.');
  end;
end;

procedure TCliente.SetComplemento(const Value: string);
begin
  FComplemento := Value;
end;

procedure TCliente.SetEndereco(const Value: string);
begin
  if Value <> '' then
  begin
    FEndereco := Value;
  end
  else
  begin
    raise Exception.Create('O endereço não pode estar vazio.');
  end;
end;

procedure TCliente.SetEstado(const Value: string);
begin
  FEstado := Value;
end;

procedure TCliente.SetFgAtivo(const Value: integer);
begin
  FFgAtivo := Value;
end;

procedure TCliente.SetIdCliente(const Value: integer);
begin
  FIdCliente := Value;
end;

procedure TCliente.SetNome(const Value: string);
begin
  if Value <> '' then
  begin
    FNome := Value;
  end
  else
  begin
    raise Exception.Create('O nome não pode estar vazio.');
  end;
end;

procedure TCliente.SetNumero(const Value: string);
begin
  FNumero := Value;
end;

procedure TCliente.SetSobrenome(const Value: string);
begin
  if Value <> '' then
  begin
    FSobrenome := Value;
  end
  else
  begin
    raise Exception.Create('O sobrenome não pode estar vazio.');
  end;
end;

procedure TCliente.SetTelefone(const Value: string);
begin
  if Length(Value) = 10 then
  begin
    FTelefone := Value;
  end
  else
  begin
    raise Exception.Create('O número de telefone ' + Value +' é inválido.');
  end;
end;

procedure TCliente.SetTitulo(const Value: string);
begin
  FTitulo := Value;
end;

end.
