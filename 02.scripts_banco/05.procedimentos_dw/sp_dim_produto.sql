create or alter procedure sp_dim_produto(@data_carga datetime)
as
begin
	INSERT INTO DIM_PRODUTO(COD_PRODUTO, PRODUTO, COD_CATEGORIA, CATEGORIA)
		SELECT 
			P.COD_PRODUTO,
			P.PRODUTO,
			P.COD_CATEGORIA,
			P.CATEGORIA
		FROM 
			TB_AUX_PRODUTO P
end


-- Teste

exec sp_dim_produto '20230104'

USE dw_lowlatency
select * from dim_produto
select * from tb_aux_produto