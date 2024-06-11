%beagle(nombre, altura, peso)
%cocker(nombre, peso, altura, genero)
%perro(duenio, perro, caracteristicas del perro)
perro(lucia, beagle(kongo, 20, 15), [jugueton, carinioso, tonto]).
perro(lucia, cocker(susi, 13, 38, hembra), [inteligente, bueno]).
perro(lucia, cocker(nana, 13, 38, hembra), [inteligente, bueno]).
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

estandarRacial(beagle(_, Altura, _)) :-
    enRango(40, 33, Altura).

estandarRacial(cocker(_, Peso, Altura, hembra)) :-
    enRango(39, 38, Altura), enRango(15, 13, Peso).

estandarRacial(cocker(_, Peso, Altura, macho)) :-
    enRango(41, 39, Altura), enRango(15, 13, Peso).


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

%3. Todos los perros se pueden enfermar antes de la competencia, pero sabemos, por estadística, 
%que los perros de Lucía no se enferman ni tampoco aquellos que cumplan con el estándar racial. 
%Así que debemos hacer el predicado que nos diga si un perro puede estar enfermo.
%> puedeEstarEnfermo(ayudanteDeSanta).
%true.

puedeEstarEnfermo(NombrePerro) :-
    perro(Duenio, Perro, _),
    Duenio \= lucia,
    not(estandarRacial(Perro)),
    nombrePerro(Perro, NombrePerro).

nombrePerro(cocker(NombrePerro, _, _, _), NombrePerro).
nombrePerro(beagle(NombrePerro, _, _), NombrePerro).
nombrePerro(NombrePerro, NombrePerro).

/*
4. Hay un dicho que dice que los perros se parecen a su dueño.
Veamos si podemos saber qué perros se parecen a qué humanos. Un perro 
se parece a un humano si todos las características que tienen un humano,
las tiene ese perro.
> sePareceASuDuenio(X, Y).
X = homero,
Y = ayudanteDeSanta
X = gise,
Y = cocker(polo, 20, 41, macho)
X = ralph,
Y = beagle(kongo, 20, 15)
X = ralph,
Y = ayudanteDeSanta. */

incluido(A, B):-forall(member(X, A), member(X, B)).

sePareceASuDuenio(Humano, Perro) :-caracteristicas(Humano, CaracteristicasHumano),  
   	caracteristicas(Perro, CaracteristicasPerro),      
    incluido(CaracteristicasHumano, CaracteristicasPerro).

%5. Como toda competencia tiene un ganador, queremos ver el dueño de perros 
%que mas chances tiene de ganar. Para eso, debe tener al menos 2 perros que 
%cumplan con el estándar racial.
puedeGanar(Duenio):-humano(Duenio, _),findall(Perro, (perro(Duenio,Perro, _), estandarRacial(Perro)), 
                                 ListaCumplen),length(ListaCumplen, Cantidad),Cantidad >= 2.

%6. 6. Queremos verificar si todos los perros de una determinada raza tienen un peso dentro de cierto rango. 
%Implementa un predicado que verifique si todos los perros de una raza específica cumplen con esta condición.

razaDePerro(beagle(_, _, _), beagle).
razaDePerro(cocker(_, _, _, _), cocker).

pesoPerro(beagle(_, _, Peso), Peso).
pesoPerro(cocker(_, Peso, _, _), Peso).

cumplen(Raza, PesoMinimo, PesoMaximo) :-razaDePerro( _, Raza),
    forall((perro(_, Perro, _), razaDePerro(Perro, Raza),pesoPerro(Perro, Peso)),
           (enRango(PesoMaximo,PesoMinimo, Peso))).
           
enRango(NumeroMax, NumeroMin, X):- 
    X =< NumeroMax,
    X >= NumeroMin.












