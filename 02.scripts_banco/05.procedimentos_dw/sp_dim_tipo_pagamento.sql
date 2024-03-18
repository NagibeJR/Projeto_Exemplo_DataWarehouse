use dw_lowlatency

create or alter procedure sp_dim_tipo_pagamento(@data_carga datetime)
as
begin
	INSERT INTO DIM_TIPO_PAGAMENTO (COD_TIPO_PAGAMENTO, TIPO_PAGAMENTO)
			SELECT 
				P.COD_TIPO_PAGAMENTO,
				P.TIPO_PAGAMENTO
			FROM 
				TB_TIPO_PAGAMENTO P
end



-- Teste

exec sp_dim_tipo_pagamento '20230104'

select * from dim_tipo_pagamento
SELECT * FROM TB_TIPO_PAGAMENTO