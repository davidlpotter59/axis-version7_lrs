include "startend.inc"

where lrssetup:reported_date  >= l_starting_date and
      lrssetup:reported_date  <= l_ending_date 

sum
/nobanner
/domain="lrssetup"

lrssetup:units

across units                     
       
by
sfsvendor:name[1]/newlines/total 
lrssetup:reported_date/year/month
