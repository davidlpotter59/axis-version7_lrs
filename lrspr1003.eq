/* lrspr1003.eq

   scips.com

   May 4, 2012

   list claims that are open with reserves
*/

description list claims that are open with no reserves ;

where (lrssetup:status_2 = 0 or
(lrssetup:status_2 <> 0 and
lrssetup:status not one of "C"))
list
/domain="lrssummary"
/title = "Claim Status Open With Reserves"
/nobanner
/nodetail

lrssummary:claim_no/column=1
loss_resv/column=20
ulae_resv/column=30
alae_resv/column=40

sorted by claim_no

end of claim_no
if total[lrssummary:loss_resv] <> 0 or
   total[lrssummary:alae_resv] <> 0 or
   total[lrssummary:ulae_resv] <> 0 then
    {
    lrssummary:claim_no/noheading/column=1
    loss_resv/noheading/column=20
    ulae_resv/noheading/column=30
    alae_resv/noheading/column=40
    }

;
