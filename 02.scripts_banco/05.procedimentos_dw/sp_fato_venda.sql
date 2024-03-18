create or alter procedure sp_fato_venda(@data_carga datetime)
as
BEGIN
    INSERT INTO FATO_VENDA (ID_TEMPO, ID_LOJA, ID_PRODUTO, ID_TIPO_PAGAMENTO, COD_VENDA, VOLUME, VALOR, QUANTIDADE)
    SELECT 
        T.ID_TEMPO,
        L.ID_LOJA,
        P.ID_PRODUTO,
        TP.ID_TIPO_PAGAMENTO,
        V.COD_VENDA,
        V.VOLUME,
        V.VALOR,
		1
    FROM 
        TB_AUX_VENDA V
        INNER JOIN DIM_TEMPO T ON V.COD_VENDA = T.ID_TEMPO
        INNER JOIN DIM_PRODUTO P ON V.COD_VENDA = P.ID_PRODUTO
        INNER JOIN DIM_LOJA L ON V.COD_VENDA = L.ID_LOJA
        INNER JOIN DIM_TIPO_PAGAMENTO TP ON V.COD_VENDA = TP.ID_TIPO_PAGAMENTO
END



-- Teste

exec sp_fato_venda '20230104'

USE dw_lowlatency

select * from fato_venda
select * from TB_AUX_VENDA
SELECT * FROM DIM_TEMPO