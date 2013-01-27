#!/bin/bash
## get the binary matrix (1, 0) of peaks

i=1
pblist=()
for peaks in *peaks.bed; do
    pblist[i++]=$peaks
    term1=$(echo $peaks | sed -e 's/_peaks.bed/_sorted_peaks.bed/g')
    sortBed -i $peaks > $term1
    term2=$(echo $peaks | sed -e 's/_peaks.bed/_merged_peaks.bed/g')
    mergeBed -i $term1 -d 10 > $term2
done

pbs=$(IFS=" "; echo "${pblist[*]}")
echo $pbs

cat $pbs > merged_unsort.bed
sortBed -i merged_unsort.bed > merged_sort.bed
mergeBed -i merged_sort.bed -d 10 > mergedpeaks.bed

head=()
i=1
for peaks in *_merged_peaks.bed; do
    term3=$(echo $peaks | sed -e 's/_peaks.bed/.txt/g')
    intersectBed -a mergedpeaks.bed -b $peaks -c > $term3
    term4=$(echo $peaks | sed -e 's/_peaks.bed//g')
    head[i++]=$term4
done


i=1
pbtxt=()
for peakstxt in *merged.txt; do
        pbtxt[i++]=$peakstxt
done
pbtxts=$(IFS=" "; echo "${pbtxt[*]}")
echo $pbtxts

num=${#pbtxt[@]}
end=$(expr $num*4 )
id=1
col=()
for (( i=4; i<=$end; i=$i+4));do 
        col[id++]=$i;
done
cols=$(IFS=","; echo "${col[*]}")


printf Chr\\tStart\\tEnd > matrix.txt
for i in ${!head[*]}
do 
        printf \\t${head[$i]} >> matrix.txt
done
printf \\n >> matrix.txt

paste $pbtxts | cut -f1,2,3,$cols >> matrix.txt