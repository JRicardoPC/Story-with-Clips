;INFO PLAYER
(deftemplate jugador ;objetos del inventario
    (slot vacio(type SYMBOL)(allowed-symbols si no))
    (slot mapa(type SYMBOL)(allowed-symbols si no))
    (slot linterna(type SYMBOL)(allowed-symbols si no))
    (slot llave(type SYMBOL)(allowed-symbols si no))
    (slot cerillas(type SYMBOL)(allowed-symbols si no))
)

;INVENTORY LIST
(deftemplate lista
    (slot listado(type INTEGER)(range 0 4));0- vacio 1- Mapa, 2-linterna, 3-Llave, 4-cerillas,
    (slot lint_us(type SYMBOL)(allowed-symbols on off))
    (slot cer_us(type SYMBOL)(allowed-symbols si no))
    (slot lla_us(type SYMBOL)(allowed-symbols si no))
)

;FINAL DOOR BLOCK
(deftemplate port_final
    (slot estado(type SYMBOL)(allowed-symbols abierta cerrada))
)

;CONTROL PANEL BLOCK
(deftemplate pan_cont
    (slot cristal(type SYMBOL)(allowed-symbols abierta cerrada))
)

;ROOM DEFINITION
(deftemplate habitacion
    (slot numero(type INTEGER));Numero de la habitacion
    (multislot num_port(type INTEGER)(range 1 10));Numero de las puertas que contiene
)

;ACTION DEFINITION
(deftemplate acciones
    (slot action(type INTEGER))
    (slot direccion(type INTEGER));A la que te quieres dirigir
)


;POSITION DEFINITION
(deftemplate posicion
    (slot pos(type INTEGER)(default 1))
)


;CARGAMOS LOS VALORES INICIALES
(deffacts comenzamos "Atributos iniciales"
    (jugador (vacio si) (mapa no) (linterna no) (cerillas no) (llave no))
    (habitacion (numero 1) (num_port 1 2))
    (habitacion (numero 2) (num_port 1))
    (habitacion (numero 3) (num_port 2 3 4))
    (habitacion (numero 4) (num_port 3 5))
    (habitacion (numero 5) (num_port 4 6 7 8))
    (habitacion (numero 6) (num_port 6 9))
    (habitacion (numero 7) (num_port 7))
    (habitacion (numero 8) (num_port 8 9))
    (habitacion (numero 9) (num_port 5 10))
    (posicion (pos 1))
    (port_final(estado cerrada))
    (pan_cont(cristal cerrada))
    (lista(lint_us off)(listado 0)(cer_us no)(lla_us no))
)

(defrule inicio
    (initial-fact)
    =>
    (printout t "" crlf)
    (printout t "" crlf)
    (printout t "" crlf)
    (printout t "" crlf)
    (printout t "" crlf)
    (printout t "" crlf)
    (printout t "" crlf)
    (printout t "" crlf)
    (printout t "" crlf)
    (printout t "" crlf)
    (printout t "" crlf)
    (printout t "" crlf)

    (printout t "" crlf)
    (printout t "" crlf)
    (printout t "                                                               Bienvenido a esta historia interactiva" crlf)
    (printout t "" crlf)
    (printout t "                                                           Recuerde que todas sus acciones decidiran su destino" crlf)
    (printout t "" crlf)
    (printout t "                                                                               Comenzamos!!!" crlf)
    (printout t "" crlf)
    (printout t "                                                                                     3" crlf)
    (printout t "" crlf)
    (printout t "                                                                                     2" crlf)
    (printout t "" crlf)
    (printout t "                                                                                     1" crlf)
    (printout t "" crlf)
    (printout t "" crlf)
    (printout t "" crlf)
    (printout t "" crlf)
    (printout t "" crlf)
    (printout t "" crlf)

    (printout t "" crlf)
    (printout t "" crlf)
    (printout t "" crlf)
    (printout t "" crlf)

    (printout t "   Despiertas en una extraña habitacion, ¿Como llegastes ahi?, los recuerdos de la noche anterior son difusos." crlf)
    (printout t "   Tras levantarte, y mirar la habitación, puedes ver en el centro una gran mesa con un papel encima." crlf)
    (printout t "   En frente tuyo, se encuentra una puerta gris con un gran 2 en rojo escrito en ella, y a tu izquierda otra con un 1" crlf)
    (printout t "   ¿Que quieres hacer?(1- avanzar, 2- usar o 3- investigar)" crlf)
    (bind ?act (read))
    (if (= ?act 1)
        then
        (printout t "   ¿A que puerta quieres avanzar?(1-Puerta uno  2-Puerta dos)" crlf)
        (bind ?port(read))
        (if (= ?port 1)
            then
            (assert (acciones (direccion 1)(action ?act)))
            else
            (assert (acciones (direccion 2)(action ?act))))
        else
        (assert (acciones (direccion 0)(action ?act))))
    (assert (posicion(pos 1)))
)



;*********************************************************************************************************************************************
;REGLAS DE AVANZAR

;---------------------------------------------------------------------------------------------------------------------------------------------
;REGLAS HABITACION 1

;estas en 1 y te quedas en 1
(defrule unoauno
    (and (posicion (pos 1))(acciones(direccion 0)(action 1)))
    ?direc <- (acciones(direccion ?x)
                       (action ?y))
    ?post <- (posicion(pos ?j))
    =>
    (printout t "   Sigues en la misma sala" crlf)
    (printout t "   ¿Que quieres hacer?(1- avanzar, 2- usar o 3- investigar)" crlf)
    (bind ?act (read))
    (if (= ?act 1)
        then
        (printout t "   ¿A que puerta quieres avanzar?(1-Puerta uno  2-Puerta dos)" crlf)
        (bind ?port(read))
        (if (= ?port 1)
            then
            (modify ?direc(direccion 1)(action ?act))
            else
            (modify ?direc(direccion 2)(action ?act)))
        else
        (modify ?direc(direccion 0)(action ?act)))
)

;estas en 2 q desde 1
(defrule unoados
    (and (posicion (pos 1))(acciones(direccion 1)(action 1)))
    ?direc <- (acciones(direccion ?x)
                       (action ?y))
    ?post <- (posicion(pos ?j))
    =>
    (printout t "   Tras cruzar la puerta, te das cuenta que te encuentras en un baño, el lavabo gotea lentamente, dejando un pequeño eco en la habitacion " crlf)
    (printout t "   la bañera esta cubierta por una fina capa de moho, y al espejo que tienes en frente, solo le quedan algunos fragmentos " crlf)
    (printout t "   ¿Que quieres hacer?(1- avanzar, 2- usar o 3- investigar)" crlf)
    (bind ?act (read))
    (if (= ?act 1)
        then
        (printout t "   ¿A que puerta quieres avanzar?(1-Puerta uno)" crlf)
        (bind ?port(read))
        (if (= ?port 1)
            then
            (modify ?direc (direccion 1)(action ?act)))
        else
        (modify ?direc (direccion 0)(action ?act)))
    (modify ?post (pos 2))
)


;estas en 3 desde 1
(defrule unoatres
    (and (posicion (pos 1))(acciones(direccion 2)(action 1)))
    ?direc <- (acciones(direccion ?x)
                       (action ?y))
    ?post <- (posicion(pos ?j))
    =>
    (printout t "   Tras cruzar la puerta llegas al un antiguo salon, una vieja lampara de techo cuelga en el centro, balanceandose lentamente" crlf)
    (printout t "   En el salon puedes ver 2 nuevas puertas, con un 3 y 4 respectivamente dibujado" crlf)
    (printout t "   ¿Que quieres hacer?(1- avanzar, 2- usar o 3- investigar)" crlf)
    (bind ?act (read))
    (if (= ?act 1)
        then
        (printout t "   ¿A que puerta quieres avanzar?(1-Puerta dos 2-Puerta tres 3-Puerta cuatro)" crlf)
        (bind ?port(read))
        (if (= ?port 1)
            then
            (modify ?direc(direccion 2)(action ?act))
            else
            (if (= ?port 2)
                then
                (modify ?direc(direccion 3)(action ?act))
                else
                (modify ?direc(direccion 4)(action ?act))))
        else
        (modify ?direc(direccion 0)(action ?act)))
    (modify ?post (pos 3))
)

;---------------------------------------------------------------------------------------------------------------------------------------------
;REGLAS HABITACION 2

;estas en 2 y te quedas en 2
(defrule dosados
    (and (posicion (pos 2))(acciones(direccion 0)(action 1)))
    ?direc <- (acciones(direccion ?x)
                       (action ?y))
    ?post <- (posicion(pos ?j))
    =>
    (printout t "   Sigues en la misma sala" crlf)
    (printout t "   ¿Que quieres hacer?(1- avanzar, 2- usar o 3- investigar)" crlf)
    (bind ?act (read))
    (if (= ?act 1)
        then
        (printout t "   ¿A que puerta quieres avanzar?(1-Puerta uno)" crlf)
        (bind ?port(read))
        (if (= ?port 1)
            then
            (modify ?direc (direccion 1)(action ?act)))
        else
        (modify ?direc (direccion 0)(action ?act)))
    (modify ?post (pos 2))
)

;estas en 1 desde 2
(defrule dosauno;2-1
    (and (posicion (pos 2))(acciones(direccion 1)(action 1)))
    ?direc <- (acciones(direccion ?x)
                       (action ?y))
    ?post <- (posicion(pos ?j))
    =>
    (printout t "   Vuelves a la sala inicial" crlf)
    (printout t "   ¿Que quieres hacer?(1- avanzar, 2- usar o 3- investigar)" crlf)
    (bind ?act (read))
    (if (= ?act 1)
        then
        (printout t "   ¿A que puerta quieres avanzar?(1-Puerta uno  2-Puerta dos)" crlf)
        (bind ?port(read))
        (if (= ?port 1)
            then
            (modify ?direc(direccion 1)(action ?act))
            else
            (modify ?direc(direccion 2)(action ?act)))
        else
        (modify ?direc(direccion 0)(action ?act)))
    (modify ?post (pos 1))
)


;---------------------------------------------------------------------------------------------------------------------------------------------
;REGLAS HABITACION 3

;estas en 3 y te quedas en 3
(defrule tresatres
    (and (posicion (pos 3))(acciones(direccion 0)(action 1)))
    ?direc <- (acciones(direccion ?x)
                       (action ?y))
    ?post <- (posicion(pos ?j))
    =>
    (printout t "   Sigues en la misma sala" crlf)
    (printout t "   ¿Que quieres hacer?(1- avanzar, 2- usar o 3- investigar)" crlf)
    (bind ?act (read))
    (if (= ?act 1)
        then
        (printout t "   ¿A que puerta quieres avanzar?(1-Puerta dos 2-Puerta tres 3-Puerta cuatro)" crlf)
        (bind ?port(read))
        (if (= ?port 1)
            then
            (modify ?direc(direccion 2)(action ?act))
            else
            (if (= ?port 2)
                then
                (modify ?direc(direccion 3)(action ?act))
                else
                (modify ?direc(direccion 4)(action ?act))))
        else
        (modify ?direc(direccion 0)(action ?act)))
    (modify ?post (pos 3))
)

;estas en 1 desde 3
(defrule tresauno;3-1
    (and (posicion (pos 3))(acciones(direccion 2)(action 1)))
    ?direc <- (acciones(direccion ?x)
                       (action ?y))
    ?post <- (posicion(pos ?j))
    =>
    (printout t "   Vuelves a la sala inicial" crlf)
    (printout t "   ¿Que quieres hacer?(1- avanzar, 2- usar o 3- investigar)" crlf)
    (bind ?act (read))
    (if (= ?act 1)
        then
        (printout t "   ¿A que puerta quieres avanzar?(1-Puerta uno  2-Puerta dos)" crlf)
        (bind ?port(read))
        (modify ?direc(direccion ?port)(action ?act))
        else
        (modify ?direc(direccion 0)(action ?act)))
    (modify ?post (pos 1))
)

;estas en 4 desde 3
(defrule tresacuatro;3-4
    (and (posicion (pos 3))(acciones(direccion 3)(action 1)))
    ?direc <- (acciones(direccion ?x)
                       (action ?y))
    ?post <- (posicion(pos ?j))
    =>
    (printout t "   Tras cruzar la puerta, entras en una biblioteca, altas estanterias llenas de libros cubren las paredes, el polvo y las telarañas" crlf)
    (printout t "   te indican que nadie los usa hace tiempo." crlf)
    (printout t "   ¿Que quieres hacer?(1- avanzar, 2- usar o 3- investigar)" crlf)
    (bind ?act (read))
    (if (= ?act 1)
        then
        (printout t "   ¿A que puerta quieres avanzar?(1-Puerta tres  2-Puerta cinco)" crlf)
        (bind ?port(read))
        (if (= ?port 1)
            then
            (modify ?direc(direccion 3)(action ?act))
            else
            (modify ?direc(direccion 5)(action ?act)))
        else
        (modify ?direc(direccion 0)(action ?act)))
    (modify ?post (pos 4))
)

;estas en 5 desde 3
(defrule tresacinco;3-5
    (and (posicion (pos 3))(acciones(direccion 4)(action 1)))
    ?direc <- (acciones(direccion ?x)
                       (action ?y))
    ?post <- (posicion(pos ?j))
    =>
    (printout t "   Llegas a un largo pasillo con 3 puertas, una en cada punto cardinal, 6 8 7, mirandolas de izquierda a derecha, algunos cuadros rasgados se pueden ver en las paredes." crlf)
    (printout t "   ¿Que quieres hacer?(1- avanzar, 2- usar o 3- investigar)" crlf)
    (bind ?act (read))
    (if (= ?act 1)
        then
        (printout t "   ¿A que puerta quieres avanzar?(1-Puerta cuatro  2-Puerta seis  3-Puerta siete  4-Puerta ocho)" crlf)
        (bind ?port(read))
        (if (= ?port 1)
            then
            (modify ?direc(direccion 4)(action ?act))
            else
            (if (= ?port 2)
                then
                (modify ?direc(direccion 6)(action ?act))
                else
                (if (= ?port 3)
                    then
                    (modify ?direc(direccion 7)(action ?act))
                    else
                    (modify ?direc(direccion 8)(action ?act)))))
        else
        (modify ?direc(direccion 0)(action ?act)))
    (modify ?post (pos 5))
)

;---------------------------------------------------------------------------------------------------------------------------------------------
;REGLAS HABITACION 4

;estas en 4 y te quedas en 4
(defrule cuatroacuatro
    (and (posicion (pos 4))(acciones(direccion 0)(action 1)))
    ?direc <- (acciones(direccion ?x)
                       (action ?y))
    ?post <- (posicion(pos ?j))
    =>
    (printout t "   Sigues en la misma sala" crlf)
    (printout t "   ¿Que quieres hacer?(1- avanzar, 2- usar o 3- investigar)" crlf)
    (bind ?act (read))
    (if (= ?act 1)
        then
        (printout t "   ¿A que puerta quieres avanzar?(1-Puerta tres  2-Puerta cinco)" crlf)
        (bind ?port(read))
        (if (= ?port 1)
            then
            (modify ?direc(direccion 3)(action ?act))
            else
            (modify ?direc(direccion 5)(action ?act)))
        else
        (modify ?direc(direccion 0)(action ?act)))
    (modify ?post (pos 4))
)


;estas en 3(desde 4)
(defrule cuatroatres;4-3
    (and (posicion (pos 4))(acciones(direccion 3)(action 1)))
    ?direc <- (acciones(direccion ?x)
                       (action ?y))
    ?post <- (posicion(pos ?j))
    =>
    (printout t "   Tras cruzar la puerta, vuelves al salon" crlf)
    (printout t "   ¿Que quieres hacer?(1- avanzar, 2- usar o 3- investigar)" crlf)
    (bind ?act (read))
    (if (= ?act 1)
        then
        (printout t "   ¿A que puerta quieres avanzar?(1-Puerta dos 2-Puerta tres 3-Puerta cuatro)" crlf)
        (bind ?port(read))
        (if (= ?port 1)
            then
            (modify ?direc(direccion 2)(action ?act))
            else
            (if (= ?port 2)
                then
                (modify ?direc(direccion 3)(action ?act))
                else
                (modify ?direc(direccion 4)(action ?act))))
        else
        (modify ?direc(direccion 0)(action ?act)))
    (modify ?post (pos 3))
)

;estando en 9 desde 4
(defrule cuatroanueve;4-9
    (and (posicion (pos 4))(acciones(direccion 5)(action 1)))
    ?direc <- (acciones(direccion ?x)
                       (action ?y))
    ?post <- (posicion(pos ?j))
    =>
    (printout t "   Llegas a un gran vestibulo, en frente tuyo, se puede ver una gran puerta con un 10 dibujado, ¿Sera la salida?, en el medio" crlf)
    (printout t "   de la sala, se puede apreciar un extraño mecanismo" crlf)
    (printout t "   ¿Que quieres hacer?(1- avanzar, 2- usar o 3- investigar)" crlf)
    (bind ?act (read))
    (if (= ?act 1)
        then
        (printout t "   ¿A que puerta quieres avanzar?(1-Puerta cinco 2-Puerta diez)" crlf)
        (bind ?port(read))
        (if (= ?port 1)
            then
            (modify ?direc(direccion 5)(action ?act))
            else
            (modify ?direc(direccion 10)(action ?act)))
        else
        (modify ?direc(direccion 0)(action ?act)))
    (modify ?post (pos 9))
)

;---------------------------------------------------------------------------------------------------------------------------------------------
;REGLAS HABITACION 5

;estas en 5 y te quedas en 5
(defrule cincoacinco
    (and (posicion (pos 5))(acciones(direccion 0)(action 1)))
    ?direc <- (acciones(direccion ?x)
                       (action ?y))
    ?post <- (posicion(pos ?j))
    =>
    (printout t "   Sigues en la misma sala" crlf)
    (printout t "   ¿Que quieres hacer?(1- avanzar, 2- usar o 3- investigar)" crlf)
    (bind ?act (read))
    (if (= ?act 1)
        then
        (printout t "   ¿A que puerta quieres avanzar?(1-Puerta cuatro  2-Puerta seis  3-Puerta siete  4-Puerta ocho)" crlf)
        (bind ?port(read))
        (if (= ?port 1)
            then
            (modify ?direc(direccion 4)(action ?act))
            else
            (if (= ?port 2)
                then
                (modify ?direc(direccion 6)(action ?act))
                else
                (if (= ?port 3)
                    then
                    (modify ?direc(direccion 7)(action ?act))
                    else
                    (modify ?direc(direccion 8)(action ?act)))))
        else
        (modify ?direc(direccion 0)(action ?act)))
    (modify ?post (pos 5))
)

;estas en 3 desde 5
(defrule cincoatres;5-3
    (and (posicion (pos 5))(acciones(direccion 4)(action 1)))
    ?direc <- (acciones(direccion ?x)
                       (action ?y))
    ?post <- (posicion(pos ?j))
    =>
    (printout t "   Regresas al viejo salon" crlf)
    (printout t "   ¿Que quieres hacer?(1- avanzar, 2- usar o 3- investigar)" crlf)
    (bind ?act (read))
    (if (= ?act 1)
        then
        (printout t "   ¿A que puerta quieres avanzar?(1-Puerta dos 2-Puerta tres 3-Puerta cuatro)" crlf)
        (bind ?port(read))
        (if (= ?port 1)
            then
            (modify ?direc(direccion 2)(action ?act))
            else
            (if (= ?port 2)
                then
                (modify ?direc(direccion 3)(action ?act))
                else
                (modify ?direc(direccion 4)(action ?act))))
        else
        (modify ?direc(direccion 0)(action ?act)))
    (modify ?post (pos 3))
)

;estas en 6 desde 5
(defrule cincoaseis;5-6
    (and (posicion (pos 5))(acciones(direccion 6)(action 1)))
    ?direc <- (acciones(direccion ?x)
                       (action ?y))
    ?post <- (posicion(pos ?j))
    =>
    (printout t "   Al cruzar la puerta, lo primero que ves es una gran cama de matrimonio, a tu izquierda se encuentra un gran armario envejecido, al que le falta" crlf)
    (printout t "   una puerta, dentro se puede apreciar algunas prendas de ropa. Al mismo tiempo a tu derecha puedes ver otra puerta, esta vez con un 9" crlf)
    (printout t "   ¿Que quieres hacer?(1- avanzar, 2- usar o 3- investigar)" crlf)
    (bind ?act (read))
    (if (= ?act 1)
        then
        (printout t "   ¿A que puerta quieres avanzar?(1-Puerta seis  2-Puerta nueve)" crlf)
        (bind ?port(read))
        (if (= ?port 1)
            then
            (modify ?direc(direccion 6)(action ?act))
            else
            (modify ?direc(direccion 9)(action ?act)))
        else
        (modify ?direc(direccion 0)(action ?act)))
    (modify ?post (pos 6))
)

;estas en 7 desde 5
(defrule cincoasiete;5-7
    (and (posicion (pos 5))(acciones(direccion 7)(action 1)))
    ?direc <- (acciones(direccion ?x)
                       (action ?y))
    ?post <- (posicion(pos ?j))
    =>
    (printout t "   Llegas a una pequeña cocina, por el suelo puedes ver algunos restos de platos rotos y comida, en el fuego se encuentra una cafetera," crlf)
    (printout t "   la cual parece estar ya preparada" crlf)
    (printout t "   ¿Que quieres hacer?(1- avanzar, 2- usar o 3- investigar)" crlf)
    (bind ?act (read))
    (if (= ?act 1)
        then
        (printout t "   ¿A que puerta quieres avanzar?(1-Puerta siete)" crlf)
        (bind ?port(read))
        (if (= ?port 1)
            then
            (modify ?direc(direccion 7)(action ?act)))
        else
        (modify ?direc(direccion 0)(action ?act)))
    (modify ?post (pos 7))
)

;estas en 8 desde 5
(defrule cincoaocho ;5-8
    (and (posicion (pos 5))(acciones(direccion 8)(action 1)))
    ?direc <- (acciones(direccion ?x)
                       (action ?y))
    ?post <- (posicion(pos ?j))
    =>
    (printout t "   En la entrada de la puerta puedes ver colgados algunos dibujos infantiles, ¿sera la habitacion de algun niño?" crlf)
    (printout t "   tras cruzar la puerta, llegas a una oscura habitación, la unica luz que ves viene de la puerta que tienes a tu izquierda" crlf)
    (printout t "   ¿Que quieres hacer?(1- avanzar, 2- usar o 3- investigar)" crlf)
    (bind ?act (read))
    (if (= ?act 1)
        then
        (printout t "   ¿A que puerta quieres avanzar?(1-Puerta ocho  2-Puerta nueve)" crlf)
        (bind ?port(read))
        (if (= ?port 1)
            then
            (modify ?direc(direccion 8)(action ?act))
            else
            (modify ?direc(direccion 9)(action ?act)))
        else
        (modify ?direc(direccion 0)(action ?act)))
    (modify ?post (pos 8))
)

;---------------------------------------------------------------------------------------------------------------------------------------------
;REGLAS HABITACION 6

;estas en 6 y te quedas en 6
(defrule seisaseis
    (and (posicion (pos 6))(acciones(direccion 0)(action 1)))
    ?direc <- (acciones(direccion ?x)
                       (action ?y))
    ?post <- (posicion(pos ?j))
    =>
    (printout t "   Sigues en la misma sala" crlf)
    (printout t "   ¿Que quieres hacer?(1- avanzar, 2- usar o 3- investigar)" crlf)
    (bind ?act (read))
    (if (= ?act 1)
        then
        (printout t "   ¿A que puerta quieres avanzar?(1-Puerta seis  2-Puerta nueve)" crlf)
        (bind ?port(read))
        (if (= ?port 1)
            then
            (modify ?direc(direccion 6)(action ?act))
            else
            (modify ?direc(direccion 9)(action ?act)))
        else
        (modify ?direc(direccion 0)(action ?act)))
    (modify ?post (pos 6))
)

;estas en 5 desde 6
(defrule seisacinco;6-5
    (and (posicion (pos 6))(acciones(direccion 6)(action 1)))
    ?direc <- (acciones(direccion ?x)
                       (action ?y))
    ?post <- (posicion(pos ?j))
    =>
    (printout t "   Vuelves al pasillo" crlf)
    (printout t "   ¿Que quieres hacer?(1- avanzar, 2- usar o 3- investigar)" crlf)
    (bind ?act (read))
    (if (= ?act 1)
        then
        (printout t "   ¿A que puerta quieres avanzar?(1-Puerta cuatro  2-Puerta seis  3-Puerta siete  4-Puerta ocho)" crlf)
        (bind ?port(read))
        (if (= ?port 1)
            then
            (modify ?direc(direccion 4)(action ?act))
            else
            (if (= ?port 2)
                then
                (modify ?direc(direccion 6)(action ?act))
                else
                (if (= ?port 3)
                    then
                    (modify ?direc(direccion 7)(action ?act))
                    else
                    (modify ?direc(direccion 8)(action ?act)))))
        else
        (modify ?direc(direccion 0)(action ?act)))
    (modify ?post (pos 5))
)

;estas en 8 desde 6
(defrule seisaocho;6-8
    (and (posicion (pos 6))(acciones(direccion 9)(action 1)))
    ?direc <- (acciones(direccion ?x)
                       (action ?y))
    ?post <- (posicion(pos ?j))
    =>
    (printout t "   Llegas a una habitacion que parece de algun niño, pero esta demasiado oscuro para apreciar algo, solo puedes ver la luz que se filtra " crlf)
    (printout t "   por debajo de la puerta a tu derecha" crlf)
    (printout t "   ¿Que quieres hacer?(1- avanzar, 2- usar o 3- investigar)" crlf)
    (bind ?act (read))
    (if (= ?act 1)
        then
        (printout t "   ¿A que puerta quieres avanzar?(1-Puerta ocho  2-Puerta nueve)" crlf)
        (bind ?port(read))
        (if (= ?port 1)
            then
            (modify ?direc(direccion 8)(action ?act))
            else
            (modify ?direc(direccion 9)(action ?act)))
        else
        (modify ?direc(direccion 0)(action ?act)))
    (modify ?post (pos 8))
)

;---------------------------------------------------------------------------------------------------------------------------------------------
;REGLAS HABITACION 7

;estas en 7 y te quedas en 7
(defrule sieteasiete
    (and (posicion (pos 7))(acciones(direccion 0)(action 1)))
    ?direc <- (acciones(direccion ?x)
                       (action ?y))
    ?post <- (posicion(pos ?j))
    =>
    (printout t "   Sigues en la misma sala" crlf)
    (printout t "   ¿Que quieres hacer?(1- avanzar, 2- usar o 3- investigar)" crlf)
    (bind ?act (read))
    (if (= ?act 1)
        then
        (printout t "   ¿A que puerta quieres avanzar?(1-Puerta siete)" crlf)
        (bind ?port(read))
        (if (= ?port 1)
            then
            (modify ?direc(direccion 7)(action ?act)))
        else
        (modify ?direc(direccion 0)(action ?act)))
    (modify ?post (pos 7))
)

;estas en 5 desde 7
(defrule sieteacinco;7-5
    (and (posicion (pos 7))(acciones(direccion 7)(action 1)))
    ?direc <- (acciones(direccion ?x)
                       (action ?y))
    ?post <- (posicion(pos ?j))
    =>
    (printout t "   Vuelves al pasillo" crlf)
    (printout t "   ¿Que quieres hacer?(1- avanzar, 2- usar o 3- investigar)" crlf)
    (bind ?act (read))
    (if (= ?act 1)
        then
        (printout t "   ¿A que puerta quieres avanzar?(1-Puerta cuatro  2-Puerta seis  3-Puerta siete  4-Puerta ocho)" crlf)
        (bind ?port(read))
        (if (= ?port 1)
            then
            (modify ?direc(direccion 4)(action ?act))
            else
            (if (= ?port 2)
                then
                (modify ?direc(direccion 6)(action ?act))
                else
                (if (= ?port 3)
                    then
                    (modify ?direc(direccion 7)(action ?act))
                    else
                    (modify ?direc(direccion 8)(action ?act)))))
        else
        (modify ?direc(direccion 0)(action ?act)))
    (modify ?post (pos 5))
)

;---------------------------------------------------------------------------------------------------------------------------------------------
;REGLAS HABITACION 8

;estas en 8 y te quedas en 8
(defrule ochoaocho
    (and (posicion (pos 8))(acciones(direccion 0)(action 1)))
    ?direc <- (acciones(direccion ?x)
                       (action ?y))
    ?post <- (posicion(pos ?j))
    =>
    (printout t "   Sigues en la misma sala" crlf)
    (printout t "   ¿Que quieres hacer?(1- avanzar, 2- usar o 3- investigar)" crlf)
    (bind ?act (read))
    (if (= ?act 1)
        then
        (printout t "   ¿A que puerta quieres avanzar?(1-Puerta ocho  2-Puerta nueve)" crlf)
        (bind ?port(read))
        (if (= ?port 1)
            then
            (modify ?direc(direccion 8)(action ?act))
            else
            (modify ?direc(direccion 9)(action ?act)))
        else
        (modify ?direc(direccion 0)(action ?act)))
    (modify ?post (pos 8))
)

;estas en 5 desde 8
(defrule ochoacinco;8-5
    (and (posicion (pos 8))(acciones(direccion 8)(action 1)))
    ?direc <- (acciones(direccion ?x)
                       (action ?y))
    ?post <- (posicion(pos ?j))
    =>
    (printout t "   Vuelves al pasillo" crlf)
    (printout t "   ¿Que quieres hacer?(1- avanzar, 2- usar o 3- investigar)" crlf)
    (bind ?act (read))
    (if (= ?act 1)
        then
        (printout t "   ¿A que puerta quieres avanzar?(1-Puerta cuatro  2-Puerta seis  3-Puerta siete  4-Puerta ocho)" crlf)
        (bind ?port(read))
        (if (= ?port 1)
            then
            (modify ?direc(direccion 4)(action ?act))
            else
            (if (= ?port 2)
                then
                (modify ?direc(direccion 6)(action ?act))
                else
                (if (= ?port 3)
                    then
                    (modify ?direc(direccion 7)(action ?act))
                    else
                    (modify ?direc(direccion 8)(action ?act)))))
        else
        (modify ?direc(direccion 0)(action ?act)))
    (modify ?post (pos 5))
)

;estas en 6 desde 8
(defrule ochoaseis;8-6
    (and (posicion (pos 8))(acciones(direccion 9)(action 1)))
    ?direc <- (acciones(direccion ?x)
                       (action ?y))
    ?post <- (posicion(pos ?j))
    =>
    (printout t "   Al cruzar la puerta, lo primero que ves es una gran cama de matrimonio, al frente se encuentra un gran armario envejecido, al que le falta una puerta" crlf)
    (printout t "   dentro, se puede apreciar algunas prendas de ropa. Al mismo tiempo a tu derecha puedes ver otra puerta, esta vez con un 6" crlf)
    (printout t "   ¿Que quieres hacer?(1- avanzar, 2- usar o 3- investigar)" crlf)
    (bind ?act (read))
    (if (= ?act 1)
        then
        (printout t "   ¿A que puerta quieres avanzar?(1-Puerta seis  2-Puerta nueve)" crlf)
        (bind ?port(read))
        (if (= ?port 1)
            then
            (modify ?direc(direccion 6)(action ?act))
            else
            (modify ?direc(direccion 9)(action ?act)))
        else
        (modify ?direc(direccion 0)(action ?act)))
    (modify ?post (pos 6))
)

;---------------------------------------------------------------------------------------------------------------------------------------------
;REGLAS DE LA HABITACION 9

;estas en 9 y te quedas en 9
(defrule nueveanueve
    (and (posicion (pos 9))(acciones(direccion 0)(action 1)))
    ?direc <- (acciones(direccion ?x)
                       (action ?y))
    ?post <- (posicion(pos ?j))
    =>
    (printout t "   Sigues en la misma sala" crlf)
    (printout t "   ¿Que quieres hacer?(1- avanzar, 2- usar o 3- investigar)" crlf)
    (bind ?act (read))
    (if (= ?act 1)
        then
        (printout t "   ¿A que puerta quieres avanzar?(1-Puerta cinco 2-Puerta diez)" crlf)
        (bind ?port(read))
        (if (= ?port 1)
            then
            (modify ?direc(direccion 5)(action ?act))
            else
            (modify ?direc(direccion 10)(action ?act)))
        else
        (modify ?direc(direccion 0)(action ?act)))
    (modify ?post (pos 9))
)

;estas en 4 desde 9
(defrule nueveacuatro;9-4
    (and (posicion (pos 9))(acciones(direccion 5)(action 1)))
    ?direc <- (acciones(direccion ?x)
                       (action ?y))
    ?post <- (posicion(pos ?j))
    =>
    (printout t "   Vuelves a la biblioteca" crlf)
    (printout t "   ¿Que quieres hacer?(1- avanzar, 2- usar o 3- investigar)" crlf)
    (bind ?act (read))
    (if (= ?act 1)
        then
        (printout t "¿A que puerta quieres avanzar?(1-Puerta tres  2-Puerta cinco)" crlf)
        (bind ?port(read))
        (if (= ?port 1)
            then
            (modify ?direc(direccion 3)(action ?act))
            else
            (modify ?direc(direccion 5)(action ?act)))
        else
        (modify ?direc(direccion 0)(action ?act)))
    (modify ?post (pos 4))
)


;REGLAS DE LA HABITACION 10

(defrule salidaopen;
    (and (posicion (pos 9))(acciones(direccion 10)(action 1))(port_final (estado abierta)))
    =>
    (printout t "Has Logrado Salir Felicidades" crlf)
)

(defrule salidaclosed;
    (and (posicion (pos 9))(acciones(direccion 10)(action 1))(port_final (estado cerrada)))
    ?direc <- (acciones(direccion ?x) (action ?y))
    =>
    (printout t "   La Puerta parece cerrada con llave" crlf)
    (modify ?direc (direccion 0))
)

;*********************************************************************************************************************************************
;REGLAS DE USAR

;Inventario vacio
(defrule invacio
    (and (acciones(direccion 0)(action 2)) (jugador(vacio si)))
    ?direc <- (acciones(direccion ?x) (action ?y))
    =>
    (printout t "" crlf)
    (printout t "   No Tienes Objetos en tu Inventario!!!!!!" crlf)
    (printout t "" crlf)
    (printout t "" crlf)
    
    (modify ?direc (action 1))
    
)

;---------------------------------------------------------------------------------------------------------------------------------------------

;Que usar
(defrule queusar
    (and (posicion (pos ?x)) (acciones(direccion 0)(action 2)) (jugador(vacio no)) (lista(listado 0)))
    ?prob <- (jugador (vacio ?v) (mapa ?m) (linterna ?l) (cerillas ?c) (llave ?r))
    ?usage <- (lista (listado ?q) (lint_us ?w) (cer_us ?a) (lla_us ?e))
    =>
                       
    (printout t "   ¿Que Objeto quiere usar?" crlf)
    (if (= (str-compare ?m si) 0) 
        then
        (printout t "   1- Mapa" crlf))
    (if (= (str-compare ?l si) 0)
        then
        (printout t "   2- Linterna" crlf))
    (if (= (str-compare ?c si) 0)
        then
        (printout t "   3- Cerillas" crlf))
    (if (= (str-compare ?r si) 0)
        then
        (printout t "   4- Llave" crlf))
    (bind ?obj (read))
    (modify ?usage(listado ?obj))
)

;---------------------------------------------------------------------------------------------------------------------------------------------

;Usar el mapa
(defrule mapa
    (and (acciones(direccion 0))(lista(listado 1))(jugador(mapa si)))
    ?direc <- (acciones(direccion ?x) (action ?y))
    ?usage <- (lista (listado ?q) (lint_us ?w) (cer_us ?a) (lla_us ?e))
    =>
    (printout t "                                                                               " crlf)
    (printout t "                                                                               " crlf)
    (printout t "         |-------------|----|                                                  " crlf)
    (printout t "         |             1    |                                                  " crlf)
    (printout t "         |      a      |  b |              Leyenda:                            " crlf)
    (printout t "         |             |    |                  1..10- Puertas                  " crlf)
    (printout t "         |------2------|--|-|----------|       a- Sala inicial                 " crlf)
    (printout t "         |                3            |       b- Baño                         " crlf)
    (printout t "         |      c         |      d     |       c- Salon                        " crlf)
    (printout t "         |                |            |       d- Biblioteca                   " crlf)
    (printout t "   |-----|---4---|--------|------5-----|       e- Pasillo                      " crlf)
    (printout t "   |     |       |        |            |       f- Habitacion de matrimonio     " crlf)
    (printout t "   |  g  7       |        |            |       g- Cocina                       " crlf)
    (printout t "   |     |   e   6   f    |     i      |       h- Habitacion infantil          " crlf)
    (printout t "   |-----|       |        |            |       i- Vestibulo                    " crlf)
    (printout t "         |       |        |            |                                       " crlf)
    (printout t "         |       |        |            |                                       " crlf)
    (printout t "         |---8---|----9---|-----10-----|                                       " crlf)
    (printout t "         |                |                                                    " crlf)
    (printout t "         |       h        |                                                    " crlf)
    (printout t "         |                |                                                    " crlf)
    (printout t "         |----------------|                                                    " crlf)
    (printout t "                                                                               " crlf)
    (printout t "                                                                               " crlf)
    (modify ?direc (action 1))
    (modify ?usage(listado 0))
)

;---------------------------------------------------------------------------------------------------------------------------------------------

(defrule linterna_off
    (and (acciones(direccion 0)) (lista(listado 2)) (jugador(linterna si)) (lista(lint_us off)))
    ?usage <- (lista (listado ?q) (lint_us ?w) (cer_us ?a) (lla_us ?e))
    ?direc <- (acciones(direccion ?r) (action ?y))
    =>
    (printout t "   Has encendido la linterna" crlf)
    (printout t "" crlf)
    (modify ?usage (listado 0)(lint_us on))
    (modify ?direc (action 1))
)  

(defrule linterna_on
    (and (acciones(direccion 0)) (lista(listado 2)) (jugador(linterna si)) (lista(lint_us on)))
    ?usage <- (lista (listado ?q) (lint_us ?w) (cer_us ?a) (lla_us ?e))
    ?direc <- (acciones(direccion ?r) (action ?y))
    =>
    (printout t "   Has apagado la linterna" crlf)
    (printout t "" crlf)
    (modify ?usage (listado 0)(lint_us off))
    (modify ?direc (action 1))
)

;---------------------------------------------------------------------------------------------------------------------------------------------
;LLAVE CUANDO NO TOCA

(defrule llave_no
    (and (acciones(direccion 0)) (lista(listado 4)) (jugador(llave si)) (not (posicion (pos 9))))
    ?usage <- (lista (listado ?q) (lint_us ?w) (cer_us ?a) (lla_us ?e))
    ?direc <- (acciones(direccion ?r) (action ?y))
    =>
    (printout t "   Oak: Este no es el momento de usar eso" crlf)
    (printout t "" crlf)
    (modify ?direc (action 1))
    (modify ?usage (listado 0))
)

; LLAVE PANEL CERRADO
(defrule llave_cerrado
    (and (acciones(direccion 0)) (lista(listado 4)) (jugador(llave si)) (posicion (pos 9)) (pan_cont(cristal cerrada)))
    ?usage <- (lista (listado ?q) (lint_us ?w) (cer_us ?a) (lla_us ?e))
    ?direc <- (acciones(direccion ?r) (action ?y))
    =>
    (printout t "   El Cristal que protege la cerradura esta cerrado, busca como abrirlo" crlf)
    (printout t "" crlf)
    (modify ?direc (action 1))
    (modify ?usage (listado 0))
)

; LLAVE PANEL ABIERTO
(defrule llave_abierto
    (and (acciones(direccion 0)) (lista(listado 4)(lla_us no)) (jugador(llave si)) (posicion(pos 9)) (pan_cont(cristal abierta)))
    ?usage <- (lista (listado ?q) (lint_us ?w) (cer_us ?a) (lla_us ?e))
    ?direc <- (acciones(direccion ?r) (action ?y))
    ?fin <- (port_final(estado ?z))
    =>
    (printout t "   Tras usar la llave, se escucha la cerradura de la puerta abrirse" crlf)
    (printout t "" crlf)
    (modify ?direc (action 1))
    (modify ?usage (listado 0)(lla_us si))
    (modify ?fin(estado abierta))
)

(defrule llave_abierto_us
    (and (acciones(direccion 0)) (lista(listado 4)(lla_us si)) (jugador(llave si)) (posicion(pos 9)) (pan_cont(cristal abierta)))
    ?usage <- (lista (listado ?q) (lint_us ?w) (cer_us ?a) (lla_us ?e))
    ?direc <- (acciones(direccion ?r) (action ?y))
    =>
    (printout t "   Oak: La llave ya esta usada" crlf)
    (printout t "" crlf)
    (modify ?direc (action 1))
    (modify ?usage (listado 0))
)

;---------------------------------------------------------------------------------------------------------------------------------------------
;CERILLAS

(defrule cerilla_no
    (and (acciones(direccion 0)) (lista(listado 3)) (jugador(cerillas si)) (not (posicion (pos 7))))
    ?usage <- (lista (listado ?q) (lint_us ?w) (cer_us ?a) (lla_us ?e))
    ?direc <- (acciones(direccion ?r) (action ?y))
    =>
    (printout t "   Oak: Este no es el momento de usar eso" crlf)
    (printout t "" crlf)
    (modify ?direc (action 1))
    (modify ?usage (listado 0))
)

(defrule cerilla_si
    (and (acciones(direccion 0)) (lista(listado 3)(cer_us no)) (jugador(cerillas si)) (posicion (pos 7)))
    ?usage <- (lista (listado ?q) (lint_us ?w) (cer_us ?a) (lla_us ?e))
    ?direc <- (acciones(direccion ?r) (action ?y))
    ?pan <- (pan_cont(cristal ?z))
    =>
    (printout t "   Tras usar la cerilla para encender el fuego, escuchas un sonido que proviene del vestibulo, ¿Que sera?" crlf)
    (printout t "" crlf)
    (modify ?direc (action 1))
    (modify ?usage (listado 0)(cer_us si))
    (modify ?pan(cristal abierta))
)

(defrule cerilla_si_us
    (and (acciones(direccion 0)) (lista(listado 3)(cer_us si)) (jugador(cerillas si)) (posicion (pos 7)))
    ?usage <- (lista (listado ?q) (lint_us ?w) (cer_us ?a) (lla_us ?e))
    ?direc <- (acciones(direccion ?r) (action ?y))
    =>
    (printout t "   Oak: Las cerillas ya estan usadas" crlf)
    (printout t "" crlf)
    (modify ?direc (action 1))
    (modify ?usage (listado 0))
)


;*********************************************************************************************************************************************
;REGLAS DE INVESTIGAR

;---------------------------------------------------------------------------------------------------------------------------------------------
;HABITACION 1

(defrule habuno_Nmap
    (and (posicion (pos 1)) (acciones(direccion 0)(action 3)) (jugador(mapa no)))
    ?prob <- (jugador (vacio ?v) (mapa ?m) (linterna ?l) (cerillas ?c) (llave ?x))
    ?direc <- (acciones(direccion ?r) (action ?y))
    =>
    (printout t "   Te acercas a la mesa y ves que el papel que habia en esta parece un mapa ¿Lo coges?(1-si 2-no)" crlf)
    (bind ?dec (read))
    (if (= ?dec 1)
        then
        (printout t "   Felicidades Has conseguido el mapa de la casa!!" crlf)
        (printout t "" crlf)
        (modify ?prob(vacio no)(mapa si))
        else
        (printout t "   Dejas el mapa donde esta" crlf))
    (modify ?direc (action 1))
)
        
(defrule habuno_Smap
    (and (posicion (pos 1)) (acciones(direccion 0)(action 3)) (jugador(mapa si)))
    ?direc <- (acciones(direccion ?r) (action ?y))
    =>
    (printout t "   Despues de investigar la habitación no encuentras nada mas" crlf)
    (printout t "" crlf)
    (modify ?direc (action 1))
)

;---------------------------------------------------------------------------------------------------------------------------------------------
;HABITACION 2
(defrule habdos
    (and (posicion (pos 2)) (acciones(direccion 0)(action 3)))
    ?direc <- (acciones(direccion ?r) (action ?y))
    =>
    (printout t "   Tras investigar el baño, no encuentras nada que puedas necesitar" crlf)
    (modify ?direc (action 1))
)

;---------------------------------------------------------------------------------------------------------------------------------------------
;HABITACION 3
(defrule habtres_lintno
    (and (posicion (pos 3)) (acciones(direccion 0)(action 3)) (jugador(linterna no)))
    ?prob <- (jugador (vacio ?v) (mapa ?m) (linterna ?l) (cerillas ?c) (llave ?x))
    ?direc <- (acciones(direccion ?r) (action ?y))
    =>
    (printout t "   Te acercas a un pequeño mueble cerca de la puerta 2 y ves que hay una linterna ¿La coges?(1-si 2-no)" crlf)
    (bind ?dec (read))
    (if (= ?dec 1)
        then
        (printout t "   Felicidades Has conseguido una Linterna" crlf)
        (printout t "" crlf)
        (modify ?prob(vacio no)(linterna si))
        else
        (printout t "   Sigues de largo y dejas la linterna donde estaba" crlf))
    (modify ?direc (action 1))
)
        
(defrule habtres_lintsi
    (and (posicion (pos 3)) (acciones(direccion 0)(action 3)) (jugador(linterna si)))
    ?direc <- (acciones(direccion ?r) (action ?y))
    =>
    (printout t "   Despues de investigar la habitación no encuentras nada mas" crlf)
    (printout t "" crlf)
    (modify ?direc (action 1))
)

;---------------------------------------------------------------------------------------------------------------------------------------------
;HABITACION 4
(defrule habcuatro_cers
    (and (posicion (pos 4)) (acciones(direccion 0)(action 3)) (jugador(cerillas no)))
    ?prob <- (jugador (vacio ?v) (mapa ?m) (linterna ?l) (cerillas ?c) (llave ?x))
    ?direc <- (acciones(direccion ?r) (action ?y))
    =>
    (printout t "   Entre las estanterias puedes ver una pequeña mesa con un puro a medio gastar y una caja de cerillas¿Coges las caja de cerillas?(1-si 2-no)" crlf)
    (bind ?dec (read))
    (if (= ?dec 1)
        then
        (printout t "   Felicidades has conseguido cerillas" crlf)
        (printout t "" crlf)
        (modify ?prob(vacio no)(cerillas si))
        else
        (printout t "   Sigues de largo y dejas la caja de cerillas donde estaba" crlf))
    (modify ?direc (action 1))
)
        
(defrule habcuatro_cern
    (and (posicion (pos 4)) (acciones(direccion 0)(action 3)) (jugador(cerillas si)))
    ?direc <- (acciones(direccion ?r) (action ?y))
    =>
    (printout t "   Despues de investigar la habitación no encuentras nada mas" crlf)
    (printout t "" crlf)
    (modify ?direc (action 1))
)

;---------------------------------------------------------------------------------------------------------------------------------------------
;HABITACION 5
(defrule habcinco
    (and (posicion (pos 5)) (acciones(direccion 0)(action 3)))
    ?direc <- (acciones(direccion ?r) (action ?y))
    =>
    (printout t "   Tras investigar el pasillo, no encuentras nada que puedas necesitar" crlf)
    (modify ?direc (action 1))
)

;---------------------------------------------------------------------------------------------------------------------------------------------
;HABITACION 6
(defrule habseis
    (and (posicion (pos 6)) (acciones(direccion 0)(action 3)))
    ?direc <- (acciones(direccion ?r) (action ?y))
    =>
    (printout t "   Tras investigar el cuarto de matrimonio, no encuentras nada que puedas necesitar" crlf)
    (modify ?direc (action 1))
)

;---------------------------------------------------------------------------------------------------------------------------------------------
;HABITACION 7
(defrule habsiete_paneln
    (and (posicion (pos 7)) (acciones(direccion 0)(action 3)) (pan_cont(cristal cerrada)))
    ?prob <- (jugador (vacio ?v) (mapa ?m) (linterna ?l) (cerillas ?c) (llave ?x))
    ?direc <- (acciones(direccion ?r) (action ?y))
    =>
    (printout t "   Al investigar la cocina, te acercas al fuego, donde puedes ver que puedes encender el fuego para la cafetera " crlf)
    (printout t "" crlf)
    (modify ?direc (action 1))
)
        
(defrule habsiete_panels
    (and (posicion (pos 7)) (acciones(direccion 0)(action 3)) (pan_cont(cristal abierta)))
    ?direc <- (acciones(direccion ?r) (action ?y))
    =>
    (printout t "   Despues de encender el fuego, no hay nada mas que hacer en la habitación" crlf)
    (printout t "" crlf)
    (modify ?direc (action 1))
)

;---------------------------------------------------------------------------------------------------------------------------------------------
;HABITACION 8
(defrule habocho_linoff
    (and (posicion (pos 8)) (acciones(direccion 0)(action 3)) (lista(lint_us off)))
    ?prob <- (jugador (vacio ?v) (mapa ?m) (linterna ?l) (cerillas ?c) (llave ?x))
    ?direc <- (acciones(direccion ?r) (action ?y))
    =>
    (printout t "   La Habitacion esta demasiado oscura para poder investigarse" crlf)
    (printout t "" crlf)
    (modify ?direc (action 1))
)
        
(defrule habocho_linon_llavn
    (and (posicion (pos 8)) (acciones(direccion 0)(action 3)) (lista(lint_us on)) (jugador(llave no)))
    ?prob <- (jugador (vacio ?v) (mapa ?m) (linterna ?l) (cerillas ?c) (llave ?x))
    ?direc <- (acciones(direccion ?r) (action ?y))
    =>
    (printout t "   Lo primero que ves en la habitacion, es un pequeño balancin moviendose, y una cuna al lado, al acercarte con cuidado a la cuna" crlf)
    (printout t "   puedes ver como en su interior se encuentran unas llaves ¿Las coges?(1-si 2-no)" crlf)
    (bind ?dec (read))
    (if (= ?dec 1)
        then
        (printout t "   Felicidades has conseguido las llaves" crlf)
        (printout t "" crlf)
        (modify ?prob(vacio no)(llave si))
        else
        (printout t "   Decides no coger las llaves" crlf))
    (modify ?direc (action 1))
)

(defrule habocho_linon_llavs
    (and (posicion (pos 8)) (acciones(direccion 0)(action 3)) (lista(lint_us on)) (jugador(llave si)))
    ?prob <- (jugador (vacio ?v) (mapa ?m) (linterna ?l) (cerillas ?c) (llave ?x))
    ?direc <- (acciones(direccion ?r) (action ?y))
    =>
    (printout t "   Despues de investigar la habitación no encuentras nada mas" crlf)
    (printout t "" crlf)
    (modify ?direc (action 1))
)

;---------------------------------------------------------------------------------------------------------------------------------------------
;HABITACION 9
(defrule habnueve_crisclose
    (and (posicion (pos 9)) (acciones(direccion 0)(action 3)) (pan_cont(cristal cerrada)))
    ?direc <- (acciones(direccion ?r) (action ?y))
    =>
    (printout t "   Al acercarte al mecanismo del centro de la sala, puedes ver como hay una cerradura, pero esta protegida por un cristal blindado" crlf)
    (printout t "" crlf)
    (modify ?direc (action 1))
)
        
(defrule habnueve_crisopen
    (and (posicion (pos 9)) (acciones(direccion 0)(action 3)) (pan_cont(cristal abierta)))
    ?direc <- (acciones(direccion ?r) (action ?y))
    =>
    (printout t "   Al acercarte al mecanismo del centro de la sala, puedes ver como hay una cerradura, y que el cristal blindado esta abierto" crlf)
    (printout t "" crlf)
    (modify ?direc (action 1))
)