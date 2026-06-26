@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ZI_StorageLocation'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZI_StorageLocation as select from I_ProductStorageLocationBasic as a 
inner join I_StorageLocationStdVH as b on ( b.StorageLocation = a.StorageLocation and b.Plant = a.Plant  )
left outer join zstockqtysum as e on ( e.Product = a.Product and e.Plant = a.Plant and e.StorageLocation = a.StorageLocation  )
{
    key a.StorageLocation,
    key    a.Plant,
    key    ltrim( a.Product, '0' ) as Product,
        cast(e.MatlWrhsStkQtyInMatlBaseUnit as abap.dec( 17,3 )) as StockQty,
        b.StorageLocationName
} 
group by
a.StorageLocation,
b.StorageLocationName,
a.Plant,
    a.Product,
    e.MatlWrhsStkQtyInMatlBaseUnit
