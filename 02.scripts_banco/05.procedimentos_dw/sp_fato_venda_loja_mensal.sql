create or alter procedure sp_fato_venda_loja_mensal
as
begin
		DECLARE @ID_TEMPO BIGINT,
				@MES INT,
				@ANO INT,
				@ID_LOJA INT,
				@VOLUME NUMERIC(10,2),
				@VALOR NUMERIC(10,2)

		DECLARE C_VENDA_LOJA_MENSAL CURSOR FOR
		SELECT ID_TEMPO, MES, ANO
		FROM DIM_TEMPO
		WHERE NIVEL = 'MES'

		DELETE FATO_VENDA_LOJA_MENSAL

		OPEN C_VENDA_LOJA_MENSAL
		FETCH C_VENDA_LOJA_MENSAL INTO @ID_TEMPO,@MES, @ANO

		WHILE @@FETCH_STATUS = 0
		BEGIN
				INSERT INTO FATO_VENDA_LOJA_MENSAL
				SELECT @ID_TEMPO,V.ID_LOJA,V.VOLUME,V.VALOR,V.QUANTIDADE
				FROM FATO_VENDA V
				INNER JOIN DIM_TEMPO T ON V.ID_TEMPO = T.ID_TEMPO
				WHERE MONTH(T.DATA) = @MES AND YEAR(T.DATA) = @ANO
				GROUP BY V.ID_LOJA

			FETCH C_VENDA_LOJA_MENSAL INTO @ID_TEMPO,@MES, @ANO
		END
	CLOSE C_VENDA_LOJA_MENSAL
	DEALLOCATE C_VENDA_LOJA_MENSAL
END



-- Teste

exec sp_fato_venda_loja_mensal



use dw_lowlatency