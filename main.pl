%game_start(1) :- write('Obrigado por jogar o jogo'), nl, !.

game_start :-	write('Bem vindo ao jogo'), nl,
    random(0,3,Mapn),
	write('O seu objetivo no jogo e achar a chave e entrar no castelo para salvar a princesa, voce esta atualmente em um(a) '),
    map_list(X,Mapn),
    %assert(plocation(you, X)),
    write(X), nl,
	write('Voce pode ir para um(a) (1)'),
    random(0,3,Mapn2),
    map_list(Y,Mapn2),
    write(Y),
    write(' ou para um(a) (2)'),
    random(0,3,Mapn3),
    map_list(Z,Mapn3),
    write(Z),
    write(', escolha sua alternativa digitando o nome do local.'),nl,
	read(Alternative),
    (Y = Alternative ; Z = Alternative),
    go_to(Alternative).

%game_start(2) :- play.

map_list(praia, 0).
map_list(floresta, 1).
map_list(caverna, 2).
map_list(castelo, 3).

%reward().
%reward().

go_to(praia) :-
    beach_art.

beach_art :-
    format('_\\/_                 |                _\\/_'),nl,
    format('/o\\\\             \\       /            //o\\'),nl,
    format(' |                 .---.                |'),nl,
    format('_|_______     --  /     \\  --     ______|__'),nl,
    format('         `~~^~~^~~^~~^~~^~~^~~^~~^~~^~~^~~^~~`').
