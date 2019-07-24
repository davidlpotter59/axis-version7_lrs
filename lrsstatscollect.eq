/*  lrsstatscollect.eq

    june 6, 2003

    SCIPS.com

    loss stats collect file */
                            
include "startend.inc"
            
find lrsdetail with 
        ((lrsdetail:loss_paid <> 0 and
        (lrsdetail:trans_date => l_starting_date and
         lrsdetail:trans_date <= l_ending_date)) or

        (lrsdetail:lae_paid <> 0 and
        (lrsdetail:trans_date => l_starting_date and
         lrsdetail:trans_date <= l_ending_date)) or

        (lrsdetail:loss_resv <> 0 and
        (lrssetup:status <> "C" or
        (lrssetup:status = "C" and
         lrssetup:status_date => l_starting_date))) or

        (lrsdetail:lae_resv <> 0 and
        (lrssetup:status <> "C" or
        (lrssetup:status = "C" and
         lrssetup:status_date => l_starting_date))))

and lrsdetail:trans_code < 30 and
lrssetup:line_of_business <> 65
