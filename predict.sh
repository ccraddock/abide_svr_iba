#!/bin/bash

argc=$#
argv=("$@")

mask="/mnt/mask/cc200_binary.nii.gz"
inv_mask="/mnt/mask/invert"

subdirs=('/abide_data/data/NYU_0050952' \
         '/abide_data/data/NYU_0050954' \
         '/abide_data/data/NYU_0050955' \
         '/abide_data/data/NYU_0050956' \
         '/abide_data/data/NYU_0050957' \
         '/abide_data/data/NYU_0050958' \
         '/abide_data/data/NYU_0050959' \
         '/abide_data/data/NYU_0050960' \
         '/abide_data/data/NYU_0050961' \
         '/abide_data/data/NYU_0050962' \
         '/abide_data/data/NYU_0050964' \
         '/abide_data/data/NYU_0050965' \
         '/abide_data/data/NYU_0050966' \
         '/abide_data/data/NYU_0050967' \
         '/abide_data/data/NYU_0050968' \
         '/abide_data/data/NYU_0050969' \
         '/abide_data/data/NYU_0050970' \
         '/abide_data/data/NYU_0050972' \
         '/abide_data/data/NYU_0050973' \
         '/abide_data/data/NYU_0050974' \
         '/abide_data/data/NYU_0050976' \
         '/abide_data/data/NYU_0050977' \
         '/abide_data/data/NYU_0050978' \
         '/abide_data/data/NYU_0050979' \
         '/abide_data/data/NYU_0050981' \
         '/abide_data/data/NYU_0050982' \
         '/abide_data/data/NYU_0050983' \
         '/abide_data/data/NYU_0050984' \
         '/abide_data/data/NYU_0050985' \
         '/abide_data/data/NYU_0050986' \
         '/abide_data/data/NYU_0050987' \
         '/abide_data/data/NYU_0050988' \
         '/abide_data/data/NYU_0050989' \
         '/abide_data/data/NYU_0050990' \
         '/abide_data/data/NYU_0050991' \
         '/abide_data/data/NYU_0050992' \
         '/abide_data/data/NYU_0050993' \
         '/abide_data/data/NYU_0050994' \
         '/abide_data/data/NYU_0050995' \
         '/abide_data/data/NYU_0050996' \
         '/abide_data/data/NYU_0050997' \
         '/abide_data/data/NYU_0050998' \
         '/abide_data/data/NYU_0050999' \
         '/abide_data/data/NYU_0051000' \
         '/abide_data/data/NYU_0051001' \
         '/abide_data/data/NYU_0051002' \
         '/abide_data/data/NYU_0051003' \
         '/abide_data/data/NYU_0051006' \
         '/abide_data/data/NYU_0051007' \
         '/abide_data/data/NYU_0051008' \
         '/abide_data/data/NYU_0051009' \
         '/abide_data/data/NYU_0051010' \
         '/abide_data/data/NYU_0051011' \
         '/abide_data/data/NYU_0051012' \
         '/abide_data/data/NYU_0051013' \
         '/abide_data/data/NYU_0051014' \
         '/abide_data/data/NYU_0051015' \
         '/abide_data/data/NYU_0051016' \
         '/abide_data/data/NYU_0051017' \
         '/abide_data/data/NYU_0051018' \
         '/abide_data/data/NYU_0051019' \
         '/abide_data/data/NYU_0051020' \
         '/abide_data/data/NYU_0051021' \
         '/abide_data/data/NYU_0051023' \
         '/abide_data/data/NYU_0051024' \
         '/abide_data/data/NYU_0051025' \
         '/abide_data/data/NYU_0051026' \
         '/abide_data/data/NYU_0051027' \
         '/abide_data/data/NYU_0051028' \
         '/abide_data/data/NYU_0051029' \
         '/abide_data/data/NYU_0051030' \
         '/abide_data/data/NYU_0051032' \
         '/abide_data/data/NYU_0051033' \
         '/abide_data/data/NYU_0051034' \
         '/abide_data/data/NYU_0051035' \
         '/abide_data/data/NYU_0051036' \
         '/abide_data/data/NYU_0051038' \
         '/abide_data/data/NYU_0051039' \
         '/abide_data/data/NYU_0051040' \
         '/abide_data/data/NYU_0051041' \
         '/abide_data/data/NYU_0051042' \
         '/abide_data/data/NYU_0051044' \
         '/abide_data/data/NYU_0051045' \
         '/abide_data/data/NYU_0051046' \
         '/abide_data/data/NYU_0051047' \
         '/abide_data/data/NYU_0051048' \
         '/abide_data/data/NYU_0051049' \
         '/abide_data/data/NYU_0051050' \
         '/abide_data/data/NYU_0051051' \
         '/abide_data/data/NYU_0051052' \
         '/abide_data/data/NYU_0051053' \
         '/abide_data/data/NYU_0051054' \
         '/abide_data/data/NYU_0051055' \
         '/abide_data/data/NYU_0051056' \
         '/abide_data/data/NYU_0051057' \
         '/abide_data/data/NYU_0051058' \
         '/abide_data/data/NYU_0051059' \
         '/abide_data/data/NYU_0051060' \
         '/abide_data/data/NYU_0051061' \
         '/abide_data/data/NYU_0051062' \
         '/abide_data/data/NYU_0051063' \
         '/abide_data/data/NYU_0051064' \
         '/abide_data/data/NYU_0051065' \
         '/abide_data/data/NYU_0051066' \
         '/abide_data/data/NYU_0051067' \
         '/abide_data/data/NYU_0051068' \
         '/abide_data/data/NYU_0051069' \
         '/abide_data/data/NYU_0051070' \
         '/abide_data/data/NYU_0051071' \
         '/abide_data/data/NYU_0051072' \
         '/abide_data/data/NYU_0051073' \
         '/abide_data/data/NYU_0051074' \
         '/abide_data/data/NYU_0051075' \
         '/abide_data/data/NYU_0051076' \
         '/abide_data/data/NYU_0051077' \
         '/abide_data/data/NYU_0051078' \
         '/abide_data/data/NYU_0051079' \
         '/abide_data/data/NYU_0051080' \
         '/abide_data/data/NYU_0051081' \
         '/abide_data/data/NYU_0051082' \
         '/abide_data/data/NYU_0051083' \
         '/abide_data/data/NYU_0051084' \
         '/abide_data/data/NYU_0051085' \
         '/abide_data/data/NYU_0051086' \
         '/abide_data/data/NYU_0051087' \
         '/abide_data/data/NYU_0051088' \
         '/abide_data/data/NYU_0051089' \
         '/abide_data/data/NYU_0051090' \
         '/abide_data/data/NYU_0051091' \
         '/abide_data/data/NYU_0051093' \
         '/abide_data/data/NYU_0051094' \
         '/abide_data/data/NYU_0051095' \
         '/abide_data/data/NYU_0051096' \
         '/abide_data/data/NYU_0051097' \
         '/abide_data/data/NYU_0051098' \
         '/abide_data/data/NYU_0051099' \
         '/abide_data/data/NYU_0051100' \
         '/abide_data/data/NYU_0051101' \
         '/abide_data/data/NYU_0051102' \
         '/abide_data/data/NYU_0051103' \
         '/abide_data/data/NYU_0051104' \
         '/abide_data/data/NYU_0051105' \
         '/abide_data/data/NYU_0051106' \
         '/abide_data/data/NYU_0051107' \
         '/abide_data/data/NYU_0051109' \
         '/abide_data/data/NYU_0051110' \
         '/abide_data/data/NYU_0051111' \
         '/abide_data/data/NYU_0051112' \
         '/abide_data/data/NYU_0051113' \
         '/abide_data/data/NYU_0051114' \
         '/abide_data/data/NYU_0051116' \
         '/abide_data/data/NYU_0051117' \
         '/abide_data/data/NYU_0051118' \
         '/abide_data/data/NYU_0051121' \
         '/abide_data/data/NYU_0051122' \
         '/abide_data/data/NYU_0051123' \
         '/abide_data/data/NYU_0051124' \
         '/abide_data/data/NYU_0051126' \
         '/abide_data/data/NYU_0051127' \
         '/abide_data/data/NYU_0051128' \
         '/abide_data/data/NYU_0051129' \
         '/abide_data/data/NYU_0051130' \
         '/abide_data/data/NYU_0051131' \
         '/abide_data/data/NYU_0051146' \
         '/abide_data/data/NYU_0051147' \
         '/abide_data/data/NYU_0051148' \
         '/abide_data/data/NYU_0051149' \
         '/abide_data/data/NYU_0051150' \
         '/abide_data/data/NYU_0051151' \
         '/abide_data/data/NYU_0051152' \
         '/abide_data/data/NYU_0051153' \
         '/abide_data/data/NYU_0051154' \
         '/abide_data/data/NYU_0051155' \
         '/abide_data/data/NYU_0051156' \
         '/abide_data/data/NYU_0051159' )

export AFNI_COMPRESS=GZIP
export AFNI_PATH=/abide_data/afni_bin

echo "predict.sh $argc"

if [ "$argc" -ne "2" ]
then
    echo "usage: ${argv[0]} <subnum> <roi>"
    exit 1
fi

subnum=${argv[0]}
roinum=${argv[1]}

dir=${subdirs[${subnum}]}
echo "Processing ${subnum} ${roinum} ${dir} ${subid}"

ccwd=$PWD

# verify that the file exists, is appropriate, and parse out 
# relevant information
if [ ! -d ${dir} ]
then
    echo "$dir does not exist" 
    exit 1
fi

# go into the directory to make some things easier

subid=$( basename $dir )

prefix=${subid}
dataname=${subid}_sm_zscore.nii.gz
tcname=${subid}_label
tdir=/mnt/data/${subid}

# do everything locally and copy back when done
cd $tdir

echo "Processing ${subnum} ${dir} ${subid}"

# get all of the timecourses
for (( i=${roinum}; i<=${roinum}; i++ ))
do

    if [ ! -f ${tcname}_${i}.1D ]
    then
        echo "Couldn't find TC file for ${i} (${tcname}_${i}.1D)"
        continue
    fi

    if [ ! -f ${prefix}_w_${i}.nii.gz ]
    then
        ${AFNI_PATH}/3dsvm -type regression -c 100 -e 0.001 \
              -trainvol ${dataname} \
              -trainlabels ${tcname}_${i}.1D \
              -mask ${inv_mask}_${i}.nii.gz \
              -model ${prefix}_model_${i}.nii.gz \
              -bucket ${prefix}_w_${i}.nii.gz

        rm ${prefix}_model_${i}.nii.gz
    else
        echo "Model file for $i already created"
    fi

    pred_dir=${tdir}/pred_${i}
    if [ ! -d ${pred_dir} ]
    then
        echo "creating ${pred_dir}"
        mkdir -p ${pred_dir}
    fi

    # now do the predictions
    for (( s=1; s<${#subdirs[@]}; s++ ))
    do
        echo "$s <=> $subnum"
        if [ "${s}" -ne "${subnum}" ]
        then
            testsub=$( basename ${subdirs[${s}]} )

            testdata=/mnt/data/${testsub}/${testsub}_sm_zscore.nii.gz
            if [ ! -f ${testdata} ]
            then
                echo "Cannot find ${testdata}"
                continue
            fi

            pred_file=${pred_dir}/${subid}_${testsub}_pred_${i}.1D

            echo "predicting ${testsub} ${i}" 

            ${AFNI_PATH}/3dsvm_linpredict -mask ${mask} \
                ${prefix}_w_${i}.nii.gz \
                ${testdata} \
                > ${pred_file}
        fi
    done

    tar cf pred_${i}.tar ${pred_dir} ${prefix}_w_${i}.nii.gz
    gzip pred_${i}.tar
    rm -rfv ${pred_dir} ${prefix}_w_${i}.nii.gz
   
    mv pred_${i}.tar.gz ${dir}/
done
