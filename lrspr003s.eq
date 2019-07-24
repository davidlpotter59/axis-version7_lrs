/* LRSPR003S.EQ

   SCIPS.com

   May 11, 2001

   loss daily register - Summary Only  */

description Totals by Transaction Register - Summary Only ;

DEFINE L_TRANS = SWITCH(LRSDETAIL:TRANS_TYPE)
                   CASE 1  : 1
                   DEFAULT : 5

DEFINE STRING L_PROG_NUMBER = "LRSPR001NEW - Rev. 2.00"

define string l_claim_no = str(lrsdetail:claim_no) + sfsline_alias:claim_alpha 
             
include "startend.inc"

WHERE LRSDETAIL:TRANS_DATE => L_STARTING_DATE AND
      LRSDETAIL:TRANS_DATE <= L_ENDING_DATE and
      lrsdetail:trans_code < 30 and
      lrsdetail:preload not one of 1 

LIST
/DOMAIN="LRSDETAIL"
/NOBANNER
/PAGEWIDTH=250
/DUPLICATES
/title = "LOSS TRANSACTION REGISTER - SUMMARY ONLY"
/nopageheadings    
/nodetail

LRSDETAIL:TRANS_DATE
LRSDETAIL:LOSS_RESV
LRSDETAIL:LOSS_PAID
LRSDETAIL:LAE_RESV
LRSDETAIL:LAE_PAID
lrsdetail:loss_resv + loss_paid + lae_resv + lae_paid/heading="Total"

SORTED BY LRSDETAIL:TRANS_DATE/newlines=2
       
end of lrsdetail:trans_date     
lrsdetail:trans_date/noheading
total[LRSDETAIL:LOSS_RESV]/noheading
total[LRSDETAIL:LOSS_PAID]/noheading
total[LRSDETAIL:LAE_RESV]/noheading
total[LRSDETAIL:LAE_PAID]/noheading
total[lrsdetail:loss_resv] + total[lrsdetail:loss_paid] + 
total[lrsdetail:lae_resv] + total[lrsdetail:lae_paid]/noheading
