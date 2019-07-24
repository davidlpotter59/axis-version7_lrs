
/*  lrsprph14.eq

    scips.com

    april 23, 2009

    Number of claims settled greater then 90 days and less then a year the range of the group is 180 days.

*/
                                                                    
description Number of suits open at beginning of the period;
include "startend.inc"

where lrssetup:litigation = "Y" and lrssetup:loss_date <= l_starting_date and lrssetup:status_2 one of 1,2 

list

/domain="lrssetup"

claim_no name litigation
