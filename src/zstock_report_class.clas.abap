CLASS zstock_report_class DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.


    DATA:wa_final TYPE zstock_report_cds,
         it_final TYPE TABLE OF zstock_report_cds.


    INTERFACES if_rap_query_provider.
  PROTECTED SECTION.
  PRIVATE SECTION.
ENDCLASS.



CLASS ZSTOCK_REPORT_CLASS IMPLEMENTATION.


  METHOD if_rap_query_provider~select.

    DATA: lt_response TYPE TABLE OF zstock_report_cds.
    DATA:lt_current_output TYPE TABLE OF zstock_report_cds.
    DATA:wa1 TYPE zcd_interest_cds.

    DATA(lt_clause)        = io_request->get_filter( )->get_as_sql_string( ).
    DATA(lv_top)           = io_request->get_paging( )->get_page_size( ).
    DATA(lv_skip)          = io_request->get_paging( )->get_offset( ).
    DATA(lt_fields)        = io_request->get_requested_elements( ).
    DATA(lt_sort)          = io_request->get_sort_elements( ).
    DATA(lt_filter)        = io_request->get_filter( )->get_as_sql_string( ).
    DATA(get_aggregation)        = io_request->get_aggregation( )."get_filter( )->get_as_sql_string( ).


    TRY.
        DATA(lt_filter_cond) = io_request->get_filter( )->get_as_ranges( ).
      CATCH cx_rap_query_filter_no_range INTO DATA(lx_no_sel_option).
    ENDTRY.

    DATA(plant)            =  VALUE #( lt_filter_cond[ name =  'PLANT'  ]-range OPTIONAL ).
    DATA(storagelocation)  =  VALUE #( lt_filter_cond[ name =  'STORAGELOCATION'  ]-range OPTIONAL ).
    data(product)          =  VALUE #( lt_filter_cond[ name = 'PRODUCT'  ]-range OPTIONAL ).
    DATA(batch)            =  VALUE #( lt_filter_cond[ name = 'BATCH'  ]-range OPTIONAL ).
    DATA(materialbaseunit) =  VALUE #( lt_filter_cond[ name = 'MATERIALBASEUNIT'  ]-range OPTIONAL ).
    DATA(productgroup)     =  VALUE #( lt_filter_cond[ name = 'PRODUCTGROUP'  ]-range OPTIONAL ).
    DATA(producttype)      =  VALUE #( lt_filter_cond[ name = 'PRODUCTTYPE'  ]-range OPTIONAL ).
    DATA(lot_number)       =  VALUE #( lt_filter_cond[ name = 'LOT_NUMBER'  ]-range OPTIONAL ).
    DATA(bag_number)       =  VALUE #( lt_filter_cond[ name = 'BAG_NUMBER'  ]-range OPTIONAL ).
    DATA(packername)       =  VALUE #( lt_filter_cond[ name = 'PACKERNAME'  ]-range OPTIONAL ).
    DATA(zlevel1)       =  VALUE #( lt_filter_cond[ name = 'ZLEVEL1'  ]-range OPTIONAL ).
    DATA(zdesc2) = VALUE #( lt_filter_cond[ name = 'ZDESC2' ]-range OPTIONAL ).
DATA(zdesc3) = VALUE #( lt_filter_cond[ name = 'ZDESC3' ]-range OPTIONAL ).

LOOP AT product INTO DATA(W).

w-low = conv CHAR18( |{ w-low ALPHA = IN }| ).
MODIFY product FROM W TRANSPORTING LOW.
ENDLOOP.


    SELECT FROM i_stockquantitycurrentvalue_2( p_displaycurrency = 'INR' ) AS a
    INNER  JOIN i_productdescription          AS b ON ( b~product = a~product AND b~language = 'E' )
    LEFT OUTER JOIN I_ProductStorageLocationBasic  as z on ( a~Product = z~Product and z~StorageLocation = a~StorageLocation  )
    LEFT OUTER JOIN   i_productgrouptext_2 AS e ON ( e~productgroup = a~productgroup AND e~language = 'E' )
    LEFT OUTER JOIN zmatgrp_levels AS matgrp_levels ON (  a~productgroup  = matgrp_levels~zlevel1234 )
    LEFT OUTER JOIN zuser_01 AS ZCAP ON (  A~PRODUCT = lpad( ZCAP~zuser , 18 , '0'  )  )
*   LEFT OUTER JOIN Zpo_Rateamt_CDS as vg on  ( vg~Material = a~Product  )
   LEFT OUTER JOIN Zpo_Latest_CDS as vg on  ( vg~material = a~Product  )




    LEFT OUTER JOIN I_PRODUCTSTORAGELOCATIONBASIC as pl on ( Pl~Plant = a~Plant and pl~StorageLocation = a~StorageLocation
                                                                and pl~Product = a~Product )
    INNER join I_Product as prduct on (  prduct~Product = a~Product  )
    LEFT outer join I_ProductTypeText_2 as prdtype on ( prdtype~ProductType = a~ProductType and prdtype~Language = 'E' )
    LEFT OUTER JOIN I_unitofmeasure as uom on ( a~MaterialBaseUnit = uom~UnitOfMeasure )
    FIELDS DISTINCT a~plant ,
           a~storagelocation,
           A~StockValueInDisplayCurrency,
           ltrim( a~product, '0' ) as Product,
           a~batch,
           a~materialbaseunit,
           a~matlwrhsstkqtyinmatlbaseunit,
           a~productgroup,
           a~producttype,
           a~sddocument,
           a~sddocumentitem,
           a~MaterialBaseUnit as unit,
           a~MatlWrhsStkQtyInMatlBaseUnit as rate ,
           a~StockValueInCCCrcy,
           a~MaterialBaseUnit as Materialbaseunitt,
           a~Currency as Currency,
           a~InventoryStockType,
           b~productdescription,
           prduct~yy1_level1f4_prd as zlevel1,
           prduct~yy1_level2_f4_prd as zlevel2,
           prduct~YY1_Level3_PRD as zlevel3,
           prduct~yy1_level1_desc_prd as zdesc,
           prduct~YY1_leveldesc_2_PRD as zdesc2,
           prduct~YY1_level3_desc_PRD as zdesc3,
           pl~WarehouseStorageBin,
           ZCAP~zpass,
           vg~NetPriceAmount,
           pl~ISMARKEDFORDELETION,
           uom~UnitOfMeasureISOCode,
           CASE
           WHEN E~ProductGroupName is INITIAL
           then e~ProductGroupText
           else
           E~ProductGroupName end as ProductGroupName,
           prdtype~ProductTypeName
    WHERE ( a~valuationareatype = '1'   and a~InventoryStockType = '01' )
    AND ( A~ProductType <> 'ZFRT' AND    A~ProductType <> 'ZSFG' AND  A~ProductType <> 'ZBYP' AND   A~ProductType <> 'ZROH' )
      AND a~matlwrhsstkqtyinmatlbaseunit GT 0
      AND a~plant            IN  @plant
      AND a~storagelocation  IN  @storagelocation
      AND a~product         in  @product
      AND a~batch            IN  @batch
      AND a~materialbaseunit IN  @materialbaseunit
      AND a~productgroup     IN  @productgroup
      AND a~producttype      IN  @producttype
      AND prduct~yy1_level1f4_prd     IN  @zlevel1
      AND prduct~yy1_level2_f4_prd     IN  @zdesc2
      AND prduct~YY1_Level3_PRD     IN  @zdesc3
    INTO TABLE @DATA(i_data).

LOOP AT i_data INTO DATA(w_data).

wa_final-zlevel1 = w_data-zdesc .

wa_final-zdesc2 = w_data-zdesc2 .
wa_final-zdesc3 = w_data-zdesc3 .
wa_final-zlevel1_code = w_data-zlevel1 .
wa_final-zlevel2_code = w_data-zlevel2 .
wa_final-zlevel3_code = w_data-zlevel3 .
wa_final-productgrouptext = w_data-ProductGroupName .
wa_final-DL_Flag = w_data-ISMARKEDFORDELETION.
wa_final-plant                       = w_data-plant                       .
wa_final-storagelocation             = w_data-storagelocation             .
wa_final-product                     = w_data-product                   .
wa_final-batch                       = w_data-batch                       .
wa_final-quantity = w_data-MatlWrhsStkQtyInMatlBaseUnit .
wa_final-productgroup                = w_data-productgroup                .
wa_final-producttype                 = w_data-producttype                 .
wa_final-productdes          = w_data-productdescription          .
WA_FINAL-producttypetext  =  W_DATA-ProductTypeName .
DATA(lv_parts) = ``.

IF w_data-zpass IS NOT INITIAL.
lv_parts = lv_parts  +  w_data-zpass.
ENDIF.

IF w_data-netpriceamount IS NOT INITIAL.
lv_parts =   w_data-netpriceamount .
****** 2026.03.07
**lv_parts +
ENDIF.

wa_final-zcap_price = cond string(
when lv_parts IS INITIAL then ``
else condense( lv_parts ) ).
DATA(lv_mult) = ``.

IF w_data-zpass IS NOT INITIAL AND w_data-matlwrhsstkqtyinmatlbaseunit IS NOT INITIAL.
lv_mult =  lv_mult +  (  w_data-zpass * w_data-matlwrhsstkqtyinmatlbaseunit ).
ENDIF.

****** 2026.03.07
IF w_data-netpriceamount IS NOT INITIAL AND w_data-matlwrhsstkqtyinmatlbaseunit IS NOT INITIAL.
lv_mult =   ( w_data-matlwrhsstkqtyinmatlbaseunit * w_data-netpriceamount ).
ENDIF.
*********
*lv_mult +

wa_final-zcap_value = cond string(
when lv_mult IS INITIAL then ``
else condense( lv_mult ) ).

wa_final-zdesc2 = w_data-zdesc2.
wa_final-zdesc3 = w_data-zdesc3.
IF w_data-MaterialBaseUnit = 'ST'.
wa_final-unit = 'PC'.
ELSE.
wa_final-unit = w_data-MaterialBaseUnit.
ENDIF.
DATA: ls_temp_rate TYPE STANDARD TABLE OF zstock_report_cds,
ls_temp_rate_line LIKE LINE OF ls_temp_rate.
DATA: lv_calc_rate TYPE f.
lv_calc_rate  = w_data-StockValueInDisplayCurrency / w_data-MatlWrhsStkQtyInMatlBaseUnit.

ls_temp_rate_line-rate = lv_calc_rate.
wa_final-rate = ls_temp_rate_line-rate.
wa_final-Amountin_LC  =    w_data-StockValueInDisplayCurrency .
wa_final-Storagebin = w_data-WarehouseStorageBin.
wa_final-currency = w_data-Currency.

APPEND wa_final TO it_final.
CLEAR:wa_final.
ENDLOOP.


MOVE-CORRESPONDING it_final TO lt_response.



*
* TRY.
*        """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
**_Paging implementation
*        IF lv_top < 0  .
*          lv_top = lv_top * -1 .
*        ENDIF.
*        DATA(lv_start) = lv_skip + 1.
*        DATA(lv_end)   = lv_top + lv_skip.
*        APPEND LINES OF lt_response FROM lv_start TO lv_end TO lt_current_output.
*
*        io_response->set_total_number_of_records( lines( lt_current_output ) ).
*        io_response->set_data( lt_current_output ).
*
*      CATCH cx_root INTO DATA(lv_exception).
*        DATA(lv_exception_message) = cl_message_helper=>get_latest_t100_exception( lv_exception )->if_message~get_longtext( ).
*    ENDTRY.








*NEW zcl_adjust_entity(  )->adjust_via_request( EXPORTING io_request = io_request
*                                                                    flag       = 'X'
*                                                           CHANGING ct_data    = lt_response ).
*
*    IF io_request->is_total_numb_of_rec_requested(  ).
*      io_response->set_total_number_of_records( lines( lt_response ) ).
*      io_response->set_data( lt_response ).
*    ELSE.
*      io_response->set_total_number_of_records( lines( lt_response ) ).
*      io_response->set_data( lt_response ).
*   ENDIF.



 TRY.
          """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

          DATA(lv_offset) = io_request->get_paging( )->get_offset( ).
          DATA(lv_page_size) = io_request->get_paging( )->get_page_size( ).
          DATA(lv_max_rows) = COND #( WHEN lv_page_size = if_rap_query_paging=>page_size_unlimited
                                      THEN 0
                                      ELSE lv_page_size ).
          " sorting
          DATA(sort_elements) = io_request->get_sort_elements( ).
          DATA(lt_sort_criteria) = VALUE string_table(
              FOR sort_element IN sort_elements
              ( sort_element-element_name && COND #( WHEN sort_element-descending = abap_true
                                                     THEN ` descending`
                                                     ELSE ` ascending` ) ) ).

          DATA lv_sort_string TYPE string .
          lv_sort_string  = COND #( WHEN lt_sort_criteria IS INITIAL THEN '                                   '
                                                                              ELSE concat_lines_of( table = lt_sort_criteria sep = `, ` ) ).
          " requested elements
         DATA(lt_req_elements) = io_request->get_requested_elements( ).
*          " aggregate
          DATA(lt_aggr_element) = io_request->get_aggregation( )->get_aggregated_elements( ).

          IF lt_aggr_element IS NOT INITIAL.
            LOOP AT lt_aggr_element ASSIGNING FIELD-SYMBOL(<fs_aggr_element>).
              DELETE lt_req_elements WHERE table_line = <fs_aggr_element>-result_element.
              DATA(lv_aggregation) = |{ <fs_aggr_element>-aggregation_method }( { <fs_aggr_element>-input_element } ) as { <fs_aggr_element>-result_element }|.
              APPEND lv_aggregation TO lt_req_elements.
            ENDLOOP.
          ENDIF.
          DATA(lv_req_elements) = concat_lines_of( table = lt_req_elements
                                                   sep   = `, ` ).
          " grouping
          DATA(lt_grouped_element) = io_request->get_aggregation( )->get_grouped_elements( ).
          DATA(lv_grouping) = concat_lines_of( table = lt_grouped_element
                                               sep   = `, ` ).

          IF lv_sort_string IS INITIAL.
            IF lv_grouping IS NOT INITIAL .
              lv_sort_string = lv_grouping .
            ELSE .
              lv_sort_string  = lv_req_elements .
            ENDIF .
          ENDIF .

          SELECT (lv_req_elements) FROM @lt_response AS a
                                             "  WHERE (lt_clause)
                                                GROUP BY (lv_grouping)
                                                ORDER BY (lv_sort_string)
                                                INTO CORRESPONDING FIELDS OF TABLE @lt_current_output
                                                OFFSET @lv_offset
                                                 UP TO @lv_max_rows ROWS.





          IF io_request->is_total_numb_of_rec_requested(  ).
            io_response->set_total_number_of_records( lines( lt_response ) ).
          ENDIF.

          IF io_request->is_data_requested(  ).
            io_response->set_data( lt_current_output ).
          ENDIF.

        CATCH cx_root INTO DATA(lv_exception).

      ENDTRY.

ENDMETHOD.
ENDCLASS.
