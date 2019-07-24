/*  LRSPR657

    Net Direct Losses By Claim Number - Summary by Adjustor and Adjustor type

    Date Written :  December 22, 2003

    SCIPS.com */

description 
Net Direct Incurred Losses By Claim Number - Summary by Adjustor and Adjustor Type - Vendor type MUST be greater than 0 in SFSVENDOR! ;
            
define string l_claim_no = str(lrsdetail:claim_no) + trun(sfsline_alias:claim_alpha)
          
Define String l_prog_number = "LRSPR657 Rev. 4.10"
                                  
Include "lrs10cal.inc"      

define wdate l_reported_since = l_starting_date 

define file sfsvendora = access sfsvendor, set sfsvendor:company_id= lrsdetail:company_id,
                                               sfsvendor:vendor_no = lrsdetail:vendor_no, many to one, exact 

where lrssetup:reported_date => l_reported_since and
      lrsdetail:vendor_no <> 0 and
      sfsvendora:vendor_type > 0

list
/nobanner
/domain="lrsdetail"
/title="Net Direct Losses By Claim Number - Summary by Adjustor and Adjustor Type"
/pagewidth=170
/duplicates 
/nodetail 

Include "lrs20prt.inc"

sorted by sfsvendora:vendor_type /newpage 
          lrsdetail:vendor_no/newlines  
          lrsdetail:claim_no
          lrsdetail:cause_of_loss
                              

top of lrsdetail:vendor_no 
lrsdetail:vendor_no /noheading/column=1
sfsvendor:name[1]/column=10/noheading /newline 

end of sfsvendora:vendor_type  
""/newline 
"Vendor Type Total"/column=20
total[l_loss_paid]     /noheading/column=100
total[l_curr_adj_exp]  /noheading/column=115
total[l_curr_resv]     /noheading/column=130
total[l_curr_adj_resv] /noheading/column=145
                   
end of lrsdetail:vendor_no  
""/newline 
"Vendor Total"/column=20
total[l_loss_paid]     /noheading/column=100
total[l_curr_adj_exp]  /noheading/column=115
total[l_curr_resv]     /noheading/column=130
total[l_curr_adj_resv] /noheading/column=145

end of lrsdetail:claim_no 
l_claim_no/noheading/column=1
lrssetup:policy_no/noheading/column=15
str(lrsdetail:cause_of_loss) + " " + lrsdetail:cause_loss_subline/noheading/column=30
lrssetup:loss_date/noheading/column=40
str(lrsdetail:line_of_business) + " " + lrsdetail:lob_subline/noheading /column=55
lrssetup:reported_date/noheading/column=70
lrsdetail:trans_code/noheading/column=85
total[l_loss_paid]     /noheading/column=100
total[l_curr_adj_exp]  /noheading/column=115
total[l_curr_resv]     /noheading/column=130
total[l_curr_adj_resv] /noheading/column=145

include "reporttop.inc"
""/newline   
Trun("Vendor Type: " +  str(sfsvendora:vendor_type,"ZZZZ"))/noheading/center/newline
