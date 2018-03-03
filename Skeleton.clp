
;------------------------------------------------------------------------|
;modulo main con la definizione di template, regole e funzioni principali|
;------------------------------------------------------------------------|
(defmodule MAIN (export ?ALL))

;definizione generico attributo
(deftemplate MAIN::attribute 
	(slot name)
	(slot value)
	(slot certainty (default 100) (range 0 100))
)

(deftemplate MAIN::best-guitar
	(slot name(default ?NONE))
	(slot certainty (default ?NONE))
	(slot price (default ?NONE)))
	
;definizione di una generica domanda
(deftemplate MAIN::question
	(slot id (type INTEGER))
	(slot attribute (default ?NONE))
	(slot the-question (type STRING)(default ?NONE))
	(multislot allowed-values)
	(slot already-asked (default FALSE))
	(multislot precursors (default ?DERIVE))
	(slot pronto (default FALSE))
	(slot why(type STRING))
	(slot info (type STRING))
	(slot priority (default LOW))
	(multislot ans-mean (default ?NONE)))

;template per tenere traccia delle domande a cui si è risposto
(deftemplate MAIN::answered-id-list
	(multislot id)
)

;template per tenere traccia, per ogni domanda fatta, di quale risposta è stata data dall'utente
(deftemplate MAIN::answer-list
	(slot id (default none))
	(slot question)
	(slot answer)
)

;template per asserire un fatto che ci dirà che dobbiamo procedere con le domande
(deftemplate MAIN::question-loop
	(slot loop (default TRUE))
)

;template per asserire  un fatto che ci dirà se dobbiamo stampare in fase di ritrattazione le domande a cui l'utente ha risposto
(deftemplate MAIN::retract-loop
	(slot print (default FALSE))
)

;template per asserire fatti che rappresentano una copia di backup delle domande e dei relativi precursori. Sarà usata principalmente in fase di ritrattazione
(deftemplate MAIN::question-precursors
	(slot question)
	(multislot precursors)
	(slot retract-it (default FALSE))
)

;template per asserire fatti che verranno utilizzati per popolare la base di conoscenza con le regole
(deftemplate MAIN::def-rule
	(multislot if)
	(multislot then)
)

;template che rappresenta una generica regola
(deftemplate MAIN::rule
  (slot certainty (default 100))
  (multislot if)
  (multislot then)
)

;template che rappresenta una generica chitarra elettrica per principianti
(deftemplate MAIN::beginner-guitar-elettrica
	(slot mancina (default no))
	(slot name (default ?NONE))
	(slot kit-ampli (default no))
	(slot micro (default no))
	(slot battipenna (default si))
	(slot fascia-prezzo-beginner (default bassa))
	(slot prezzo (default ?NONE)))
	
;template che rappresenta una generica chitarra acustica per principianti
(deftemplate MAIN::beginner-guitar-acustica
	(slot mancina (default no))
	(slot name (default ?NONE))
	(slot micro (default no))
	(slot amplificazione-b (default no))
	(slot fascia-prezzo-beginner)
	(slot prezzo (default ?NONE)))
	
;template per una generica chitarra acustica
(deftemplate MAIN::acoustic-guitar
	(slot mancina (default no))
	(slot name (default ?NONE))
	(slot amplificazione(default no))
	(slot legno(default any))
	(slot grandezza-cassa(default any))
	(slot spessore-cassa(default any))
	(slot fascia-prezzo(default media))
	(slot larghezza-manico(default any))
	(slot spessore-manico(default any))
	(slot bool-spalla-mancante (default no))
	(slot prezzo (default ?NONE)))

;template per una generica chitarra elettrica
(deftemplate MAIN::electric-guitar
	(slot mancina (default no))
	(slot name (default ?NONE))
	(multislot genre(default any))
	(slot peso (default any))
	(slot num-pickup(default 1))
	(slot pickup-type(default hambucker))
	(slot bridge-type(default any))
	(slot colore-meccaniche (default argentato))
	(slot tipo-intarsi (default circolari))
	(slot forma (default any))
	(slot num-tasti (default 22))
	(slot num-corde (default 6))
	(slot fascia-prezzo (default media))
	(slot prezzo (default ?NONE)))
	
;template per una generica chitarra jazz/semiacustica
(deftemplate MAIN::electric-guitar-jazz
	(slot mancina (default no))
	(slot name (default ?NONE))
	(slot spessore-manico (default any))
	(multislot genre(default any))
	(slot peso (default any))
	(slot num-pickup(default 1))
	(slot pickup-type(default hambucker))
	(slot bridge-type(default any))
	(slot colore-meccaniche (default argentato))
	(slot tipo-intarsi (default circolari))
	(slot forma (default any))
	(slot num-tasti (default 22))
	(slot num-corde (default 6))
	(slot fascia-prezzo (default media))
	(slot prezzo (default ?NONE)))

	
;funzione per stampare il why di una domanda
(deffunction MAIN::print-why(?question)
	(do-for-all-facts ((?q question))(eq ?question ?q:the-question)(printout t ?q:why crlf)))

;funzione per stampare le info di una domanda
(deffunction MAIN::print-info(?question)
	(do-for-all-facts ((?q question))(eq ?question ?q:the-question)(printout t ?q:info crlf)))

	
;funzione per chiedere all'utente di rispodere ad una domanda
;nel caso in cui si possa rispodnere con il ns (non so) si dà anche all'utente la possibilità di rispondere con un valore
;da 0 a 100 che rappresenta il grado di certezza della risposta 'si'
(deffunction MAIN::ask-question (?question ?allowed-values ?ans-mean)
	(printout t crlf crlf ?question "  " crlf)
	(loop-for-count (?i 1 (length$ ?ans-mean))
		  (format t "%-6s -> %s %n" (nth$ ?i ?allowed-values) (nth$ ?i ?ans-mean)))
	(format t "%-6s -> %s %n" "info" "per ottenere informazioni")
	(format t "%-6s -> %s %n" "why" "per capire la motivazione della domanda")
	(printout t "Risposta -> ")	
	(bind ?answer (read))
	(if (lexemep ?answer) then (bind ?answer (lowcase ?answer)))
	(if (eq ?answer why) then (print-why ?question))
	(if (eq ?answer info) then (print-info ?question))
	(while (and (not (member$ ?answer ?allowed-values))(not(integerp ?answer))) do
	(printout t crlf crlf ?question "  " crlf)
	(loop-for-count (?i 1 (length$ ?ans-mean))
		  (format t " %-6s -> %s %n" (nth$ ?i ?allowed-values) (nth$ ?i ?ans-mean)))
	(format t "%-6s -> %s %n" "info" "per ottenere informazioni")
	(format t "%-6s -> %s %n" "why" "per capire la motivazione della domanda")
	(printout t "Risposta -> ")	
		(bind ?answer (read))
		(if (lexemep ?answer) then (bind ?answer (lowcase ?answer)))
		(if (eq ?answer why) then (print-why ?question))
		(if (eq ?answer info) then (print-info ?question)))
	(if (eq ?answer y) then (bind ?answer si))
	(if (eq ?answer n) then (bind ?answer no))
	?answer)

	
	
	
;--------------------------------------------------------------|
;modulo per le domande con relativi template, funzioni e regole|
;--------------------------------------------------------------|

(defmodule QUESTIONS (import MAIN ?ALL)(export ?ALL))

;re-inizializza l'attributo loop a true per riprendere a fare domande dopo la ritrattazione
(defrule QUESTIONS::restart-question-loop
	?f <- (retract-loop (print TRUE))
	?x <- (question-loop (loop FALSE))
	=>
	(modify ?f (print FALSE))
	(modify ?x (loop TRUE))
)

;funzione che genere una copia di backup delle domande e dei relativi precursori per ripristinare le domande durante la ritrattazione
(defrule QUESTIONS::generate-question-precursors
	(declare (salience 10))
	(question (the-question ?question)(precursors $?precursors))
	(not (question-precursors (question ?question)))
	=>
	(assert (question-precursors (question ?question)(precursors ?precursors)))
)

;segna come pronta per essere posta una domanda che non ha più precursori (sono stati eliminati perchè soddisfatti da quanto presente in wm)
(defrule QUESTIONS::ready-to-ask-a-question
	(declare (salience 10))
	?q <- (question (already-asked FALSE)(precursors )(pronto FALSE)(the-question ?t))
	=>
	(modify ?q (pronto TRUE))
)

;stabilisce come comportarsi nel caso di attributo con valore ns
(defrule QUESTIONS::don-t-know-attribute
	(declare (salience 10))
	?a <- (attribute (name ?name) (value ns) (certainty ?c))
	=>
	(retract ?a)
	(assert (attribute (name ?name) (value si) (certainty (/ ?c 2))))
	(assert (attribute (name ?name) (value no) (certainty (- 100 (/ ?c 2)))))
	(focus RULES QUESTIONS RULES)
)

;regola che modifica la lista dei precursori quando uno di tipo 'is' è soddisfatto
(defrule QUESTIONS::precursor-is-satisfied
   ?q <- (question (already-asked FALSE) (precursors ?name is ?value $?rest)(the-question ?qst))
   (attribute (name ?name) (value ?value) (certainty ?certainty))
   =>
    (if (eq (nth 1 ?rest) and) 
		then (modify ?q (precursors (rest$ ?rest)))
		else (modify ?q (precursors ?rest)))
)

;regola che modifica la lista dei precursori quando uno di tipo 'is not' è soddisfatto
(defrule QUESTIONS::precursor-is-not-satisfied
   ?f <- (question (the-question ?qst)(already-asked FALSE)(precursors ?name is-not ?value $?rest))
   (attribute (name ?name) (value ~?value) (certainty ?certainty))
   =>
   (if (eq (nth 1 ?rest) and) 
		then (modify ?f (precursors (rest$ ?rest)))
		else (modify ?f (precursors ?rest))
	)
)


;;regola per porre le prime domande all'utente. Le prime domande hanno priorità HIGH
(defrule QUESTIONS::ask-starting-question
	(declare (salience -10))
	?ql <- (answered-id-list (id $?id-list))
	?f <- (question (id ?i)
					(already-asked FALSE)
					(pronto TRUE)
					(the-question ?the-question)
					(attribute ?the-attribute)
					(priority HIGH)
					(allowed-values $?valid-answers)
					(ans-mean $?ans-mean))
	=>
	(modify ?f (already-asked TRUE)(pronto FALSE))
	(bind ?answer (ask-question ?the-question ?valid-answers ?ans-mean))
	(if (lexemep ?answer)
		then (assert (attribute (name ?the-attribute)(value ?answer)))
	else (if (or(> ?answer 40)(eq ?answer 40)) 
			then (assert (attribute (name ?the-attribute) (value si) (certainty ?answer)))
			else (assert (attribute (name ?the-attribute) (value ns) (certainty (* ?answer 2))))		  )
	)
	(assert (answer-list (id ?i)(question ?the-question)(answer ?answer)))
	(modify ?ql (id (create$ ?id-list ?i)))
	(focus RULES QUESTIONS))
	
	
;regola per porre domande con priorita' media
(defrule QUESTIONS::ask-medium-question
	(declare (salience -50))
	?ql <- (answered-id-list (id $?id-list))
	?f <- (question (id ?i)
					(already-asked FALSE)
					(pronto TRUE)
					(the-question ?the-question)
					(attribute ?the-attribute)
					(priority MEDIUM)
					(allowed-values $?valid-answers)
					(ans-mean $?ans-mean))
	=>
	(modify ?f (already-asked TRUE)(pronto FALSE))
	(bind ?answer (ask-question ?the-question ?valid-answers ?ans-mean))
	(if (lexemep ?answer)
		then (assert (attribute (name ?the-attribute)(value ?answer)))
	else (if (or(> ?answer 40)(eq ?answer 40)) 
			then (assert (attribute (name ?the-attribute) (value si) (certainty ?answer)))
			else (assert (attribute (name ?the-attribute) (value ns) (certainty (* ?answer 2))))		  )
	)
	(assert (answer-list (id ?i)(question ?the-question)(answer ?answer)))
	(modify ?ql (id (create$ ?id-list ?i)))
	(focus RULES QUESTIONS))
	
;;regola per modificare lo stato di una domanda con already-asked a TRUE e che permette di asserire quanto affermato dall'utente
(defrule QUESTIONS::ask-a-question
	(declare (salience -100))
	?ql <- (answered-id-list (id $?id-list))
	?f <- (question (id ?i)
					(already-asked FALSE)
					(pronto TRUE)
					(the-question ?the-question)
					(attribute ?the-attribute)
					(priority LOW)
					(allowed-values $?valid-answers)
					(ans-mean $?ans-mean))
	=>
	(modify ?f (already-asked TRUE)(pronto FALSE))
	(bind ?answer (ask-question ?the-question ?valid-answers ?ans-mean))
	(if (lexemep ?answer)
		then (assert (attribute (name ?the-attribute)(value ?answer)))
	else (if (or(> ?answer 40)(eq ?answer 40)) 
			then (assert (attribute (name ?the-attribute) (value si) (certainty ?answer)))
			else (assert (attribute (name ?the-attribute) (value ns) (certainty (* ?answer 2))))		  )
	)
	(assert (answer-list (id ?i)(question ?the-question)(answer ?answer)))
	(modify ?ql (id (create$ ?id-list ?i)))
	(focus RULES QUESTIONS))

;regola che stabilisce quando non ci sono più domande da porre
(defrule QUESTIONS::questions-finished
	(declare (salience -100))
	?f <- (question-loop (loop TRUE))
	(not (question (pronto TRUE)))
	(answer-list )
	=>
	(modify ?f (loop FALSE))
	(focus MAIN)
)
;-----------------------------------|
;modulo per la gestione delle regole|
;-----------------------------------|

(defmodule RULES (import MAIN ?ALL) (import QUESTIONS ?ALL)(export ?ALL))

;elimina le parti in and di una regola negli antecedenti o LHS
(defrule RULES::throw-away-ands-in-antecedent
  ?f <- (rule (if and $?rest))
  =>
  (modify ?f (if ?rest))
)

;elimina le parti in and di una regola nei conseguenti o RHS
(defrule RULES::throw-away-ands-in-consequent
  ?f <- (rule (then and $?rest))
  =>
  (modify ?f (then ?rest))
)


;effettua il matching fra gli attributi presenti nella wm e le parti sinistre delle regole modificando opportunamente il cf
(defrule RULES::remove-is-condition-when-satisfied
  ?f <- (rule (certainty ?c1) 
              (if ?attribute is ?value $?rest))
  (attribute (name ?attribute) 
             (value ?value) 
             (certainty ?c2))
  => 
  (modify ?f (certainty (min ?c1 ?c2)) (if ?rest))
)

;asserisce nuovi attributi quando una regola è soddisfatta. Questo è il caso in cui sia antecedente che conseguente hanno cf
(defrule RULES::perform-rule-consequent-with-certainty
  ?f <- (rule (certainty ?c1) 
              (if) 
              (then ?attribute is ?value with certainty ?c2 $?rest))
  =>
   (modify ?f (then ?rest))
   (assert (attribute (name ?attribute) 
                     (value ?value)
                     (certainty (/ (* ?c1 ?c2) 100))))  
)

;asserisce nuovi attributi quando la parte sinistra di una regola è soffisfatta. In questo caso la parte destra non ha cf
(defrule RULES::perform-rule-consequent-without-certainty
  ?f <- (rule (certainty ?c1)
              (if)
              (then ?attribute is ?value $?rest))
  (test (or (eq (length$ ?rest) 0)
            (neq (nth 1 ?rest) with)))
  =>
  (modify ?f (then ?rest))
  (assert (attribute (name ?attribute) (value ?value) (certainty ?c1)))
)

;elimina gli attributi che si ripetono, combinando i fattori di certezza
(defrule RULES::combine-certainties
  ?rem1 <- (attribute (name ?rel) (value ?val) (certainty ?per1))
  ?rem2 <- (attribute (name ?rel) (value ?val) (certainty ?per2))
  (test (neq ?rem1 ?rem2))
  =>
  (retract ?rem1)
  (modify ?rem2 (certainty (/ (+ (/ (- (* 100 (+ ?per1 ?per2)) (* ?per1 ?per2)) 100) (/ (+ ?per1 ?per2) 2)) 2)))

)



;----------------------------------------|
;modulo che si occupa della ritrattazione|
;----------------------------------------|

(defmodule RETRACT (import MAIN ?ALL)(export ?ALL))

;funzione che modifica come da ritrattare tutti i precursori della domanda con attributo uguale a quello passato come parametro
;si procede poi in maniera ricorsiva per porre come da ritrattare tutte le domande che dipendono dall'attributo di partenza
(deffunction RETRACT::question-retract-chaining (?attribute)
	(do-for-all-facts ((?q question)(?p question-precursors)) (and (member$ ?attribute ?p:precursors)(eq ?p:question ?q:the-question)(eq ?q:already-asked TRUE))
	(modify ?p (retract-it TRUE))
	(question-retract-chaining ?q:attribute))
)

;funzione per stampare le domande a cui l'utente ha risposto e chiedere quale domanda vuole ritrattare
;La funzione restituisce la risposta dell'utente
(deffunction RETRACT::print-retract-process ()
   (printout t crlf)
   (printout t "Le domande a cui hai risposto sono le seguenti:")
   (printout t "->" crlf)
   (do-for-all-facts ((?p answer-list)) TRUE (printout t ?p:id ". " ?p:question " -> " ?p:answer crlf))
   (printout t "Inserisci l'id della domanda che vuoi ritrattare (exit per uscire) -> ")
   (bind ?answer (read))
   (if (lexemep ?answer) then (bind ?answer (lowcase ?answer)))
   (while (not (member$ ?answer (fact-slot-value (nth 1 (find-fact ((?p answered-id-list)) TRUE)) id))) do
	  (printout t crlf)
	  (printout t "id non valido. Inserisci l'id di una delle domande stampate" crlf)
	  (do-for-all-facts ((?p answer-list)) TRUE (printout t ?p:id ". Domanda:  " ?p:question " -> " ?p:answer crlf))
	  (printout t "Inserisci l'id della domanda che vuoi ritrattare (exit per uscire) ->")
      (bind ?answer (read))
      (if (lexemep ?answer) then (bind ?answer (lowcase ?answer)))
	)
   ?answer
)


;regola che impone come da ritrattare la domanda selezionata dall'utente
;la funzione elimina tutte le regole (che sono state modificate durante il processo di inferenza) 
;e le asserisce di nuovo per ripristinare la situazione di partenza
(defrule RETRACT::begin-retract-process
	?r <- (retract-loop (print TRUE))
	=>
	(bind ?answer (print-retract-process ))
	(if (eq ?answer exit) 
	then (focus GUITAR)
	else (do-for-all-facts ((?p question-precursors)(?q answer-list)) (and (eq ?answer ?q:id) (eq ?p:question ?q:question)) (modify ?p (retract-it TRUE)))
			(do-for-all-facts ((?r rule)) TRUE (retract ?r))
			(do-for-all-facts ((?d def-rule)) TRUE (assert (rule (certainty 100) (if ?d:if) (then ?d:then))))
		)
)

;funzione che ripristina i precursori di una domanda che dovrebbe avere come precursore l'attributo passato come parametro 
(deffunction restore-precursors-in-non-asked-questions
	(?attribute)
	(do-for-all-facts ((?qq question)(?pp question-precursors)) (and(member ?attribute ?pp:precursors)(eq ?qq:the-question ?pp:question)(neq ?qq:precursors ?pp:precursors)) 
		(modify ?qq (precursors ?pp:precursors)))
	
)

;funzione che modifica ad non ancora pronta per essere posta una domanda che ha come attributo un attributo presente nella parte destra di una regola. Tale attributo è quello passato come parametro
;restituisce l'attributo passato come parametro
(deffunction retract-post-rule-questions 
	(?attribute)
	(do-for-all-facts ((?qq question)(?a attribute)) (and(eq ?qq:attribute ?attribute)(eq ?a:name ?attribute)) 
		(modify ?qq (already-asked FALSE)(pronto FALSE))(restore-precursors-in-non-asked-questions ?a:name)(retract ?a))
	?attribute
)


;funzione che si occupa della ritrattazione vera e propria 
;modifica le domande ripristinando i precursori e modificando gli attributi 'pronto' e 'already-asked'
(defrule RETRACT::retract-question
	(declare (salience 10))
	?p <- (question-precursors	(question ?question)(precursors $?precursors)(retract-it TRUE))
	?x <- (question (the-question ?question)(attribute ?the-attribute))
	?a <- (answer-list (id ?id)(question ?question))
	?l  <- (answered-id-list (id $?id-list))
	=>	
	;cancella la domanda dalla lista delle domande già poste
	(progn$ (?field ?id-list) (if (eq ?field ?id) then (delete$ ?id-list ?field-index ?field-index)))
	;si elimina dalla WM il fatto che rappresenta la domanda con la relativa risposta
	(retract ?a)
	;si modificano gli attributi della domanda per ripristinare i precursori e si pongono gli attributi 'already-asked' e 'pronto' a false
	(modify ?x (precursors ?precursors)(already-asked FALSE)(pronto FALSE))
	;si pone retract-it a false per indicare che quella domanda non deve più essere ritrattata
	(modify ?p (retract-it FALSE))
	;si modificano i retract-it a true di tutti le domande che hanno come precursore l'attributo
	(question-retract-chaining ?the-attribute)
	;per tutti gli attributi, con relativi valori, che si trovano nella parte destra di una regola che nella parte sinistra ha l'attributo della domanda in esame, 
	;si avvia il question-retract-chaining e si ritratta l'attributo
	(do-for-all-facts ((?r def-rule)(?a attribute)) (and(member ?the-attribute ?r:if)(member ?a:name ?r:then)(member ?a:value ?r:then))
		(question-retract-chaining (retract-post-rule-questions ?a:name))(retract ?a))
	;si ritrattano tutti gli attributi che hanno come nome l'attributo della domanda in esame
	(do-for-all-facts ((?a attribute)) (eq ?a:name ?the-attribute) (retract ?a))
)

;regola che modifica i precursori delle domande segnando che non devono piu' essere ritrattate
(defrule RETRACT::trigger-questions
	(declare (salience -10))
	?p <- (question-precursors (retract-it TRUE))
	=>
	(modify ?p (retract-it FALSE))
)

;regola che permette di riprendere con le domande dopo aver ripristinato la situazione
(defrule RETRACT::restart-questions
	(declare (salience -10))
	(not (question-precursors (retract-it TRUE)))
	=>
	(focus RULES QUESTIONS RULES)
)



;--------------------------------------------------------------------------------------------------------------------------|
;modulo con la lista delle chitarre e le funzioni per riconoscere a partire dagli attributi quali sono le chitarre migliori|
;--------------------------------------------------------------------------------------------------------------------------|

(defmodule GUITAR (import MAIN ?ALL)(export ?ALL))

;lista delle chitarre
(deffacts GUITAR::list-guitars-beginner

	;lista delle chitarre per principianti
	(beginner-guitar-elettrica (mancina no)(name Ibanez-IJRG-jumpstartkit)(kit-ampli si)(micro no)(prezzo 289.00)(fascia-prezzo-beginner alta) )
	(beginner-guitar-elettrica (mancina no)(name Ibanez-GRX70-starterkit)(kit-ampli si)(micro no)(prezzo 229.00)(fascia-prezzo-beginner bassa))
	(beginner-guitar-elettrica (mancina no)(name Ibanez-IJM21RU-BKN-jumpstartkit)(kit-ampli si)(micro si)(prezzo 219.00)(fascia-prezzo-beginner bassa))
	(beginner-guitar-elettrica (mancina no)(name Ibanez-GRG170)(kit-ampli no)(micro no)(battipenna no)(fascia-prezzo-beginner alta)(prezzo 265.00))
	(beginner-guitar-elettrica (mancina no)(name Ibanez-GRG150)(kit-ampli no)(micro no)(battipenna si)(fascia-prezzo-beginner bassa)(prezzo 220.00))
	(beginner-guitar-elettrica (mancina no)(name Ibanez-GRGM21)(kit-ampli no)(micro si)(battipenna si)(fascia-prezzo-beginner bassa)(prezzo 185.00))
	(beginner-guitar-elettrica (mancina no)(name Ibanez-GRGM22QA)(kit-ampli no)(micro si)(battipenna no)(fascia-prezzo-beginner bassa)(prezzo 195.00))
	(beginner-guitar-elettrica (mancina no)(name Ibanez-SA360)(kit-ampli no)(micro no)(battipenna no)(fascia-prezzo-beginner alta)(prezzo 335.00))
	(beginner-guitar-acustica (mancina no)(name Ibanez-V50NJP)(amplificazione-b no)(micro no)(fascia-prezzo-beginner bassa)(prezzo 98.00))
	(beginner-guitar-acustica (mancina no)(name Ibanez-PF12MHCE)(amplificazione-b si)(micro no)(fascia-prezzo-beginner alta)(prezzo 265.00))
	(beginner-guitar-acustica (mancina no)(name Ibanez-15ECE-BK)(amplificazione-b si)(micro si)(fascia-prezzo-beginner bassa)(prezzo 219.00))
	(beginner-guitar-acustica (mancina no)(name Ibanez-IJV30JR)(amplificazione-b no)(micro si)(fascia-prezzo-beginner bassa)(prezzo 109.00))
	(beginner-guitar-acustica (mancina no)(name Ibanez-AW54MINIGB-OPN)(amplificazione-b si)(micro si)(fascia-prezzo-beginner alta)(prezzo 259.00))
	(beginner-guitar-elettrica (mancina si)(name Ibanez-GRGM21BKNL)(micro si)(kit-ampli no)(fascia-prezzo-beginner bassa)(prezzo 185.00))
	(beginner-guitar-elettrica (mancina si)(name Ibanez-GRG170DXL)(micro no)(kit-ampli no)(fascia-prezzo-beginner alta)(prezzo 265.00))
	(beginner-guitar-elettrica (mancina si)(name Ibanez-GRX70-starterkit-left)(kit-ampli si)(micro no)(fascia-prezzo-beginner bassa)(prezzo 229.00))
	(beginner-guitar-acustica (mancina si)(name Ibanez-AEG10LII-BK)(amplificazione-b si)(fascia-prezzo-beginner bassa)(micro no)(prezzo 237.00))
	(beginner-guitar-acustica (mancina si)(name Ibanez-PF15L)(amplificazione-b no)(fascia-prezzo-beginner bassa)(micro no)(prezzo 149.00))
	(beginner-guitar-acustica (mancina si)(name Ibanez-AVC9L-OPN)(amplificazione-b no)(micro si)(fascia-prezzo-beginner alta)(prezzo 359.00))
	)
	

;lista delle chitarre elettriche e acustiche	
(deffacts GUITAR::list-guitar
	(electric-guitar-jazz (genre jazz)(spessore-manico alto)(mancina no)(name Ibanez-AFC125)(prezzo 888.00)(peso alto)(num-pickup 2)(bridge-type normal)(colore-meccaniche dorato)(tipo-intarsi no)(forma hollow)(fascia-prezzo media))
	(electric-guitar-jazz (genre jazz)(spessore-manico alto)(mancina no)(name Ibanez-GB10)(prezzo 2799.00)(peso alto)(num-pickup 2)(bridge-type normal)(colore-meccaniche argentato)(tipo-intarsi lunghi)(forma hollow)(fascia-prezzo molto-alta))
	(electric-guitar-jazz (genre jazz)(spessore-manico alto)(mancina no)(name Ibanez-PM200)(prezzo 2999.00)(peso alto)(num-pickup 1)(bridge-type normal)(colore-meccaniche dorato)(tipo-intarsi lunghi)(forma hollow)(fascia-prezzo molto-alta))
	(electric-guitar-jazz (genre jazz)(spessore-manico alto)(mancina no)(name Ibanez-AFC151)(prezzo 963.00)(peso alto)(num-pickup 1)(bridge-type normal)(colore-meccaniche argentato)(tipo-intarsi no)(forma hollow)(fascia-prezzo media))
	(electric-guitar-jazz (genre jazz)(spessore-manico alto)(mancina no)(name Ibanez-ASV100)(prezzo 1250.00)(peso basso)(num-pickup 2)(bridge-type normal)(colore-meccaniche argentato)(tipo-intarsi lunghi)(forma semi-hollow)(fascia-prezzo alta))
	(electric-guitar-jazz (genre jazz)(spessore-manico alto)(mancina no)(name Ibanez-vintage-AGV10A)(prezzo 499.00)(peso basso)(num-pickup 2)(bridge-type normal)(colore-meccaniche argentato)(tipo-intarsi lunghi)(forma hollow)(fascia-prezzo bassa))
	(electric-guitar-jazz (genre jazz)(spessore-manico alto)(mancina no)(name Ibanez-vintage-ASV10A)(prezzo 519.00)(peso basso)(num-pickup 2)(bridge-type normal)(colore-meccaniche argentato)(tipo-intarsi lunghi)(forma semi-hollow)(fascia-prezzo bassa))
	(electric-guitar-jazz (genre jazz)(spessore-manico basso)(mancina no)(name Ibanez-AM200)(prezzo 2333.00)(peso basso)(num-pickup 2)(bridge-type normal)(colore-meccaniche dorato)(forma semi-hollow)(tipo-intarsi lunghi)(fascia-prezzo molto-alta))
	(electric-guitar-jazz (genre jazz)(spessore-manico basso)(mancina no)(name Ibanez-SS401F)(prezzo 1840.00)(peso alto)(num-pickup 1)(bridge-type normal)(colore-meccaniche dorato)(forma hollow)(tipo-intarsi no)(fascia-prezzo alta))
	(electric-guitar-jazz (genre jazz)(spessore-manico basso)(mancina no)(name Ibanez-AS153)(prezzo 1211.00)(peso basso)(num-pickup 2)(bridge-type normal)(colore-meccaniche dorato)(forma semi-hollow)(tipo-intarsi lunghi)(fascia-prezzo alta))
	(electric-guitar-jazz (genre jazz)(spessore-manico alto)(mancina no)(name Ibanez-SJ300)(prezzo 1235.00)(peso alto)(num-pickup 2)(bridge-type normal)(colore-meccaniche dorato)(forma hollow)(tipo-intarsi lunghi)(fascia-prezzo alta))
	(electric-guitar-jazz (genre jazz)(spessore-manico basso)(mancina no)(name Ibanez-AFS75T)(prezzo 615.00)(peso alto)(num-pickup 2)(bridge-type tremolo)(colore-meccaniche argentato)(forma hollow)(tipo-intarsi lunghi)(fascia-prezzo media))
	(electric-guitar-jazz (genre jazz)(spessore-manico alto)(mancina no)(name Ibanez-AG75)(prezzo 372.00)(peso alto)(num-pickup 2)(bridge-type normal)(colore-meccaniche argentato)(forma hollow)(tipo-intarsi lunghi)(fascia-prezzo bassa))
	(electric-guitar-jazz (genre jazz)(spessore-manico alto)(mancina no)(name Ibanez-EKM10T)(prezzo 1014.00)(peso alto)(num-pickup 2)(bridge-type tremolo)(colore-meccaniche dorato)(forma semi-hollow)(tipo-intarsi lunghi)(fascia-prezzo media))
	(electric-guitar-jazz (genre jazz)(spessore-manico basso)(mancina no)(name Ibanez-AS73T)(prezzo 473.00)(peso alto)(num-pickup 2)(bridge-type tremolo)(colore-meccaniche argentato)(forma semi-hollow)(tipo-intarsi circolari)(fascia-prezzo bassa))
	(electric-guitar-jazz (genre jazz)(spessore-manico basso)(mancina si)(name Ibanez-AG95QAL)(prezzo 652.00)(peso alto)(num-pickup 2)(bridge-type normal)(colore-meccaniche dorato)(forma hollow)(tipo-intarsi lunghi)(fascia-prezzo media))
	(electric-guitar-jazz (genre jazz)(spessore-manico alto)(mancina si)(name Ibanez-AS93FML)(prezzo 638.00)(peso basso)(num-pickup 2)(bridge-type normal)(colore-meccaniche dorato)(forma hollow)(tipo-intarsi lunghi)(fascia-prezzo media))
	(electric-guitar-jazz (genre jazz)(spessore-manico basso)(mancina si)(name Ibanez-AF55L)(prezzo 353.00)(peso alto)(num-pickup 2)(bridge-type normal)(colore-meccaniche argentato)(forma hollow)(tipo-intarsi circolari)(fascia-prezzo bassa))
	(electric-guitar-jazz (genre jazz)(spessore-manico alto)(mancina si)(name Ibanez-AS73L)(prezzo 359.00)(peso basso)(num-pickup 2)(bridge-type normal)(colore-meccaniche argentato)(forma semi-hollow)(tipo-intarsi lunghi)(fascia-prezzo bassa))
	(electric-guitar-jazz (genre jazz)(spessore-manico basso)(mancina si)(name Ibanez-AS53L)(prezzo 325.00)(peso basso)(num-pickup 2)(bridge-type normal)(colore-meccaniche argentato)(forma semi-hollow)(tipo-intarsi circolari)(fascia-prezzo bassa))
	(electric-guitar (genre rock)(mancina no)(name Ibanez-RG8520)(prezzo 1532.00)(peso alto)(num-pickup 2)(bridge-type floyd)(colore-meccaniche argentato)(forma rg)(fascia-prezzo alta)(tipo-intarsi rose))
	(electric-guitar (genre rock)(mancina no)(name Ibanez-RG657)(prezzo 1799.00)(peso alto)(num-pickup 3)(bridge-type floyd)(colore-meccaniche dorato)(forma rg)(tipo-intarsi circolari)(fascia-prezzo alta))
	(electric-guitar (genre rock)(mancina no)(name Ibanez-PGM80)(prezzo 1469.00)(peso basso)(num-pickup 3)(bridge-type tremolo)(colore-meccaniche dorato)(forma rg)(tipo-intarsi circolari)(fascia-prezzo alta))
	(electric-guitar (genre rock)(mancina no)(name Ibanez-PGMM31)(prezzo 1469.00 )(peso bassso)(num-pickup 2)(bridge-type normal)(colore-meccaniche argentato)(forma rg)(tipo-intarsi circolari)(fascia-prezzo alta))
	(electric-guitar (genre rock)(mancina no)(name Ibanez-RG6UCS)(prezzo 2299.00)(peso alto)(num-pickup 2)(bridge-type floyd)(colore-meccaniche argentato)(forma rg)(tipo-intarsi circolari)(fascia-prezzo molto-alta))
	(electric-guitar (genre rock)(mancina no)(name Ibanez-RG652BG)(prezzo 1555.00)(peso alto)(num-pickup 2)(bridge-type floyd)(colore-meccaniche dorato)(forma rg)(tipo-intarsi circolari)(fascia-prezzo alta))
	(electric-guitar (genre rock)(mancina si)(name Ibanez-RG652HML)(prezzo 1399.00)(peso alto)(num-pickup 2)(bridge-type floyd)(colore-meccaniche argentato)(forma rg)(tipo-intarsi circolari)(fascia-prezzo alta))
	(electric-guitar (genre rock)(mancina no)(name Ibanez-RGEW)(prezzo 769.00)(peso alto)(num-pickup 2)(bridge-type normal)(colore-meccaniche argentato)(forma rg)(fascia-prezzo media)(tipo-intarsi circolari))
	(electric-guitar (genre rock)(mancina no)(name Ibanez-RG470)(prezzo 415.00)(peso alto)(num-pickup 3)(bridge-type floyd)(colore-meccaniche argentato)(forma rg)(fascia-prezzo bassa)(tipo-intarsi circolari))
	(electric-guitar (genre rock)(mancina si)(name Ibanez-450L)(prezzo 370.00)(peso alto)(num-pickup 3)(bridge-type floyd)(colore-meccaniche argentato)(forma rg)(fascia-prezzo bassa)(tipo-intarsi circolari))
	(electric-guitar (genre rock)(mancina no)(name Ibanez-S621)(prezzo 459.00)(peso basso)(num-pickup 2)(bridge-type normal)(colore-meccaniche argentato)(forma sa)(fascia-prezzo bassa)(tipo-intarsi circolari))
	(electric-guitar (genre rock)(mancina no)(name Ibanez-S670)(prezzo 459.00)(peso basso)(num-pickup 3)(bridge-type floyd)(colore-meccaniche argentato)(forma sa)(fascia-prezzo bassa)(tipo-intarsi circolari))
	(electric-guitar (genre rock)(mancina no)(name Ibanez-S6570)(prezzo 2111.00)(peso basso)(num-pickup 3)(bridge-type floyd)(colore-meccaniche argentato)(forma sa)(fascia-prezzo molto-alta)(tipo-intarsi circolari))
	(electric-guitar (genre rock)(mancina no)(name Ibanez-SA460)(prezzo 433.00)(peso basso)(num-pickup 2)(bridge-type tremolo)(colore-meccaniche argentato)(forma sa)(fascia-prezzo bassa)(tipo-intarsi circolari))
	(electric-guitar (genre rock)(mancina no)(name Ibanez-AX120)(prezzo 195.00)(peso basso)(num-pickup 2)(bridge-type normal)(colore-meccaniche argentato)(forma sg)(fascia-prezzo bassa)(tipo-intarsi lunghi))
	(electric-guitar (genre rock)(mancina no)(name Ibanez-AR720)(prezzo 899.00)(peso basso)(num-pickup 2)(bridge-type normal)(colore-meccaniche dorato)(forma sg)(fascia-prezzo media)(tipo-intarsi lunghi))
	(electric-guitar (genre rock)(mancina no)(name Ibanez-EGEN8)(prezzo 825.00)(peso basso)(num-pickup 3)(bridge-type floyd)(colore-meccaniche dorato)(forma sa)(fascia-prezzo media)(tipo-intarsi circolari))
	(electric-guitar (genre rock)(mancina no)(name Ibanez-ClassicJem)(prezzo 1659.00)(peso alto)(num-pickup 3)(bridge-type floyd)(colore-meccaniche dorato)(forma rg)(fascia-prezzo alta)(tipo-intarsi rose))
	(electric-guitar (genre rock)(mancina no)(name Ibanez-JEM)(prezzo 1459.00)(peso basso)(num-pickup 2)(bridge-type floyd)(colore-meccaniche argentato)(forma rg)(fascia-prezzo alta)(tipo-intarsi rose))
	(electric-guitar (genre rock)(mancina si)(name Ibanez-JEML)(prezzo 1559.00)(peso basso)(num-pickup 2)(bridge-type floyd)(colore-meccaniche argentato)(forma rg)(fascia-prezzo alta)(tipo-intarsi rose))
	(electric-guitar (genre rock)(mancina si)(name Ibanez-SA160L)(prezzo 359.00)(peso basso)(num-pickup 2)(bridge-type tremolo)(colore-meccaniche argentato)(forma sa)(fascia-prezzo bassa)(tipo-intarsi circolari))
	(electric-guitar (genre rock)(mancina si)(name Ibanez-RG652L)(prezzo 960.00)(peso alto)(num-pickup 2)(bridge-type floyd)(colore-meccaniche argentato)(forma rg)(fascia-prezzo media))
	(electric-guitar (genre rock)(mancina si)(name Ibanez-RG450L)(prezzo 399.00)(peso alto)(num-pickup 3)(bridge-type floyd)(colore-meccaniche argentato)(forma rg)(fascia-prezzo bassa)(tipo-intarsi circolari))
	(electric-guitar (genre rock)(mancina si)(name Ibanez-SA260L)(prezzo 329.00)(peso basso)(num-pickup 3)(bridge-type tremolo)(colore-meccaniche argentato)(forma sa)(fascia-prezzo bassa)(tipo-intarsi circolari))
	(electric-guitar (genre metal)(num-tasti 24)(mancina no)(name Ibanez-RGAIX6)(prezzo 777.00)(peso alto)(num-pickup 2)(bridge-type normal)(colore-meccaniche argentato)(forma rg)(fascia-prezzo media)(tipo-intarsi no))
	(electric-guitar (genre metal)(num-tasti 24)(mancina no)(name Ibanez-RGAIX7)(prezzo 888.00)(peso alto)(num-pickup 2)(bridge-type normal)(colore-meccaniche argentato)(forma rg)(fascia-prezzo media)(tipo-intarsi no)(num-corde 7))
	(electric-guitar (genre metal)(num-tasti 24)(mancina no)(name Ibanez-RGIX6DLB)(prezzo 1211.00)(peso alto)(num-pickup 2)(bridge-type floyd)(colore-meccaniche argentato)(forma rg)(fascia-prezzo alta)(tipo-intarsi circolari))
	(electric-guitar (genre metal)(num-tasti 24)(mancina no)(name Ibanez-RGIM7)(prezzo 849.00)(peso alto)(num-pickup 2)(pickup-type attivi)(bridge-type normal)(colore-meccaniche argentato)(forma rg)(fascia-prezzo media)(tipo-intarsi no))
	(electric-guitar (genre metal)(num-tasti 24)(mancina no)(name Ibanez-JBM27)(prezzo 1399.00)(peso basso)(num-pickup 2)(pickup-type attivi)(bridge-type floyd)(colore-meccaniche argentato)(forma rg)(fascia-prezzo alta)(tipo-intarsi no)(num-corde 7))
	(electric-guitar (genre metal)(num-tasti 24)(mancina no)(name Ibanez-JBM100)(prezzo 2699.00)(peso basso)(num-pickup 2)(pickup-type attivi)(bridge-type floyd)(colore-meccaniche argentato)(forma rg)(fascia-prezzo molto-alta)(tipo-intarsi no)(num-corde 6))
	(electric-guitar (genre metal)(num-tasti 24)(mancina no)(name Ibanez-APEX200)(prezzo 2066.00)(peso basso)(num-pickup 2)(pickup-type hambucker)(bridge-type floyd)(colore-meccaniche argentato)(forma rg)(fascia-prezzo molto-alta)(tipo-intarsi no)(num-corde 7))
	(electric-guitar (genre metal)(num-tasti 22)(mancina no)(name Ibanez-RGDIX7)(prezzo 857.00)(peso alto)(num-pickup 2)(bridge-type floyd)(num-corde 7)(colore-meccaniche argentato)(forma rg)(fascia-prezzo media)(tipo-intarsi no))
	(electric-guitar (genre metal)(num-tasti 22)(mancina no)(name Ibanez-RGDIM6)(prezzo 888.00)(peso alto)(num-pickup 2)(pickup-type attivi)(bridge-type normal)(colore-meccaniche argentato)(forma rg)(fascia-prezzo media)(tipo-intarsi no))
	(electric-guitar (genre metal)(num-tasti 24)(mancina no)(name Ibanez-RGDIX6)(prezzo 799.00)(peso alto)(num-pickup 2)(bridge-type normal)(colore-meccaniche argentato)(forma rg)(fascia-prezzo media)(tipo-intarsi circolari))
	(electric-guitar (genre metal)(num-tasti 24)(mancina no)(name Ibanez-RGDIX7)(prezzo 857.00)(peso alto)(num-pickup 2)(bridge-type normal)(colore-meccaniche argentato)(forma rg)(fascia-prezzo media)(tipo-intarsi circolari)(num-corde 7))
	(electric-guitar (genre metal)(num-tasti 22)(mancina no)(name Ibanez-SIX6)(prezzo 549.00)(peso basso)(num-pickup 2)(bridge-type floyd)(colore-meccaniche argentato)(forma sa)(fascia-prezzo bassa)(tipo-intarsi no))
	(electric-guitar (genre metal)(num-tasti 22)(mancina no)(name Ibanez-SIX7)(prezzo 599.00)(peso basso)(num-pickup 2)(bridge-type normal)(colore-meccaniche argentato)(forma sa)(fascia-prezzo bassa)(num-corde 7)(tipo-intarsi no))
	(electric-guitar (genre metal)(num-tasti 22)(mancina no)(name Ibanez-FRIX6)(prezzo 799.00)(peso alto)(num-pickup 2)(pickup-type attivi)(bridge-type normal)(colore-meccaniche argentato)(forma lp)(fascia-prezzo media)(tipo-intarsi no))
	(electric-guitar (genre metal)(num-tasti 22)(mancina no)(name Ibanez-FRIX7)(prezzo 899.00)(peso alto)(num-pickup 2)(pickup-type attivi)(bridge-type normal)(colore-meccaniche argentato)(forma lp)(fascia-prezzo media)(num-corde 7)(tipo-intarsi no))
	(electric-guitar (genre metal)(num-tasti 24)(mancina no)(name Ibanez-ARZIR)(prezzo 780.00)(peso alto)(num-pickup 2)(pickup-type attivi)(bridge-type normal)(colore-meccaniche argentato)(forma lp)(fascia-prezzo media)(tipo-intarsi no))
	(electric-guitar (genre metal)(num-tasti 24)(mancina si)(name Ibanez-RGDIX6L)(prezzo 799.00)(peso alto)(num-pickup 2)(bridge-type normal)(colore-meccaniche argentato)(forma rg)(fascia-prezzo media)(tipo-intarsi no))
	(electric-guitar (genre metal)(num-tasti 24)(mancina si)(name Ibanez-RGIR20L)(prezzo 330.00)(peso alto)(num-pickup 2)(pickup-type attivi)(bridge-type normal)(colore-meccaniche argentato)(fascia-prezzo bassa)(tipo-intarsi no))
	(electric-guitar (genre metal)(num-tasti 24)(mancina si)(name Ibanez-RGIR27L)(prezzo 279.00)(peso alto)(num-pickup 2)(pickup-type attivi)(bridge-type normal)(colore-meccaniche argentato)(fascia-prezzo bassa)(tipo-intarsi no)(num-corde 7))
	(acoustic-guitar (mancina no)(name Ibanez-AE205JR)(prezzo 444.00)(amplificazione si)(legno palissandro)(grandezza-cassa basso)(spessore-cassa basso)(fascia-prezzo alta)(larghezza-manico basso)(spessore-manico basso)(bool-spalla-mancante si))
	(acoustic-guitar (mancina no)(name Ibanez-AE245JR)(prezzo 491.00)(amplificazione si)(legno acero)(grandezza-cassa basso)(spessore-cassa basso)(fascia-prezzo alta)(larghezza-manico basso)(spessore-manico basso)(bool-spalla-mancante si))
	(acoustic-guitar (mancina no)(name Ibanez-AE305)(prezzo 648.00)(amplificazione si)(legno palissandro)(grandezza-cassa alto)(spessore-cassa basso)(fascia-prezzo alta)(larghezza-manico basso)(spessore-manico basso)(bool-spalla-mancante si))
	(acoustic-guitar (mancina no)(name Ibanez-AE245)(prezzo 538.00)(amplificazione si)(legno acero)(grandezza-cassa alto)(spessore-cassa basso)(fascia-prezzo alta)(larghezza-manico basso)(spessore-manico basso)(bool-spalla-mancante si))
	(acoustic-guitar (mancina no)(name Ibanez-AVD16)(prezzo 1600.00)(amplificazione no)(legno palissandro)(grandezza-cassa alto)(spessore-cassa alto)(fascia-prezzo alta)(larghezza-manico basso)(spessore-manico basso)(bool-spalla-mancante no))
	(acoustic-guitar (mancina no)(name Ibanez-AVD10)(prezzo 598.00)(amplificazione no)(legno acero)(grandezza-cassa alto)(spessore-cassa alto)(fascia-prezzo alta)(larghezza-manico basso)(spessore-manico basso)(bool-spalla-mancante no))
	(acoustic-guitar (mancina no)(name Ibanez-AVM10E)(prezzo 599.00)(amplificazione no)(legno palissandro)(grandezza-cassa basso)(spessore-cassa basso)(fascia-prezzo alta)(larghezza-manico basso)(spessore-manico basso)(bool-spalla-mancante no))
	(acoustic-guitar (mancina no)(name Ibanez-AVC10)(prezzo 380.00)(amplificazione no)(legno acero)(grandezza-cassa basso)(spessore-cassa basso)(fascia-prezzo bassa)(larghezza-manico basso)(spessore-manico basso)(bool-spalla-mancante no))
	(acoustic-guitar (mancina no)(name Ibanez-AVN1)(prezzo 341.00)(amplificazione no)(legno acero)(grandezza-cassa basso)(spessore-cassa alto)(fascia-prezzo bassa)(larghezza-manico basso)(spessore-manico alto)(bool-spalla-mancante no))
	(acoustic-guitar (mancina no)(name Ibanez-AC240)(prezzo 251.00)(amplificazione no)(legno acero)(grandezza-cassa alto)(spessore-cassa basso)(fascia-prezzo bassa)(larghezza-manico basso)(spessore-manico alto)(bool-spalla-mancante no))
	(acoustic-guitar (mancina si)(name Ibanez-AC240L)(prezzo 251.00)(amplificazione no)(legno acero)(grandezza-cassa alto)(spessore-cassa basso)(fascia-prezzo bassa)(larghezza-manico bassa)(spessore-manico alto)(bool-spalla-mancante no))
	(acoustic-guitar (mancina no)(name Ibanez-AEW)(prezzo 364.00)(amplificazione si)(legno palissandro)(grandezza-cassa alto)(spessore-cassa alto)(fascia-prezzo bassa)(larghezza-manico alto)(spessore-manico alto)(bool-spalla-mancante si))
	(acoustic-guitar (mancina no)(name Ibanez-PC32CE)(prezzo 499.00)(amplificazione si)(legno palissandro)(grandezza-cassa alto)(spessore-cassa basso)(fascia-prezzo alta)(larghezza-manico alto)(spessore-manico alto)(bool-spalla-mancante si))
	(acoustic-guitar (mancina no)(name Ibanez-PF32MHCE)(prezzo 326.00)(amplificazione si)(legno acero)(grandezza-cassa alto)(spessore-cassa alto)(fascia-prezzo bassa)(larghezza-manico basso)(spessore-manico alto)(bool-spalla-mancante si))
	(acoustic-guitar (mancina no)(name Ibanez-AEG)(prezzo 319.00)(amplificazione si)(legno acero)(grandezza-cassa alto)(spessore-cassa basso)(fascia-prezzo bassa)(larghezza-manico basso)(spessore-manico basso)(bool-spalla-mancante si))
	(acoustic-guitar (mancina no)(name Ibanez-AELBT)(prezzo 489.00)(amplificazione si)(legno palissandro)(grandezza-cassa alto)(spessore-cassa basso)(fascia-prezzo alta)(larghezza-manico alto)(spessore-manico alto)(bool-spalla-mancante si))
	(acoustic-guitar (mancina si)(name Ibanez-AVC9L)(prezzo 451.00)(amplificazione no)(legno acero)(grandezza-cassa basso)(spessore-cassa basso)(fascia-prezzo alta)(larghezza-manico alto)(spessore-manico basso)(bool-spalla-mancante no))
	(acoustic-guitar (mancina si)(name Ibanez-AE245L)(prezzo 539.00)(amplificazione no)(legno acero)(grandezza-cassa alto)(spessore-cassa basso)(fascia-prezzo alta)(larghezza-manico basso)(spessore-manico alto)(bool-spalla-mancante si))
	(acoustic-guitar (mancina si)(name Ibanez-AW54L)(prezzo 264.00)(amplificazione no)(legno acero)(grandezza-cassa alto)(spessore-cassa alto)(fascia-prezzo bassa)(larghezza-manico basso)(spessore-manico alto)(bool-spalla-mancante no))
	(acoustic-guitar (mancina si)(name Ibanez-AC340L)(prezzo 285.00)(amplificazione no)(legno acero)(grandezza-cassa alto)(spessore-cassa basso)(fascia-prezzo bassa)(larghezza-manico alto)(spessore-manico basso)(bool-spalla-mancante no))
	(acoustic-guitar (mancina si)(name Ibanez-AW54LCE)(prezzo 264.00)(amplificazione si)(legno acero)(grandezza-cassa alto)(spessore-cassa alto)(fascia-prezzo bassa)(larghezza-manico alto)(spessore-manico basso)(bool-spalla-mancante si))
	(acoustic-guitar (mancina si)(name Ibanez-AEG10LII)(prezzo 237.00)(amplificazione si)(legno palissandro)(grandezza-cassa alto)(spessore-cassa basso)(fascia-prezzo bassa)(larghezza-manico basso)(spessore-manico alto)(bool-spalla-mancante si))
	(acoustic-guitar (mancina si)(name Ibanez-PF15L)(prezzo 149.00)(amplificazione no)(legno palissandro)(grandezza-cassa alto)(spessore-cassa alto)(fascia-prezzo bassa)(larghezza-manico basso)(spessore-manico alto)(bool-spalla-mancante no)))
	

;regola per asserire fatti che rappresentano le chitarre acustiche migliori sulla base degli attributi presenti nella WM
(defrule GUITAR::assert-best-matches-acoustic
	(declare (salience 100))
	(acoustic-guitar
		(name ?name)
		(mancina ?man)
		(amplificazione ?amp)
		(legno ?l)
		(grandezza-cassa ?gc)
		(spessore-cassa ?sc)
		(fascia-prezzo ?fp)
		(larghezza-manico ?lm)
		(spessore-manico ?sm)
		(prezzo ?price))
	(attribute (name mancina) (value ?man) (certainty ?c1))
	(attribute (name amplificazione) (value ?amp) (certainty ?c2))
	(attribute (name legno) (value ?l) (certainty ?c3))
	(attribute (name grandezza-cassa) (value ?gc) (certainty ?c4))
	(attribute (name spessore-cassa)(value ?sc)(certainty ?c5))
	(attribute (name fascia-prezzo)(value ?fp)(certainty ?c6))
	(attribute (name larghezza-manico)(value ?lm)(certainty ?c7))
	(attribute (name spessore-manico)(value ?sm)(certainty ?c8))
	=>
	(assert (best-guitar (name ?name) (price ?price) (certainty (/(+ ?c1 ?c2 ?c3 ?c4 ?c5 ?c6 ?c7 ?c8)8))))
)

;regola per asserire fatti che rappresentano le chitarre elettriche migliori per priincipianti sulla base degli attributi presenti nell WM
(defrule GUITAR::assert-best-matches-beg
	(declare (salience 10))
	(beginner-guitar-elettrica
		(name ?name)
		(mancina ?man)
		(kit-ampli ?ka)
		(micro ?micro)
		(battipenna ?bp)
		(fascia-prezzo-beginner ?fp)
		(prezzo ?price))
	(attribute (name fascia-prezzo-beginner)(value ?fp)(certainty ?c3))
	(attribute (name mancina) (value ?man) (certainty ?c1))
	(attribute (name kit-ampli) (value ?ka) (certainty ?c2))
	(attribute (name micro) (value ?micro) (certainty ?c4))
	(attribute (name battipenna)(value ?bp)(certainty ?c5))
	=>
	(assert (best-guitar (name ?name) (price ?price) (certainty (min ?c1 ?c2 ?c3 ?c4 ?c5))))
)
	
;regola per asserire fatti che rappresentano le chitarre acustiche per principianti migliori sulla base degli attributi presenti nella WM
(defrule GUITAR::assert-best-matches-bag
	(declare (salience 100))
	(attribute (name guitar-type)(value acustica))
	(beginner-guitar-acustica
		(name ?name)
		(mancina ?man)
		(micro ?micro)
		(amplificazione-b ?amp)
		(fascia-prezzo-beginner ?fp)
		(prezzo ?price))
	(attribute (name mancina) (value ?man) (certainty ?c1))
	(attribute (name amplificazione-b) (value ?amp) (certainty ?c2))
	(attribute (name micro) (value ?micro) (certainty ?c4))
	(attribute (name fascia-prezzo-beginner)(value ?fp)(certainty ?c3))
	=>
	(assert (best-guitar (name ?name) (price ?price) (certainty (/(+ ?c1 ?c2 ?c4 ?c3 )4))))
)
	
;regola per asserire fatti che rappresentano le chitarre elettriche migliori sulla base degli attributi presenti nella WM
(defrule GUITAR::assert-best-matches-electric
	(declare (salience 100))
	(electric-guitar
		(name ?name)
		(mancina ?man)
		(genre ?g)
		(forma ?f)
		(fascia-prezzo ?fp)
		(num-pickup ?np)
		(num-corde ?nc)
		(peso ?p)
		(bridge-type ?bt)
		(pickup-type ?pt)
		(colore-meccaniche ?cm)
		(tipo-intarsi ?ti)
		(prezzo ?price))
	(attribute (name mancina) (value ?man) (certainty ?c1))
	(attribute (name genre) (value ?g) (certainty ?c2))
	(attribute (name forma) (value ?f) (certainty ?c3))
	(attribute (name fascia-prezzo) (value ?fp) (certainty ?c4))
	(attribute (name num-pickup)(value ?np)(certainty ?c5))
	(attribute (name num-corde) (value ?nc) (certainty ?c6))
	(attribute (name peso) (value ?p) (certainty ?c7))
	(attribute (name bridge-type) (value ?bt) (certainty ?c8))
	(attribute (name pickup-type) (value ?pt) (certainty ?c9))
	(attribute (name colore-meccaniche)(value ?cm)(certainty ?c10))
	(attribute (name tipo-intarsi)(value ?ti)(certainty ?c11))
	=>
	(assert (best-guitar (name ?name) (price ?price) (certainty (/(+ ?c1 ?c2 ?c3 ?c4 ?c5 ?c6 ?c7 ?c8 ?c9 ?c10 ?c11)11))))
)

;regola per asserire fatti che rappresentano le chitarre jazz migliori sulla base degli attributi presenti nella WM
(defrule GUITAR::assert-best-matches-jazz
	(declare (salience 100))
	(electric-guitar-jazz
		(name ?name)
		(mancina ?man)
		(genre ?g)
		(forma ?f)
		(fascia-prezzo ?fp)
		(num-pickup ?np)
		(num-corde ?nc)
		(peso ?p)
		(bridge-type ?bt)
		(pickup-type ?pt)
		(colore-meccaniche ?cm)
		(tipo-intarsi ?ti)
		(spessore-manico ?sm)
		(prezzo ?price))
	(attribute (name mancina) (value ?man) (certainty ?c1))
	(attribute (name genre) (value ?g) (certainty ?c2))
	(attribute (name forma) (value ?f) (certainty ?c3))
	(attribute (name fascia-prezzo) (value ?fp) (certainty ?c4))
	(attribute (name num-pickup)(value ?np)(certainty ?c5))
	(attribute (name num-corde) (value ?nc) (certainty ?c6))
	(attribute (name peso) (value ?p) (certainty ?c7))
	(attribute (name bridge-type) (value ?bt) (certainty ?c8))
	(attribute (name pickup-type) (value ?pt) (certainty ?c9))
	(attribute (name colore-meccaniche)(value ?cm)(certainty ?c10))
	(attribute (name tipo-intarsi)(value ?ti)(certainty ?c11))
	(attribute (name spessore-manico)(value ?sm)(certainty ?c12))
	=>
	(assert (best-guitar (name ?name) (price ?price) (certainty (/(+ ?c1 ?c2 ?c3 ?c4 ?c5 ?c6 ?c7 ?c8 ?c9 ?c10 ?c11 ?c12) 12)))))
	
;regola per stampare l'intestazione che precede la lista delle chitarre quando non ci sono pi domande da porre
(defrule GUITAR::print-header ""
   (declare (salience 10))
   (not (question (pronto TRUE)))
   =>
   (printout t crlf)
   (printout t "*****************************************************************" crlf)
   (printout t "*                     CHITARRE SELEZIONATE                      *" crlf)
   (printout t "*****************************************************************" crlf crlf)
   (printout t "CHITARRA                  PREZZO      CERTAINTY" crlf)
   (printout t "------------------------------------------------" crlf)
   (assert (phase print-guitars)))

;regola per stampare la lista delle chitarre in maniera ordinata sulla base del CF
(defrule GUITAR::print-guitar ""
  ?rem <- (best-guitar (name ?name) (price ?price) (certainty ?per))		  
  (not (best-guitar (name ?n) (price ?p) (certainty ?per1&:(> ?per1 ?per))))
  =>
  (retract ?rem)
  (format t " %-24s %2.2f%-5s %2.2f %n" ?name ?price " " ?per)
  (printout t "-------------------------------------------------" crlf))


;regola per stampare una linea che indica la fine della lista delle chitarre
(defrule GUITAR::end-spaces ""
   (not (best-guitar (name ?n)))
   =>
   (printout t "------------------------------------------------" crlf))

 
;funzione per chiedere all'utente se vuole procedere con la ritrattazione di una domanda
(deffunction GUITAR::ask-retract()
	(printout t crlf "Vuoi visualizzare o modificare le domande a cui hai precedentemente risposto? (Y/N)")
	(bind ?answ (read))
	(if (lexemep ?answ) then (bind ?answ (lowcase ?answ)))
	(while (not (or (eq ?answ y)(eq ?answ n)))
		(printout t crlf "Vuoi visualizzare o modificare le domande a cui hai precedentemente risposto? (Y/N)")
		(bind ?answ (read))
		(if (lexemep ?answ) then (bind ?answ (lowcase ?answ)))
	)
	?answ
)

;regola che permette di chiedere all'utente se vuole terminare o avviare una nuova sessione
(defrule GUITAR::finish
	(declare (salience -10))
	(not (attribute (name best-guitar)))
	(retract-loop (print TRUE))
	=>
	;solo per debug
	;(do-for-all-facts ((?a attribute)) TRUE (printout t ?a:name " " ?a:value " " ?a:certainty " " crlf))
	(if (eq y (ask-retract))
		then (focus RETRACT MAIN)
		else (printout t crlf crlf "Premere r per riavviare il programma, qualsiasi altro tasto per ucire -> ")
			 (bind ?ans (read))
			 (if (lexemep ?ans) then (bind ?ans (lowcase ?ans)))
			 (if (eq ?ans r) then (reset)(run) else (exit))
	)
)
  
;;******************
;; INITIAL FACTS
;;******************
					
					
;fatti da asserire al momento dell'avvio del programma
;question-loop indica che si deve procedere con le domande
;retract-loop indica che non si deve procedere con la ritrattazione
;answered-id-list è la lista delle domande a cui l'utente ha risposto
(deffacts initial-facts
	(question-loop (loop TRUE))
	(retract-loop (print FALSE))
	(answered-id-list (id create$ exit))
)

;regola che genera le regole a partire da meta-regole
(defrule MAIN::gen-rules
	(declare (salience 100))
	(def-rule (if $?if) (then $?then))
	=>
	(assert (rule (certainty 100) (if ?if) (then ?then)))
)

;regola che modifica il retract-loop in maniera da poter attivare la regola che chiede all'utente se si uvole procedere 
;con la ritrattazione
(defrule MAIN::focus-on-retract
(declare (salience 10))
	(question-loop (loop FALSE))
	?x <- (retract-loop (print FALSE))
	=>
	(modify ?x (print TRUE))
	(focus GUITAR RULES)
)

;regola che si attiva all'inizio dell'esecuzione per porre la strategia di risoluzione dei conflitti a random
(defrule MAIN::start
	=>
	(focus QUESTIONS RULES)
	(set-strategy random)
)