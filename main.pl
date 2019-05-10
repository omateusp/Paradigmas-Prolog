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
estado('rio_grande_do_sul', 20).
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

eh_vizinho(X,Y) :- (vizinho(X,Y);vizinho(Y,X)).

game_start :-
    write('Bem vindo ao jogo da viagem'), nl,
    random(0, 27, Obj),
	write('O seu objetivo no jogo chegar no estado brasileiro: '),
    estado(X, Obj),
    write(X), nl,
	write('Voce inicia sua viagem no estado '),
    random(0, 27, Inicial),
    estado(Y, Inicial),
    assert(posicao(you, Y)),
    write(Y),
    lista_vizinhos(acre).

lista_vizinhos(Atual) :-
    vizinho(Atual, X).
