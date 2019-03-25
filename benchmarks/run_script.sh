#!/bin/bash

for w in 1 4
do
  OUTFILE="e-${w}w-results.txt"
  printf "# Threads" >> $OUTFILE
  for k in {1..5}
  do
    printf ",ERMIA (W$w) [T$k]" >> $OUTFILE
  done
  printf "\n" >> $OUTFILE
  for i in 1 2 4 12 23 24 31 32 36 47 48
  do
    printf "$i" >> $OUTFILE
    for k in {1..5}
    do
      echo "running $w,$i,$k"
      ermia=$(./run.sh ./ermia_SI_SSN tpcc $w $i 10 '-node_memory_gb=40 -null_log_device -enable_gc -phantom_prot --retry-aborted-transactions -persist-policy=async' '--new-order-fast-id-gen' 2>/dev/null | grep -oE '^[0-9.]+ commits/s' | grep -oE '[0-9.]+')
      printf ",$ermia" >> $OUTFILE
      sleep 1
    done
    printf "\n" >> $OUTFILE
  done
done
