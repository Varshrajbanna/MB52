CLASS zcd_interest_class DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.
    INTERFACES if_rap_query_provider.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZCD_INTEREST_CLASS IMPLEMENTATION.


  METHOD if_rap_query_provider~select.
    DATA: lt_response TYPE TABLE OF zcd_interest_cds.
    DATA:lt_current_output TYPE TABLE OF zcd_interest_cds.
    DATA:wa1 TYPE zcd_interest_cds.

    DATA(lv_top)           = io_request->get_paging( )->get_page_size( ).
    DATA(lv_skip)          = io_request->get_paging( )->get_offset( ).
*    DATA(lt_filter)        = io_request->get_filter( )->get_as_sql_string( ).
    DATA(lt_fields)        = io_request->get_requested_elements( ).
    DATA(lt_sort)          = io_request->get_sort_elements( ).
    DATA(lt_filter)        = io_request->get_filter( )->get_as_sql_string( ).
*    REPLACE ALL OCCURRENCES OF '=' IN lt_filter WITH '<>'.
*    REPLACE ALL OCCURRENCES OF 'AND' IN lt_filter WITH 'OR'.

    TRY.
        DATA(lt_filter_cond) = io_request->get_filter( )->get_as_ranges( ).
      CATCH cx_rap_query_filter_no_range INTO DATA(lx_no_sel_option).
    ENDTRY.

    DATA(postingdate)          =  VALUE #( lt_filter_cond[ name =  'POSTINGDATE'  ]-range OPTIONAL ).
    DATA(purchaseorder)          =  VALUE #( lt_filter_cond[ name =  'PURCHASEORDER'  ]-range OPTIONAL ).
    DATA(materialdocument)     =  VALUE #( lt_filter_cond[ name = 'MATERIALDOCUMENT'  ]-range OPTIONAL ).
    DATA(supplier)     =  VALUE #( lt_filter_cond[ name = 'SUPPLIER'  ]-range OPTIONAL ).

    LOOP AT postingdate ASSIGNING FIELD-SYMBOL(<wa_postingdate>).
      IF <wa_postingdate>-high IS NOT INITIAL.
        <wa_postingdate>-high = <wa_postingdate>-high+0(4) && <wa_postingdate>-high+5(2) && <wa_postingdate>-high+8(2).
      ENDIF.
      IF <wa_postingdate>-low IS NOT INITIAL.
        <wa_postingdate>-low = <wa_postingdate>-low+0(4) && <wa_postingdate>-low+5(2) && <wa_postingdate>-low+8(2).
      ENDIF.
    ENDLOOP.
    TYPES:BEGIN OF ty_final,

            companycode   TYPE i_billingdocumentbasic-companycode,
            customer_code TYPE i_billingdocumentbasic-payerparty,
*            customer_code TYPE i_billingdocumentbasic-BillingDocument,
*            customer_code TYPE i_billingdocumentbasic-AccountingDocument,
*            customer_code TYPE i_billingdocumentitembasic-ProfitCenter,
*            customer_code TYPE i_billingdocumentbasic-AccountingPostingStatus,
*            customer_code TYPE i_billingdocumentbasic-BillingDocumentDate,
*            customer_code TYPE I_OperationalAcctgDocItem-AmountInTransactionCurrency,
*            customer_code TYPE I_OperationalAcctgDocItem-NetDueDate,
*            customer_code TYPE I_OperationalAcctgDocItem-AmountInTransactionCurrency,
*            customer_code TYPE -payerparty,
*            customer_code TYPE i_billingdocumentbasic-payerparty,
*            customer_code TYPE i_billingdocumentbasic-payerparty,
*            customer_code TYPE i_billingdocumentbasic-payerparty,
*            customer_code TYPE i_billingdocumentbasic-payerparty,
*            customer_code TYPE i_billingdocumentbasic-payerparty,

          END OF ty_final.

    DATA:wa_final TYPE ty_final,
         it_final TYPE TABLE OF ty_final.


   SELECT a~companycode ,
          a~PAYERPARTY
   FROM I_BillingDocumentBasic as a
   INTO TABLE @data(i_data).


    """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    MOVE-CORRESPONDING it_final TO lt_response.

    TRY.
        """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
*_Paging implementation
        IF lv_top < 0  .
          lv_top = lv_top * -1 .
        ENDIF.
        DATA(lv_start) = lv_skip + 1.
        DATA(lv_end)   = lv_top + lv_skip.
        APPEND LINES OF lt_response FROM lv_start TO lv_end TO lt_current_output.

        io_response->set_total_number_of_records( lines( lt_current_output ) ).
        io_response->set_data( lt_current_output ).

      CATCH cx_root INTO DATA(lv_exception).
        DATA(lv_exception_message) = cl_message_helper=>get_latest_t100_exception( lv_exception )->if_message~get_longtext( ).
    ENDTRY.


  ENDMETHOD.
ENDCLASS.
