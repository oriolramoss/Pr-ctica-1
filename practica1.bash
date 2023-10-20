#!bin/bash
bol=0
while [ $bol=0 ]
do	
	read option
	case $option in
		'q')
			echo "Sortint de l'aplicació"
			exit 0
		;;
		
		'lp')
			cut -d',' -f7,8 cities.csv | uniq
		;;

		'sc')
			echo "Introdueix pais:"
			read x
			pais="XX"

			if [ -n $x ]; then
				pais=$(cut -d',' -f7,8 cities.csv | egrep "$x" | cut -d',' -f1 | uniq)
				if [ -z "$pais" ]; then
					pais="XX"
				fi
			fi


			echo $pais
		;;
		
		'se')
			echo "Introdueix estat:"
                        read y
                        estat="XX"
                        if [ -n "$y" ]; then
                                estat=$(egrep "$pais" cities.csv | cut -d',' -f4,5 | egrep "$y" | cut -d',' -f1 | uniq)
                                if [ -z "$estat" ]; then
                                        estat="XX"
                                fi
                        fi
                        echo $estat
		;;

		'le')
			cut -d',' -f4,5,8 cities.csv | egrep "$x" | cut -d',' -f1,2 | uniq
		;;
		
		'lcp')
			
			cut -d',' -f2,7,11 cities.csv | egrep "$pais" | cut -d',' -f1,3 | uniq	
		;;

		'ecp')
			cut -d',' -f2,7,11 cities.csv | egrep "$pais" | cut -d',' -f1,3 | uniq > "$pais".csv
		;;
		
		'lce')
			
			#problema 8
			cut -d',' -f2,5,11 cities.csv | egrep "$y" | cut -d',' -f1,3 | uniq
			'''
			#problema 9 és el mateix pero guardant
			cut -d',' -f2,5,11 cities.csv | egrep "$y" | cut -d',' -f1,3 | uniq > "$pais"_"$estat".csv
			'''
		;;

		'gwd')
			echo "Digues població:"
			read z
			if [ -n "$z" ]; then
				wikiid=$(cut -d',' -f2,5,8,11 cities.csv | egrep "$y" | egrep "$z" | cut -d',' -f4 | uniq)

                        	echo $wikiid
				wget https://www.wikidata.org/wiki/Special:EntityData/"$wikiid".json
			fi	
		;;

		'est')
			awk -F',' 'BEGIN{ Nord=0; Sud=0; Est=0; Oest=0; Noubic=0; NoWDld=0; }  { if ( NR > 0 ) { Nord += ( $9 > 0 ) } { Sud += ( $9 < 0 ) } { Est += ( $10 > 0 ) } { Oest += ( $10 < 0 ) } { Noubic += ( $9 == 0  )&&( $10 == 0 ) } { NoWDld += ( $11=="" ) } } END { print "Nord " Nord " Sud " Sud " Est " Est " Oest " Oest " No ubic " Noubic " No WDld " NoWDld }' cities.csv
                ;; 
	esac
done	
