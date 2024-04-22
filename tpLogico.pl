%beagle(nombre, altura, peso)
%cocker(nombre, peso, altura, genero)
%perro(duenio, perro, caracteristicas del perro)
perro(lucia, beagle(kongo, 20, 15), [jugueton, carinioso, tonto]).
perro(lucia, cocker(susi, 13, 38, hembra), [inteligente, bueno]).
perro(gise, cocker(polo, 20, 41, macho), [malo, inteligente]).
perro(homero,ayudanteDeSanta, [carinioso,tonto, vago]).
gato(senioraDeLosGatos, flufy).
gato(senioraDeLosGatos, michifuz).
%humano(nombre, características)
humano(homero, [tonto, vago]).
humano(lucia, [carinioso, inteligente]).
humano(gise, [inteligente, malo]).
humano(ralph, [tonto, carinioso]).
%1
%estandarRacial():-
%-Los beagles tienen que tener una altura entre 33 y 40cms
%-Los cockers una altura entre 38 y 39cm si es hembra y entre 39 y 41 si es macho. 
%Además deben tener peso entre 13 y 15kg sin importar su género.
%-Los perros sin raza no tienen estándar racial.
%> estandarRacial(beagle(loquito, 36, 15)).
%True %porque su altura es de 36 y está entre la altura necesaria

estandarRacial(NombrePerro):- perro(_,beagle(NombrePerro,Altura,_),_),Altura >= 33, Altura =< 40.
estandarRacial(NombrePerro):- perro(_,cocker(NombrePerro,Peso,Altura,hembra),_),
    Altura >= 38, Altura =< 39, Peso >= 13, Peso =< 15.
estandarRacial(NombrePerro):- perro(_,cocker(NombrePerro,Peso,Altura,macho),_),
    Altura >= 39, Altura =< 41, Peso >= 13, Peso =< 15.
estandarRacial(_):- false.

%2Ahora necesitamos obtener cada una de las características indistintamente de si es un humano o un perro.
%>caracteristica(beagle(A, _, _), X).
%A = kongo,
%X = jugueton
%A = kongo,
%X = carinioso
%>caracteristica(homero, X).
%X = tonto
%X = vago

caracteristicas(Nombre, Caracteristicas):- perro(_, Nombre, Caracteristicas).
caracteristicas(Nombre, Caracteristicas):- perro(_, beagle(Nombre, _, _), Caracteristicas).
caracteristicas(Nombre, Caracteristicas):- perro(_, cocker(Nombre, _, _, _), Caracteristicas).
caracteristicas(Nombre, Caracteristicas):- humano(Nombre, Caracteristicas).























