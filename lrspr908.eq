/*  lrspr908.eq

    white hall mutual insurance company 

    april 11, 1995

    claim count of reported claim for a given year

    sorted by A/S LOB, reported year/loss_date */

description Claims Reported Count ;

    define unsigned ascii number l_year_1 = year(lrssetup:reported_date)
    define unsigned ascii number l_year_2 = year(lrssetup:loss_date)

    define date l_starting_date = parameter/prompt="Enter As Of Date: "

define unsigned ascii number l_lob = switch(sfsline_alias:stmt_lob)
case 3,4                : 1
case 5                  : 2
case 17                 : 3
case 1,2,9,25,26        : 4
case 21                 : 5

define string l_lob_str = switch(l_lob)
case 1                  : "Ho/Fo"
case 2                  : "CMP"
case 3                  : "Other Liab"
case 4                  : "Spec Prop" 
case 5                  : "Auto PD"
default                 : ""

    where year(lrssetup:reported_date) = year(l_starting_date)

    list
    /nobanner
    /domain="lrssetup"
    /title="Claims Reported Count"
    /nodetail

    lrssetup:claim_no

    sorted by l_year_1/noheading/count
              l_lob/noheading/count
              l_year_2/noheading/count

top of l_year_1
""/newline
" Reported Date "
l_year_1/mask="9999"/noheading  

top of l_year_2
"    Loss Date "
l_year_2/mask="9999"/noheading  

top of l_lob
"      "
l_lob_str/newline/noheading

;
