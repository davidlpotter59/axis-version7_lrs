/*  lrspr990.eq

    October 19, 2002

    SCIPS.com, Inc.

    Program to list all claims in the lrssummary file and if there
    are any problems print a warning message 
*/

description 
Program to list all claims in the lrssummary file and if there are any problems print a warning message ;

define signed ascii number l_total_resv[9]=if
lrsdetail:trans_code < 30 then lrsdetail:loss_resv
else 0.00

define signed ascii number l_total_paid[9]=if
lrsdetail:trans_code < 30 then lrsdetail:loss_paid 
else 0.00

define signed ascii number l_total_ulae_resv[9]=if
lrsdetail:trans_code < 30 and lrsdetail:ulae = "Y" 
then lrsdetail:lae_resv
else 0.00

define signed ascii number l_total_ulae_paid[9]=if
lrsdetail:trans_code < 30 and lrsdetail:ulae = "Y"
then lrsdetail:lae_paid
else 0.00

define signed ascii number l_total_alae_resv[9]=if
lrsdetail:trans_code < 30 and lrsdetail:alae = "Y" 
then lrsdetail:lae_resv
else 0.00

define signed ascii number l_total_alae_paid[9]=if
lrsdetail:trans_code < 30 and lrsdetail:alae = "Y"
then lrsdetail:lae_paid
else 0.00
 
where lrsdetail:trans_code < 30

list
/nobanner
/domain="lrssummary"
/title="LRSSUMMARY Audit Report "

lrssummary:claim_no/column=1
lrssummary:claimant[1,10]/column=15
lrssetup:loss_date/column=30
lrssummary:trans_date/column=40
lrssummary:loss_resv/column=55/mask="ZZZ,ZZZ.99-"
lrssummary:loss_paid/column=70/mask="ZZZ,ZZZ.99-"
lrssummary:ulae_resv/column=85/mask="ZZZ,ZZZ.99-"
lrssummary:ulae_paid/column=100/mask="ZZZ,ZZZ.99-"
lrssummary:alae_resv/column=115/mask="ZZZ,ZZZ.99-"
lrssummary:alae_paid/column=130/mask="ZZZ,ZZZ.99-"
                                           
followed by 
"Actual Claim Balance ===> "/column=20
total[l_total_resv,lrssummary:claim_no]/column=55/mask="ZZZ,ZZZ.99-"
total[l_total_paid,lrssummary:claim_no]/column=70/mask="ZZZ,ZZZ.99-"
total[l_total_ulae_resv,lrssummary:claim_no]/column=85/mask="ZZZ,ZZZ.99-"
total[l_total_ulae_paid,lrssummary:claim_no]/column=100/mask="ZZZ,ZZZ.99-"
total[l_total_alae_resv,lrssummary:claim_no]/column=115/mask="ZZZ,ZZZ.99-"
total[l_total_alae_paid,lrssummary:claim_no]/column=130/mask="ZZZ,ZZZ.99-"

if total[l_total_resv, lrssummary:claim_no] <> lrssummary:loss_resv or
   total[l_total_paid, lrssummary:claim_no] <> lrssummary:loss_paid or
   total[l_total_ulae_resv, lrssummary:claim_no] <>  lrssummary:ulae_resv or
   total[l_total_alae_resv, lrssummary:claim_no] <>  lrssummary:alae_resv or
   total[l_total_ulae_paid, lrssummary:claim_no] <>  lrssummary:ulae_paid or
   total[l_total_alae_paid, lrssummary:claim_no] <>  lrssummary:alae_paid then 
   {
   ""/newline=2
   "Claim is out of BALANCE  -  Fix immediately   "/column=50
   }

sorted by lrssummary:claim_no/total/newline
