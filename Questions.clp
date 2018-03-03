
;lista delle domande con precursori, priorità e valori ammessi come risposta
;per la risoluzione dei conflitti si è usata la seguente tecnica:
;le domande sono divise in tre categorie sulla base delle priorità che sono HIGH, MEDIUM e LOW
;Se ci sono due domande che hanno entrambe precursori soddisfatti si porrà prima quella con priorità più alta;
;Nel caso in cui invece ci siano due domande con stessa priorità e precursori soddisfatti verranno poste in maniera random
(deffacts question-list 
	
	
	(question 
		(id 1)
		(attribute compratore)
		(the-question "Sei interessato all'acquisto di una chitarra?")
		(why "Sapere se sei un possibile acquirente mi aiutera' a capire che tipo di utente sei")
		(info "Rispondere solo si o no")
		(priority HIGH)
		(allowed-values y n)
		(ans-mean si no))
		
	(question
		(id 2)
		(attribute ha-ibanez)
		(the-question "Possiedi gia' una chitarra di marca Ibanez?")
		(why "Sapere se possiedi una chitarra ibanez mi aiutera' a capire che tipo di utente sei")
		(info "Ibanez e' un marchio molto noto nell'ambito delle chitarre e dei bassi, in particolare quelli elettrici")
		(priority HIGH)
		(allowed-values y n)
		(ans-mean si no)
		(precursors ha-chitarra is si))
	
	(question 
		(id 3)
		(attribute ha-chitarra)
		(the-question "Possiedi gia' una chitarra?")
		(why "Sapere se sei gia' in possesso di una chitarra mi permettera' di capire che tipo di utente sei")
		(info "Si intende qualsiasi tipo di chitarra (acustica, classica, elettrica ecc.)")
		(priority HIGH)
		(allowed-values y n)
		(ans-mean si no))
		
	(question
		(id 4)
		(attribute suona-da-due-anni)
		(the-question "Suoni da almeno due anni?")
		(why "Mi aiutera' a capire che tipo di utente sei")
		(info "Si intende in maniera anche approssimativa")
		(priority HIGH)
		(allowed-values y n)
		(ans-mean si no)
		(precursors ha-ibanez is si))
		
	(question
		(id 5)
		(attribute suona-da-due-anni)
		(the-question "Suoni da almeno due anni?")
		(why "Mi aiutera' a capire che tipo di utente sei")
		(info "Si intende in maniera approssimativa")
		(priority HIGH)
		(allowed-values y n)
		(ans-mean si no)
		(precursors ha-chitarra is si and ha-ibanez is no))
		
	(question
		(id 6)
		(attribute suona-live)
		(the-question "Suoni o hai intenzione di suonare dal vivo?")
		(why "Sapere se suoni dal vivo mi aiutera' a filtrare i risultati prediligendo chitarre che a parita' di prestazioni risultano essere piu' comode da suonare live")
		(info "Rispondere esclusivamente si o no")
		(priority HIGH)
		(allowed-values y n)
		(ans-mean si no))
		
	(question
		(id 7)
		(attribute sostituire-chitarra)
		(the-question "Hai intenzione di sostituire la tua vecchia chitarra con una dello stesso tipo (magari di qualita' migliore) o di aggiungerne una alla tua collezione?")
		(why "Sapere se vuoi sostituire la tua chitarra mi aiutera' a filtrare i risultati in base al modello della suddetta")
		(info "sub -> Sostituire vecchia chitarra
			   add -> Aggiungere nuova chitarra alla collezione")
		(allowed-values sub add)
		(ans-mean sostituire aggiungere)
		(precursors ha-chitarra is si and compratore is si)
		(priority MEDIUM))
	
	(question
		(id 8)
		(attribute tipo-chitarra-da-acquistare)
		(the-question "Che tipo di chitarra hai intenzione di sostituire?")
		(why "Il tipo di chitarra e' fondamentale perhe' io possa aiutarti")
		(info "Le chitarre elettriche necessitano di essere collegate ad un amplificatore per poter esprimere al meglio il proprio suono
Le chitarre acustiche sono caratterizzate invece da avere una cassa molto piu' larga e vuota all'interno che amplifica il suono")
		(allowed-values e a)
		(ans-mean elettrica acustica)
		(precursors sostituire-chitarra is sub)
		(priority MEDIUM))
	
	(question
		(id 9)
		(attribute genere-chitarra-da-acquistare)
		(the-question "Che genere suonavi con la chitarra elettrica che vuoi sostituire?")
		(why "Esistono diverse macrocategorie di chitarre elttriche")
		(info "Il jazz e' un genere caratterizzato dall'uso estensivo dell'improvvisazione e da una particolare la pulsazione ritmica tipica chiamata swing
Il rock e' un genere caratterizzato dall'uso di effetti che modificano il suono della chitarra come distorsori, chorus, delay ecc.
Il metal e' un genere caratterizzato da riff pesanti, suoni molto bassi e l'utilizzo di distorsori (dai piu' leggeri ai piu' pesanti")
		(allowed-values j r m)
		(ans-mean jazz rock metal)
		(precursors tipo-chitarra-da-acquistare is e and sostituire-chitarra is sub)
		(priority MEDIUM))
			
	(question
		(id 10)
		(attribute tipo-chitarra-da-acquistare)
		(the-question "Che tipo di chitarra ti piacerebbe aggiungere alla tua collezione?")
		(why "Il tipo di chitarra e' fondamentale perche' io possa aiutarti")
		(info "Le chitarre elettriche necessitano di essere collegate ad un amplificatore per poter esprimere al meglio il proprio suono
Le chitarre acustiche sono caratterizzate invece da avere una cassa molto piu' larga e vuota all'interno che amplifica il suono")
		(allowed-values a e)
		(ans-mean acustica elettrica)
		(precursors sostituire-chitarra is add)
		(priority MEDIUM))

	(question 
		(id 11)
		(attribute genere-chitarra-da-acquistare)
		(the-question "Qual e' il genere che ti piacerebbe suonare con la tua nuova chitarra?")
		(why "Mi aiutera' a capire la chitarra piu' adatta al genere che ti interessa")
		(info "Il jazz e' un genere caratterizzato dall'uso estensivo dell'improvvisazione e da una particolare la pulsazione ritmica tipica chiamata swing
Il rock e' un genere caratterizzato dall'uso di effetti che modificano il suono della chitarra come distorsori, chorus, delay ecc.
Il metal e' un genere caratterizzato da riff pesanti, suoni molto bassi e l'utilizzo di distorsori (dai piu' leggeri ai piu' pesanti")
		(priority MEDIUM)
		(allowed-values j r m)
		(ans-mean jazz rock metal)
		(precursors tipo-chitarra-da-acquistare is e and sostituire-chitarra is add))	
	

	;domande per principiante 
	
	(question 
		(id 12)
		(attribute tipo-chitarra-principiante)
		(the-question "Che tipo di chitarra ti interessa?")
		(why "E' una domanda cruciale per capire che tipo di chitarra consigliarti")
		(info "Le chitarre elettriche necessitano di essere collegate ad un amplificatore per poter esprimere al meglio il proprio suono
Le chitarre acustiche sono caratterizzate invece da avere una cassa molto piu' larga e vuota all'interno che amplifica il suono")
		(precursors ha-chitarra is no and compratore is si)
		(allowed-values a e)
		(ans-mean acustica elettrica)
		(priority MEDIUM))
		
	(question 
		(id 13)
		(attribute ha-amplificatore)
		(the-question "Possiedi gia' un amplificatore per chitarra?")
		(why "Mi aiutera' a capire se preferire kit con chitarra e ampli o meno")
		(info "Nei kit ibanez e' compreso un piccolo amplificatore da 10W ottimo per iniziare ad avvicinarsi allo strumento")
		(priority MEDIUM)
		(allowed-values y n)
		(ans-mean si no)
		(precursors tipo-chitarra-principiante is e))
		
	(question 
		(id 14)
		(attribute vuole-ampli)
		(the-question "Hai intenzione di acquistare l'amplificatore separatamente?")
		(why "La ibanez produce dei kit chitarra-amplificatore perfetti per chi vuole approcciarsi alla chitarra elettrica")
		(info "Rispondere no se vuoi che preferisca kit chitarra-amplificatore")
		(allowed-values y n ns)
		(ans-mean si no "non so")
		(priority MEDIUM)
		(precursors ha-amplificatore is no))
		
	(question
		(id 15)
		(attribute fascia-prezzo-principiante)
		(the-question "Vuoi spendere sicuramete meno di 250 euro?")
		(why "In conclusione mi serve sapere il tuo budget qual e' per poter filtrare i risultati")
		(info "E' una informazione cruciale per cappire quali chitarre poterti suggerire")
		(allowed-values y n)
		(ans-mean si no)
		(priority LOW)
		(precursors ha-chitarra is no and compratore is si))
		
	(question 
		(id 16)
		(attribute plettro)
		(the-question "Hai intenzione di usare il plettro per suonare?")
		(why "Se hai intenzione di usare il plettro, saranno preferite chitarre con il battipenna in maniera tale che si eviti di graffiare il corpo della chitarra")
		(info "Il plettro e' quello strumento (solitamente in plastica) usato per pizzicare le corde")
		(allowed-values y n ns)
		(ans-mean si no "non so")
		(priority LOW)
		(precursors ha-chitarra is no and compratore is si))
		
	(question 
		(id 17)
		(attribute possiede-impianto)
		(the-question "Possiedi un impianto o anche un piccolo amplificatore a cui collegare la tua chitarra acustica?")
		(why "Saranno preferite chitarre acustiche amplificate")
		(info "Le chitarre amplificate hanno un piccolo microfono all'interno che permette di amplificare il suono")
		(allowed-values y n)
		(ans-mean si no)
		(precursors tipo-chitarra-principiante is a)
		(priority MEDIUM))
		
	(question 
		(id 19)
		(attribute alto)
		(the-question "Sei alto almeno 1,65 m?")
		(why "Per iniziare e per prendere familiarita' con lo strumento potrebbe servirti una chitarra leggermente piu' piccola del solito ma ugualmente prestante")
		(info "Rispondere anche in maniera molto approssimativa")
		(allowed-values y n)
		(ans-mean si no)
		(precursors ha-chitarra is no and compratore is si)
		(priority LOW))
		
	(question
		(id 20)
		(attribute corporatura)
		(the-question "Che tipo di corporatura hai?")
		(why "Per iniziare e per prendere familiarita' con lo strumento potrebbe servirti una chitarra leggermente piu' piccola del solito ma ugualmente prestante")
		(info "Ripondere anche in maniera approssimativa")
		(allowed-values a b c)
		(ans-mean magra normale robusta)
		(precursors ha-chitarra is no and compratore is si)
		(priority LOW))
		
	
		
	;domande per curioso
	
	(question 
		(id 21)
		(attribute curioso-tipo-chitarra)
		(the-question "Fra quale tipo di chitarre vorresti curiosare?")
		(why "Mi serve per capire quale tipo di chitarre poterti consigliare")
		(info "Le chitarre elettriche necessitano di essere collegate ad un amplificatore per poter esprimere al meglio il proprio suono
Le chitarre acustiche sono caratterizzate invece da avere una cassa molto piu' larga e vuota all'interno che amplifica il suonoa")
		(allowed-values a e)
		(ans-mean acustica elettrica)
		(precursors compratore is no)
		(priority MEDIUM))
		
	
		
	
		
	;domande curioso chitarra acustica

	(question
		(id 24)
		(attribute curioso-folk-acustica)
		(the-question "Ti piace ascoltare e/o suonare un genere simile al folk/jazz/gipsy e derivati?")
		(why "Verranno preferite chitarre con un corpo piu' sottile che esaltano le tonalita' alte")
		(info "Sono generi caratterizzati da tonalita' alte e squillanti")
		(allowed-values y n ns)
		(ans-mean si no "non so")
		(precursors compratore is no and curioso-tipo-chitarra is a)
		(priority MEDIUM))
		
	(question 
		(id 26)
		(attribute curioso-pop-acustica)
		(the-question "Allora ti piacerebbe una chitarra piu' adatta alla musica pop/rock?")
		(why "Verranno preferite chitarre con un corpo piu' sottile che esaltano le tonalita' basse")
		(info "Le chitarre più adatte a questo genere sono caratterizzate da un suono più profondo e corposo")
		(allowed-values y n ns)
		(ans-mean si no "non so")
		(precursors compratore is no and curioso-folk-acustica is no)
		(priority MEDIUM))
		
	(question
		(id 27)
		(attribute curioso-accompagnamento)
		(the-question "Sei un chitarrista solista o di accompagnamento?")
		(why "Verranno preferite chitarre con manici piu' larghi e sottili nel caso di un chitarrista di accompagnamento")
		(info "I chitarristi solisti sono chitarristi che si cimentano in assoli, virtuosismi ecc
I chitarristi di accompagnamento invece suonano sempre in gruppo, suonando il sottofondo che accompagna una voce o altri musicisti solisti")
		(allowed-values s a)
		(ans-mean solista accompagnamento)
		(precursors compratore is no and curioso-tipo-chitarra is a)
		(priority MEDIUM))
		
	(question 
		(id 28)
		(attribute curioso-spalla-mancante)
		(the-question "Ti piacerebbe curiosare fra chitarre acustiche con spalla mancante?")
		(why "Saranno preferite chitarre a spalla mancante piuttosto che chitarra acustiche con la forma classica")
		(info "La forma a spalla mancante permette di raggiungere piu' facilmente gli ultimi tasti del manico. E' una questione prettamente estetica")
		(allowed-values y n ns)
		(ans-mean si no "non so")
		(precursors curioso-tipo-chitarra is a)
		(priority LOW))
		
	(question
		(id 25)
		(attribute curioso-possiede-impianto)
		(the-question "Possiedi un impianto a cui collegare la tua chitarra acustica?")
		(why "Verranno preferite chitarre amplificate")
		(info "Un impianto si compone almeno da un mixer e da una cassa a cui collegare la chitarra")
		(priority LOW)
		(allowed-values y n)
		(ans-mean si no)
		(precursors compratore is no and curioso-tipo-chitarra is a))
		
	;domande curioso elettrica
	
	(question 
		(id 30)
		(attribute curioso-tipo-elettrica)
		(the-question "Che genere ti piace suonare/ascoltare?")
		(why "In base al genere che preferisci suonare cerchero' di filtrare i risultati favorendo chitarre piu' adatte a quel genere.")
		(info "Il jazz e' un genere caratterizzato dall'uso estensivo dell'improvvisazione e da una particolare la pulsazione ritmica tipica chiamata swing
Il rock e' un genere caratterizzato dall'uso di effetti che modificano il suono della chitarra come distorsori, chorus, delay ecc.
Il metal e' un genere caratterizzato da riff pesanti, suoni molto bassi e l'utilizzo di distorsori (dai piu' leggeri ai piu' pesanti")
		(allowed-values j r m)
		(ans-mean jazz rock metal)
		(precursors compratore is no and curioso-tipo-chitarra is e)
		(priority MEDIUM))
		
	(question 
		(id 31)
		(attribute curioso-intarsi)
		(the-question "Preferisci che la tua chitarra abbia degli intarsi in madreperla sulla tastiera?")
		(why "Le chitarre di solito hanno degli intarsi sulla tastiera ma esistono anche chitarre che non li presentano")
		(info "Gli intarsi sulla tastiera hanno una funzione puramente estetica")
		(precursors curioso-tipo-chitarra is e)
		(allowed-values y n)
		(ans-mean si no)
		(priority MEDIUM))
	
	

	;domande curioso jazz
	(question
		(id 32)
		(attribute curioso-jazz-classico)
		(the-question "Sei un amante del jazz classico?")
		(why "Le chitarre con un solo pickup sono esteticamente piu' adatte e permettono di esaltare i suoni bassi ottenendo un suono piu' ovattato, tipico del jazz classico")
		(info "Con jazz classico si intende il jazz nativo sullo stile di artisti come Charlie Parker, John Coltrane ecc.")
		(precursors curioso-tipo-elettrica is j)
		(allowed-values y n ns)
		(ans-mean si no "non so")
		(priority MEDIUM))
	
	(question
		(id 96)
		(attribute curioso-jazz-pulito)
		(the-question "Ti piace un suono pulito, senza effetti e senza distorsori?")
		(why "Mi aiutera' a capire la forma della chitarra piu' adatta alle tue esigenze e il tipo di pickup")
		(info "Gli effetti sono dei pedali  a cui collegare la chitarra che vanno a modificare il suono prima che questo esca dall'amplificatore. Ne esistono di vari tipo: delay, chorus, compressore, distorsore ecc.")
		(precursors curioso-tipo-elettrica is j)
		(allowed-values y n ns)
		(ans-mean si no "non so")
		(priority MEDIUM))
		
	(question 
		(id 33)
		(attribute curioso-fusion)
		(the-question "Ti piacerebbe suonare fusion?")
		(why "Mi serve per capire se suoni altro oltre al jazz")
		(info "Il fusion e' un genere che mescola elementi derivanti da vari generi: principalmente jazz, rock e funk")
		(precursors curioso-tipo-elettrica is j and curioso-jazz-classico is no)
		(allowed-values y n ns)
		(ans-mean si no "non so")
		(priority MEDIUM))

		
	(question 
		(id 34)
		(attribute curioso-blues)
		(the-question "Sei un amante del blues o del rock anni '60?")
		(why "Nel blues e nel rock molto spesso si usano chitarre con la leva del tremolo")
		(info "Si intende un genere simile al Rock 'n Roll dei primi anni '60, con distorsori molto leggeri")
		(precursors curioso-tipo-elettrica is j and curioso-fusion is no)
		(allowed-values y n ns)
		(ans-mean si no "non so")
		(priority MEDIUM))
		
	;curioso chitarre rock
	(question
		(id 35)
		(attribute curioso-corpo-strato)
		(the-question "Preferisci chitarre con la forma classica stile stratocaster?")
		(why "La forma della chitarra e' una delle cose principali che in molti cercano quando acquistano una chitarra")
		(info "Un esempio lo puoi trovare a questo link: http://www.ibanez.co.jp/products/eg_pre16_jp.php?year=2016&cat_id=1&series_id=5&pre=0")
		(precursors curioso-tipo-elettrica is r)
		(allowed-values y n ns)
		(ans-mean si no "non so")
		(priority MEDIUM))
		
	(question 
		(id 37)
		(attribute curioso-versatile)
		(the-question "Preferiresti una chitarra piu' versatile con la quale spaziare fra diversi generi?")
		(why "Verranno preferite le chitarre con tre pickup in quanto, potendo scegliere fra piu' configurazioni, risultano essere piu' versatili")
		(info "Con il termine 'versatile' si intende la capacita' di adattarsi a diversi generi (dal rock piu' pesante al soft-rock, reggae, funk ecc.")
		(precursors curioso-tipo-elettrica is r)
		(allowed-values y n ns)
		(ans-mean si no "non so")
		(priority MEDIUM))
		
	(question
		(id 38)
		(attribute curioso-effettistica)
		(the-question "Sei un amante dell'effettistica oppure sei un chitarrista rock classico?")
		(why "Sicuramente un chitarrista amante dell'effettistica sara' piu' propenso ad acquistare una chitarra con il ponte mobile e la leva del vibrato")
		(info "Gli effetti per chitarra sono dei pedali che permettono di modificare il suono naturale della chitarra. Esempi possono essere: distorsore, delay, chorus e tanti altri")
		(precursors curioso-tipo-elettrica is r)
		(allowed-values y n ns)
		(ans-mean si no "non so")
		(priority MEDIUM))
		
	(question 
		(id 39)
		(attribute curioso-soft-rock)
		(the-question "Sei un amante del rock leggero o psichedelico?")
		(why "Sicuramente un chitarrista amante di questo genere apprezzera' una chitarra con la leva del tremolo per ottenere un effetto vibrato simile a quello di un violino")
		(info "Il soft rock e' un genere che si contrappone all'hard rock. E' caratterizzato da tempi medio-lenti e da sonorita' rilassanti")
		(precursors curioso-tipo-elettrica is r)
		(allowed-values y n ns)
		(ans-mean si no "non so")
		(priority MEDIUM))
		
	(question 
		(id 40)
		(attribute curioso-solista)
		(the-question "Sei un amante della musica solista o della musica di gruppo?")
		(why "I chitarristi solisti moderni tendono ad usare molto la leva del tremolo e l'effetto ottenuto grazie ad un tipo di ponte particolare chiamato Floyd Rose")
		(info "Si intende il genere di artisti come Steve Vai, Joe Satriani ecc.")
		(precursors curioso-soft-rock is no)
		(allowed-values y n ns)
		(ans-mean si no "non so")
		(priority MEDIUM))
		
	;domande curioso chitarre metal
	(question 
		(id 41)
		(attribute curioso-sei-corde)
		(the-question "Sei un amante delle chitarre a sei corde?")
		(why "Nel metal molto spesso si utilizzando chitarre con sette, otto e a volte anche nove corde")
		(info "Le chitarre a sette corde hanno una corda piu' bassa che permette di ottenere, ovviamente, suoni piu' bassi che accompagnati ad un distorsore sono tipici del metal (sopratutto quello moderno)")
		(precursors curioso-tipo-elettrica is m)
		(allowed-values y n ns)
		(ans-mean si no "non so")
		(priority MEDIUM))
		
	(question
		(id 42)
		(attribute curioso-solo-distorsore)
		(the-question "Ti piacerebbe usare usare solo distorsori?")
		(why "Mi serve per capire che tipo di pickup scegliere per la tua chitarra")
		(info "Il distorsore e' un effetto che viene utilizzato principalmente nelle canzoni metal e rock per rendere il suono della chitarra piu' cattivo")
		(allowed-values y n ns)
		(ans-mean si no "non so")
		(precursors curioso-tipo-elettrica is m)
		(priority MEDIUM))
		
	(question
		(id 43)
		(attribute curioso-metal-solista)
		(the-question "Sei un chitarrista solista o un chitarrista da accompagnamento?")
		(why "Saranno preferite chitarre con ponte mobile come tremolo o floyd rose")
		(info "riff -> Sequenza di note che si ripete frequantemente nel brano e viene di solito usato come accompagnamento")
		(precursors curioso-tipo-elettrica is m)
		(allowed-values y n ns)
		(ans-mean si no "non so")
		(priority MEDIUM))
		
	(question 
		(id 44)
		(attribute curioso-metal-lp)
		(the-question "Preferiresti chitarre con una forma simile alla famosissima LesPaul?")
		(why "La forma di una chitarra e' uno delle caratteristiche principali che un utente cerca quando deve scegliere una chitarra")
		(info "Un esempio di chitarra a forma LesPaul e': http://www.ibanez.co.jp/products/eg_pre16_jp.php?year=2016&cat_id=1&series_id=21&pre=0")
		(precursors curioso-metal-solista is no and curioso-sei-corde is si)
		(allowed-values y n ns)
		(ans-mean si no "non so")
		(priority LOW))
		
	(question 
		(id 92)
		(attribute curioso-tecnico)
		(the-question "Ti piacerebbe imparare o praticare tecniche come tapping o sweep picking?")
		(why "Mi serve per capire la chitarra piu' adatta alla tua tecnica")
		(info "Sweep picking: consente l'esecuzione con il plettro di sequenze di note singolarmente disposte su corde diverse
		       Tapping: consiste nell'utilizzare la mano ritmica per suonare delle note direttamente sulla tastiera")
		(precursors curioso-metal-solista is si)
		(allowed-values y n ns)
		(ans-mean si no "non so")
		(priority LOW))
		
	
	
	;domande generali per compratore con priorita' bassa
	(question
		(id 45)
		(attribute mancino)
		(the-question "Sei mancino?")
		(why "Le chitarre per mancini sono diverse da quelle per destrimani")
		(info "	Mancino -> colui che tende ad usare il lato sinistro del corpo per compiere movimenti e gesti automatici e volontari
	Destrimano -> colui che tende ad usare invece il lato destro del corpo per compiere il medesimo tipo di movimenti")
		(precursors compratore is si)
		(priority LOW)
		(allowed-values y n)
		(ans-mean si no))
		
	(question 
		(id 46)
		(attribute problema-sudorazione)
		(the-question "Soffri di sudrazione alle mani?")
		(why "E' un problema diffuso e in caso di risposta affermativa verranno preferite chitarre con meccaniche argentate o nere, meno delicate di meccaniche dorate")
		(info "Il problema della sudorazione eccessiva alle mani e' un problema molto diffuso fra i chitarristi")
		(precursors compratore is si and tipo-chitarra-da-acquistare is e)
		(priority LOW)
		(allowed-values y n)
		(ans-mean si no))
		
	(question 
		(id 47)
		(attribute pulisce-chitarra)
		(the-question "Quando finisci di suonare sei solito pulire l'hardware della chitarra?")
		(why "In caso di risposta affermativa verranno preferite chitarre con meccaniche argentate o nere, meno delicate di meccaniche dorate")
		(info "L'hardware racchiude tutte le parti metalliche della chitarra")
		(precursors problema-sudorazione is si)
		(priority LOW)
		(allowed-values y n)
		(ans-mean si no))
		
	(question 
		(id 48)
		(attribute fascia-prezzo-acustica)
		(the-question "A che fascia di prezzo sei interessato per la tua chitarra acustica?")
		(why "La fascia di prezzo e' una informazione fondamentale")
		(info "Le chitarre piu' costose monteranno pezzi di qualita' migliore")
		(allowed-values a b)
		(ans-mean "piu' di 400 euro" "men di 400 euro")
		(precursors compratore is si and tipo-chitarra-da-acquistare is a)
		(priority LOW))
		
	(question 
		(id 49)
		(attribute fascia-prezzo-elettrica)
		(the-question "A che fascia di prezzo sei interessato per la tua chitarra elettrica?")
		(why "La fascia di prezzo e' una informazione fondamentale")
		(info "Le chitarre piu' costose monteranno pezzi di qualita' migliore")
		(allowed-values a b c d)
		(ans-mean "piu' di 2000 euro" "fra 1200 e 2000 euro" "fra 600 e 1200 euro" "meno di 600 euro")
		(precursors compratore is si and tipo-chitarra-da-acquistare is e)
		(priority LOW))
		

		
	;domande acustica compratore	

	(question 
		(id 50)
		(attribute folk-acustica)
		(the-question "Di solito ti piace ascoltare e suonare un genere simile al folk, gipsy o country?")
		(why "Esistono chitarre particolarmente adatte a questo tipo di accompagnamento")
		(info "Le chitarre adatte per questo genere hanno la caratteristica di avere un suono più squillante e metallico")
		(allowed-values y n ns)
		(ans-mean si no "non so")
		(precursors tipo-chitarra-da-acquistare is a))
		
	
	(question
		(id 51)
		(attribute suona-seduto)
		(priority MEDIUM)
		(the-question "Quando suoni dal vivo suoni da seduto?")
		(why "Potrei consigliarti anche chitarre che sono scomode da suonare in piedi")
		(info "Le chitarre con una cassa troppo doppia potrebbero risultare scomode da suonare in piedi")
		(allowed-values y n ns)
		(ans-mean si no "non so")
		(precursors tipo-chitarra-da-acquistare is a and suona-live is si))
		
	(question 
		(id 52)
		(attribute conosce-fingerstyle)
		(the-question "Hai mai sentito parlare di fingerstyle?")
		(why "Mi serve per capire se sei interessato ad una chitarra particolarmente adatta per questa tecnica")
		(info "Il fingerstyle è una tecnica che consiste nel toccare le corde direttamente con le dita, senza uso di utensili intermedi quali il plettro")
		(allowed-values y n)
		(ans-mean si no)
		(priority LOW)
		(precursors tipo-chitarra-da-acquistare is a and chitarra-da-accompagnamento is si))
	
	(question 
		(id 53)
		(attribute fingerstyle)
		(the-question "Sai praticare la tecnica del fingerstyle?")
		(why "Esistono chitarra più adatte di altre per questa tecnica")
		(info "Il fingerstyle è una tecnica che consiste nel toccare le corde direttamente con le dita, senza uso di utensili intermedi quali il plettro")
		(precursors conosce-fingerstyle is si)
		(priority LOW)
		(allowed-values y n)
		(ans-mean si no))
	
	(question 
		(id 54)
		(attribute chitarra-amplificata)
		(the-question "Anche se non suoni dal vivo possiedi un impianto dove poter collegare la tua chitarra?")
		(why "Se possiedi un impianto verranno preferite chitarre microfonate")
		(info "Un impianto si compone fondamentalmente da un mixer e da almeno una cassa al quale collegarlo")
		(precursors suona-live is no and tipo-chitarra-da-acquistare is a)
		(allowed-values y n)
		(ans-mean si no)
		(priority MEDIUM))
		
	(question 
		(id 55)
		(attribute chitarra-da-accompagnamento)
		(the-question "Ti interessa una chitarra per l'accompagnamento o una chitarra più adatta al virtuosismo?")
		(why "Rispondendo a questa domanda eviterò di suggerire chitarre più adatta al virtuosismo")
		(info "Con accompagnamento intendo il sottofondo che accompagna una voce nella sua esecuzione")
		(precursors tipo-chitarra-da-acquistare is a and ha-chitarra is si)
		(allowed-values y n ns)
		(ans-mean si no "non so")
		(priority MEDIUM))
		
	(question 
		(id 56)
		(attribute spalla-mancante)
		(the-question "Ti piacerebbe una chitarra con spalla mancante?")
		(why "Esistono chitarre acustiche con diverse forme. Si possono suddividere in due macro-categorie, ovvero con e senza spalla mancante.")
		(info "Puoi trovare un esempio di chitarra con spalla mancante a questo link: http://www.ibanez.co.jp/products/ag_detail_jp.php?year=2016&cat_id=3&series_id=78&data_id=1&color=CL01")
		(precursors tipo-chitarra-da-acquistare is a and ha-chitarra is si)
		(allowed-values y n ns)
		(ans-mean si no "non so")
		(priority LOW))
		
	(question 
		(id 57)
		(attribute pop-acustica)
		(the-question "Allora ti piace ascoltare o suonare un genere più vicino al pop/rock?")
		(why "Questa risposta mi serve per comprendere meglio che tipo di suono preferiresti ottenere")
		(info "Le chitarre più adatte a questo genere sono caratterizzate da un suono più profondo e corposo")
		(precursors folk-acustica is no and ha-chitarra is si)
		(allowed-values y n ns)
		(ans-mean si no "non so")
		(priority MEDIUM))
		
	
	;domande chitarra jazz
	
	(question 
		(id 58)
		(attribute intarsi-jazz)
		(the-question "Preferiresti una chitarra che abbia degli intarsi in madreperla sul manico?")
		(why "In caso di risposta negativa verranno preferite chitarre senza intarsi in madreperla")
		(info "Gli intarsi hanno una funzione prettamente estetica")
		(precursors genere-chitarra-da-acquistare is j)
		(allowed-values y n)
		(ans-mean si no)
		(priority LOW))
		
	(question
		(id 60)
		(attribute jazz-classico)
		(the-question "Sei un amante del jazz classico anni 20?")
		(why "Le chitarre con un solo pickup permettono di esaltare i suoni bassi e di ottenere un suono piu' ovattato tipico del jazz classico")
		(info "Con jazz classico si intende il jazz nativo sullo stile di artisti come Charlie Parker, John Coltrane ecc.")
		(precursors genere-chitarra-da-acquistare is j and ha-chitarra is si)
		(allowed-values y n ns)
		(ans-mean si no "non so")
		(priority MEDIUM))
	
	(question
		(id 61)
		(attribute jazz-effettistica)
		(the-question "Di solito usi effetti per modificare il suono della chitarra?")
		(why "Mi serve per capire se suoni altro oltre al jazz standard. Saranno preferite chitarre con un suono piu' pulito e ovattato")
		(info "Con effetti si intendo distorsori e altri pedali a cui collegare la chitarra per modificarne il suono")
		(precursors tipo-chitarra-elettrica is j and jazz-classico is no)
		(allowed-values y n ns)
		(ans-mean si no "non so")
		(priority MEDIUM))
	
	(question
		(id 62)
		(attribute spessore-corde)
		(the-question "Di solito utilizzi delle corde particolarmente doppie (da 011 in poi)? ")
		(why "Verranno preferite chitarre con un manico e un corpo piu' doppio")
		(info "Lo spessore delle corde si puo' leggere sulle confezioni. Con 011 si indica lo spessore della corda piu' piccola")
		(precursors genere-chitarra-da-acquistare is j and ha-chitarra is si)
		(allowed-values y n ns)
		(ans-mean si no "non so")
		(priority MEDIUM))
		
	(question
		(id 63)
		(attribute blues)
		(the-question "Sei un amante del blues e del rock 'n roll anni '60?")
		(why "Verranno preferite chitarre con un corpo piu' sottile oppure chitarre che presentano una leva al ponte, piu' adatte ad essere affiancate ad un leggero distorsore")
		(info "La leva al ponte (malgrado la sua scomodita') permette di ottenere il famoso effetto tremolo che si sposa bene con distorsori che si usano principalmente nel blues")
		(precursors genere-chitarra-da-acquistare is j and jazz-effettistica is si)
		(allowed-values y n ns)
		(ans-mean si no "non so")
		(priority MEDIUM))
		
	;domande chitarra rock
	
	(question 
		(id 93)
		(attribute intarsi-rock)
		(the-question "Preferiresti dei classici intarsi a forma circolare sul manico della chitarra?")
		(why "Gli intarsi sul manico sono puramente estetici")
		(info "Gli intarsi sul manico sono quasi sempre in madreperla")
		(allowed-values y n ns)
		(ans-mean si no "non so")
		(precursors genere-chitarra-da-acquistare is r)
		(priority LOW))
		
	(question
		(id 64)
		(attribute corpo-strato)
		(the-question "Per la tua chitarra preferiresti la forma classica stile stratocaster?")
		(why "La forma della chitarra e' una delle cose principali che in molti cercano quando acquistano una chitarra")
		(info "Un esempio lo puoi trovare a questo link: http://www.ibanez.co.jp/products/eg_pre16_jp.php?year=2016&cat_id=1&series_id=5&pre=0")
		(precursors genere-chitarra-da-acquistare is r)
		(allowed-values y n ns)
		(ans-mean si no "non so"))
		
		
	(question 
		(id 67)
		(attribute versatile)
		(the-question "Ti piace suonare e/o ascoltare qualcosa di leggermente diverso dal rock?")
		(why "Verranno preferite le chitarre con tre pickup in quanto, potendo scegliere fra piu' configurazioni, risultano essere piu' versatili")
		(info "Per esempio funk, fusion, pop, reggae ecc..")
		(precursors corpo-strato is si)
		(allowed-values y n ns)
		(ans-mean si no "non so")
		(priority MEDIUM))
	
		
	(question
		(id 68)
		(attribute solista-rock)
		(the-question "Sei un chitarrista solista oppure sei un chitarrista di accompagnamento?")
		(why "Mi serve per poterti consigliare al meglio il tipo di ponte che potresti volere sulla tua chitarra")
		(info "I chitarristi solisti sono chitarristi che si cimentano in assoli, virtuosismi ecc
I chitarristi di accompagnamento invece suonano sempre in gruppo, suonando il sottofondo che accompagna una voce o altri musicisti solisti")
		(allowed-values y n)
		(ans-mean si no)
		(precursors genere-chitarra-da-acquistare is r)
		(priority MEDIUM))
	
	(question
		(id 69)
		(attribute amante-effettistica)
		(the-question "Sei un amante dell'effettistica oppure sei un chitarrista rock classico?")
		(why "Sicuramente un chitarrista amante dell'effettistica sara' piu' propenso ad acquistare una chitarra con il ponte mobile e la leva del vibrato")
		(info "Gli effetti per chitarra sono dei pedali che permettono di modificare il suono naturale della chitarra. Esempi possono essere: distorsore, delay, chorus e tanti altri")
		(precursors genere-chitarra-da-acquistare is r and solista-rock is si)
		(allowed-values y n ns)
		(ans-mean si no "non so")
		(priority LOW))

	
	;domande chitarra metal
	(question 
		(id 73)
		(attribute amante-metal-moderno)
		(the-question "Sei un amante del metal piu' moderno oppure preferisci il metal tradizionale")
		(why "Nel metal piu' moderno si utilizzano molto chitarre con piu' di sei corde, in particolare in sottogeneri come il djent e il trash metal")
		(info "Con metal tradizionale si intende il metal degli anni '90")
		(allowed-values y n ns)
		(ans-mean si no "non so")
		(precursors genere-chitarra-da-acquistare is m)
		(priority MEDIUM))
	
	(question
		(id 74)
		(attribute solo-distorsore)
		(the-question "Quando suoni utilizzi solo il distorsore oppure a volte usi anche un suono piu' pulito?")
		(why "Mi serve per capire che tipo di pickup scegliere")
		(info "Il distorsore e' un effetto che viene utilizzato principalmente nelle canzoni metal e rock per rendere il suono della chitarra piu' cattivo")
		(allowed-values y n ns)
		(ans-mean si no "non so")
		(precursors genere-chitarra-da-acquistare is m)
		(priority MEDIUM))
		
	(question 
		(id 75)
		(attribute solista-metal)
		(the-question "Preferiresti una chitarra piu' adatta all'esecuzione di assoli o una per l'accompagnamento?")
		(why "Molte chitarre hanno caratteristiche (tipologia di ponte per esempio) che le rendono particolarmente adatte al virtuosismo e poco adatte all'accompagnamento")
		(info "Rispondere esclusivamente si o no")
		(precursors genere-chitarra-da-acquistare is m)
		(allowed-values y n)
		(ans-mean si no)
		(priority MEDIUM))
	
	(question 
		(id 76)
		(attribute lp-shape)
		(the-question "Preferiresti una chitarra con una forma simile a quella della famosissima LesPaul?")
		(why "La forma di una chitarra e' uno delle caratteristiche principali che un utente cerca quando deve scegliere una chitarra")
		(info "Un esempio di chitarra a forma LesPaul e': http://www.ibanez.co.jp/products/eg_pre16_jp.php?year=2016&cat_id=1&series_id=21&pre=0")
		(precursors amante-metal-moderno is no)
		(allowed-values y n ns)
		(ans-mean si no "non so")
		(priority LOW))
	
	(question 
		(id 77)
		(attribute sweep-tapping)
		(the-question "Di solito pratichi tecniche quali sweep picking o tapping?")
		(why "Serve per capire la chitarra piu' adatta alla tua tecnica")
		(info "Sweep picking: consente l'esecuzione con il plettro di sequenze di note singolarmente disposte su corde diverse
Tapping: consiste nell'utilizzare la mano ritmica per suonare delle note direttamente sulla tastiera")
		(precursors solista-metal is si)
		(allowed-values y n ns)
		(ans-mean si no "non so"))	
		
		(question 
		(id 78)
		(attribute intarsi-metal)
		(the-question "Preferiresti una chitarra con intarsi sul manico?")
		(why "Gli intarsi sul manico sono puramente estetici")
		(info "Gli intarsi sul manico sono quasi sempre in madreperla")
		(allowed-values y n ns)
		(ans-mean si no "non so")
		(precursors genere-chitarra-da-acquistare is m)
		(priority LOW))
	
)
			