Contrução da Tabela de Feature Engineering

CREATE OR REPLACE TABLE `ivory-enigma-402100.CrimeStudy.01_crime_features` AS
SELECT
    IFNULL(clearance_status, 'UNKNOWN_STATUS') AS clearance_status,
    SAFE_CAST(IFNULL(FORMAT_DATE('%Y-%m-%d', SAFE_CAST(clearance_date AS DATE)), 'UNKNOWN_DATE') AS STRING) AS clearance_date,
    IFNULL(district, 'UNKNOWN_DISTRICT') AS district,
    -- Extrai o dia da semana (nome completo) como uma string
    SAFE_CAST(FORMAT_DATETIME('%A', timestamp) AS STRING) AS day_of_week_name,
    -- Extrai o ano da data de conclusão como um número inteiro
    SAFE_CAST(IFNULL(EXTRACT(YEAR FROM SAFE_CAST(clearance_date AS DATE)), -1) AS INT64) AS clearance_year,
    -- Caso o tipo primário do crime seja nulo, atribui 'UNKNOWN'
    IFNULL(primary_type, 'UNKNOWN_CRIME_TYPE') AS crime_type
FROM
    `bigquery-public-data.austin_crime.crime`
WHERE
    -- Garante que apenas registros com tipo primário e timestamp válidos sejam considerados
    primary_type IS NOT NULL
    AND timestamp IS NOT NULL;



--Criação dos Modelos
--Modelo 1 ( crime_type_predictor )
CREATE OR REPLACE MODEL `ivory-enigma-402100.CrimeStudy.02_crime_type_predictor`
OPTIONS(
    model_type='LOGISTIC_REG', -- Correção aqui
    labels=['crime_type']
) AS
SELECT
    clearance_status,
    clearance_date,
    district,
    day_of_week_name,
    clearance_year,
    crime_type
FROM
    `ivory-enigma-402100.CrimeStudy.01_crime_features`
WHERE
    crime_type != 'UNKNOWN_CRIME_TYPE'; -- Excluindo a categoria 'UNKNOWN' para um treinamento mais focado

--Modelo 2 ( district_predictor )
CREATE OR REPLACE MODEL `ivory-enigma-402100.CrimeStudy.03_district_predictor`
OPTIONS(
    model_type='LOGISTIC_REG', -- Correção aqui
    labels=['district']
) AS
SELECT
    clearance_status,
    clearance_date,
    day_of_week_name,
    clearance_year,
    crime_type,
    district
FROM
    `ivory-enigma-402100.CrimeStudy.01_crime_features`
WHERE
    district != 'UNKNOWN_DISTRICT'; -- Excluindo a categoria 'UNKNOWN'

Tabelas Finais para Análise
SELECT
    predicted_crime_type,
    -- Inclua as colunas de entrada para entender a previsão
    clearance_status,
    clearance_date,
    district,
    day_of_week_name,
    clearance_year
FROM
    ML.PREDICT(MODEL `ivory-enigma-402100.CrimeStudy.02_crime_type_predictor`,
               (
                   SELECT
                       clearance_status,
                       clearance_date,
                       district,
                       day_of_week_name,
                       clearance_year
                   FROM
                       `ivory-enigma-402100.CrimeStudy.01_crime_features`
                   -- Adicione aqui quaisquer filtros para os dados que você quer prever
                   -- Por exemplo, para prever em dados que não foram usados no treinamento:
                   -- WHERE RAND() < 0.2 -- Assumindo que você separou 20% para teste
               ))
LIMIT 100; -- Limite para não exibir muitas linhas




