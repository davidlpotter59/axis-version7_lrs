/* lrspr1000.eq

   scips.com

   September 15, 2005

   list claims that are closed with reserves
*/
            
description list claims that are closed with reserves ;

where (lrssetup:status_2 one of 1, 2 and
(lrssummary:loss_resv <> 0 or
lrssummary:alae_resv <> 0 or
lrssummary:ulae_resv <> 0))
list
/domain="lrssummary"                        
/title="Claims closed with reserves"
/nobanner

claim_no           
loss_resv
ulae_resv
alae_resv                    
switch(lrssetup:status_2)
  case 1 : "Closed With Payments"
  case 2 : "Closed Without Payments"

sorted by claim_no
;
