/* lrspr1002.eq

   scips.com

   September 15, 2005

   list claims that are open with no reserves
*/
            
description list claims that summary shows closed but setup shows open ;

where ((lrssetup:status_2 = 0 and
      lrssummary:status one of "C") or 
      (lrssetup:status = "O" and
      lrssummary:status one of "C"))
list
/domain="lrssummary"
/title = "Summary shows closed setup shows open"
/nobanner
/nodetail

lrssummary:claim_no/column=1           
lrssummary:status/column=20/heading="Summary-Status"
lrssetup:status_2/column=30/heading="Setup-Status 2"
lrssetup:status/column=40/heading="Setup-Status"

sorted by claim_no

end of claim_no
lrssummary:claim_no/noheading/column=1           
lrssummary:status/column=20/noheading
lrssetup:status_2/column=30/noheading
lrssetup:status/column=40/noheading

;
