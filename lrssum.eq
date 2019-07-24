define unsigned ascii number l_adjustor[5]= lrsdetail:vendor_no 

include "lrs10cal.inc"

sum
/nobanner 
/nopageheadings 
         
l_loss_paid l_curr_adj_exp l_curr_resv l_curr_adj_resv units 

by

lrsdetail:vendor_no
