CLASS zcl_journalitem_auto DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    INTERFACES if_oo_adt_classrun .
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCL_JOURNALITEM_AUTO IMPLEMENTATION.


  METHOD if_oo_adt_classrun~main.
  DATA: lt_entry      TYPE TABLE FOR ACTION IMPORT i_journalentrytp~post,
          ls_entry    LIKE LINE OF lt_entry,
          ls_glitem   LIKE LINE OF ls_entry-%param-_glitems,
          ls_amount   LIKE LINE OF ls_glitem-_currencyamount.
*          ls_taxitem   LIKE LINE OF ls_entry-%param-_taxitems,
*          ls_taxamt   LIKE LINE OF ls_taxitem-_currencyamount.



      ls_entry-%cid = 'My%CID_01'.
      ls_entry-%param-companycode = '0194'.
      ls_entry-%param-businesstransactiontype = 'RFBU'.
      ls_entry-%param-documentreferenceid = 'BKPFF'.
      ls_entry-%param-accountingdocumenttype = 'SA'.
      ls_entry-%param-accountingdocumentheadertext = 'Test1'.
      ls_entry-%param-documentdate = sy-datum.
      ls_entry-%param-postingdate = sy-datum.
      ls_entry-%param-createdbyuser = sy-uname.
      ls_entry-%param-TaxReportingDate = sy-datum.
      ls_entry-%param-TaxDeterminationDate = sy-datum.


      CLEAR ls_glitem.
        ls_glitem-glaccountlineitem = '0010'.
        ls_glitem-glaccount         = '00483520'.
*        ls_glitem-costcenter       = '0191731601'.
*        ls_glitem-profitcenter     = '0000731601'.
        ls_glitem-documentitemtext  = 'TEST1'.
*        ls_glitem-TaxCode           = 'A0'.
*        ls_glitem-TaxCountry        = 'GB'.

        CLEAR ls_amount.
        ls_amount-currencyrole = '00'.
        ls_amount-currency = 'GBP'.
        ls_amount-journalentryitemamount = '-100'.
        APPEND ls_amount TO ls_glitem-_currencyamount.
        ls_glitem-_profitabilitysupplement-ProfitCenter = '0000731601'.
        APPEND ls_glitem TO ls_entry-%param-_glitems.
*  <<<<<<<<<<<<<<<<<<<<<<>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
  CLEAR ls_glitem.
        ls_glitem-glaccountlineitem = '0020'.
        ls_glitem-glaccount         = '00171150'.
*        ls_glitem-costcenter        = '0191731601'.
*        ls_glitem-profitcenter      = '0000731601'.
        ls_glitem-documentitemtext  = 'TEST2'.

        CLEAR ls_amount.
        ls_amount-currencyrole = '00'.
        ls_amount-currency = 'GBP'.
        ls_amount-journalentryitemamount = '100'.
        APPEND ls_amount TO ls_glitem-_currencyamount.
        ls_glitem-_profitabilitysupplement-ProfitCenter = '0000731601'.
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
      ENTITY JournalEntry
      EXECUTE post FROM  lt_entry
        MAPPED FINAL(ls_post_mapped)
        FAILED FINAL(ls_post_failed)
        REPORTED FINAL(ls_post_reported).

if ls_post_failed is not INITIAL.
LOOP AT ls_post_reported-journalentry ASSIGNING FIELD-SYMBOL(<ls_post_reported_deep>).
 DATA(lv_result) = <ls_post_reported_deep>-%msg->if_message~get_text( ).
 ...
 ENDLOOP.
 else.
        COMMIT ENTITIES BEGIN RESPONSE OF i_journalentrytp FAILED DATA(Lt_failed_data) REPORTED DATA(lt_reported1).
 COMMIT ENTITIES END.
 endif.



  ENDMETHOD.
ENDCLASS.
