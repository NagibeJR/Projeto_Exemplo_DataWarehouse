USE dw_lowlatency
create or alter procedure sp_oltp_tipo_pagamento(@data_carga datetime)
as
begin
	INSERT INTO tb_aux_tipo_pagamento (DATA_CARGA, COD_TIPO_PAGAMENTO, TIPO_PAGAMENTO)
			SELECT 
				@data_carga,
				L.COD_TIPO_PAGAMENTO,
				L.TIPO_PAGAMENTO AS TIPO_PAGAMENTO
			FROM 
				TB_TIPO_PAGAMENTO L

end



-- Teste

exec sp_oltp_tipo_pagamento '20230104'


SELECT * FROM TB_TIPO_PAGAMENTO