-- Script para povoar a dimensão tempo
	
create or alter procedure sp_dim_tempo (@dt_inicial datetime, @dt_final datetime)
as
begin
    SET NOCOUNT ON
    SET LANGUAGE BRAZILIAN

	WHILE (@DT_INICIAL < @DT_FINAL)
	BEGIN
		DECLARE @ANO_ATUAL INT = YEAR(@dt_inicial)

		INSERT INTO DIM_TEMPO (NIVEL, ANO)
		VALUES ('ANO', @ANO_ATUAL)
			

		WHILE (@ANO_ATUAL = YEAR(@DT_INICIAL) AND @DT_INICIAL <= @DT_FINAL)
		BEGIN
			DECLARE @NOME_TRI VARCHAR(20),
					@NOME_SEM VARCHAR(20),
					@NUM_SEM INT,
					@MES_ATUAL INT = MONTH(@DT_INICIAL)

			IF(DATEPART(QQ, @DT_INICIAL) = 1)
			BEGIN
				SET @NOME_TRI = '1º Trimestre'
				SET @NOME_SEM = '1º Semestre'
				SET @NUM_SEM = 1
			END
			IF(DATEPART(QQ, @DT_INICIAL) = 2)
			BEGIN
				SET @NOME_TRI = '2º Trimestre'
				SET @NOME_SEM = '1º Semestre'
				SET @NUM_SEM = 1
			END
			IF(DATEPART(QQ, @DT_INICIAL) = 3)
			BEGIN
				SET @NOME_TRI = '3º Trimestre'
				SET @NOME_SEM = '2º Semestre'
				SET @NUM_SEM = 2
			END
			IF(DATEPART(QQ, @DT_INICIAL) = 4)
			BEGIN
				SET @NOME_TRI = '4º Trimestre'
				SET @NOME_SEM = '2º Semestre'
				SET @NUM_SEM = 2
			END

			INSERT INTO DIM_TEMPO (NIVEL, MES, NOME_MES, TRIMESTRE, NOME_TRIMESTRE,SEMESTRE, NOME_SEMESTRE, ANO)
			VALUES ('MES', MONTH(@DT_INICIAL), DATENAME(MM,@DT_INICIAL), DATEPART(QQ, @DT_INICIAL), @NOME_TRI, @NUM_SEM, @NOME_SEM, YEAR(@DT_INICIAL))

			WHILE (@MES_ATUAL = MONTH(@DT_INICIAL) AND @ANO_ATUAL = YEAR(@DT_INICIAL))
			BEGIN
				DECLARE @FIM_SEM VARCHAR(3) = 'NAO'
					
				IF(DATENAME(WEEKDAY, @DT_INICIAL) = 'Domingo' OR DATENAME(WEEKDAY, @DT_INICIAL) = 'S�bado')
					SET @FIM_SEM = 'SIM'

				INSERT INTO DIM_TEMPO VALUES
				('DIA', @DT_INICIAL, DAY(@DT_INICIAL), DATENAME(WEEKDAY, @DT_INICIAL), @FIM_SEM, NULL, 'NAO', DATEPART(MM, @DT_INICIAL), DATENAME(MM, @DT_INICIAL), DATEPART(QQ, @DT_INICIAL), @NOME_TRI, @NUM_SEM, @NOME_SEM, YEAR(@DT_INICIAL))

				SET @DT_INICIAL = DATEADD(DAY, 1, @DT_INICIAL)
			END
		END
	END
end

exec sp_dim_tempo '20230101', '20230701'


select * from dim_tempo

INSERT INTO DIM_FERIADOS(DATA,DESCRICAO,TIPO)VALUES
('2024-01-01','Confraternização Universal','NACIONAL'),
('2024-12-02','Carnaval','NACIONAL'),
('2024-13-02','Carnaval','NACIONAL'),
('2024-23-03','Paixão de Cristo','NACIONAL'),
('2024-21-04','Tiradentes','NACIONAL'),
('2024-01-05','Dia do Trabalho','NACIONAL'),
('2024-30-05','Corpus Christi','NACIONAL'),
('2024-07-09','Independência do Brasil','NACIONAL'),
('2024-12-10','Nossa Sr. Aparecida - Padroeira do Brasil','NACIONAL'),
('2024-02-11','Finados','NACIONAL'),
('2024-15-11','Proclamação da República','NACIONAL'),
('2024-20-11','Dia Nacional de Zumbi e da Consciência Negra','NACIONAL'),
('2024-25-12','Natal','NACIONAL')
select * from DIM_FERIADOS

create or alter procedure so_atualiza_feriado(@ano int)
as
begin
	update DIM_TEMPO SET FL_FERIADO = 'SIM', FERIADO = F.DESCRICAO
	from DIM_TEMPO T
	INNER JOIN DIM_FERIADOS F on (T.DATA = F.DATA)
	where T.ANO = @ANO
end

EXEC so_atualiza_feriado 2024
