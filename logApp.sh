#!/bin/sh

DIR=~/.log/
TEMP=.temp
TEMPG=.tempg
TEMPF=.tempf
FMT=.xml
DIRIMAGE=~/.log/images/

function sendLog(){
    curl -u $USER:$PASS -T $DIR'xml/'$1$FMT $DIRFTP'xml/'
}
function sendImg(){
    IMAGE=$1
    HTTP=${IMAGE:0:4}
    EXTENS=${IMAGE: -4}

    if [ $HTTP = 'http' ]
    then
	curl $IMAGE -o $2$EXTENS
	curl -u $USER:$PASS -T $2$EXTENS $DIRFTP'images/'

    else
	cp $IMAGE $2$EXTENS
	curl -u $USER:$PASS -T $2$EXTENS $DIRFTP'images/'
    fi
    
    echo '<image>'$DATE$EXTENS'</image>' >> $DIR$TEMP
}

function log(){
    
    DATE=`date +%Y-%m-%d__%H:%M:%S`
    if [ $1 = -c ]
    then
	read -p 'title: ' titre
	read -p 'Description: ' describe
	read -p 'Enter tags: ' cate
	echo '<item>' >> $DIR'xml/'$2$FMT
	echo '	<meta>' >> $DIR'xml/'$2$FMT
	echo '	    <titre>'$titre'</titre>' >> $DIR'xml/'$2$FMT
	echo '	    <description>'$describe'</description>' >> $DIR'xml/'$2$FMT
	echo '	    <tags>'$cate'</tags>' >> $DIR'xml/'$2$FMT
	echo '	    <creationdate>'$DATE'</creationdate>' >> $DIR'xml/'$2$FMT
	echo '	    <modificationdate>'$DATE'</modificationdate>' >> $DIR'xml/'$2$FMT
	echo '	    <notecount>0</notecount>' >> $DIR'xml/'$2$FMT
	echo '	</meta>' >> $DIR'xml/'$2$FMT
	echo '	<notes>' >> $DIR'xml/'$2$FMT
	echo '	</notes>' >> $DIR'xml/'$2$FMT
	echo '</item>' >> $DIR'xml/'$2$FMT
	sendLog $2
    elif [ $1 = -a ]
    then
	echo a
    elif [ $1 = ls ]
    then
	ls $DIR'xml/' 
    elif [ $1 = -r ]
    then
	cat $DIR'xml/'$2$FMT
    elif [ $1 = -m ]
    then
	vim $DIR'xml/'$2$FMT
    elif [ $1 = -u ]
    then
	sendLog $2
    elif [ $1 = -mu ]
    then
	vim $DIR'xml/'$2$FMT
	sendLog $2

    elif  [ $1 = -rm ] 
    then
	rm $DIR'xml/'$2$FMT
    else
	FILE=$1
	CONTENT=$2
	ATRIMAGE=$3
	IMAGE=$4
	head -n -2 $DIR'xml/'$FILE$FMT > $DIR$TEMPG
	COUNT=$(sed -n 8p $DIR$TEMPG)
	IFS='>'
	set $COUNT
	COUNT=$2
	IFS='<'
	set $COUNT
	COUNT=$1	
	let COUNT++
	echo $COUNT
	
	sed -i 's/<notecount>.*<\/notecount>/<notecount>'$COUNT'<\/notecount>/' $DIR$TEMPG
	sed -i 's/<modificationdate>.*<\/modificationdate>/<modificationdate>'$DATE'<\/modificationdate>/' $DIR$TEMPG
	
	echo '<note>' > $DIR$TEMP
	echo '		<id>'$COUNT'</id>' >> $DIR$TEMP
	echo '		<creationdate>'$DATE'</creationdate>' >> $DIR$TEMP
	echo '		<contenu>'$CONTENT'</contenu>' >> $DIR$TEMP
	
	if [ $ATRIMAGE = -img ]  
	then
	    sendImg $IMAGE $DIRIMAGE$DATE
	fi

	echo '	    </note>' >> $DIR$TEMP
	echo '	</notes>' >> $DIR$TEMP
	echo '</item>' >> $DIR$TEMP
	paste -z $DIR$TEMPG $DIR$TEMP > $DIR$TEMPF
	head -n -1 $DIR$TEMPF > $DIR'xml/'$FILE$FMT
	sendLog $FILE

    fi
}
