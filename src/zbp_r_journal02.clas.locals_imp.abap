CLASS lhc_zr_journal DEFINITION INHERITING FROM cl_abap_behavior_handler.
  PRIVATE SECTION.

    METHODS get_instance_authorizations FOR INSTANCE AUTHORIZATION
      IMPORTING keys REQUEST requested_authorizations FOR zr_journal RESULT result.

    METHODS post FOR DETERMINE ON SAVE
      IMPORTING keys FOR zr_journal~post.

ENDCLASS.

CLASS lhc_zr_journal IMPLEMENTATION.

  METHOD get_instance_authorizations.
  ENDMETHOD.

  METHOD post.

    DATA: lt_entry  TYPE TABLE FOR ACTION IMPORT i_journalentrytp~post,
          ls_entry  LIKE LINE OF lt_entry,
          ls_glitem LIKE LINE OF ls_entry-%param-_glitems,
          ls_amount LIKE LINE OF ls_glitem-_currencyamount,
           n                          TYPE i.
*          ls_taxitem   LIKE LINE OF ls_entry-%param-_taxitems,
*          ls_taxamt   LIKE LINE OF ls_taxitem-_currencyamount.

    READ ENTITIES OF zr_journal IN LOCAL MODE
               ENTITY zr_journal ALL FIELDS WITH CORRESPONDING #( keys ) RESULT FINAL(data_read).

    READ TABLE data_read INTO DATA(wa_read) INDEX 1.
    DATA(fdate) = wa_read-creationdate.
    DATA(tdate) = wa_read-creatitodate.


select * FROM ZCM_JOURNALITEM
WHERE CreationDate BETWEEN @fdate and @tdate
into TABLE @data(it_so).



LOOP AT it_so ASSIGNING FIELD-SYMBOL(<FS_SO>).
 n += 1.
    "purchase requisition
    DATA(cid) = 'My%CID' && '_' && n.


    ls_entry-%cid = cid.
    ls_entry-%param-companycode = <FS_SO>-CompanyCode."
    ls_entry-%param-businesstransactiontype = 'RFBU'.
    ls_entry-%param-documentreferenceid = 'BKPFF'.
    ls_entry-%param-accountingdocumenttype = 'SA'.
    ls_entry-%param-accountingdocumentheadertext = 'Test1'.
    ls_entry-%param-documentdate = sy-datum.
    ls_entry-%param-postingdate = sy-datum.
    ls_entry-%param-createdbyuser = sy-uname.
    ls_entry-%param-taxreportingdate = sy-datum.
    ls_entry-%param-taxdeterminationdate = sy-datum.


    CLEAR ls_glitem.
    ls_glitem-glaccountlineitem = '0010'.
    ls_glitem-glaccount         = '00483520'.
*        ls_glitem-costcenter       = '0191731601'.
*        ls_glitem-profitcenter     = '0000731601'.
    ls_glitem-documentitemtext  = 'TEST1'.
*        ls_glitem-TaxCode           = 'A0'.
*        ls_glitem-TaxCountry        = 'GB'.

  <FS_SO>-NetAmount = <FS_SO>-NetAmount * -1.
    CLEAR ls_amount.
    ls_amount-currencyrole = '00'.
    ls_amount-currency = 'GBP'.
    ls_amount-journalentryitemamount = <FS_SO>-NetAmount.
    APPEND ls_amount TO ls_glitem-_currencyamount.
    ls_glitem-_profitabilitysupplement-profitcenter = '0000731601'.
    ls_glitem-_profitabilitysupplement-SalesOrder = <fs_so>-SalesOrder.
    ls_glitem-_profitabilitysupplement-SalesOrderItem = <fs_so>-SalesOrderItem.
    APPEND ls_glitem TO ls_entry-%param-_glitems.
*  <<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    CLEAR ls_glitem.
    ls_glitem-glaccountlineitem = '0020'.
    ls_glitem-glaccount         = '00171150'.
*        ls_glitem-costcenter        = '0191731601'.
*        ls_glitem-profitcenter      = '0000731601'.
    ls_glitem-documentitemtext  = 'TEST2'.

<FS_SO>-NetAmount = <FS_SO>-NetAmount * -1.
    CLEAR ls_amount.
    ls_amount-currencyrole = '00'.
    ls_amount-currency = 'GBP'.
    ls_amount-journalentryitemamount = <FS_SO>-NetAmount.
    APPEND ls_amount TO ls_glitem-_currencyamount.
   ls_glitem-_profitabilitysupplement-profitcenter = '0000731601'.
    ls_glitem-_profitabilitysupplement-SalesOrder = <fs_so>-SalesOrder.
    ls_glitem-_profitabilitysupplement-SalesOrderItem = <fs_so>-SalesOrderItem.
    APPEND ls_glitem TO ls_entry-%param-_glitems.
*  <<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>
*       ls_taxitem-TaxCode = 'A0'.
*       ls_taxitem-TaxDeterminationDate = SY-datum.
*
*       ls_taxamt-CurrencyRole = '00'.
*       ls_taxamt-Currency     = 'GBP'.
*       ls_taxamt-JournalEntryItemAmount = '0.00'.
*       APPEND ls_taxamt TO ls_taxitem-_currencyamount.
*       APPEND ls_taxitem TO ls_entry-%param-_taxitems.
*  <<<<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
    APPEND ls_entry TO lt_entry.


    MODIFY ENTITIES OF i_journalentrytp
      ENTITY journalentry
    EXECUTE post FROM  lt_entry
      FAILED DATA(ls_failed_deep)
          REPORTED DATA(ls_reported_deep)
          MAPPED DATA(ls_mapped_deep).


ENDLOOP.



  ENDMETHOD.

ENDCLASS.

CLASS lsc_zr_journal DEFINITION INHERITING FROM cl_abap_behavior_saver.
  PROTECTED SECTION.

    METHODS save_modified REDEFINITION.

    METHODS cleanup_finalize REDEFINITION.

ENDCLASS.

CLASS lsc_zr_journal IMPLEMENTATION.

  METHOD save_modified.
  ENDMETHOD.

  METHOD cleanup_finalize.
  ENDMETHOD.

ENDCLASS.
