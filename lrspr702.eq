/*  lrspr702.eq

    May 4, 2002

    SCIPS.com

    losses by Adjuster */

description Print Losses by Adjuster ;

include "startend.inc"

define unsigned ascii number l_ctr = 1

define unsigned ascii number l_open_ctr = if lrssetup:status = "O" then
1
else
0

define unsigned ascii number l_closed_ctr = if lrssetup:status = "C" then
1
else
0

define unsigned ascii number l_reopen_ctr = if lrssetup:status = "R" then
1
else
0

define unsigned ascii number l_claim_count = if lrssetup:status = "O" or
                                                lrssetup:status = "R" or
                                                lrssetup:status = "C"  then
l_open_ctr + l_closed_ctr + l_reopen_ctr  


where lrsdetail:trans_date >= l_starting_date and
      lrsdetail:trans_date <= l_ending_date and
      lrssetup:adjustor_vendor <> 0 and
      lrsdetail:trans_code < 30
list
/nobanner           
/title="Claims By Adjuster (Outside)"
/domain="lrssetup" 
/nodetail
/pagewidth=150
/noreporttotals 

lrssetup:adjustor_vendor/column=1/heading="Vendor-NO"
sfsvendor_adjust:name /heading="Adjuster-Name" /column=8/width=30
-- version 7 does not like units
--count[lrssetup:units]/heading="Number-of Claims"/column=40/mask="ZZ,ZZZ"
l_claim_count/heading="Number-of Claims"/column=40/mask="zz,zzz"
l_open_ctr/heading="Open-Claims"/column=50/mask="ZZ,ZZZ"
l_closed_ctr/heading="Closed-Claims"/column=60/mask="ZZ,ZZZ"
l_reopen_ctr/heading="Reopened-Claims"/column=70/mask="ZZ,ZZZ"
lrsdetail:loss_paid/column=80/mask="$ZZ,ZZZ,ZZZ.99-"/heading="Losses-Paid"
lrsdetail:loss_resv/column=95/mask="$ZZ,ZZZ,ZZZ.99-"/heading="Loss-Reserves"
lrsdetail:lae_paid/column=110/mask="$ZZ,ZZZ,ZZZ.99-"/heading="LAE-Paid"

Sorted by lrssetup:adjustor_vendor/newlines=2

top of report
"Report No: LRSPR702 - Version 7.0"/column= 1/newline
"Report Period "
l_starting_date/noheading/mask="MM/DD/YYYY" 
" to "
l_ending_date/noheading/mask="MM/DD/YYYY"/newline 

end of lrssetup:adjustor_vendor 
box/noheadings 
    lrssetup:adjustor_vendor/column=1
    sfsvendor_adjust:name/column=8/width=30/mask="XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" 
--    total[l_ctr,lrssetup:adjustor_vendor]/column=40/mask="ZZ,ZZ9" 
    total[l_claim_count]/column= 40/mask="zz,zz9"
    total[l_open_ctr,lrssetup:adjustor_vendor]/column=50/mask="ZZ,ZZ9"
    total[l_closed_ctr,lrssetup:adjustor_vendor]/column=60/mask="ZZ,ZZ9"
    total[l_reopen_ctr,lrssetup:adjustor_vendor]/column=70/mask="ZZ,ZZ9" 
    total[lrsdetail:loss_paid,lrssetup:adjustor_vendor]/mask="$ZZ,ZZZ,ZZZ.99-"/column=80

    total[lrsdetail:loss_resv,lrssetup:adjustor_vendor]/mask="$ZZ,ZZZ,ZZZ.99-"/column=95
    total[lrsdetail:lae_paid,lrssetup:adjustor_vendor]/mask="$ZZ,ZZZ,ZZZ.99-"/column=110
end box 

end of report 
""/newline     
" Report Total"/column=25
--count[l_ctr]/column=40/mask="ZZ,ZZ9"
count[l_claim_count ]/column= 40/mask ="zz,zz9"
total[l_open_ctr]/column=50/mask="ZZ,ZZ9"
total[l_closed_ctr]/column=60/mask="ZZ,ZZ9"
total[l_reopen_ctr]/column=70/mask="ZZ,ZZ9"
total[lrsdetail:loss_paid]/mask="$ZZ,ZZZ,ZZZ.99-"/column=80
total[lrsdetail:loss_resv]/mask="$ZZ,ZZZ,ZZZ.99-"/column=95
total[lrsdetail:lae_paid]/mask="$ZZ,ZZZ,ZZZ.99-"/column=110
