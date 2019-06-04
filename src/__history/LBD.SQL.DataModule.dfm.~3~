object dm: Tdm
  OldCreateOrder = False
  Height = 80
  Width = 190
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
        ', endereco AS Endere'#231'o, fone_fixo AS Telefone FROM tb_cliente')
    Left = 79
    Top = 17
  end
  object DS: TDataSource
    DataSet = Query
    Left = 131
    Top = 17
  end
end
