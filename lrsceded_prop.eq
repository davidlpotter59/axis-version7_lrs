define signed ascii number l_ceded_percent[5] = 1.0000 - 
lrsceded_old:direct_liab_percent/decimalplaces=4

define signed ascii number l_ceded_liab = lrsceded_old:total_amount_ceded - 
lrsceded_old:direct_liab

define signed ascii number l_ceded_lae = round(lrsceded_old:total_lae * 
l_ceded_percent)

--where lrsceded_old:claim_NO = 612002
list
/nobanner
/domain="lrsceded_old"   
/noduplicates 
/pagewidth=79
/nopageheadings 
/title="Farmers of Salem lrsceded_old Conversion"

--lrsceded_old:company_id 
lrsceded_old:claim_no   
direct   
direct_percent direct_lae loss_resv loss_paid
property_surplus
lrsceded_old:property_xol 

sorted by claim_no --cause_of_loss/newline 

end of page
"OLD File"
