-- Script para povoar a dimensão tempo
use dw_lowlatency 

create or alter procedure sp_dim_tempo (@dt_inicial datetime, @dt_final datetime)
as
begin
		SET NOCOUNT ON
		SET LANGUAGE BRAZILIAN

		DECLARE @DIA INT,
				@MES INT,
				@ANO INT,
				@TRIMESTRE INT,
				@NOME_TRIMESTRE VARCHAR(100),
				@SEMESTRE INT,
				@NOME_SEMESTRE VARCHAR (100),
				@FINALSEMANA CHAR(3),
				@DATA DATE,
				@NOMEDIA VARCHAR(7),
				@DIASEMANA INT,
				@NOME_DIA VARCHAR (7),
				@NOME_MES VARCHAR(10),
				@DATA_NIVEL DATETIME,
				@ULTIMO_DIA_MES INT

		SET @DATA = @DT_INICIAL

		WHILE @DATA <= @DT_FINAL
		BEGIN
			SET @DIA = DAY(@DATA)
			SET @MES = MONTH(@DATA)
			SET @ANO = YEAR (@DATA)
			SET @DIASEMANA = DATEPART(WEEKDAY, @DATA)
			SET @TRIMESTRE = DATEPART(QUARTER, @DATA)
			SET @NOME_DIA = DATENAME(dw, @DATA)
			SET @NOME_MES = DATENAME(mm,@DATA)
			SET @DATA_NIVEL =(SELECT DATEADD(DD, - DAY (DATEADD(M, 1, @DATA)),DATEADD(M, 1, @DATA)))
			SET @ULTIMO_DIA_MES = DATEPART(DAY,@DATA_NIVEL)

			IF @MES < 6
				SET @SEMESTRE = 1
			ELSE
				SET @SEMESTRE = 2

			IF @DIASEMANA = 7 OR @DIASEMANA = 1
				SET @FINALSEMANA = 'SIM'
			ELSE
				SET @FINALSEMANA = 'NAO'

				SET @NOME_SEMESTRE = STR(@SEMESTRE) + '° Semestre' + '/' + STR(@ANO)
				SET @NOME_TRIMESTRE = STR(@TRIMESTRE) + '° Trimestre' + '/' + STR(@ANO)

				INSERT INTO DIM_TEMPO(NIVEL, DATA, DIA, DIA_SEMANA,NOME_MES,FIM_SEMANA,FERIADO,FL_FERIADO, MES, TRIMESTRE,NOME_TRIMESTRE, SEMESTRE, NOME_SEMESTRE, ANO)
				VALUES('DIA',@DATA, @DIA, @NOME_DIA,@NOME_MES, @FINALSEMANA,'Sem Feriado','NAO',@MES,@TRIMESTRE, @NOME_TRIMESTRE, @SEMESTRE, @NOME_SEMESTRE, @ANO)

			IF (@DIA = DATEPART(DAY, @DATA_NIVEL))
			BEGIN
				INSERT INTO DIM_TEMPO(NIVEL,DATA, NOME_MES, MES, TRIMESTRE,NOME_TRIMESTRE, SEMESTRE,NOME_SEMESTRE, ANO)
				VALUES('MES',@DATA, @NOME_MES, @MES, @TRIMESTRE, @NOME_TRIMESTRE, @SEMESTRE, @NOME_SEMESTRE , @ANO)
			END

			IF (@DIA = 31 AND @MES = 12)
			BEGIN
				INSERT INTO DIM_TEMPO(NIVEL,DATA, ANO)
				VALUES('ANO',@DATA, @ANO)
			END

			SET @DATA = DATEADD(DAY, 1, @DATA)
	END
end	

exec sp_dim_tempo '20230101', '20230701'

select * from dim_tempo


-- Script para povoar a dimensão feriados no ano de 2023
--Dados retirados do site a baixo
--https://www.anbima.com.br/feriados/fer_nacionais/2023.asp
INSERT INTO DIM_FERIADOS(DATA,DESCRICAO,TIPO)
VALUES('2023-01-01','Confraternização Universal','NACIONAL'),
		('2023-20-02','Carnaval','NACIONAL'),
		('2023-21-02','Carnaval','NACIONAL'),
		('2023-07-04','Paixão de Cristo','NACIONAL'),
		('2023-21-04','Tiradentes','NACIONAL'),
		('2023-01-05','Dia do Trabalho','NACIONAL'),
		('2023-08-06','Corpus Christi','NACIONAL')

select * from DIM_FERIADOS


-- Script para atualizar a dimensão tempo com os feriados cadastrados na dimensão feriados

create or alter procedure so_atualiza_feriado(@ano int)
as
begin
	
	UPDATE DIM_TEMPO 
	SET FL_FERIADO = 'SIM', FERIADO = F.DESCRICAO
	FROM DIM_TEMPO T
	INNER JOIN DIM_FERIADOS F ON T.DATA = F.DATA
	WHERE T.ANO = @ano

end

EXEC so_atualiza_feriado '2023'
