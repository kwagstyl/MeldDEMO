 

subs={'AlSt';'BeTr'}
Cortex=read_label(['fsaverage_sym'],['lh.cortex']);
 Cortex=Cortex(:,1)+1;  

for t=1:2;
    con = subs{t}
ML_C=MRIread(['',con,'/xhemi/surf/lh.sulc_on_lh.mgh']);
    ML_C.vol(Cortex)=ML_C.vol(Cortex)/10;
    
      MRIwrite(ML_C,['',con,'/xhemi/surf/lh.sulc_on_lh.mgh'])

    MR_C=MRIread(['',con,'/xhemi/surf/rh.sulc_on_lh.mgh']);
        MR_C.vol(Cortex)=MR_C.vol(Cortex)/10;
        
              MRIwrite(MR_C,['',con,'/xhemi/surf/rh.sulc_on_lh.mgh'])

end