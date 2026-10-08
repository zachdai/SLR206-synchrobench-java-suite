#!/bin/bash

case $1 in
	"1" )	OUTPUTS="CoarseGrainedListBasedSet"
	;;
	"2" )	OUTPUTS="HandOverHandListIntSet"
	;;
	"3" )	OUTPUTS="LazyLinkedListSortedSet"
	;;
	"all" ) OUTPUTS="CoarseGrainedListBasedSet HandOverHandListIntSet LazyLinkedListSortedSet"
	;;
	*)		echo "Specify algorithm: 1, 2, 3 or all"
			exit 0
esac

for OUTPUT in $OUTPUTS
do
	echo "Who I am: $OUTPUT on `uname -n`"
	echo "started on" `date`

	for i in 1 4 6 8 10 12
	do
		for j in 0 10 100
		do
			for k in 100 1000 10000
			do
				r=$((2*k))
				echo "→ $OUTPUT	$i	$j	$k"
				java -cp bin contention.benchmark.Test -b linkedlists.lockbased.$OUTPUT -d 2000 -t $i -u $j -i $k -r $r -W 0 | grep Throughput
			done
		done
	done
done

echo "finished on" `date`
echo "DONE \o/"
