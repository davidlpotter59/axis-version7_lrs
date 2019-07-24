/*  lrsfl001

    SCIPS.com

    March 8, 2002

    Form Letter to print the In House Adjustors Claim Notification
*/

Description Inhouse Adjustors Claims Notification Form Letter;

define unsigned ascii number l_claim_no[11]=parameter/prompt="<NL>Enter Claim Number"    
define string l_needed_information[200]=parameter/prompt="<NL>Information Required"

define string l_name_1=sfpname:name[1]

where lrssetup:claim_no = l_claim_no 

list
/nobanner 
/domain="lrssetup"
/noblanklines
/nodefaults
/nopageheadings    

todaysdate/column=1/line=10/mask="M(15) DD, YYYY"               

box/noblanklines/column=7/line=13
sfpname:name/newline
sfpname:address/newline
trun(sfpname:city) + ", " + sfpname:str_state + "    " + sfpname:str_zipcode 
xob/newline 
                       
box/line=22
""/newline=2
"Dear Insured,"/newline=2
"We are in receipt of your claim, which I have been assigned to handle."/newline=2

"In order to process your claim, please forward the following:"/newline 
end box

box/column=5/width=60
^textmode
^l_needed_information
^listmode
end box       

followed by

"Please complete the atached and forward along with a copy of the"/newline
"policy report."/newline=2

"If you have any questions, please call me at 1-800-498-0954."/newline=3
"Sincerely,"/newlines=4
"Jackie Leino"/newline
"Ext 129"/newline=3    


sfsagent:agent_no/heading="CC: " 
sfsagent:name/noheading
