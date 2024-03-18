USE dw_lowlatency
create or alter procedure sp_oltp_venda(@data_carga datetime, @data_inicial datetime, @data_final datetime)
as
begin 
	INSERT INTO TB_AUX_VENDA (DATA_CARGA, DATA_VENDA, COD_LOJA, COD_PRODUTO, COD_TIPO_PAGAMENTO, COD_VENDA, VOLUME,VALOR)
				SELECT 
					@data_carga,
					L.DATA_VENDA AS DATA_VENDA,
					L.COD_LOJA,
					L.COD_PRODUTO AS COD_PRODUTO,
					L.COD_TIPO_PAGAMENTO AS COD_TIPO_PAGAMENTO,
					L.COD_VENDA,
					L.VOLUME AS VOLUME,
					L.VALOR

				FROM 
					TB_VENDA L
end	



-- Teste

exec sp_oltp_venda '20230304', '20230301', '20230304'

select * from TB_AUX_VENDA
SELECT * FROM TB_VENDA

select * from TB_VENDA
select * from TB_LOJA
select * from TB_PRODUTO
select * from TB_CATEGORIA
select * from TB_CIDADE
select * from TB_ESTADO
select * from TB_TIPO_PAGAMENTO