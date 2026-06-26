@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Product Group F4'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true
define view entity zproductgrp
  as select from I_StockQuantityCurrentValue_2( P_DisplayCurrency:'INR' ) as a
    inner join   I_ProductGroupText_2                                     as b on(
      b.ProductGroup = a.ProductGroup
      and b.Language = 'E'
    )
{
  key a.ProductGroup,
      case
            when b.ProductGroupName is initial
            then b.ProductGroupText
            else
            b.ProductGroupName end as ProductGroupName
}
where ( a.ValuationAreaType = '1' and a.InventoryStockType = '01' )
group by
a.ProductGroup,
b.ProductGroupName,
b.ProductGroupText
