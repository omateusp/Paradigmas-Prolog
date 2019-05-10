%estados brasileiros.
estado(acre, 0).
estado(alagoas, 1).
estado(amapa, 2).
estado(amazonas, 3).
estado(bahia, 4).
estado(ceara, 5).
estado(distrito_federal, 6).
estado(espirito_santo, 7).
estado(goias, 8).
estado(maranhao, 9).
estado(mato_grosso, 10).
estado(mato_grosso_do_sul, 11).
estado(minas_gerais, 12).
estado(para, 13).
estado(paraiba, 14).
estado(parana, 15).
estado(pernambuco, 16).
estado(piaui, 17).
estado(rio_de_janeiro, 18).
estado(rio_grande_do_norte, 19).
estado(rio_grande_do_sul, 20).
estado(rondonia, 21).
estado(roraima, 22).
estado(santa_catarina, 23).
estado(sao_paulo, 24).
estado(sergipe, 25).
estado(tocantins, 26).

%vizinhos
vizinho(acre, amazonas).
vizinho(acre, rondonia).
vizinho(amazonas, roraima).
vizinho(amazonas, para).
vizinho(amazonas, rondonia).
vizinho(amazonas, mato_grosso).
vizinho(roraima, para).
vizinho(amapa, para).
vizinho(rondonia, mato_grosso).
vizinho(para, mato_grosso).
vizinho(para, tocantins).
vizinho(para, maranhao).
vizinho(mato_grosso, mato_grosso_do_sul).
vizinho(mato_grosso, goias).
vizinho(mato_grosso, tocantins).
vizinho(mato_grosso_do_sul, goias).
vizinho(mato_grosso_do_sul, minas_gerais).
vizinho(mato_grosso_do_sul, sao_paulo).
vizinho(mato_grosso_do_sul, parana).
vizinho(parana, sao_paulo).
vizinho(parana, santa_catarina).
vizinho(santa_catarina, rio_grande_do_sul).
vizinho(sao_paulo, rio_de_janeiro).
vizinho(sao_paulo, minas_gerais).
vizinho(rio_de_janeiro, minas_gerais).
vizinho(rio_de_janeiro, espirito_santo).
vizinho(minas_gerais, distrito_federal).
vizinho(minas_gerais, goias).
vizinho(minas_gerais, bahia).
vizinho(minas_gerais, espirito_santo).
vizinho(goias, distrito_federal).
vizinho(goias, tocantins).
vizinho(goias, bahia).
vizinho(tocantins, maranhao).
vizinho(tocantins, piaui).
vizinho(tocantins, bahia).
vizinho(bahia, espirito_santo).
vizinho(bahia, piaui).
vizinho(bahia, sergipe).
vizinho(bahia, alagoas).
vizinho(bahia, pernambuco).
vizinho(sergipe, alagoas).
vizinho(alagoas, pernambuco).
vizinho(pernambuco, piaui).
vizinho(pernambuco, paraiba).
vizinho(pernambuco, ceara).
vizinho(paraiba, rio_grande_do_norte).
vizinho(paraiba, ceara).
vizinho(rio_grande_do_norte, ceara).
vizinho(ceara, piaui).
vizinho(piaui, maranhao).

capital(acre, rio_branco).
capital(alagoas, maceio).
capital(amapa, macapa).
capital(amazonas, manaus).
capital(bahia, salvador).
capital(ceara, fortaleza).
capital(distrito_federal, brasilia).
capital(espirito_santo, vitoria).
capital(goias, goiania).
capital(maranhao, sao_luis).
capital(mato_grosso, cuiaba).
capital(mato_grosso_do_sul, campo_grande).
capital(minas_gerais, belo_horizonte).
capital(para, belem).
capital(paraiba, joao_pessoa).
capital(parana, curitiba).
capital(pernambuco, recife).
capital(piaui, teresina).
capital(rio_de_janeiro, rio_de_janeiro).
capital(rio_grande_do_norte, natal).
capital(rio_grande_do_sul, porto_alegre).
capital(rondonia, porto_velho).
capital(roraima, boa_vista).
capital(santa_catarina, florianopolis).
capital(sao_paulo, sao_paulo).
capital(sergipe, aracaju).
capital(tocantins, palmas).

eh_vizinho(X,Y) :- (vizinho(X,Y);vizinho(Y,X)).

vizinhos :-
    posicao(you, Atual),
    (findall(X,eh_vizinho(Atual,X),Vizinhos)),
    write(Vizinhos).

posicao_atual :-
    posicao(you, Atual),
    write(Atual).

destino :-
    objetivo(you, Dest),
    write(Dest).

game_start :-
    retractall(posicao(you,X)),
    write('Bem vindo ao jogo da viagem'), nl,
    random(0, 27, Obj),
	write('O seu objetivo no jogo eh chegar no estado brasileiro: '),
    estado(X, Obj),
    assert(objetivo(you,X)),
    write(X), nl,nl,
    write('Regras: voce so pode viajar entre estados vizinhos.'),nl,nl,
    write('Comandos:'),nl,
    write('viajar(Destino). -- permite ao jogador viajar para um estado vizinho.'),nl,
    write('eh_vizinho(X, Y). -- permite verificar todos os vizinhos de um estado.'),nl,
    write('vizinhos. -- pesquisa os vizinhos atuais.'),nl,
    write('destino. -- verifica o estado de destino.'),nl,
    write('posicao_atual. -- verifica a posicao atual.'),nl,nl,
	write('Voce iniciara sua viagem no estado: '),
    another(Obj, X, Inicial),
    estado(Y, Inicial),
    assert(posicao(you, Y)),
    write(Y),nl.

another(Obj, Obj_name, Inicial) :-
    random(0, 27, X),
    estado(Spawn, X),
    \+(X = Obj),\+(eh_vizinho(Spawn, Obj_name)) -> Inicial is X; another(Obj, Obj_name, Inicial).

venceu :-
    objetivo(you, Obj),
    posicao(you, Pos),
    \+(Pos = Obj) -> nl ; nl,nl,write('Parabens vc chegou ao destino!!'),nl.

verificar_capital(Dest) :-
    read(Capital),
    capital(Dest, Dest_cap),
    Capital = Dest_cap -> nl,write('Resposta correta.'),nl;
    write('Resposta incorreta, tente novamente:'),nl,
    verificar_capital(Dest).

viajar(Dest) :-
    posicao(you, Atual),
    eh_vizinho(Dest, Atual),nl,
    write('Para viajar precisa digitar o nome da capital do estado '),
    write(Dest),nl,
    verificar_capital(Dest),
    retract(posicao(you, Atual)),
    assert(posicao(you, Dest)),
    write('Voce esta no estado '),
    write(Dest),
    write(' agora.'),nl,
    venceu.
