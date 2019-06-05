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
    procedure Setdescricao(const Value: String);
    procedure Setfg_ativo(const Value: integer);
    procedure SetidItem(const Value: integer);
    procedure SetprecoCusto(const Value: double);
    procedure SetprecoVenda(const Value: double);
protected
public
property idItem : integer read FidItem write SetidItem;
property descricao : String read Fdescricao write Setdescricao;
property precoCusto : double read FprecoCusto write SetprecoCusto;
property precoVenda : double read FprecoVenda write SetprecoVenda;
property fg_ativo : integer read Ffg_ativo write Setfg_ativo;

published
end;
implementation

{ TItem }

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

end.
