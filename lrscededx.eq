/*  lrsceded

    SCIPS.com

    march 26, 2002

    Reinsurance Worksheet for claims
*/

description Ceded Reinsurance Worksheet Including Recoveries - Spreadsheet Output Version;

define unsigned ascii number l_claim_no[11]=parameter/prompt=
"Enter Claim Number<NL>"

define signed ascii number l_ceded_percent[5] = 1.0000 - 
lrsceded:direct_liab_percent/decimalplaces=4

define signed ascii number l_total_lae = lrsceded:ulae_resv + lrsceded:alae_resv 

define signed ascii number l_ceded_liab = lrsceded:total_amount_ceded - 
lrsceded:direct_liab

define signed ascii number l_ceded_lae = round(lrsceded:total_lae * 
l_ceded_percent)

define signed ascii number l_direct_liab_lae_recovery = lrsceded:liab_lae *
lrsceded:direct_liab_percent/decimalplaces=2

where lrsceded:claim_NO = l_claim_no 
list
/nobanner
/domain="lrsceded"   
/noduplicates 
/pagewidth=132 
/pagelength=0
/noheadings
/noreporttotals
/wks  

"Company ID:      "
lrsceded:company_id 
"Claim Number:    "/column=50
lrsceded:claim_no   
"Policy Number:   "/column=80
lrsceded:policy_no/column=100
sfpname:name[1] /newline 
"Cause of Loss:   "
sfscause:description
"Reported Date:   "/column=80
lrssetup:reported_date/column=100/newline
"Incurred Date:   "/column=80
lrssetup:loss_date/column=100/newline=2
"Total Case:      "
lrsceded:total_case          
"Total LAE:       "/column=80
lrsceded:total_lae/column=101 /newline  
"Total Loss  Paid "
lrsceded:loss_paid
"Total LAE Paid   "/column=80
lrsceded:ulae_paid + lrsceded:alae_paid/column=98 /newline 
"Balance:       "
lrsceded:total_case - lrsceded:loss_paid
"Balance    :"/column=80
lrsceded:total_lae-(lrsceded:ulae_paid + lrsceded:alae_paid)/column=98/newline=2

if sfscause:line_type = "P" then
{
"P R O P E R T Y"/column=60/newline=2
"Surplus Percent  "    
lrsceded:surplus_percent/column=35 
"Surplus Incurred "/column=80
lrsceded:property_surplus/column=100/newline
"Amount Subject   "
lrsceded:amount_subject/column=30
"Excess of Loss   "/column=80
lrsceded:property_xol/column=100/newline
"NET Loss          "/column=80
lrsceded:direct/column=101/newline=2 
}

"RECOVERY / PAYMENT INFORMATION"/col=50/newline=3
if sfscause:line_type = "P" then
{
 
"P R O P E R T Y"/column=60/newline=2
"Surplus Case Recovery"/column=1
lrsceded:surplus_case_recovery/column=30
"Surplus LAE Recovery"/column=50
lrsceded:surplus_lae_recovery /column=80
"Total Surplus    "/column=100
lrsceded:surplus_case_recovery+lrsceded:surplus_lae_recovery/column=110/newline 
"Excess of Loss Case Recovery"/column=1
lrsceded:xol_case_recovery /column=30
"Excess of Loss LAE Recovery  "/column=50
lrsceded:xol_lae_recovery/column=80
"Total Excess "/column=100
lrsceded:xol_case_recovery+lrsceded:xol_lae_recovery/column=110/newline=2   
"NET Case Payments     "/column=1
lrsceded:direct_case_recovery/column=30
"Net LAE Payments  "/column=50
lrsceded:direct_lae_recovery /column=80 
"Total NET"/column=100                 
lrsceded:direct_case_recovery+lrsceded:direct_lae_recovery/column=110/newline=2
}

if sfscause:line_type = "L" then
{
"L I A B I L I T Y"/column=60/newline=2 

/*  beginning of the Liability treaties" */

if lrsceded:liab_treaty_no[1] <> 0 then  
{
"Treaty # " + trun(str(lrsceded:liab_treaty_no[1],"ZZZZZ"))/col=1
lrsceded:liab_case_recovery[1]/column=30 
"Treaty # " + trun(str(lrsceded:liab_treaty_no[1],"ZZZZZ")) + " LAE "/column=50
lrsceded:liab_lae_recovery[1]/column=80/duplicates 
"Total  "/column=100/duplicates 
lrsceded:liab_case_recovery[1] + lrsceded:liab_lae_recovery[1]/column=110/newline
}

if lrsceded:liab_treaty_no[2] <> 0 then
{
"Treaty # " + trun(str(lrsceded:liab_treaty_no[2],"ZZZZZ"))/col=1
lrsceded:liab_case_recovery[2]/column=30 
"Treaty # " + trun(str(lrsceded:liab_treaty_no[2],"ZZZZZ")) + " LAE "/column=50
lrsceded:liab_lae_recovery[2]/column=80/duplicates 
"Total  "/column=100/duplicates 
lrsceded:liab_case_recovery[2] + lrsceded:liab_lae_recovery[2]/column=110/newline
}

if lrsceded:liab_treaty_no[3] <> 0 then
{
"Treaty # " + trun(str(lrsceded:liab_treaty_no[3],"ZZZZZ"))/col=1
lrsceded:liab_case_recovery[3]/column=30 
"Treaty # " + trun(str(lrsceded:liab_treaty_no[3],"ZZZZZ")) + " LAE "/column=50
lrsceded:liab_lae_recovery[3]/column=80/duplicates 
"Total  "/column=100/duplicates 
lrsceded:liab_case_recovery[3] + lrsceded:liab_lae_recovery[3]/column=110/newline
}

if lrsceded:liab_treaty_no[4] <> 0 then
{
"Treaty # " + trun(str(lrsceded:liab_treaty_no[4],"ZZZZZ"))/col=1
lrsceded:liab_case_recovery[4]/column=30 
"Treaty # " + trun(str(lrsceded:liab_treaty_no[4],"ZZZZZ")) + " LAE "/column=50
lrsceded:liab_lae_recovery[4]/column=80/duplicates 
"Total  "/column=100/duplicates 
lrsceded:liab_case_recovery[4] + lrsceded:liab_lae_recovery[4]/column=110/newline
}

if lrsceded:liab_treaty_no[5] <> 0 then
{
"Treaty # " + trun(str(lrsceded:liab_treaty_no[5],"ZZZZZ"))/col=1
lrsceded:liab_case_recovery[5]/column=30 
"Treaty # " + trun(str(lrsceded:liab_treaty_no[5],"ZZZZZ")) + " LAE "/column=50
lrsceded:liab_lae_recovery[5]/column=80/duplicates 
"Total  "/column=100/duplicates 
lrsceded:liab_case_recovery[5] + lrsceded:liab_lae_recovery[5]/column=110/newline
}

if lrsceded:liab_treaty_no[6] <> 0 then
{
"Treaty # " + trun(str(lrsceded:liab_treaty_no[6],"ZZZZZ"))/col=1
lrsceded:liab_case_recovery[6]/column=30 
"Treaty # " + trun(str(lrsceded:liab_treaty_no[6],"ZZZZZ")) + " LAE "/column=50
lrsceded:liab_lae_recovery[6]/column=80/duplicates 
"Total  "/column=100/duplicates 
lrsceded:liab_case_recovery[6] + lrsceded:liab_lae_recovery[6]/column=110/newline  
}
""/newline
"Net Case Payments"
lrsceded:liab_direct_case_recovery      /column=30
"Net LAE Payments"/column=50
lrsceded:liab_direct_lae_recovery /column=80/duplicates  
"Total NET  "/column=100
lrsceded:liab_direct_case_recovery + lrsceded:liab_direct_lae_recovery/column=110/newline=2   
}

"R E S E R V E S"/column=60/newline=2   

if sfscause:line_type = "P" then
{
"P R O P E R T Y"/column=60/newline=2  

"Surplus Reserve  "/column=1
lrsceded:surplus_case_reserve/column=30
"Surplus LAE      "/column=50
lrsceded:surplus_lae_reserve/column=80
"Total Surplus    "/column=100
lrsceded:surplus_case_reserve + lrsceded:surplus_lae_recovery/column=110/newline   
"XOL Reserve      "/column=1 
lrsceded:xol_case_reserve/column=30
"XOL LAE          "/column=50
lrsceded:xol_lae_reserve/column=80
"Total XOL        "/column=100
lrsceded:xol_case_reserve + lrsceded:xol_lae_reserve/column=110/newline=2
"NET Reserve      "/column=1
lrsceded:direct_case_reserve/column=30
"NET LAE          "/column=50
lrsceded:direct_lae_reserve/col=80  
"Total NET        "/column=100
lrsceded:direct_case_reserve + lrsceded:direct_lae_reserve/column=110/newline=2
}
 
if sfscause:line_type = "L" then
{

"L I A B I L I T Y"/column=60/newline=2  

if lrsceded:liab_treaty_no[1] <> 0 then
{
"Treaty # " + trun(str(lrsceded:liab_treaty_no[1],"ZZZZZ"))/col=1
lrsceded:liab_case_reserve[1]/column=30 
"Treaty # " + trun(str(lrsceded:liab_treaty_no[1],"ZZZZZ")) + " LAE "/column=50
lrsceded:liab_lae_reserve[1]/column=80/duplicates 
"Total  "/column=100/duplicates 
lrsceded:liab_case_reserve[1] + lrsceded:liab_lae_reserve[1]/column=110/newline  
}

if lrsceded:liab_treaty_no[2] <> 0 then
{
"Treaty # " + trun(str(lrsceded:liab_treaty_no[2],"ZZZZZ"))/col=1
lrsceded:liab_case_reserve[2]/column=30 
"Treaty # " + trun(str(lrsceded:liab_treaty_no[2],"ZZZZZ")) + " LAE "/column=50
lrsceded:liab_lae_reserve[2]/column=80/duplicates 
"Total  "/column=100/duplicates 
lrsceded:liab_case_reserve[2] + lrsceded:liab_lae_reserve[2]/column=110/newline  
}

if lrsceded:liab_treaty_no[3] <> 0 then
{
"Treaty # " + trun(str(lrsceded:liab_treaty_no[3],"ZZZZZ"))/col=1
lrsceded:liab_case_reserve[3]/column=30 
"Treaty # " + trun(str(lrsceded:liab_treaty_no[3],"ZZZZZ")) + " LAE "/column=50
lrsceded:liab_lae_reserve[3]/column=80/duplicates 
"Total  "/column=100/duplicates 
lrsceded:liab_case_reserve[3] + lrsceded:liab_lae_reserve[3]/column=110/newline  
}    

if lrsceded:liab_treaty_no[4] <> 0 then
{
"Treaty # " + trun(str(lrsceded:liab_treaty_no[4],"ZZZZZ"))/col=1
lrsceded:liab_case_reserve[4]/column=30 
"Treaty # " + trun(str(lrsceded:liab_treaty_no[4],"ZZZZZ")) + " LAE "/column=50
lrsceded:liab_lae_reserve[4]/column=80/duplicates 
"Total  "/column=100/duplicates 
lrsceded:liab_case_reserve[4] + lrsceded:liab_lae_reserve[4]/column=110/newline  
} 

if lrsceded:liab_treaty_no[5] <> 0 then
{
"Treaty # " + trun(str(lrsceded:liab_treaty_no[5],"ZZZZZ"))/col=1
lrsceded:liab_case_reserve[5]/column=30 
"Treaty # " + trun(str(lrsceded:liab_treaty_no[5],"ZZZZZ")) + " LAE "/column=50
lrsceded:liab_lae_reserve[5]/column=80/duplicates 
"Total  "/column=100/duplicates 
lrsceded:liab_case_reserve[5] + lrsceded:liab_lae_reserve[5]/column=110/newline  
} 

if lrsceded:liab_treaty_no[6] <> 0 then
{
"Treaty # " + trun(str(lrsceded:liab_treaty_no[6],"ZZZZZ"))/col=1
lrsceded:liab_case_reserve[6]/column=30 
"Treaty # " + trun(str(lrsceded:liab_treaty_no[6],"ZZZZZ")) + " LAE "/column=50
lrsceded:liab_lae_reserve[6]/column=80/duplicates 
"Total  "/column=100/duplicates 
lrsceded:liab_case_reserve[6] + lrsceded:liab_lae_reserve[6]/column=110/newline  
}

""/newline
"Net Case Reserves"/column=1
lrsceded:liab_direct_case_reserve/column=30
"Net LAE Reserves"/column=50
lrsceded:liab_direct_lae_reserve/column=80 
"Total NET  "/column=100
lrsceded:liab_direct_case_reserve+ lrsceded:liab_direct_lae_reserve/column=110/newline=2   

}
