
# coding: utf-8

# In[146]:

import re, os, subprocess, copy
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt


# ###Load log file and remove the burnin

# In[147]:

dat_log = pd.read_csv('p1.log', sep = '\t', comment = '#', header = 2)
dat_log = dat_log.ix[int(round(shape(dat_log)[0] * 0.1, 0)):shape(dat_log)[0], :]


# ###Plot the histograms and print hpds for priors. 
# The data in blue are those that were constrained in the xml file. Those in red had uniform priors and were producing -Inf posterior. So I used a unform prior with boudnds 0 to 1000 Mya. Please check these. With the calibrations defined before the prior did not run.

# In[197]:

unbounded_priors = ['tmrcs(AleocharaTriboliumMeloeDendroctonus)', 'tmrca(ColeopteraStrepsiptera)', 'tmrca(Dicondylia)', 'tmrca(Diplura)', 'tmrca(Ellipura)', 'tmrca(HemipteraSternorrhyncha except Aleyrodidae)', 'tmrca(Megaloptera)', 'tmrca(MegalopteraNeuroptera)', 'tmrca(Neuroptera)']
for i in times:
    print i
    hpd = [np.percentile(dat_log[i], b) for b in [0.025, 0.975]]
    print 'The prior HPD for %s is %s' %(i, hpd) 
    if i in unbounded_priors:
        print 'This prior was set as a uniform. I set it with uninformative bounds between 0 and 1000 Mya. Please check'
        col_plot = 'red'
    else:
        col_plot = 'blue'
    dat_log[i].plot(color = col_plot)
    plt.show()
    dat_log[i].hist(color = col_plot)
    plt.show()

        
        


# In[176]:




# 

# In[183]:




# 

# 

# In[183]:




# 

# In[183]:




# 

# In[184]:




# 

# In[184]:




# 

# In[184]:




# 

# In[184]:




# In[183]:




# In[183]:




# In[159]:




# In[157]:




# In[144]:




# In[144]:




# In[ ]:



