
/*  lrsprph14.eq

    scips.com

    april 23, 2009

    Number of claims settled greater then 90 days and less then a year the range of the group is 180 days.

*/
                                                                    
description Number of suits closed during the period;

where CLAIMCOLLECTION:litigation = "Y" and claimcollection:status_2 one of 0,1,2 

sum

/domain="claimcollection"

units/heading="ligitaion cliams" 

across switch(claimcollection:status_2)
        case 0 : "OPEN"
         case 1 : "Closed"
         case 2 : "Closed"
