/*  lrspr950

    SCIPS.com, Inc.

    October 8, 2002

    report to list the loss transaction codes used in lrsdetail file
*/

Description 
List the transaction codes (Direct, Assumed, Ceded and Treaty) that are used in the lrsdetail file ;

define string l_trans_code[1]=str(lrscode:trans_code)

define l_str_trans_code=switch(l_trans_code)
case "1","2"     : "1X - Direct     "
case "3","4"     : "3X - Assumed    "
case "5","6"     : "5X - Specific   "
case "7","8"     : "7X - Treaty     "
default          : "Unknown " + l_trans_code

list
/nobanner
/domain="lrscode"
/title="Loss Reporting System Transaction Codes"

box/needs=10/fixedbox                                
    lrscode:trans_code 
    lrscode:description 
end box

sorted by l_str_trans_code/newlines 

top of l_str_trans_code
l_str_trans_code/noheading/newline  
