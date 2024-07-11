CREATE DATABASE euro_campeonato;
-- Tabela Paises
CREATE TABLE paises (
id SERIAL PRIMARY KEY,
nome VARCHAR(255) NOT NULL
);
-- Tabela Cidades
CREATE TABLE cidades (
id SERIAL PRIMARY KEY,
nome VARCHAR(255) NOT NULL,
pais_id INT,
FOREIGN KEY (pais_id) REFERENCES paises(id)
);
-- Tabela Estadios
CREATE TABLE estadios (
id SERIAL PRIMARY KEY,
nome VARCHAR(255) NOT NULL,
cidade_id INT,
capacidade INT,
FOREIGN KEY (cidade_id) REFERENCES cidades(id)
);
-- Tabela Selecoes
CREATE TABLE selecoes (
id SERIAL PRIMARY KEY,
nome VARCHAR(255) NOT NULL,
pais_id INT,
FOREIGN KEY (pais_id) REFERENCES paises(id)
);

-- Tabela Jogadores
CREATE TABLE jogadores (
id SERIAL PRIMARY KEY,
nome VARCHAR(255) NOT NULL,
idade INT,
posicao VARCHAR(255),
selecao_id INT,
FOREIGN KEY (selecao_id) REFERENCES selecoes(id)
);
-- Tabela Partidas
CREATE TABLE partidas (
id SERIAL PRIMARY KEY,
gols_selecao1 INT,
gols_selecao2 INT,
estatisticas_equipe1_id INT,
estatisticas_equipe2_id INT,
selecao_casa_id INT,
selecao_fora_id INT,
estadio_id INT,
grupo_id INT,
data_hora TIMESTAMP,
FOREIGN KEY (selecao_casa_id) REFERENCES selecoes(id),
FOREIGN KEY (selecao_fora_id) REFERENCES selecoes(id),
FOREIGN KEY (grupo_id) REFERENCES grupos(id),
FOREIGN KEY (estadio_id) REFERENCES estadios(id),
FOREIGN KEY (estatisticas_equipe1_id) REFERENCES EstatisticasGlobaisEquipe(id),
FOREIGN KEY (estatisticas_equipe2_id) REFERENCES EstatisticasGlobaisEquipe(id)
);

-- Tabela Eventos
CREATE TABLE eventos (
id SERIAL PRIMARY KEY,
tipo VARCHAR(255),
jogador_id INT,
minuto INT,
partida_id INT,
FOREIGN KEY (jogador_id) REFERENCES jogadores(id),
FOREIGN KEY (partida_id) REFERENCES partidas(id)
);
-- Tabela Grupos
CREATE TABLE grupos (
id SERIAL PRIMARY KEY,
nome VARCHAR(1) NOT NULL
);
-- Tabela Selecao_Grupo
CREATE TABLE selecao_grupo (
id SERIAL PRIMARY KEY,
grupo_id INT NOT NULL,
selecao_id INT NOT NULL,
pontos INT DEFAULT 0,
jogos INT DEFAULT 0,
vitorias INT DEFAULT 0,
empates INT DEFAULT 0,
derrotas INT DEFAULT 0,
gols_pro INT DEFAULT 0,
gols_contra INT DEFAULT 0,
FOREIGN KEY (grupo_id) REFERENCES grupos(id),
FOREIGN KEY (selecao_id) REFERENCES selecoes(id)
);
-- Tabela Substituicao
CREATE TABLE substituicao (
id SERIAL PRIMARY KEY,
partida_id INT NOT NULL,
jogador_sai_id INT NOT NULL,
jogador_entra_id INT NOT NULL,
minuto INT,
FOREIGN KEY (partida_id) REFERENCES partidas(id),
FOREIGN KEY (jogador_sai_id) REFERENCES jogadores(id),
FOREIGN KEY (jogador_entra_id) REFERENCES jogadores(id)
);
-- Tabela Golo
CREATE TABLE golo (
id SERIAL PRIMARY KEY,
partida_id INT NOT NULL,
jogador_id INT NOT NULL,
minuto INT,
FOREIGN KEY (partida_id) REFERENCES partidas(id),
FOREIGN KEY (jogador_id) REFERENCES jogadores(id)
);
-- Tabela Cartao
CREATE TABLE cartao (
id SERIAL PRIMARY KEY,
partida_id INT NOT NULL,
jogador_id INT NOT NULL,
tipo VARCHAR(10), -- 'amarelo' ou 'vermelho'
minuto INT,
FOREIGN KEY (partida_id) REFERENCES partidas(id),
FOREIGN KEY (jogador_id) REFERENCES jogadores(id)
);
-- Tabela EstatisticasGlobaisEquipe
CREATE TABLE estatisticas_globais_equipe (
     id SERIAL PRIMARY KEY,
     partida_id INT NOT NULL,
     selecao_id INT NOT NULL,
     remates INT,
     livres INT,
     foras_de_jogo INT,
     FOREIGN KEY (partida_id) REFERENCES partidas(id),
     FOREIGN KEY (selecao_id) REFERENCES selecoes(id)
);
-- Tabela EstatisticasIndividuais
CREATE TABLE estatisticas_individuais (
  id SERIAL PRIMARY KEY,
  partida_id INT NOT NULL,
  jogador_id INT NOT NULL,
  passes INT,
  assistencias INT,
  remates INT,
  minutos_jogados INT,
  FOREIGN KEY (partida_id) REFERENCES partidas(id),
  FOREIGN KEY (jogador_id) REFERENCES jogadores(id)
);