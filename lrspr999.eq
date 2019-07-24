/* lrspr999.eq
   
   scips.com

   may 2, 2005

   no of open claims count
*/

description no of open claims - need to enter an as of date ;

include "end.inc"

where ((lrssetup:status one of "O", "R" and
lrssetup:status_date <= l_ending_date) or
(lrssetup:status one of "C" and
lrssetup:status_date > l_ending_date))
list
/domain="lrssetup"
/nobanner
/nodetail
/Title = "No of Open Claims"

line_of_business
claim_no/heading="No of Open Claims"/column=60

sorted by line_of_business
          status
          
end of line_of_business
sfsline_heading:description/noheading
count[lrssetup:claim_no]/column=60 

end of report
""/newline=2
"Total No of Open Claims as of " + str(l_ending_date,"MM/DD/YYYY") + " = "/column=1
count[lrssetup:claim_no]/noheading/column=60
