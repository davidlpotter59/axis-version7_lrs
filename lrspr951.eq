/* lrspr951.eq 

   scips.com

   October 18, 2001

   Paid to Paid Loss Ratio on Closed Claims
*/

description Paid to Paid Loss Ratio on Closed Claims;

where lrsdetail:trans_code = 12
sum
/domain="lrsdetail"
/nobanner
/title="Paid to Paid Loss Ratio on Closed Claims"

lrsdetail:loss_paid 
lrsdetail:lae_paid

across lrsdetail:trans_date/year

by lrssetup:reported_date/year
;
