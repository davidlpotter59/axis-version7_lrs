/*  lrspr730.eq

    may 5, 2002

    SCIPS.com

    SCIPS output for summary claim activity by Month/year

date            Comments
=====          =================
05/07/2001     removed comments column per FOS request
*/

description Excel output of the Summary Claim Activity Report by Month / Year ;

include "startend.inc"

define signed ascii number l_loss_reserve = if lrsdetail:trans_code < 30 then
lrsdetail:loss_resv 
else
0.00

define signed ascii number l_ulae_reserve = if lrsdetail:trans_code < 30 and
lrsdetail:ulae = "Y" then
lrsdetail:lae_resv 
else
0.00

define signed ascii number l_alae_reserve = if lrsdetail:trans_code < 30 and
lrsdetail:alae = "Y" then
lrsdetail:lae_resv 
else
0.00

define signed ascii number l_loss_paid = if lrsdetail:trans_code < 30 then
lrsdetail:loss_paid 
else
0.00

define signed ascii number l_ulae_paid = if lrsdetail:trans_code < 30 and 
lrsdetail:ulae="Y" then
lrsdetail:lae_paid
else
0.00

define signed ascii number l_alae_paid = if lrsdetail:trans_code < 30 and 
lrsdetail:alae="Y" then
lrsdetail:lae_paid
else
0.00
           
define file alt_sfscause = access sfscause, set
sfscause:company_id= lrssetup:company_id ,
sfscause:line_of_business= lrssetup:line_of_business,
sfscause:lob_subline= lrssetup:lob_subline,
sfscause:cause_of_loss= lrssetup:cause_of_loss ,
sfscause:cause_loss_subline= lrssetup:cause_loss_subline , generic

where lrssetup:reported_date >= l_starting_date and
      lrssetup:reported_date <= l_ending_date 

list
/nobanner
/domain="lrssetup"
/title="Claims By Reported Date - Summary"
/nodetail 
/noreporttotals 
/pagewidth=255
/wks 

lrssetup:reported_date/mask="MM/DD/YYYY"/heading="Reported-Date"/column=1
lrssetup:claim_no /heading="Claim-Number"/column=15
l_loss_reserve/heading="Loss-Reserve"/total/column=30
l_ulae_reserve/heading="Unallocated-Reserves"/total/column=45
l_alae_reserve/heading="Allocated-Reserves"/total/column=60
l_loss_paid/heading="Paid-Loss"/total/column=75
l_ulae_paid/heading="Paid-Unallocated"/total/column=90
l_alae_paid/heading="Paid-Allocated"/total/column=105
lrssetup:adjustor_vendor/heading="Adjustor"/column=120
sfsvendor_adjust:name[1,1,15]/noheading /column=127
lrssetup:cause_of_loss /heading="Cause-of Loss"/column=155
sfscause2:description[1,15]/noheading/column=165
--lrssetup:comments/column=190 

sorted by lrssetup:reported_date/newlines=2
          lrssetup:claim_no 
                            
end of lrssetup:claim_no 

box/noheadings
lrssetup:reported_date/column=1/mask="MM/DD/YYYY"
lrssetup:claim_no /column=15
total[l_loss_reserve,lrssetup:claim_no]/column=30
total[l_ulae_reserve,lrssetup:claim_no]/column=45
total[l_alae_reserve,lrssetup:claim_no]/column=60
total[l_loss_paid,lrssetup:claim_no]/column=75
total[l_ulae_paid,lrssetup:claim_no]/column=90
total[l_alae_paid,lrssetup:claim_no]/column=105
lrssetup:adjustor_vendor/column=120
sfsvendor_adjust:name[1,1,15]/noheading/column=127
lrssetup:cause_of_loss/column=155 
sfscause2:description[1,15]/noheading/column=165
--lrssetup:comments/column=190             
end box

end of lrssetup:reported_date 
""/newline=2                  
"  Reported Date Total"/column=1
total[l_loss_reserve,lrssetup:reported_date]/column=30
total[l_ulae_reserve,lrssetup:reported_date]/column=45
total[l_alae_reserve,lrssetup:reported_date]/column=60
total[l_loss_paid,lrssetup:reported_date]/column=75
total[l_ulae_paid,lrssetup:reported_date]/column=90
total[l_alae_paid,lrssetup:reported_date]/column=105

end of report 
""/newline=3
"  Report Totals "/column=10
total[l_loss_reserve]/column=30
total[l_ulae_reserve]/column=45
total[l_alae_reserve]/column=60
total[l_loss_paid]/column=75
total[l_ulae_paid]/column=90
total[l_alae_paid]/column=105
