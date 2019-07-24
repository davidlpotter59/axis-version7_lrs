/* LRSPR002.EQ 

   May 16, 2001

   SCIPS.com 

   claim status report */

description Status Report ;

DEFINE L_TRANS = SWITCH(lrsdetail:TRANS_TYPE)
                   CASE 1  : 1
                   DEFAULT : 2   
                               
define file alt_sfplocation = access sfplocation, set
sfplocation:policy_no = lrssetup:policy_no,
sfplocation:pol_Year = lrssetup:pol_year,
sfplocation:end_sequence = lrssetup:end_sequence,
sfplocation:prem_no = lrssetup:prem_no,
sfplocation:build_no = lrssetup:build_no, generic

define unsigned ascii number l_status_claim = parameter/prompt="Enter Claim No "

define string l_claim_no = str(lrsdetail:claim_no) + sfsline_alias:claim_alpha 

where lrsdetail:claim_no = l_status_claim
LIST
/DOMAIN="lrsdetail"
/NOBANNER
/PAGEWIDTH=200
/NOREPORTTOTALS
/NOHEADING      
/nopageheadings

lrssummary:claimant[1,20]/heading="Claimant"
str(lrsdetail:line_of_business) + " " + lrsdetail:lob_subline/HEADING=
"Line-Of-Business"
str(lrsdetail:cause_of_loss) + " " + lrsdetail:cause_loss_subline/heading=
"Cause-Of-Loss"
lrsdetail:VENDOR_NO/HEADING="Adjustor"   
lrsdetail:TRANS_DATE/HEADING="Trans-Date"
lrsdetail:TRANS_CODE/HEADING="Trans-Code"
lrsdetail:LOSS_RESV/MASK="ZZZZZZZ-"/HEADING="Loss-Resv"
lrsdetail:LOSS_PAID/MASK="ZZZZZZZ.ZZ-"/HEADING="Loss-Paid"
if lrsdetail:loss_paid <> 0 or
   lrsdetail:lae_paid <> 0 then
{
lrscheck:check_no_string /heading="Check-Number"
}
if lrsdetail:ulae = "Y" then
    {
    lrsdetail:LAE_RESV/MASK="ZZZZZZZ-"/HEADING="ULAE-Resv"
    lrsdetail:LAE_PAID/MASK="ZZZZZ.ZZ-"/HEADING="ULAE-Paid"
    }
if lrsdetail:alae = "Y" then
    {
    lrsdetail:LAE_RESV/MASK="ZZZZZZZ-"/HEADING="ALAE-Resv"
    lrsdetail:LAE_PAID/MASK="ZZZZZ.ZZ-"/HEADING="ALAE-Paid"
    }
if sfscompany:loss_coverage = 1 then
    {
    lrsdetail:coverage/heading="Coverage"
    }

lrsdetail:misc/toggle

SORTED BY --lrsdetail:CLAIM_NO/NEWPAGE
          L_TRANS/TOTAL/heading="CLAIM"
          lrsdetail:cause_of_loss
          lrsdetail:cause_loss_subline/newlines=2/total/heading="CAUSE OF LOSS"
          year(lrsdetail:trans_date)
          month(lrsdetail:trans_date)
          day(lrsdetail:trans_date)
          lrsdetail:sub_code
                    
end of lrsdetail:cause_of_loss
""/newline
SWITCH(lrssummary:status)
  CASE "O" : "CLAIM OPEN"
  CASE "C" : "CLAIM CLOSED"
  CASE "R" : "CLAIM RE-OPENED"

TOP OF PAGE                                 
box/noblanklines/noheading
"Program Number: LRSPR002"
sfscompany:name[1]/center
pagenumber/newline=2/heading="Page"/column=120 
"STATUS REPORT FOR CLAIM " + l_claim_no/column=49/newline=2
lrssetup:POLICY_NO/HEADING="Policy"/column=45
" - "
sfsline_alias:description/newline=2

if sfsline_alias:lob_code <> "AUTO" then
    {                   
    box/noblanklines/noheadings/column=1
    sfpname:NAME[1]/newline  
    if sfpname:name[2] <> "" then
        sfpNAME:name[2]/newline
    if sfpname:name[3] <> "" then
        sfpname:name[3]/newline
    if alt_sfplocation:address <> "" then
        alt_sfplocation:address/newline
    if alt_sfplocation:address1[1] <> "" then
        alt_sfplocation:address1[1]/newline
    if alt_sfplocation:address1[2] <> "" then
        alt_sfplocation:address1[2]/newline
    if alt_sfplocation:address1[3] <> "" then
        alt_sfplocation:address1[3]/newline
    box/noblanklines/noheadings/squeeze
    alt_sfplocation:city + ", "
    alt_sfplocation:str_state 
    alt_sfplocation:str_zipcode                
    end box/newline 
    if sfscause:line_type = "L" then
        {
        "Claimant: "
        lrssetup:Claimant/newline
        }
    end box
    }                       
if sfsline_alias:lob_code = "AUTO" then
    {
    box/noblanklines/noheadings/column=1
    "Year:     "
    capvehicle:year/newline
    "Make:     "
    capvehicle:make/newline
    "Model:    "
    capvehicle:model/newline
    "Serial No:"
    capvehicle:serial_no/newline
    "Driver:   "
    lrsdriver:name/newline
    if sfscause:line_type <> "L" then
        "Insured:  "
    else
        "Claimant: "
    lrssetup:Claimant/newline
    end box
    }

box/noblanklines/noheadings/column=60
"Examinor:       "
lrssetup:examiner_no/mask="ZZZZZ"
sfsvendor_alias:name[1]/newline
"Adjustor:       "
lrssetup:adjustor_vendor/mask="ZZZZZ"
sfsvendor1:name[1]/newline
"Coverage Option:"
lrssetup:coverage_vendor/mask="ZZZZZ"
sfsvendor4:name[1]/newline                     
"Litigation:     "
lrssetup:litigation_vendor/mask="ZZZZZ"
sfsvendor2:name[1]/newline                        
"DJ:             "
lrssetup:dj_vendor/mask="ZZZZZ"
sfsvendor3:name[1]/newline
"Subro/Salvage:  "
lrssetup:subro_vendor/mask="ZZZZZ"
sfsvendor5:name[1]/newline
"Cat No:         "
if lrssetup:company_id <> "FLEMINGTON" then
    {
    lrssetup:CAT_NO/mask="ZZZZZ"
    lrscat:description/newline
    }
else
    {
    lrssetup:STR_CAT_NO/mask="ZZZZZ"
    lrscat1:description/newline
    }
"Public Adjustor:"
lrssetup:pub_adjust_no/mask="ZZZZZ"
lrspubadj:name[1]/newline
end box
end box

box/noblanklines/noheadings/column=120/inline
"Policy Eff Date:"
sfpNAME:EFF_DATE/NEWLINE
"Policy Exp Date:"
sfpNAME:EXP_DATE/NEWLINE
"Date Of Loss:   "
lrssetup:LOSS_DATE/NEWLINE
"Date Reported   "
lrssetup:REPORTED_DATE
end box

;

/*  END OF FILE  */
