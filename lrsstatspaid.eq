/*  lrsstatspaid.eq

    September 30, 2004

    SCIPS.com

    Replace lrscol1 - lrscol4, does not require select/collection= to run */
                   
include "startend.inc"
   
find lrsdetail with      

        ((lrsdetail:loss_paid <> 0 and
         lrsdetail:trans_date => l_starting_date and
         lrsdetail:trans_date <= l_ending_date and
         lrsdetail:trans_code < 30 and
         lrsdetail:line_of_business not one of 65 and
         lrsdetail:trans_date <= l_ending_date) or

        (lrsdetail:lae_paid <> 0 and
         lrsdetail:trans_date => l_starting_date and
         lrsdetail:trans_date <= l_ending_date and
         lrsdetail:trans_code < 30 and
         lrsdetail:line_of_business not one of 65 and
         lrsdetail:trans_date <= l_ending_date) or

        (lrsdetail:loss_resv <> 0 and
        (lrssetup:status <> "C" or
        (lrssetup:status = "C" and
         lrssetup:status_date => l_starting_date)) and
        lrsdetail:trans_code < 30 and
        lrsdetail:line_of_business not one of 65 and
        lrsdetail:trans_date <= l_ending_date) or

        (lrsdetail:lae_resv <> 0 and
        (lrssetup:status <> "C" or
        (lrssetup:status = "C" and
         lrssetup:status_date => l_starting_date)) and
        lrsdetail:trans_code < 30 and
        lrsdetail:line_of_business not one of 65 and
        lrsdetail:trans_date <= l_ending_date))

