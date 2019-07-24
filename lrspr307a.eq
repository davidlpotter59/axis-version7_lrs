define unsigned ascii number l_vendor_no[5] = lrscheck:vendor_no[1]

define file sfsvendor_alt = access sfsvendor, set
sfsvendor:company_id = lrsdetail_ff:company_id,
sfsvendor:vendor_no = l_vendor_no, generic

Where sfsvendor_alt:ten99 = "Y" or
lrscheck:ten99 = 1 
list/domain="lrsdetail_ff"/nobanner/duplicates
lrsdetail_ff:claim_no
lrsdetail_ff:lae_paid
Lrscheck:vendor_no[1]
lrsdetail_ff:trans_date
sfsvendor_alt:ident_no/duplicates

sorted by l_vendor_no

End of l_vendor_no
""/newline	
total[lrsdetail_ff:lae_paid]/align=lrsdetail_ff:lae_paid/newline
;
