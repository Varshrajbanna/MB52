@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Product Type F4'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity ZPRODUCT_TYPEF4 as select from I_StockQuantityCurrentValue_2( P_DisplayCurrency:'INR' ) as a
inner join I_ProductTypeText as b on ( b.ProductType = a.ProductType and b.Language = 'E' ) 
{
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.8
    @EndUserText.label: 'Product Type'
    key a.ProductType,
    
     @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.8
    @EndUserText.label: 'Product Type Text'
     b.MaterialTypeName 
     
//     @Search.defaultSearchElement: true
//    @Search.fuzzinessThreshold: 0.8
    
}
where ( a.ValuationAreaType = '1' and a.InventoryStockType = '01' )
 and  a.ProductType <> 'ZFRT'  and   a.ProductType <> 'ZSFG' and   a.ProductType <> 'ZBYP'

group by
a.ProductType,
    b.MaterialTypeName

    
    
