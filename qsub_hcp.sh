SCRIPT='/home/despoB/kaihwang/bin/FC_Scripts'
DATA='/home/despoB/kaihwang/bin/HCP-processing/Data'

#cd /home/despoB/connectome-data
cd /home/despoB/connectome-thalamus/NKI

for s in $(/bin/ls -d *); do
	#if [ ! -e "/home/despoB/kaihwang/Rest/Graph/gsetCI_${Subject}.mat" ]; then
	sed "s/s in 0102826_session_1/s in ${s}/g" < ${SCRIPT}/cal_adj.sh > ~/tmp/t${s}.sh
	qsub -l mem_free=5G -V -M kaihwang -m e -e ~/tmp -o ~/tmp ~/tmp/t${s}.sh
	#fi

done

