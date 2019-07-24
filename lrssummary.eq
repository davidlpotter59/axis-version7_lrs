define file asfsline = access sfsline, 
set sfsline:company_id=lrssummary:company_id,
    sfsline:line_of_business= lrssummary:line_of_business,
    sfsline:lob_subline=lrssummary:lob_subline, approximate 
 
where lrssummary:claim_no = 662002
list
/nobanner
/domain="lrssummary"
/pagewidth=255                                                              

--lrssummary:company_id 
lrssummary:claim_no 
--lrssummary:cause_of_loss 
--lrssummary:line_of_business 
--lob_subline 
--asfsline:lob_code   
lrssummary:loss_resv
lrssummary:loss_paid
