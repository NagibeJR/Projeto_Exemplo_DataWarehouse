use dw_lowlatency
CREATE OR ALTER PROCEDURE sp_oltp_loja
    @data_carga DATETIME
AS
BEGIN
   		DELETE FROM TB_AUX_LOJA
		WHERE @data_carga = DATA_CARGA
		INSERT INTO TB_AUX_LOJA (DATA_CARGA, COD_LOJA, LOJA, CIDADE, ESTADO, SIGLA_ESTADO)
		SELECT @data_carga,
				L.COD_LOJA,
				L.NM_LOJA,
				C.CIDADE,
				E.ESTADO,
				E.SIGLA
		FROM TB_LOJA L
		INNER JOIN TB_CIDADE C ON L.COD_CIDADE = C.COD_CIDADE
		INNER JOIN TB_ESTADO E ON C.COD_ESTADO = E.COD_ESTADO
END

exec sp_oltp_loja '20230321'

select * from tb_aux_loja
select * from tb_loja
select * from tb_cidade
select * from TB_ESTADO
use dw_lowlatency
