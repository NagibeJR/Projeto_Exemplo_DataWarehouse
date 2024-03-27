USE dw_lowlatency
create or alter procedure sp_oltp_venda(@data_carga datetime, @data_inicial datetime, @data_final datetime)
as
begin 
	DELETE FROM TB_AUX_VENDA
	WHERE @data_carga = DATA_CARGA
	INSERT INTO TB_AUX_VENDA (DATA_CARGA, DATA_VENDA, COD_LOJA, COD_PRODUTO, COD_TIPO_PAGAMENTO, COD_VENDA, VOLUME,VALOR)
	SELECT @data_carga,
			V.DATA_VENDA,
			V.COD_LOJA,
			V.COD_PRODUTO,
			V.COD_TIPO_PAGAMENTO,
			V.COD_VENDA,
			V.VOLUME,
			V.VALOR
	FROM TB_VENDA V
	WHERE V.DATA_VENDA >= @data_inicial AND V.DATA_VENDA >= @data_final
end	



-- Teste

exec sp_oltp_venda '20230321', '20230101', '20230601'

SELECT * FROM TB_AUX_VENDA


