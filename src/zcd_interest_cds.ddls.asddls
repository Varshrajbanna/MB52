@Search.searchable: true
@EndUserText.label: 'RESPONCE CDS'
@Metadata.allowExtensions: true
@ObjectModel: {
    query: {
        implementedBy: 'ABAP:ZCD_INTEREST_CLASS'
    }
}
define root custom entity ZCD_INTEREST_CDS
{

      @UI.lineItem  : [{ position: 10 }]
      @UI.selectionField         : [{position: 5 }]
      //      @UI.identification   : [{position: 10}]
      //      @Search.defaultSearchElement: true
      @EndUserText.label         : 'Company Code'
  key companycode   : abap.char( 10 );

      @UI.lineItem  : [{ position: 20 }]
      //      @UI.selectionField   : [{position: 10}]
      //      @UI.identification   : [{position: 10}]
      @Search.defaultSearchElement: true
      @EndUserText.label         : 'Customer Code'
  key customer_code : abap.char( 4 );

      @UI.lineItem  : [{ position: 30 }]
      //      @UI.selectionField   : [{position: 10}]
      //      @UI.identification   : [{position: 10}]
      @Search.defaultSearchElement: true
      @EndUserText.label         : 'Bill Amt'
      bill_amt      : abap.dec( 13,2 );


}
