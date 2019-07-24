

/*  lrspr701.eq

    May 4, 2002

    SCIPS.com

    losses by Examiner */

description 
Direct Incurred Losses by Examinor ;

include "startend.inc"

define string l_prog_number = "LRSPR701 - Version 7.0"

define unsigned ascii number l_ctr = 0

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
                                                lrssetup:status = "C" or
                                                lrssetup:status = "R" then
l_open_ctr + l_closed_ctr + l_reopen_ctr
 
where lrsdetail:trans_date >= l_starting_date and
      lrsdetail:trans_date <= l_ending_date and
      lrssetup:examiner_no <> 0 and
      lrsdetail:trans_code < 30
list
/nobanner           
/title="Direct Incurred Losses by Examiner"
/domain="lrssetup" 
/nodetail
/pagewidth=115
/noreporttotals 

lrssetup:examiner_no/heading="Vendor-No"/column=1
sfsvendor:examinor_name /heading=" Adjuster-Name" /column=8/width=30
-- units was not working in version 7
--count[lrssetup:units]/heading="Number-of Claims"/column=40/mask="ZZ,ZZZ"
count[l_claim_count ]/heading ="Number-of Claims"/column=40/mask="zz,zzz"
l_open_ctr/heading="Open-Claims"/column=50/mask="ZZ,ZZZ"
l_closed_ctr/heading="Closed-Claims"/column=60/mask="ZZ,ZZZ"
l_reopen_ctr/heading="Reopened-Claims"/column=70/mask="ZZ,ZZZ"
lrsdetail:loss_paid/column=80/mask="$ZZ,ZZZ,ZZZ.99-"
lrsdetail:loss_resv/column=95/mask="$ZZ,ZZZ,ZZZ.99-"

Sorted by lrssetup:examiner_no /newlines=2

end of lrssetup:examiner_no 
box/noheadings 
    lrssetup:examiner_no/column=1
    sfsvendor:examinor_name/column=7/width=30/mask="XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX" 
--    total[l_ctr,lrssetup:examiner_no]/column=40/mask="ZZ,ZZ9" 
    total[l_claim_count ]/column=40/mask="zz,zz9"
    total[l_open_ctr,lrssetup:examiner_no]/column=50/mask="ZZ,ZZ9"
    total[l_closed_ctr,lrssetup:examiner_no]/column=60/mask="ZZ,ZZ9"
    total[l_reopen_ctr,lrssetup:examiner_no]/column=70/mask="ZZ,ZZ9" 
    total[lrsdetail:loss_paid,lrssetup:examiner_no]/mask="$ZZ,ZZZ,ZZZ.99-"/column=80
    total[lrsdetail:loss_resv,lrssetup:examiner_no]/mask="$ZZ,ZZZ,ZZZ.99-"/column=95
end box 

end of report 
""/newline 
" Report Total"/column=25
count[l_claim_count ]/column=40/mask="ZZ,ZZ9"
total[l_open_ctr]/column=50/mask="ZZ,ZZ9"
total[l_closed_ctr]/column=60/mask="ZZ,ZZ9"
total[l_reopen_ctr]/column=70/mask="ZZ,ZZ9"
total[lrsdetail:loss_paid]/mask="$ZZ,ZZZ,ZZZ.99-"/column=80
total[lrsdetail:loss_resv]/mask="$ZZ,ZZZ,ZZZ.99-"/column=95

include "reporttop.inc"
