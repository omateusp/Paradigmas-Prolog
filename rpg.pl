game_start :-
    dynamic(player_status/2),
    assert(player_status(vivo, 1)),
    compile_predicates([player_status/2]),
	write('Bem vindo ao jogo'), nl,
	write('Voce acorda no meio de uma estrada,'),
	write(' um lado da estrada leva para um(a) '),
    random(0,3,Mapn2),
    map_list(Y,Mapn2),
    write(Y),
    write(' o outro para um(a) '),
    random(0,3,Mapn3),
    map_list(Z,Mapn3),
    write(Z),
    write(', escolha sua alternativa digitando o nome do local.'),nl,
    valid_go(Y, Z).

valid_go(Y, Z) :-
    read(Alternative),
    (Y = Alternative ; Z = Alternative) -> go_to(Alternative);
    write('Este destino eh invalido, digite uma opcao valida:'),nl,
    valid_go(Y,Z).

next_map :-
    player_status(vivo, 1),
	write('Agora voce pode ir para um(a) '),
    random(0,4,Mapn2),
    map_list(Y,Mapn2),
    write(Y),
    write(' ou para um(a) '),
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
map_list(deserto, 2).
map_list(castelo, 3).

is_alive :-
    player_status(vida, HP),
    HP > 0 -> write('Sua vida atual eh '), nl,
    write(HP),nl;nl,
    write('Voce morreu :('),nl,
    dynamic(player_status/2),
    retract(player_status(vivo, 1)),
    assert(player_status(vivo, 0)),
    compile_predicates([player_status/2]).

reward(0) :- nl,
    player_status(vivo, 1),
    write('Voce encontrou uma banana, recuperou 10 de vida.'), nl, nl,
    player_status(vida, X),
    R is X + 10,
    dynamic(player_status/2),
    retract(player_status(vida, X)),
    assert(player_status(vida, R)),
    compile_predicates([player_status/2]),
    is_alive.
reward(1) :- nl,
    player_status(vivo, 1),
    write('Voce foi atacado por um lobo, durante a luta perdeu 15 de vida.'), nl,nl,
    player_status(vida, X),
    R is X - 15,
    dynamic(player_status/2),
    retract(player_status(vida, X)),
    assert(player_status(vida, R)),
    compile_predicates([player_status/2]),
    is_alive.
reward(2) :- nl,
    player_status(vivo, 1),
    write('Voce foi atacado por um rato, durante a batalha perdeu 10 de vida.'),nl, nl,
    player_status(vida, X),
    R is X - 10,
    dynamic(player_status/2),
    retract(player_status(vida, X)),
    assert(player_status(vida, R)),
    compile_predicates([player_status/2]),
    is_alive.
reward(3) :- nl,
    player_status(vivo, 1),
    write('Voce encontrou a chave do castelo, corra para salvar a princesa.'),nl, nl,
    dynamic(player_status/2),
    assert(player_status(item,key)),
    compile_predicates([player_status/2]).
reward(_) :- nl,
    player_status(vivo, 1),
    write('O caminho foi tranquilo e sem surpresas.'),nl,nl.

go_to(praia) :-
    random(0,5, R),
    reward(R),
    player_status(vivo, 1),
    write('Voce chegou a praia!!'),nl,
    nl,beach_art,nl,
    next_map.
go_to(floresta) :-
    random(0,5, R),
    reward(R),
    player_status(vivo, 1),
    write('Voce chegou a floresta!!'),nl,
    nl,forest_art,nl,
    next_map.
go_to(deserto) :-
    random(0,5, R),
    reward(R),
    player_status(vivo, 1),
    write('Voce chegou ao deserto!!'),nl,
    nl,desert_art,nl,
    next_map.
go_to(castelo) :-
    random(0,5, R),
    reward(R),
    player_status(vivo, 1),
    nl,castle_art,nl,
    player_status(item,key) ->
    (write('Parabens voce chegou ao castelo e salvou a princesa!!'),nl);
    write('A porta está trancada, encontre a chave e retorne ao castelo.'),
    nl, next_map.

beach_art :-
    format('_\\/_                 |                _\\/_'),nl,
    format('/o\\\\             \\       /            //o\\'),nl,
    format(' |                 .---.                |'),nl,
    format('_|_______     --  /     \\  --     ______|__'),nl,
    format('         `~~^~~^~~^~~^~~^~~^~~^~~^~~^~~^~~^~~`'),nl.

desert_art :-
    format('.    _    +     .  ______   .          .'),nl,
    format('(      /|\\      .    |      \\      .   +'),nl,
    format('.     |||||     _    | |   | | ||         .'),nl,
    format('.     |||||    | |  _| | | | |_||    .'),nl,
    format('  /\\  ||||| .  | | |   | |      |       .'),nl,
    format('_||||_|||||____| |_|_____________\\__________'),nl,
    format('.|||| |||||  /\\   _____      _____  .   .'),nl,
    format(' |||| ||||| ||||   .   .  .         ________'),nl,
    format('. \\|`-`|||| ||||    __________       .    .'),nl,
    format('   \\__ |||| ||||      .          .     .'),nl,
    format('__     ||||`-`|||  .       .    __________'),nl,
    format('.    . |||| ___/  ___________             .'),nl,
    format('. _    ||||| . _               .   _________'),nl,
    format('_   ___|||||__  _ \\\\--//    .          _'),nl,
    format('_ `---`    .)=\\oo|=(.   _   .   .    .'),nl,
    format('_  ^      .  -    . \\.|'),nl.

castle_art :-
    format('[][][] /""\\ [][][]'),nl,
    format(' |::| /____\\ |::|'),nl,
    format(' |[]|_|::::|_|[]|'),nl,
    format(' |::::::__::::::|'),nl,
    format(' |:::::/||\\:::::|'),nl,
    format(' |:#:::||||::#::|'),nl,
    format('#%*###&*##&*&#*&##'),nl,
    format('##%%*####*%%%###*%*#'),nl.

forest_art :-
    format('                                   /\\'),nl,
    format('                              /\\  //\\\\'),nl,
    format('                       /\\    //\\\\///\\\\\\        /\\'),nl,
    format('                      //\\\\  ///\\////\\\\\\\\  /\\  //\\\\'),nl,
    format('         /\\          /  ^ \\/^ ^/^  ^  ^ \\/^ \\/  ^ \\'),nl,
    format('        / ^\\    /\\  / ^   /  ^/ ^ ^ ^   ^\\ ^/  ^^  \\'),nl,
    format('       /^   \\  / ^\\/ ^ ^   ^ / ^  ^    ^  \\/ ^   ^  \\       *'),nl,
    format('      /  ^ ^ \\/^  ^\\ ^ ^ ^   ^  ^   ^   ____  ^   ^  \\     /|\\'),nl,
    format('     / ^ ^  ^ \\ ^  _\\___________________|  |_____^ ^  \\   /||o\\'),nl,
    format('    / ^^  ^ ^ ^\\  /______________________________\\ ^ ^ \\ /|o|||\\'),nl,
    format('   /  ^  ^^ ^ ^  /________________________________\\  ^  /|||||o|\\'),nl,
    format('  /^ ^  ^ ^^  ^    ||___|___||||||||||||___|__|||      /||o||||||\\   |'),nl,
    format(' / ^   ^   ^    ^  ||___|___||||||||||||___|__|||          | |       |'),nl,
    format('/ ^ ^ ^  ^  ^  ^   ||||||||||||||||||||||||||||||oooooooooo| |ooooooo|'),nl,
    format('ooooooooooooooooooooooooooooooooooooooooooooooooooooooooo'),nl.
