LOG="$(dirname $0)/log.log"
EXC="$(dirname $0)/exc.txt"
SRC="$(dirname $0)/src.txt"
DST="$(dirname $0)/dst.txt"

echo =============================== >> $LOG
echo "" >> $LOG
echo Backup Starting... >> $LOG
date >> $LOG
echo "" >> $LOG

function syncfile {
	#echo $1 . $2
	rsync -avzr --delete --exclude-from $EXC $1 $2 >> $LOG
}

IFS=$'\n'

s=0
for i in $(cat "$SRC"); do
	sources[$s]="$i"
	s=$[s+1]
done

d=0
for i in $(cat "$DST"); do
	destinations[$d]=$i
	d=$[d+1]
done

if [ $s != $d ]; then
	echo SRC and DST files have differing entry counts!
	exit
else

for (( c=0; c<$s; c++ )); do
	#echo ${sources[$c]} "     :::     " ${destinations[$c]}
	syncfile ${sources[$c]} ${destinations[$c]}
done


echo "Complete" >> $LOG
echo "" >> $LOG
fi

exit