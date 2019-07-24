/*  LRSPR650a

    Losses by Claim Number - Direct
    reporting claims reserve balances < $0.00 on
    closed claims

    Date Written : November 7, 1992

    SCIPS.com, Inc. */

description 
Direct Incurred Losses by Claim Number - Detail - Showing only claims with Reserves not equal to $0.00 and status of closed and if Open is selected showing only total that is < $0.00;
             
define string l_claim_no = str(lrsdetail:claim_no) + trun(sfsline_alias:claim_alpha
)

Define String l_prog_number = "LRSPR650 - Rev 4.20"

Include "lrs63cal.inc"

include "lrscollect.inc"
and   lrsdetail:trans_date <= l_ending_date and
      lrsdetail:trans_code < 30

list
/nobanner
/domain="lrsdetail"
/title="Direct Incurred Losses By Claim Number - Detail - Reserves "
/pagewidth=250
/duplicates
/nodetail  
/noreporttotals 
/pagelength=0

Include "lrs63prt.inc"

sorted by lrsdetail:claim_no


end of lrsdetail:claim_no
box/noblanklines 
if total[lrsdetail:loss_resv] < 0.00 then
{
""/newline
"  "
lrsdetail:claim_no /noheading/column=1 
l_status/noheading/column=12
lrssetup:status_date/noheading/column=25
lrssetup:name[1,1,50]/noheading/column=40
total[l_loss_paid,lrsdetail:claim_no]/noheading/align=l_loss_paid/column=100
total[l_curr_adj_exp,lrsdetail:claim_no]/noheading/align=l_curr_adj_exp/column=115
total[l_curr_resv,lrsdetail:claim_no]/noheading/align=l_curr_resv/column=130
total[l_curr_adj_resv,lrsdetail:claim_no]/noheading/align=l_curr_adj_resv/column=145
total[l_prior_resv,lrsdetail:claim_no]/noheading/align=l_prior_resv/column=160
total[l_prior_adj_resv,lrsdetail:claim_no]/noheading/align=l_prior_adj_resv/column=175
total[l_incurred,lrsdetail:claim_no]/align=l_incurred/column=190
total[l_incurred_lae,lrsdetail:claim_no]/align=l_incurred_lae/noheading/column=205
total[l_incurred_total,lrsdetail:claim_no]/align=l_incurred_total/noheading/column=220
""/newline
}
end box

include "reporttop.inc"
