define signed ascii number l_ceded_percent[5] = 1.0000 - 
lrsceded:direct_liab_percent/decimalplaces=4

define signed ascii number l_ceded_liab = lrsceded:total_amount_ceded - 
lrsceded:direct_liab

define signed ascii number l_ceded_lae = round(lrsceded:total_lae * 
l_ceded_percent)

where lrsceded:claim_NO = 602002
list
/nobanner
/domain="lrsceded"   
/noduplicates 
/pagewidth=200

lrsceded:company_id 
lrsceded:claim_no  
direct_liab/heading="Total-Direct-Incurred"
direct_liab_percent/heading="Direct-Percent"/nototal 
direct_liab_lae/heading="Direct-LAE"
total_amount_ceded/heading="Incurred-Amount" 
l_ceded_percent/heading="Ceded-Percentage"/nototal 
l_ceded_liab/heading="Ceded-Liability"
l_ceded_lae/heading="Ceded-LAE"              
lrsceded:liab[1]/heading="Liability-Premium"/column=120
lrsceded:liab_percent[1]/heading="Liability-Percentages"/newline/column=130
lrsceded:liab[2]/noheading /column=120
lrsceded:liab_percent[2]/noheading/newline/column=130
lrsceded:liab[3]/noheading/column=120
lrsceded:liab_percent[3]/noheading/newline/column=130
lrsceded:liab[4]/noheading/column=120
lrsceded:liab_percent[4]/noheading/newline/column=130

sorted by cause_of_loss/newline
