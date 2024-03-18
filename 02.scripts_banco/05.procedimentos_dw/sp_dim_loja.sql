create or alter procedure sp_dim_loja(@data_carga datetime)
as
begin
	INSERT INTO DIM_LOJA(COD_LOJA, LOJA, CIDADE, ESTADO, SIGLA_ESTADO)
    SELECT 
        L.COD_LOJA,
        L.LOJA,
        L.CIDADE,
        L.ESTADO,
        L.SIGLA_ESTADO
    FROM 
        TB_AUX_LOJA L
end

-- Teste

exec sp_dim_loja '20230104'

select * from dim_loja
select * from TB_AUX_LOJA
select * from TB_LOJA

use dw_lowlatency