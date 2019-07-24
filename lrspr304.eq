/* lrspr304.eq

   scips.com

   November 14, 2011 

   claims suspense list
*/

where lrssuswork1:email = lrssuswork2:email
list
/domain="lrssuswork1"
/nobanner
/noheadings
/noreporttotals      
/pagewidth=220
/wks="lrspr304"

lrssuswork1:suspense_date/column=1
lrssuswork1:Claim_no/column=20
lrssuswork1:suspense_date/column=35
lrssuswork1:user_id/column=50

^textmode
^margin 80 120
^^lrssuspense:remarks/column=80
^listmode

sorted by lrssuswork1:claim_no

top of page
"Suspense List For "
lrssuswork2:email/newline=2

"Suspense Date"/column=1
"Claim_no"/column=20
"Date of Suspense"/column=33
"Requestor"/column=50
"Remarks"/column=93
;
