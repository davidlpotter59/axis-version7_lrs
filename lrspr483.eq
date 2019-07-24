/* 
   lrspr483

   january 25, 2005

   scips.com, inc.

   claim count dump by annual statment line, date of loss - no status breakdown
*/

description 
Claim Count Dump by Annual Statement Line of Business, 
Date of Loss - This report Does not Breakout Closed, Open, etc. ;

include "startend.inc"

where lrssetup:loss_date <= l_ending_date 
and  (lrssetup:reported_date => l_starting_date and 
      lrssetup:reported_date <= l_ending_date)

sum
/nobanner
/domain="lrssetup"
/xls="lrspr483"
/title="Claim Count Dump by Annual Statement and Date of Loss"

lrssetup:units/heading="Count"

by  sfsline:stmt_lob /total/newlines 
    year(lrssetup:loss_date)
