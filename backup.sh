#These are the locations of the helper files for rsync

#Log file
LOG="$(dirname $0)/log.log"
#Exclusion list file
EXC="$(dirname $0)/exc.txt"
#List of source files and directories to sync from
SRC="$(dirname $0)/src.txt"
#List of destination files and directories to sync to
DST="$(dirname $0)/dst.txt"

#Nice log looking things
echo =============================== >> $LOG
echo "" >> $LOG
echo Backup Starting... >> $LOG
date >> $LOG
echo "" >> $LOG

#The actual rsync function
#Takes two arguments ($1 and $2), which are the source and destination log 
function syncfile {
	rsync -avzr --delete --exclude-from $EXC $1 $2 >> $LOG
}

#Sets the newline character to be \n (Allows for cat to keep spaces in directories)
IFS=$'\n'

#Grab all the sources from the text file and put them into an array
s=0
for i in $(cat "$SRC"); do
	sources[$s]="$i"
	s=$[s+1]
done

#Grab all the destinations from a text file and put them into an array
d=0
for i in $(cat "$DST"); do
	destinations[$d]=$i
	d=$[d+1]
done

#Check to make sure source and destination have matching counts. If they don't, whine and exit.
if [ $s != $d ]; then
	echo "SRC and DST files have differing entry counts!" >> $LOG
	exit
else

#Iterate over all the sources and destinations and sync them
for (( c=0; c<$s; c++ )); do
	syncfile ${sources[$c]} ${destinations[$c]}
done

#Nice looking logs
echo "Complete" >> $LOG
echo "" >> $LOG
fi

exit