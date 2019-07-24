
include "startend.inc"
define unsigned ascii number l_year[4] = year(l_starting_date) 

define file sfpcurrent_alias = access sfpcurrent,
                                  set sfpcurrent:policy_no = sfscancel:policy_no, exact
                                    
define file sfpname_alias = access sfpname,
                               set sfpname:policy_no = sfpcurrent_alias:policy_no, 
                                   sfpname:pol_year  = sfpcurrent_alias:pol_year, 
                                   sfpname:end_sequence = sfpcurrent_alias:end_sequence, exact   

where SFSCANCEL:status one of "CANCELLED" and
      sfscancel:cx_eff_date >= l_starting_date and 
      sfscancel:cx_eff_date <= l_ending_date
      and (sfscancel:cx_eff_date - sfpname_alias:eff_date) > 60 
      and sfpname_alias:line_of_business one of 3,4,14 
      and sfscancel:cancellation_code not one of 100,101,102,103,2001,2002,2003,2004,2005,2006,9001,9002,9003,9004,9005,9007,
      9009,9010

list

/domain="sfscancel" 

sfscancel:company_id 
policy_no 
sub_code 
cx_eff_date/heading="CX_eff_date" 
status  
sfscancel:cancellation_code
sfscancel:cx_eff_date - sfpname_alias:eff_date
sfpname_alias:line_of_business 

sorted by policy_no 

end of policy_no 
count[policy_no ]

end of report
count[policy_no ]
