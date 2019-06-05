object dm: Tdm
  OldCreateOrder = False
  Height = 193
  Width = 177
  object Conn: TFDConnection
    Params.Strings = (
      'DriverID=MySQL'
      'Compress=False'
      'Database=ldb'
      'Password=@Admin0901'
      'Server=localhost'
      'User_Name=admin')
    Connected = True
    LoginPrompt = False
    Left = 27
    Top = 17
  end
  object Query: TFDQuery
    Connection = Conn
    SQL.Strings = (
      
        'SELECT id_cliente AS ID, CONCAT(nome, " ", sobrenome) AS Cliente' +
        ', endereco AS Endere'#231'o, fone_fixo AS Telefone FROM tb_cliente WH' +
        'ERE fg_ativo = 1')
    Left = 31
    Top = 73
  end
  object DS: TDataSource
    DataSet = Query
    Left = 112
    Top = 73
  end
  object QueryEstoque: TFDQuery
    Connection = Conn
    SQL.Strings = (
      
        'SELECT i.id_item AS ID, i.ds_item AS Descri'#231#227'o, i.preco_custo AS' +
        ' "Pre'#231'o Custo", i.preco_venda AS "Pre'#231'o Venda", e.quantidade AS ' +
        'Quantidade'#13#10#10
      'FROM tb_item AS i'#13#10#10
      'INNER JOIN tb_estoque as e ON (i.id_item = e.id_item);')
    Left = 32
    Top = 128
  end
  object DSEstoque: TDataSource
    DataSet = QueryEstoque
    Left = 112
    Top = 128
  end
end
