#!/usr/bin/env python

import numpy as np
import sys
import glob
import tarfile
import os
import subprocess
import csv

subids=[ 'NYU_0050954', 'NYU_0050955', 'NYU_0050956', 'NYU_0050957', 'NYU_0050958', 'NYU_0050959', 'NYU_0050960',
         'NYU_0050961', 'NYU_0050962', 'NYU_0050964', 'NYU_0050965', 'NYU_0050966', 'NYU_0050967', 'NYU_0050968', 'NYU_0050969',
         'NYU_0050970', 'NYU_0050972', 'NYU_0050973', 'NYU_0050974', 'NYU_0050976', 'NYU_0050977', 'NYU_0050978', 'NYU_0050979',
         'NYU_0050981', 'NYU_0050982', 'NYU_0050983', 'NYU_0050984', 'NYU_0050985', 'NYU_0050986', 'NYU_0050987', 'NYU_0050988',
         'NYU_0050989', 'NYU_0050990', 'NYU_0050991', 'NYU_0050992', 'NYU_0050993', 'NYU_0050994', 'NYU_0050995', 'NYU_0050996',
         'NYU_0050997', 'NYU_0050998', 'NYU_0050999', 'NYU_0051000', 'NYU_0051001', 'NYU_0051002', 'NYU_0051003', 'NYU_0051006',
         'NYU_0051007', 'NYU_0051008', 'NYU_0051009', 'NYU_0051010', 'NYU_0051011', 'NYU_0051012', 'NYU_0051013', 'NYU_0051014',
         'NYU_0051015', 'NYU_0051016', 'NYU_0051017', 'NYU_0051018', 'NYU_0051019', 'NYU_0051020', 'NYU_0051021', 'NYU_0051023',
         'NYU_0051024', 'NYU_0051025', 'NYU_0051026', 'NYU_0051027', 'NYU_0051028', 'NYU_0051029', 'NYU_0051030', 'NYU_0051032',
         'NYU_0051033', 'NYU_0051034', 'NYU_0051035', 'NYU_0051036', 'NYU_0051038', 'NYU_0051039', 'NYU_0051040', 'NYU_0051041',
         'NYU_0051042', 'NYU_0051044', 'NYU_0051045', 'NYU_0051046', 'NYU_0051047', 'NYU_0051048', 'NYU_0051049', 'NYU_0051050',
         'NYU_0051051', 'NYU_0051052', 'NYU_0051053', 'NYU_0051054', 'NYU_0051055', 'NYU_0051056', 'NYU_0051057', 'NYU_0051058',
         'NYU_0051059', 'NYU_0051060', 'NYU_0051061', 'NYU_0051062', 'NYU_0051063', 'NYU_0051064', 'NYU_0051065', 'NYU_0051066', 
         'NYU_0051067', 'NYU_0051068', 'NYU_0051069', 'NYU_0051070', 'NYU_0051071', 'NYU_0051072', 'NYU_0051073', 'NYU_0051074', 
         'NYU_0051075', 'NYU_0051076', 'NYU_0051077', 'NYU_0051078', 'NYU_0051079', 'NYU_0051080', 'NYU_0051081', 'NYU_0051082',
         'NYU_0051083', 'NYU_0051084', 'NYU_0051085', 'NYU_0051086', 'NYU_0051087', 'NYU_0051088', 'NYU_0051089', 'NYU_0051090',
         'NYU_0051091', 'NYU_0051093', 'NYU_0051094', 'NYU_0051095', 'NYU_0051096', 'NYU_0051097', 'NYU_0051098', 'NYU_0051099',
         'NYU_0051100', 'NYU_0051101', 'NYU_0051102', 'NYU_0051103', 'NYU_0051104', 'NYU_0051105', 'NYU_0051106', 'NYU_0051107',
         'NYU_0051109', 'NYU_0051110', 'NYU_0051111', 'NYU_0051112', 'NYU_0051113', 'NYU_0051114', 'NYU_0051116', 'NYU_0051117',
         'NYU_0051118', 'NYU_0051121', 'NYU_0051122', 'NYU_0051123', 'NYU_0051124', 'NYU_0051126', 'NYU_0051127', 'NYU_0051128',
         'NYU_0051129', 'NYU_0051130', 'NYU_0051131', 'NYU_0051146', 'NYU_0051147', 'NYU_0051148', 'NYU_0051149', 'NYU_0051150',
         'NYU_0051151', 'NYU_0051152', 'NYU_0051153', 'NYU_0051154', 'NYU_0051155', 'NYU_0051156', 'NYU_0051159'] 

def correlation(pred_file,roi):
    real ='_'.join(pred_file.split('/')[-1].split('_')[2:4])
    #print real
    real = np.loadtxt(real_file)
    pred = np.loadtxt(pred_file)
    correlation = np.corrcoef(real,pred)
    print pred_file+','+real_file+',' +str(correlation[0][1])

def calc_corrs(roi):
    outlines = []
    for test_sub in subids:
        real_file='/abide_data/data/%s/%s_label_%s.1D'%(test_sub,test_sub,roi)
        print "working on %s %s"%(test_sub, real_file)
        try:
            real = np.loadtxt(real_file)
        except IOError:
            print "Error loading real tc file for %s %s, skipping ..."%(test_sub,roi)
            continue
        except Exception as e:
            print "Received %s"%(e)
            raise

        for train_sub in subids:
            if train_sub not in test_sub:
                pred_file='/abide_data/data/%s/preds/pred_%s/%s_%s_pred_%s.1D'%(train_sub,roi,train_sub,test_sub,roi)
                try:
                    pred = np.loadtxt(pred_file)
                except IOError as e:
                    print "Error loading pred tc file %s (%s) for %s %s %s, skipping ..."%(pred_file,e,train_sub,test_sub,roi)
                    continue
                except Exception as e:
                    print "Received %s"%(e)
                    raise
                r=np.corrcoef(real,pred)[0][1]
                outlines.append([train_sub,test_sub,roi,r])

        print "finished with %s"%(test_sub)


    with open("%s_stats.csv"%(roi),"w") as outfd:
         outcsv=csv.writer(outfd, delimiter=',')
         outcsv.writerow(["train","test","roi","pearsons correlation"])
         for line in outlines:
             outcsv.writerow(line)

if __name__=="__main__":
    print sys.argv
    if len(sys.argv) == 2:
        print "running %s with %s"%(sys.argv[0],sys.argv[1])
        calc_corrs(sys.argv[1])
    #else:
        #print "ran %s with too few arguments"%(sys.argv[0])
