USE dw_lowlatency
create or alter procedure sp_oltp_produto(@data_carga datetime)
as
begin
	INSERT INTO tb_aux_produto (DATA_CARGA, COD_PRODUTO, PRODUTO, COD_CATEGORIA, CATEGORIA)
		SELECT 
			@data_carga,
			L.COD_PRODUTO,
			L.PRODUTO AS PRODUTO,
			L.COD_CATEGORIA,
			C.CATEGORIA as CATEGORIA
		FROM 
			TB_PRODUTO L
			INNER JOIN TB_CATEGORIA C ON L.COD_CATEGORIA = C.COD_CATEGORIA
end



-- Teste

exec sp_oltp_produto '20230104'

select * from tb_aux_produto
SELECT * FROM TB_PRODUTO
SELECT * FROM TB_CATEGORIA