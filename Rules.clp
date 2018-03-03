(deffacts RULES::regole


	(def-rule 
		(if compratore is no)
		(then curioso is si))
	
	(def-rule 
		(if curioso is si)
		(then mancina is no))
		
	(def-rule 
		(if ha-chitarra is no)
		(then prima-chitarra is si))
	
	(def-rule
		(if mancino is no)
		(then mancina is no))
		
	(def-rule 
		(if mancino is si)
		(then mancina is si))
	;domande piu' generiche per esperto
	(def-rule 
		(if tipo-chitarra-da-acquistare is a)
		(then guitar-type is acustica))
		
	(def-rule 
		(if tipo-chitarra-da-acquistare is e)
		(then guitar-type is elettrica))
		
	(def-rule 
		(if genere-chitarra-da-acquistare is j)
		(then genre is jazz))
		
	(def-rule 
		(if genere-chitarra-da-acquistare is r)
		(then genre is rock))
		
	(def-rule 
		(if genere-chitarra-da-acquistare is m)
		(then genre is metal))
		
	;domande per principiante
	(def-rule 
		(if fascia-prezzo-principiante is si)
		(then fascia-prezzo-beginner is bassa))
		
	(def-rule 
		(if fascia-prezzo-principiante is no)
		(then fascia-prezzo-beginner is alta
		and fascia-prezzo-beginner is bassa with certainty 70))
		
		
	(def-rule 
		(if tipo-chitarra-principiante is a and suona-live is si)
		(then guitar-type is acustica
		and live-acustico is si
		and live-acustico is no with certainty 30))
	
		
	(def-rule 
		(if tipo-chitarra-principiante is a and suona-live is no)
		(then guitar-type is acustica
		and live-acustico is no
		and live-acustico is si with certainty 60))
		
	(def-rule 
		(if live-acustico is si)
		(then amplificazione-b is si 
		and amplificazione-b is no with certainty 40))
		
	(def-rule 
		(if live-acustico is no and possiede-impianto is no)
		(then amplificazione-b is no with certainty 80
		and amplificazione-b is si with certainty 60))
		
	(def-rule 
		(if live-acustico is no and possiede-impianto is si)
		(then amplificazione-b is no with certainty 60
		and amplificazione-b is si))
		
	(def-rule 
		(if alto is si and corporatura is a)
		(then micro is no 
		and micro is si with certainty 40))
	
	(def-rule 
		(if alto is si and corporatura is b)
		(then micro is no))
		
	(def-rule 
		(if alto is si and corporatura is c)
		(then micro is no))
		
	(def-rule 
		(if alto is no and corporatura is a)
		(then micro is si
		and micro is no with certainty 30))
		
	(def-rule 
		(if alto is no and corporatura is b)
		(then micro is si 
		and micro is no with certainty 60))
		
	(def-rule 
		(if alto is no and corporatura is c)
		(then micro is no))
		
	(def-rule 
		(if plettro is si)
		(then battipenna is si
		and battipenna is no with certainty 40))
		
	(def-rule 
		(if plettro is no)
		(then battipenna is no
		and battipenna is si with certainty 60))
		
	(def-rule 
		(if ha-amplificatore is si)
		(then kit-ampli is no))
		
	(def-rule 
		(if vuole-ampli is si)
		(then kit-ampli is no))
		
	(def-rule 
		(if vuole-ampli is no)
		(then kit-ampli is si))
		
		
	;regole curioso acustica
	(def-rule 
		(if curioso-tipo-chitarra is a and suona-da-due-anni is si)
		(then fascia-prezzo is alta))
		
	(def-rule 
		(if curioso-tipo-chitarra is a and suona-da-due-anni is no)
		(then fascia-prezzo is alta
		and fascia-prezzo is bassa with certainty 65))
		
	(def-rule 
		(if curioso-tipo-chitarra is a and ha-chitarra is no)
		(then fascia-prezzo is bassa
		and fascia-prezzo is alta with certainty 65))
	
		
	(def-rule 
		(if curioso-folk-acustica is si and suona-live is no)
		(then spessore-cassa is alto with certainty 60
		and spessore-cassa is basso
		and grandezza-cassa is basso
		and grandezza-cassa is alto with certainty 80
		and legno is acero
		and legno is palissandro with certainty 60))
		
	(def-rule
		(if curioso-folk-acustica is si and suona-live is si)
		(then spessore-cassa is alto with certainty 70
		and spessore-cassa is basso
		and grandezza-cassa is basso with certainty 80
		and grandezza-cassa is alto 
		and legno is acero
		and legno is palissandro with certainty 60))
		
	(def-rule 
		(if suona-live is si)
		(then amplificazione is si))
		
	(def-rule 
		(if suona-live is no and curioso-possiede-impianto is no)
		(then amplificazione is no))
		
	(def-rule 
		(if suona-live is no and curioso-possiede-impianto is si)
		(then amplificazione is si with certainty 75
		and amplificazione is no))
		
	(def-rule 
		(if curioso-spalla-mancante is si)
		(then bool-spalla-mancante is si))
	
	(def-rule 
		(if curioso-spalla-mancante is no)
		(then bool-spalla-mancante is no))
		
	(def-rule 
		(if curioso-accompagnamento is a)
		(then larghezza-manico is basso
		and larghezza-manico is alto with certainty 40
		and spessore-manico is alto
		and spessore-manico is basso with certainty 40))
		
	(def-rule 
		(if curioso-accompagnamento is s)
		(then larghezza-manico is alto
		and larghezza-manico is basso with certainty 40
		and spessore-manico is basso 
		and spessore-manico is alto with certainty 40))
	
	(def-rule 
		(if curioso-pop-acustica is si and suona-live is si)
		(then grandezza-cassa is alto
		and grandezza-cassa is basso with certainty 60
		and spessore-cassa is alto
		and spessore-cassa is basso with certainty 60
		and legno is palissandro
		and legno is acero with certainty 60))
		
	(def-rule 
		(if curioso-pop-acustica is si and suona-live is no)
		(then grandezza-cassa is alto
		and grandezza-cassa is basso with certainty 75
		and spessore-cassa is alto with certainty 85
		and spessore-cassa is basso
		and legno is palissandro
		and legno is acero with certainty 60))
		
	(def-rule 
		(if curioso-folk-acustica is no and curioso-pop-acustica is no)
		(then grandezza-cassa is alto with certainty 50
		and grandezza-cassa is basso with certainty 50
		and spessore-cassa is alto with certainty 50
		and spessore-cassa is basso with certainty 50
		and legno is palissandro with certainty 50 
		and legno is acero with certainty 50))
	
	
	;regole per curioso chitarre elettriche
	(def-rule 
		(if curioso-tipo-elettrica is j)
		(then genre is jazz
		and num-corde is 6
		and pickup-type is hambucker))
		
	(def-rule 
		(if curioso-tipo-elettrica is r)
		(then genre is rock))
		
	(def-rule 
		(if curioso-tipo-elettrica is m)
		(then genre is metal))
		
	(def-rule 
		(if curioso-intarsi is no)
		(then tipo-intarsi is no))
		
	(def-rule
		(if curioso-tipo-chitarra is e and suona-da-due-anni is si)
		(then fascia-prezzo is alta 
		and fascia-prezzo is media))
		
	(def-rule 
		(if curioso-tipo-chitarra is e and suona-da-due-anni is no)
		(then fascia-prezzo is bassa
		and fascia-prezzo is media with certainty 30))
		
	(def-rule 
		(if curioso-tipo-chitarra is e and ha-chitarra is no)
		(then fascia-prezzo is media with certainty 30
		and fascia-prezzo is bassa))
		
	(def-rule 
		(if curioso-tipo-chitarra is e and suona-live is si)
		(then peso is basso 
		and peso is alto with certainty 65))
		
	(def-rule 
		(if curioso-tipo-chitarra is e and suona-live is no)
		(then peso is alto 
		and peso is basso with certainty 65))
		
	(def-rule 
		(if curioso-tipo-chitarra is e)
		(then num-tasti is 22 and num-tasti is 24))
		
	;regole curioso jazz
	(def-rule 
		(if genre is jazz and curioso-intarsi is si)
		(then tipo-intarsi is lunghi 
		and tipo-intarsi is circolari with certainty 50))
		
	(def-rule 
		(if curioso-jazz-classico is si)
		(then curioso-bebop is si
		and curioso-bebop is no with certainty 30))
	
	(def-rule 
		(if curioso-bebop is si and curioso-jazz-pulito is si)
		(then num-pickup is 1
		and num-pickup is 2 with certainty 60
		and forma is hollow))
	
	(def-rule 
	(if curioso-bebop is si and curioso-jazz-pulito is no)
	(then num-pickup is 2
	and curioso-fusion is si with certainty 65))
		
	(def-rule 
		(if curioso-jazz-classico is no)
		(then num-pickup is 2))
		
	(def-rule 
		(if curioso-fusion is si)
		(then forma is semi-hollow))
	
	(def-rule 
		(if curioso-fusion is no)
		(then forma is hollow with certainty 75
		and forma is semi-hollow))
		
	(def-rule 
		(if curioso-fusion is si)
		(then curioso-blues is si with certainty 60))
		
	(def-rule 
		(if curioso-blues is si)
		(then bridge-type is normal with certainty 70
		and bridge-type is tremolo))
		
	(def-rule 
		(if curioso-blues is no)
		(then bridge-type is normal))
		
	(def-rule 
		(if curioso-tipo-elettrica is j)
		(then colore-meccaniche is dorato
		and colore-meccaniche is argentato
		and spessore-manico is alto
		and spessore-manico is basso))
	
	
	(def-rule 
		(if curioso-jazz-classico is si)
		(then curioso-blues is no with certainty 65))
		
	;regole curioso rock
	(def-rule 
		(if curioso-corpo-strato is si)
		(then forma is rg
		and forma is sa))
		
		
		
	(def-rule 
		(if curioso-corpo-strato is no)
		(then forma is sg 
		and forma is rg with certainty 20
		and forma is sa with certainty 20))
		
	(def-rule 
		(if curioso-versatile is si)
		(then num-pickup is 3
		and num-pickup is 2 with certainty 65))

	(def-rule 
		(if curioso-versatile is no)
		(then num-pickup is 2))
		
	(def-rule 
		(if curioso-effettistica is si)
		(then ponte-mobile is si
		and ponte-mobile is no with certainty 50))
		
	(def-rule 
		(if curioso-effettistica is no)
		(then ponte-mobile is no
		and ponte-mobile is si with certainty 75))

	(def-rule 
		(if ponte-mobile is si and curioso-soft-rock is si)
		(then bridge-type is tremolo
		and bridge-type is floyd with certainty 65))
		
	(def-rule 
		(if ponte-mobile is si and curioso-solista is si)
		(then bridge-type is floyd
		and bridge-type is tremolo with certainty 65))
		
	(def-rule 
		(if curioso-solista is si)
		(then num-tasti is  24))
		
	(def-rule 
		(if curioso-solista is no)
		(then num-tasti is 24 
		and num-tasti is 22 with certainty 75))
		
	(def-rule 
		(if curioso-soft-rock is si)
		(then num-tasti is 24))
	(def-rule 
		(if curioso-soft-rock is no)
		(then num-tasti is 24))
		
	(def-rule 
		(if ponte-mobile is no)
		(then bridge-type is normal))

	(def-rule 
		(if curioso-tipo-elettrica is r)
		(then pickup-type is hambucker
		and colore-meccaniche is dorato
		and colore-meccaniche is argentato
		and num-corde is 6))
		
	(def-rule 
		(if curioso-tipo-elettrica is r and curioso-intarsi is si)
		(then tipo-intarsi is circolari 
		and tipo-intarsi is rose))
		
	(def-rule 
		(if curioso-tipo-elettrica is r and curioso-intarsi is no)
		(then tipo-intarsi is no))
		
	;regole curioso metal
	(def-rule 
		(if curioso-intarsi is si and curioso-tipo-elettrica is m)
		(then tipo-intarsi is circolari))
		
	(def-rule 
		(if curioso-intarsi is no and curioso-tipo-elettrica is m)
		(then tipo-intarsi is no))
		
	(def-rule 
		(if curioso-sei-corde is si)
		(then num-corde is 6))
		
	(def-rule 
		(if curioso-sei-corde is no)
		(then num-corde is 7))
		
	(def-rule 
		(if curioso-solo-distorsore is si)
		(then pickup-type is attivi
		and pickup-type is hambucker with certainty 75))
		
	(def-rule 
		(if curioso-solo-distorsore is no)
		(then pickup-type is hambucker 
		and pickup-type is attivi with certainty 75))
		
	(def-rule
		(if curioso-metal-solista is no)
		(then num-tasti is 22 
		and num-tasti is 24 with certainty 75
		and bridge-type is normal))
		
	(def-rule 
		(if curioso-metal-solista is si)
		(then forma is rg
		and forma is sa
		and num-tasti is 24 
		and num-tasti is 22 with certainty 50))
		
	(def-rule 
		(if curioso-metal-lp is si)
		(then forma is lp))
		
	(def-rule 
		(if curioso-metal-lp is no)
		(then forma is rg
		and forma is sa))
		
	(def-rule 
		(if curioso-tecnico is si)
		(then bridge-type is tremolo with certainty 75
		and bridge-type is normal with certainty 40
		and bridge-type is floyd))
		
	(def-rule 
		(if curioso-tecnico is no)
		(then bridge-type is tremolo
		and bridge-type is normal with certainty 40
		and bridge-type is floyd with certainty 65))
		
	(def-rule 
		(if curioso-tipo-elettrica is m)
		(then genre is metal
		and num-pickup is 2
		and colore-meccaniche is argentato))
	

;regole per compratore acustica

	(def-rule 
		(if problema-sudorazione is no)
		(then colore-meccaniche is argentato 
		and colore-meccaniche is dorato))
	
	(def-rule 
		(if problema-sudorazione is si)
		(then meccaniche-delicate is no
		and meccaniche-delicate is si with certainty 60))
		
	(def-rule 
		(if meccaniche-delicate is si and pulisce-chitarra is si)
		(then colore-meccaniche is dorato
		and colore-meccaniche is argentato))
		
	(def-rule 
		(if meccaniche-delicate is si and pulisce-chitarra is no)
		(then colore-meccaniche is argentato
		and colore-meccaniche is dorato with certainty 65))
		
	(def-rule 
		(if meccaniche-delicate is no and pulisce-chitarra is si)
		(then colore-meccaniche is argentato
		and colore-meccaniche is dorato with certainty 65))
	
;regole fascia prezzo chitarre	
	(def-rule 
		(if meccaniche-delicate is no and pulisce-chitarra is no)
		(then colore-meccaniche is argentato))
		
	(def-rule 
		(if fascia-prezzo-acustica is a)
		(then fascia-prezzo is alta))
	
	(def-rule 
		(if fascia-prezzo-acustica is b)
		(then fascia-prezzo is bassa))
		
	(def-rule
		(if fascia-prezzo-elettrica is a)
		(then fascia-prezzo is molto-alta
		and fascia-prezzo is alta with certainty 80
		and fascia-prezzo is media with certainty 40))
		
	(def-rule 
		(if fascia-prezzo-elettrica is b)
		(then fascia-prezzo is alta
		and fascia-prezzo is media with certainty 75))
	
	(def-rule 
		(if fascia-prezzo-elettrica is c)
		(then fascia-prezzo is media
		and fascia-prezzo is bassa with certainty 65))
		
	(def-rule 
		(if fascia-prezzo-elettrica is d)
		(then fascia-prezzo is bassa))
	
;regole per chitarre acustiche	
	
	(def-rule 	
		(if suona-live is si and suona-seduto is si)
		(then comodita-chitarra is no))
		
	(def-rule 
		(if suona-live is si and suona-seduto is no)
		(then comodita-chitarra is si))
		
	(def-rule 
		(if suona-live is no)
		(then comodita-chitarra is no
		and comodita-chitarra is si with certainty 75))
		
	(def-rule 
		(if folk-acustica is si and comodita-chitarra is si)
		(then spessore-cassa is alto with certainty 60
		and spessore-cassa is basso
		and grandezza-cassa is basso
		and grandezza-cassa is alto with certanity 80
		and legno is acero
		and legno is palissandro with certainty 60))
		
	(def-rule
		(if folk-acustica is si and comodita-chitarra is no)
		(then spessore-cassa is alto with certainty 70
		and spessore-cassa is basso
		and grandezza-cassa is basso with certainty 80
		and grandezza-cassa is alto 
		and legno is acero
		and legno is palissandro with certainty 60))
		
	(def-rule 
		(if suona-live is si)
		(then amplificazione is si))
		
	(def-rule 
		(if suona-live is no and chitarra-amplificata is no)
		(then amplificazione is no))
		
	(def-rule 
		(if suona-live is no and chitarra-amplificata is si)
		(then amplificazione is si
		and amplificazione is no with certainty 75))
		
		
	(def-rule 
		(if spalla-mancante is si)
		(then bool-spalla-mancante is si))
	
	(def-rule 
		(if spalla-mancante is no)
		(then bool-spalla-mancante is no))
		
	(def-rule 
		(if chitarra-da-accompagnamento is si)
		(then spessore-manico is alto
		and spessore-manico is basso with certainty 75
		and larghezza-manico is basso
		and larghezza-manico is alto with certainty 60))
	
	(def-rule 
		(if chitarra da accompagnamento is no and conosce-fingerstyle is no)
		(then spessore-manico is alto with certainty 75
		and spessore-manico is basso
		and larghezza-manico is basso
		and larghezza-manico is alto with certainty 60))
		
	(def-rule 
		(if chitarra-da-accompagnamento is no and fingerstyle is no)
		(then spessore-manico is alto with certainty 75
		and spessore-manico is basso 
		and larghezza-manico is basso
		and larghezza-manico is alto with certainty 60))
		
	(def-rule 
		(if chitarra-da-accompagnamento is no and fingerstyle is si)
		(then spessore-manico is alto with certainty 70
		and spessore-manico is basso
		and larghezza-manico is alto 
		and larghezza-manico is basso with certainty 40))
	
	(def-rule 
		(if pop-acustica is si and comodita-chitarra is no)
		(then grandezza-cassa is alto
		and grandezza-cassa is basso with certainty 60
		and spessore-cassa is alto
		and spessore-cassa is basso with certainty 60
		and legno is palissandro
		and legno is acero with certainty 60))
		
	(def-rule 
		(if pop-acustica is si and comodita-chitarra is si)
		(then grandezza-cassa is alto
		and grandezza-cassa is basso with certainty 75
		and spessore-cassa is alto with certainty 85
		and spessore-cassa is basso
		and legno is palissandro
		and legno is acero with certainty 60))
		
	(def-rule 
		(if folk-acustica is no and pop-acustica is no)
		(then grandezza-cassa is alto with certainty 50
		and grandezza-cassa is basso with certainty 50
		and spessore-cassa is alto with certainty 50
		and spessore-cassa is basso with certainty 50
		and legno is palissandro with certainty 50 
		and legno is acero with certainty 50))
		
		
	;;regole sul peso della chitarra 
	
	(def-rule 
		(if suona-live is si and tipo-chitarra-da-acquistare is e)
		(then peso is basso 
		and peso is alto with certainty 80))
		
	(def-rule 
		(if suona-live is no and tipo-chitarra-da-acquistare is e)
		(then peso is basso 
		and peso is alto))
	;;regole per chitarre semiacustiche
	
	(def-rule 
		(if intarsi-jazz is no)
		(then tipo-intarsi is no
		and tipo-intarsi is circolari with certainty 50
		and tipo-intarsi is lunghi with certainty 50))
		
	(def-rule 
		(if intarsi-jazz is si and jazz-classico is si)
		(then tipo-intarsi is circolari 
		and tipo-intarsi is lunghi with certainty 60))
		
	(def-rule 
		(if intarsi-jazz is si and jazz-classico is no)
		(then tipo-intarsi is lunghi 
		and tipo-intarsi is circolari with certainty 60))
		
	(def-rule 
		(if forma-intarsi-jazz is r)
		(then tipo-intarsi is lunghi
		and tipo-intarsi is circolari with certainty 50))
	
	(def-rule 
		(if jazz-classico is si)
		(then amante-bebop is si
		and jazz-effettistica is no with certainty 60))
	
	(def-rule 
		(if jazz-classico is no)
		(then amante-bebop is no))
		
	(def-rule 
		(if amante-bebop is si)
		(then num-pickup is 1
		and num-pickup is 2 with certainty 75
		and forma is hollow))

		
	(def-rule 
		(if jazz-effettistica is no)
		(then bridge-type is normal))
		
	(def-rule 
		(if jazz-effettistica is si)
		(then bridge-type is tremolo
		and bridge-type is normal with certainty 80))
		
	(def-rule 
		(if amante-bebop is no)
		(then forma is semi-hollow
		and num-pickup is 2))

		
	(def-rule 
		(if genre is jazz)
		(then pickup-type is hambucker
		and num-corde is 6
		and num-tasti 22))
		
	(def-rule 
		(if spessore-corde is si)
		(then spessore-manico is alto 
		and spessore-manico is basso with certainty 70))
		
	(def-rule 
		(if spessore-corde is no)
		(then spessore-manico is basso
		and spessore-manico is alto with certainty 70))
		
	
	;regole sulle chitarre rock
	(def-rule 
		(if genre is rock)
		(then pickup-type is hambucker))
	
	(def-rule 
		(if corpo-strato is si)
		(then forma is rg
		and forma is sa))
		
	(def-rule
		(if corpo-strato is no)
		(then forma is sg 
		and forma is sa with certainty 30
		and forma is rg with certainty 30))
		
	(def-rule 
		(if forma is sg)
		(then num-pickup is 2))
		
	(def-rule 
		(if genre is rock)
		(then num-corde is 6))
		
	(def-rule 
		(if solista-rock is si)
		(then num-tasti is 24 
		and num-tasti is 22 with certainty 60
		and ponte is mobile))
		
	(def-rule 
		(if solista-rock is no)
		(then num-tasti is 22
		and num-tasti is 24 with certainty 60))
		
	(def-rule
		(if solista-rock is no)
		(then ponte is normal 
		and ponte is mobile with certainty 45))
		
	(def-rule 
		(if ponte is normal and problema-sudorazione is si)
		(then bridge-type is normal))
		
	(def-rule 
		(if ponte is normal and problema-sudorazione is no)
		(then bridge-type is normal))
		
	(def-rule 
		(if ponte is mobile and problema-sudorazione is si)
		(then bridge-type is normal with certainty 40
		and bridge-type is tremolo with certainty 70))
		
	(def-rule 
		(if ponte is mobile and problema-sudorazione is no)
		(then bridge-type is tremolo with certainty 70
		and bridge-type is floyd))
		
	(def-rule
		(if versatile is si)
		(then num-pickup is 3 
		and num-pickup is 2 with certainty 60))
		
	(def-rule 
		(if versatile is no)
		(then num-pickup is 2
		and num-pickup is 3 with certainty 60))
	
	(def-rule 
		(if amante-effettistica is si)
		(then ponte is mobile
		and ponte is normal is no with-certainty 70
		and amante-soft-rock is si with certainty 80
		and amante-soft-rock is no with certainty 40))
	
	(def-rule 
		(if amante-effettistica is no)
		(then ponte is mobile with certainty 80
		and ponte is normal
		and amante-soft-rock is no with certainty 80
		and amante-soft-rock is si with certainty 40))
		
	(def-rule 
		(if amante-soft-rock is no)
		(then shredder is si with certainty 75
		and cambia-accordatura is si with certainty 75))
		
	(def-rule
		(if amante-soft-rock is si)
		(then cambia-accordatura is no with certainty 75))
	
	(def-rule 
		(if ponte is mobile and amante-soft-rock is si)
		(then bridge-type is tremolo
		and bridge-type is floyd with certainty 80))
		
	(def-rule 
		(if ponte is mobile and shredder is si)
		(then floyd-rose is si
		and bridge-type is tremolo with certainty 80))
	
	(def-rule 
		(if ponte is mobile and shredder is no)
		(then bridge-type is tremolo
		and floyd-rose is si with-certainty 80))
		
	(def-rule 
		(if floyd-rose is si and cambia-accordatura is si)
		(then bridge-type is floyd with certainty 40
		and bridge-type is tremolo))
		
	(def-rule 
		(if floyd-rose is si and cambia-accordatura is no)
		(then bridge-type is floyd 
		and bridge-type is tremolo with certainty 60))
	
	(def-rule 
		(if intarsi-rock is si)
		(then tipo-intarsi is circolari
		and tipo-intarsi is rose
		and tipo-intarsi is no with certainty 40))
		
	(def-rule 
		(if intarsi-rock is no)
		(then tipo-intarsi is no with certainty 40
		and tipo-intarsi is circolari with certainty 40
		and tipo-intarsi is rose))
		
	;;regole chitarre metal
	(def-rule 
		(if num-corde is 6 and solista-metal is no)
		(then forma is lp
		and forma is rg with certainty 65
		and forma is  sa with certainty 65))
		
	(def-rule
		(if num-corde is 7)
		(then forma is rg))
		
	(def-rule 
		(if solista-metal is si and num-corde is 6)
		(then forma is rg
		and forma is sa 
		and forma is lp with certainty 40))
	
	(def-rule 
		(if genre is metal)
		(then num-pickup is 2))
		
	(def-rule 
		(if amante-metal-moderno is no)
		(then num-corde is 6))
		
	(def-rule 
		(if amante-metal-moderno is si)
		(then num-corde is 7
		and num-corde is 6 with certainty 65))
		
		
	(def-rule 
		(if lp-shape is si)
		(then forma is lp
		and forma is rg with certainty 70))
		
	(def-rule 
		(if lp-shape is no)
		(then forma is rg))
		
	(def-rule 
		(if solo-distorsore is si)
		(then pickup-type is attivi 
		and pickup-type is hambucker with certainty 80))
		
	(def-rule 
		(if solo-distorsore is no)
		(then pickup-type is hambucker))
		
	(def-rule 
		(if solista-metal is no)
		(then bridge-type is normal
		and bridge-type is floyd with certainty 65
		and bridge-type is tremolo with certainty 75
		and num-tasti is 22 
		and num-tasti is 24 with certainty 75))
		
	(def-rule 
		(if solista-metal is si)
		(then ponte is mobile 
		and bridge-type is normal with certainty 30))
		
	(def-rule 
		(if sweep-tapping is si)
		(then num-tasti is 24 
		and num-tasti is 22 with certainty 75))
		
	(def-rule 
		(if sweep-tapping is no)
		(then num-tasti is 22
		and num-tasti is 24 with certainty 75))
		
	(def-rule 
		(if intarsi-metal is si)
		(then tipo-intarsi is circolare
		and tipo-intarsi is no with certainty 40))
		
	(def-rule 
		(if intarsi-metal is no)
		(then tipo-intarsi is no
		and tipo-intarsi is circolare with certainty 40))
)
 