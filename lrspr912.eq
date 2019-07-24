/*  lrspr912.eq

    SCIPS.com 

    September 28, 2001

    claim count of reported claim for a given year - closed w/

    sorted by A/S LOB, reported year/loss_date */

description Claims Closed Without Payment - Count ;

define unsigned ascii number l_year_1 = year(lrssetup:reported_date)
define unsigned ascii number l_year_2 = year(lrssetup:loss_date)

include "startend.inc"

define unsigned ascii number l_lob = switch(sfsline_alias:stmt_lob)
case 3,4                : 1
case 5                  : 2
case 17                 : 3
case 1,2,9,25,26        : 4
case 21                 : 5
default                 : 9

define string l_lob_str = switch(l_lob)
case 1                  : "Ho/Fo"
case 2                  : "CMP"
case 3                  : "Other Liab"
case 4                  : "Spec Prop" 
case 5                  : "Auto PD"
case 9                  : "Unknown"

--where lrssetup:status_2 = 0 and
--      lrssetup:reported_date => l_starting_date and  
--      lrssetup:reported_date <= l_ending_date 
where (year(lrsdetail:trans_date) = year(l_starting_date) and
      lrsdetail:trans_code = 13)

list
/nobanner
/domain="lrssetup"
/title="Claims Closed Without Payment  Count"
/nodetail

lrssetup:claim_no

sorted by l_year_1/count/noheading

top of l_year_1
""/newline
" Reported Date "
l_year_1/mask="9999"/noheading  

end of report
""/newline
count[lrssetup:claim_no]
