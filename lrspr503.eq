/*  LRSPR503

    Direct Losses By Claim Number - New Claims Only

    Date Written :  December 22, 2003

    SCIPS.com */

description 
Direct Losses By Claim Number - New Claims Only ;
            
define string l_claim_no = str(lrsdetail:claim_no) + trun(sfsline_alias:claim_alpha)
          
Define String l_prog_number = "LRSPR503 Rev. 4.00"
                                  
Include "lrs20cal.inc"      

define wdate l_reported_since = l_starting_date 

where lrsdetail:trans_code < 30 and
      lrssetup:reported_date => l_reported_since 

list
/nobanner
/domain="lrsdetail"
/title="Direct Losses By Claim Number - New Claims Reported"
/pagewidth=170
/duplicates  
/nodetail 

Include "lrs20prt.inc"

sorted by lrsdetail:claim_no
          lrsdetail:cause_of_loss
                              
                   
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

Top of page  
"Report No.: LRSPR503"/left
username/right/newline                                                                                      
"Reported Date Period"/centre/newline 
trun(str(l_starting_date,"MM/DD/YYYY") + " - " + str(l_ending_date,"MM/DD/YYYY"))/centre/newline=2                                  

/*  END OF FILE */
