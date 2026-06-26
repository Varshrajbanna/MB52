


CLASS zcl_adjust_entity_01 DEFINITION
  PUBLIC
  FINAL
  CREATE PUBLIC .

  PUBLIC SECTION.

    METHODS adjust_via_request
      IMPORTING
        io_request TYPE REF TO if_rap_query_request
        flag       TYPE abap_boolean
      CHANGING
        ct_data    TYPE STANDARD TABLE.

    METHODS filter_data
      IMPORTING
        it_filter TYPE if_rap_query_filter=>tt_name_range_pairs
      CHANGING
        ct_data   TYPE STANDARD TABLE.

    METHODS order_data
      IMPORTING
        it_sort TYPE if_rap_query_request=>tt_sort_elements
      CHANGING
        ct_data TYPE STANDARD TABLE.

    METHODS page_data
      IMPORTING
        id_offset    TYPE int8
        id_page_size TYPE int8
      CHANGING
        ct_data      TYPE STANDARD TABLE.

    METHODS calculate_total
      CHANGING
        ct_data TYPE STANDARD TABLE.

ENDCLASS.



CLASS ZCL_ADJUST_ENTITY_01 IMPLEMENTATION.


METHOD adjust_via_request.

  DATA lt_sort      TYPE if_rap_query_request=>tt_sort_elements.
  DATA lt_filter    TYPE if_rap_query_filter=>tt_name_range_pairs.
  DATA ld_offset    TYPE int8.
  DATA ld_page_size TYPE int8.



  lt_sort = io_request->get_sort_elements( ).

* Get paging
  ld_offset    = io_request->get_paging( )->get_offset( ).
  ld_page_size = io_request->get_paging( )->get_page_size( ).

  IF ld_page_size = -1.
    ld_page_size = lines( ct_data ).
  ENDIF.



  TRY.
      lt_filter = io_request->get_filter( )->get_as_ranges( ).
    CATCH cx_rap_query_filter_no_range.
      CLEAR lt_filter.
  ENDTRY.



  IF flag IS INITIAL.

    filter_data(
      EXPORTING
        it_filter = lt_filter
      CHANGING
        ct_data   = ct_data ).

  ENDIF.



  order_data(
    EXPORTING
      it_sort = lt_sort
    CHANGING
      ct_data = ct_data ).


  calculate_total(
    CHANGING
      ct_data = ct_data ).



  page_data(
    EXPORTING
      id_offset    = ld_offset
      id_page_size = ld_page_size
    CHANGING
      ct_data      = ct_data ).

ENDMETHOD.


METHOD filter_data.

  LOOP AT it_filter INTO DATA(ls_filter).

    LOOP AT ct_data ASSIGNING FIELD-SYMBOL(<ls_data>).

      DATA(ld_index) = sy-tabix.

      ASSIGN COMPONENT ls_filter-name
        OF STRUCTURE <ls_data>
        TO FIELD-SYMBOL(<ld_field>).

      IF sy-subrc <> 0.
        CONTINUE.
      ENDIF.

      IF <ld_field> NOT IN ls_filter-range.

        DELETE ct_data INDEX ld_index.

      ENDIF.

    ENDLOOP.

  ENDLOOP.

ENDMETHOD.


METHOD order_data.

  DATA lt_sort TYPE abap_sortorder_tab.

  lt_sort =
    CORRESPONDING abap_sortorder_tab(
      it_sort
      MAPPING name = element_name ).

  SORT ct_data BY (lt_sort).

ENDMETHOD.


METHOD calculate_total.

  DATA lv_total_qty TYPE p LENGTH 16 DECIMALS 3.

  FIELD-SYMBOLS:
    <ls_data> TYPE any,
    <lv_qty>  TYPE any,
    <lv_text> TYPE any.



  LOOP AT ct_data ASSIGNING <ls_data>.

    ASSIGN COMPONENT 'QUANTITY'
      OF STRUCTURE <ls_data>
      TO <lv_qty>.

    IF sy-subrc = 0.

      lv_total_qty =
        lv_total_qty + <lv_qty>.

    ENDIF.

  ENDLOOP.



  DATA lr_line TYPE REF TO data.

  CREATE DATA lr_line LIKE LINE OF ct_data.

  ASSIGN lr_line->* TO <ls_data>.



  ASSIGN COMPONENT 'MATERIAL_DESCRIPTION'
    OF STRUCTURE <ls_data>
    TO <lv_text>.

  IF sy-subrc = 0.

    <lv_text> = 'TOTAL'.

  ENDIF.



  ASSIGN COMPONENT 'QUANTITY'
    OF STRUCTURE <ls_data>
    TO <lv_qty>.

  IF sy-subrc = 0.

    <lv_qty> = lv_total_qty.

  ENDIF.

  APPEND <ls_data> TO ct_data.

ENDMETHOD.


METHOD page_data.

  DATA lr_data TYPE REF TO data.

  DATA ld_from TYPE i.
  DATA ld_to   TYPE i.
  DATA ld_total TYPE i.

  FIELD-SYMBOLS:
    <lt_result> TYPE STANDARD TABLE,
    <ls_result> TYPE any.

  ld_total = lines( ct_data ).

  CREATE DATA lr_data LIKE ct_data.

  ASSIGN lr_data->* TO <lt_result>.



  IF id_offset IS NOT INITIAL.

    ld_from = id_offset + 1.

  ELSE.

    ld_from = 1.

  ENDIF.



  IF id_page_size IS NOT INITIAL.

    ld_to = ld_from + id_page_size - 1.

  ELSE.

    ld_to = ld_total.

  ENDIF.



  IF ld_to > ld_total.

    ld_to = ld_total.

  ENDIF.



  LOOP AT ct_data ASSIGNING <ls_result>
       FROM ld_from TO ld_to.

    INSERT <ls_result> INTO TABLE <lt_result>.

  ENDLOOP.

  ct_data = <lt_result>.

ENDMETHOD.
ENDCLASS.
