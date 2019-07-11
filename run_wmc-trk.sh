#!/bin/bash

tck_id=`jq -r '._inputs[0].meta.subject' config.json`
seg_est=`jq -r '.seg_est' config.json`
seg_true=`jq -r '.seg_true' config.json`
tractogram=`jq -r '.tractogram' config.json`
t1=`jq -r '.t1' config.json`

echo "tck conversion to trk"
cp $tractogram ${tck_id}_tractogram.tck
python tck2trk.py $t1 ${tck_id}_tractogram.tck -f;

echo "wmc conversion to trk"
mkdir tracts_est
python wmc2trk.py -tractogram ${tck_id}_tractogram.trk -classification $seg_est -out_dir tracts_est

if [ -z "$(ls -A -- "tracts_est")" ]; then
	echo "wmc to trk conversion failed"
	exit 1
fi

# Building arrays
arr_seg_true=()
arr_seg_true+=(${seg_true})
num_tracts=$((${#arr_seg_true[@]} - 2))

mkdir tracts_true
for i in `seq 1 $num_tracts`; do
	tract_name=$(jq -r "._inputs[1+$i].tags[0]" config.json | tr -d "_")
	echo $tract_name
	echo $num_tracts
	cp ${arr_seg_true[i]//[,\"]} tracts_true/${tract_name}_tract.trk
done

echo "Computing voxel measures"
python evaluation.py -sub $tck_id -dir_est tracts_est -dir_true tracts_true

