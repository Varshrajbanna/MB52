@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'I_StockQuantityCurrentValue_2'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZSTOCK_QTY_CDS_MB52 as select from I_StockQuantityCurrentValue_2 ( P_DisplayCurrency : 'INR' )            as A
{
   key  A.Plant,
   key A.StorageLocation,
   key A.Batch,
   key A.Product,
   A.ProductGroup,
   A.ProductType,
   A.Currency,
    A.MaterialBaseUnit,
    @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
  
   A.MatlWrhsStkQtyInMatlBaseUnit,
 
  cast( A.StockValueInDisplayCurrency as abap.dec( 13, 2 ) ) as StockValueInDisplayCurrency
    
}


 

