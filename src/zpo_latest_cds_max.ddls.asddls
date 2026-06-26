@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PO MAX'
@Metadata.ignorePropagatedAnnotations: true
define view entity Zpo_Latest_CDS_MAX as select from Zpo_Latest_CDS 
{
    key Material,
  max(  PurchaseOrder ) as PurchaseOrder,
    
    NetPriceAmount 
}
group by
    Material,
    NetPriceAmount
