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

next_map :-
	write('Agora voce pode ir para um(a) (1)'),
    random(0,4,Mapn2),
    map_list(Y,Mapn2),
    write(Y),
    write(' ou para um(a) (2)'),
    random(0,4,Mapn3),
    map_list(Z,Mapn3),
    write(Z),
    write(', escolha sua alternativa digitando o nome do local.'),nl,
	read(Alternative),
    (Y = Alternative ; Z = Alternative),
    go_to(Alternative).

player_status(vida, 100).
player_status(experiencia, 0).
player_status(level, 1).

map_list(praia, 0).
map_list(floresta, 1).
map_list(caverna, 2).
map_list(castelo, 3).

reward(0) :-
    write('Voce encontrou uma banana, recuperou 10 de vida.'), nl,
    player_status(vida, X),
    R is X + 10,
    write('Sua vida atual eh '), nl,
    write(R),nl,
    dynamic(player_status/2),
    retract(player_status(vida, X)),
    assert(player_status(vida, R)),
    compile_predicates([player_status/2]).
reward(1) :-
    write('Voce foi atacado por um lobo, durante a luta perdeu 15 de vida.'), nl,
    player_status(vida, X),
    R is X - 15,
    write('Sua vida atual eh '), nl,
    write(R),nl,
    dynamic(player_status/2),
    retract(player_status(vida, X)),
    assert(player_status(vida, R)),
    compile_predicates([player_status/2]).
reward(2) :-
    write('Voce foi atacado por um rato, durante a batalha perdeu 10 de vida.'), nl,
    player_status(vida, X),
    R is X - 10,
    write('Sua vida atual eh '), nl,
    write(R),nl,
    dynamic(player_status/2),
    retract(player_status(vida, X)),
    assert(player_status(vida, R)),
    compile_predicates([player_status/2]).
reward(X) :-
    write('O caminho foi tranquilo e sem surpresas.'),nl.

go_to(praia) :-
    random(0,5, R),
    reward(R),
    write('Voce chegou a praia!!'),nl,
    beach_art,
    next_map.
go_to(floresta) :-
    random(0,5, R),
    reward(R),
    write('Voce chegou a floresta!!'),nl,
    next_map.
go_to(caverna) :-
    random(0,5, R),
    reward(R),
    write('Voce chegou a caverna!!'),nl,
    next_map.
go_to(castelo) :-
    random(0,5, R),
    reward(R),
    write('Voce chegou ao castelo!!'),nl,
    next_map.
go_to(X) :-
    write('Essa opcao eh invalida, digite um opcao valida'),nl,
    read(Alternative),
    go_to(Alternative).

beach_art :-
    format('_\\/_                 |                _\\/_'),nl,
    format('/o\\\\             \\       /            //o\\'),nl,
    format(' |                 .---.                |'),nl,
    format('_|_______     --  /     \\  --     ______|__'),nl,
    format('         `~~^~~^~~^~~^~~^~~^~~^~~^~~^~~^~~^~~`').
