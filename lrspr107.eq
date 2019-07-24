/*  lrspr107.eq

    SCIPS.com

    April 24, 1995

    program to dump the last 5 years of lae paid by adjustor 
    
    unlike most of the year to year comparisons this on will only
    compare prior years current period only */

description 
LAE Period Comparison by Vendor ;

define string l_prog_number = "lrspr107"  

define date l_starting_date = parameter/prompt="Enter Starting Date: "

define date l_ending_date   = parameter/prompt="Enter Ending Date: "

define date l_start_1 = dateadd(l_starting_date,0,-4)
define date l_end_1   = dateadd(l_ending_date,0,-4) 
define date l_start_2 = dateadd(l_starting_date,0,-3)
define date l_end_2   = dateadd(l_ending_date,0,-3) 
define date l_start_3 = dateadd(l_starting_date,0,-2)
define date l_end_3   = dateadd(l_ending_date,0,-2) 
define date l_start_4 = dateadd(l_starting_date,0,-1)
define date l_end_4   = dateadd(l_ending_date,0,-1) 

signed ascii number l_lae_paid_1 = if lrsdetail:trans_date => l_start_1 and
                  lrsdetail:trans_date <= l_end_1 then
                  lrsdetail:lae_paid/dec=2

signed ascii number l_lae_paid_2 = if lrsdetail:trans_date => l_start_2 and
                  lrsdetail:trans_date <= l_end_2 then
                  lrsdetail:lae_paid/dec=2

signed ascii number l_lae_paid_3 = if lrsdetail:trans_date => l_start_3 and
                  lrsdetail:trans_date <= l_end_3 then
                  lrsdetail:lae_paid/dec=2

signed ascii number l_lae_paid_4 = if lrsdetail:trans_date => l_start_4 and
                  lrsdetail:trans_date <= l_end_4 then
                  lrsdetail:lae_paid/dec=2

signed ascii number l_lae_paid = if lrsdetail:trans_date => l_starting_date and
                  lrsdetail:trans_date <= l_ending_date then
                  lrsdetail:lae_paid/dec=2

where lrsdetail:trans_date => l_start_1 and
      lrsdetail:trans_date <= l_ending_date and
      lrsdetail:trans_code < 30 and
      lrsdetail:lae_paid <> 0

list
/nobanner
/nodetail
/domain="lrsdetail"
/title="LAE Period Comparison by Vendor"

lrsdetail:vendor_no/mask="99999"/heading="Vendor-Number"
sfsvendor:name[1]/mask="XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"/heading="Name"
l_lae_paid_1/mask="Z,ZZZ,ZZZ.99-"/noheading
l_lae_paid_2/mask="Z,ZZZ,ZZZ.99-"/noheading
l_lae_paid_3/mask="Z,ZZZ,ZZZ.99-"/noheading
l_lae_paid_4/mask="Z,ZZZ,ZZZ.99-"/noheading
l_lae_paid/mask="Z,ZZZ,ZZZ.99-"/noheading

sorted by lrsdetail:vendor_no

end of lrsdetail:vendor_no  
lrsdetail:vendor_no/mask="99999"/noheading
sfsvendor:name[1]/mask="XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"/noheading
total[l_lae_paid_1,lrsdetail:vendor_no]/mask="Z,ZZZ,ZZZ.99-"/noheading
total[l_lae_paid_2,lrsdetail:vendor_no]/mask="Z,ZZZ,ZZZ.99-"/noheading
total[l_lae_paid_3,lrsdetail:vendor_no]/mask="Z,ZZZ,ZZZ.99-"/noheading
total[l_lae_paid_4,lrsdetail:vendor_no]/mask="Z,ZZZ,ZZZ.99-"/noheading
total[l_lae_paid,lrsdetail:vendor_no]/mask="Z,ZZZ,ZZZ.99-"/noheading

top of page
trun(sfscompany:name[1])/center/newline 
"Program No.: LRSPR107"/left/newline 
"Report Period"/center/newline 
trun(str(l_starting_date,"MM/DD/YYYY") + " - " + str(l_ending_date,"MM/DD/YYYY"))/center
trun(str(l_start_1,"YYYY"))/column=45
trun(str(l_start_2,"YYYY"))/column=58
trun(str(l_start_3,"YYYY"))/column=72
trun(str(l_start_4,"YYYY"))/column=86
"Current Year "/column=95/newline
" LAE PAID "/column=42
" LAE PAID "/column=55
" LAE PAID "/column=69
" LAE PAID "/column=83
" LAE PAID "/column=95/newline
