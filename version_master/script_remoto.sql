create table paises
(
id   serial
primary key,
nome varchar(255) not null
);
create table cidades
(
id      serial
primary key,
nome    varchar(255) not null,
pais_id integer      not null
references paises
);
create table estadios
(
id         serial
primary key,
nome       varchar(255) not null,
cidade_id  integer      not null
references cidades,
capacidade integer
);
create table selecoes
(
id      serial
primary key,
nome    varchar(255) not null,
pais_id integer      not null
references paises
);
create table jogadores
(
id         serial
primary key,
nome       varchar(255) not null,
idade      integer,
posicao    varchar(255),
selecao_id integer      not null
references selecoes
);
create table eventos
(
id         serial
primary key,
tipo       varchar(255) not null,
jogador_id integer      not null
references jogadores,
minuto     integer,
partida_id integer      not null
);

create table grupos
(
id   serial
primary key,
nome varchar(1) not null
);


create table selecao_grupo
(
id          serial
primary key,
grupo_id    integer not null
references grupos,
selecao_id  integer not null
references selecoes,
pontos      integer default 0,
jogos       integer default 0,
vitorias    integer default 0,
empates     integer default 0,
derrotas    integer default 0,
gols_pro    integer default 0,
gols_contra integer default 0
);

create table substituicao
(
id               serial
primary key,
partida_id       integer not null,
jogador_sai_id   integer not null
references jogadores,
jogador_entra_id integer not null
references jogadores,
minuto           integer
);


create table cartao
(
id         serial
primary key,
partida_id integer     not null,
jogador_id integer     not null
references jogadores,
tipo       varchar(10) not null,
minuto     integer
);

create table golo
(
id         serial
primary key,
partida_id integer,
jogador_id integer
references jogadores,
minuto     integer
);


create table estatisticas_individuais
(
id              serial
primary key,
partida_id      integer,
jogador_id      integer
references jogadores,
passes          integer,
assistencias    integer,
remates         integer,
minutos_jogados integer
);


create table estatisticas_globais_equipe
(
id            serial
primary key,
partida_id    integer,
selecao_id    integer
references selecoes,
remates       integer,
livres        integer,
foras_de_jogo integer
);


create table partidas
(
id                      serial
primary key,
gols_selecao1           integer,
gols_selecao2           integer,
estatisticas_equipe1_id integer
references estatisticas_globais_equipe,
estatisticas_equipe2_id integer
references estatisticas_globais_equipe,
selecao_casa_id         integer
references selecoes,
selecao_fora_id         integer
references selecoes,
estadio_id              integer
references estadios,
data_hora               timestamp,
grupo_id                integer
references grupos
);
