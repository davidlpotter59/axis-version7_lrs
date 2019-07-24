/*  SCIPS.com, Inc.

    program no.: lrspr480

    January 31, 2004

    Claim counts - Direct only 
*/

Description Direct Claim counts by Annual Statement Line of Business ;

include "startend.inc"

define unsigned ascii number l_closed_claims =
if lrsdetail:trans_code one of 12 then 1
else 0

define unsigned ascii number l_closed_without = 
if lrsdetail:trans_code one of 13 then 1
else 0

define unsigned ascii number l_claim_count =
if lrsdetail:trans_code one of 16 then 1
else 0

define unsigned ascii number l_current_open = 
if lrsdetail:trans_date >= l_starting_date and
lrsdetail:trans_date <= l_ending_date and 
lrsdetail:trans_code one of 16 then 1
else 0

define unsigned ascii number l_current_reported = 
if lrssetup:reported_date >= l_starting_date and 
lrssetup:trans_date <= l_ending_date and 
lrsdetail:trans_code one of 16 then 1
else 0

define unsigned ascii number l_prior_reported = 
if lrssetup:reported_date < l_starting_date and
lrsdetail:trans_code one of 16 then 1
else 0

where lrsdetail:trans_code < 30
list
/domain="lrsdetail"
/nodetail 

sfsline:stmt_lob/heading="Stmt-LOB"/column=1
((l_current_reported + l_prior_reported) - (l_closed_claims + l_closed_without))/heading="Open-Claims"/column=30
(l_closed_claims + l_closed_without)/heading="Closed-Claims"/column=40
l_closed_claims/heading="Closed With-Payment"/column=50
l_closed_without/heading="Closed Without-Payment"/column=60
l_current_reported/heading="Reported-This Year"/column=70
l_prior_reported/heading="Reported-Other Years"/column=80
(l_current_reported + l_prior_reported)/heading="Total-Claims"/column=90
l_current_open/heading="Opened-This Year"/column=100

sorted by
  sfsline:stmt_lob 

end of sfsline:stmt_lob 

sfsline:stmt_lob /noheading /column=1
sfsstmt:description/column=5/noheading
(total[l_current_reported] + total[l_prior_reported]) - (total[l_closed_claims] + total[l_closed_without])
/noheading /column=30
(total[l_closed_claims] + total[l_closed_without])/noheading/column=40
total[l_closed_claims]/noheading/column=50
total[l_closed_without]/noheading/column=60
total[l_current_reported]/noheading/column=70
total[l_prior_reported]/noheading/column=80
total[l_current_reported] + total[l_prior_reported]/noheading/column=90
total[l_current_open]/noheading/column=100
