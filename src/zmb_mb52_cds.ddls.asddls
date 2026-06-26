
@EndUserText.label: 'Stock Base Data'
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.ignorePropagatedAnnotations: true

define view entity ZMB_MB52_CDS
  as select from I_StockQuantityCurrentValue_2
      ( P_DisplayCurrency : 'INR' )           as a

    inner join I_ProductDescription as b
        on  b.Product  = a.Product
        and b.Language = 'E'


    left outer join I_Product as prduct
        on prduct.Product = a.Product

    left outer join I_ProductGroupText_2 as e
        on  e.ProductGroup = a.ProductGroup
        and e.Language     = 'E'

    left outer join ZMATGRP_LEVELS as matgrp_levels
        on a.ProductGroup = matgrp_levels.zlevel1234

    left outer join zuser_01 as zcap
        on a.Product = lpad( zcap.zuser, 18, '0' )
        
//
    left outer join Zpo_Latest_CDS as vg
        on vg.Material = a.Product
//    left outer join Zpo_Rateamt as vg
//        on vg.Material = a.Product

    left outer join I_ProductStorageLocationBasic as pl
        on  pl.Plant           = a.Plant
        and pl.StorageLocation = a.StorageLocation
        and pl.Product         = a.Product

    left outer join I_ProductTypeText_2 as prdtype
        on  prdtype.ProductType = a.ProductType
        and prdtype.Language    = 'E'

{
    key a.Plant,
    key a.StorageLocation,
    key ltrim( a.Product, '0' )          as Product,
    key a.Batch,

    prduct.YY1_LEVEL1_DESC_PRD            as zlevel1,
    prduct.YY1_leveldesc_2_PRD            as zdesc2,
    prduct.YY1_level3_desc_PRD            as zdesc3,

    prduct.YY1_LEVEL1F4_PRD               as zlevel1_code,
    prduct.YY1_LEVEL2_F4_PRD              as zlevel2_code,
    prduct.YY1_Level3_PRD                 as zlevel3_code,

    b.ProductDescription                  as ProductDes,

    a.ProductGroup,
    e.ProductGroupName                    as ProductGroupText,

    a.ProductType,
    prdtype.ProductTypeName               as ProductTypeText,

    pl.WarehouseStorageBin                as StorageBin,
    a.MaterialBaseUnit,

   @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
    @Aggregation.default: #SUM
    a.MatlWrhsStkQtyInMatlBaseUnit       as Quantity,

    @Semantics.amount.currencyCode: 'Currency'
    @Aggregation.default: #SUM
    a.StockValueInDisplayCurrency         as Amountin_LC,
    pl.IsMarkedForDeletion as DL_Flag,

    @Aggregation.default: #FORMULA
//    cast(
//        case
//            when a.MatlWrhsStkQtyInMatlBaseUnit = 0
//            then 0
//            else
//              a.StockValueInDisplayCurrency /
//              a.MatlWrhsStkQtyInMatlBaseUnit
//        end
//        as abap.dec(20,2)
//    ) as Rate,

cast(
    case
        when a.MatlWrhsStkQtyInMatlBaseUnit = 0
        then 0
        else
            cast( a.StockValueInDisplayCurrency as abap.dec(23,2) )
            /
            cast( a.MatlWrhsStkQtyInMatlBaseUnit as abap.dec(23,3) )
    end
    as abap.dec(20,2)
) as Rate,


    @Aggregation.default: #SUM

    cast(
    case
        when zcap.zpass is not null and zcap.zpass <> ''
        then cast( zcap.zpass as abap.dec(20,2) )
        else vg.NetPriceAmount
    end
    as abap.dec(20,2)
) as Zcap_Price,

    @Aggregation.default: #SUM

  

cast(
    case
        when zcap.zpass is not null
             and zcap.zpass <> ''

        then
            cast( zcap.zpass as abap.dec(15,2) )
            *
            cast(
                a.MatlWrhsStkQtyInMatlBaseUnit
                as abap.dec(15,3)
            )

        else
            cast( vg.NetPriceAmount as abap.dec(15,2) )
            *
            cast(
                a.MatlWrhsStkQtyInMatlBaseUnit
                as abap.dec(15,3)
            )
    end
    as abap.dec(17,2)
) as Zcap_Value,

   
    a.Currency,

    case
        when a.MaterialBaseUnit = 'ST'
        then 'PC'
        else a.MaterialBaseUnit
    end as Unit
    
    

    
   

}
where

      a.ValuationAreaType = '1'
  and a.InventoryStockType = '01'

  and a.ProductType <> 'ZFRT'
  and a.ProductType <> 'ZSFG'
  and a.ProductType <> 'ZBYP'
  and a.ProductType <> 'ZROH'

  and a.MatlWrhsStkQtyInMatlBaseUnit > 0
//group by
//    a.Plant,
//    a.StorageLocation,
//    a.Product,
//    a.Batch,
//    prduct.YY1_LEVEL1_DESC_PRD,
//    prduct.YY1_leveldesc_2_PRD,
//    prduct.YY1_level3_desc_PRD,
//    prduct.YY1_LEVEL1F4_PRD,
//    prduct.YY1_LEVEL2_F4_PRD,
//    prduct.YY1_Level3_PRD,
//    b.ProductDescription,
//    a.ProductGroup,
//    e.ProductGroupName,
//    a.ProductType,
//    prdtype.ProductTypeName,
//    pl.WarehouseStorageBin,
//    a.MaterialBaseUnit,
//    a.MatlWrhsStkQtyInMatlBaseUnit,
//    a.StockValueInDisplayCurrency,
//    pl.IsMarkedForDeletion,
//    vg.NetPriceAmount,
//    zcap.zpass,
//    a.Currency

  
  
  
  
  
  
  
  ///
  
  
//@EndUserText.label: 'Stock Base Data'
//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@Metadata.ignorePropagatedAnnotations: true
//
//define view entity ZMB_MB52_CDS
//  as select from I_StockQuantityCurrentValue_2
//      ( P_DisplayCurrency : 'INR' )           as a
//
//    inner join I_ProductDescription as b
//        on  b.Product  = a.Product
//        and b.Language = 'E'
//
//    left outer join I_Product as prduct
//        on prduct.Product = a.Product
//
//    left outer join I_ProductGroupText_2 as e
//        on  e.ProductGroup = a.ProductGroup
//        and e.Language     = 'E'
//
//    left outer join ZMATGRP_LEVELS as matgrp_levels
//        on a.ProductGroup = matgrp_levels.zlevel1234
//
//    left outer join zuser_01 as zcap
//        on a.Product = lpad( zcap.zuser, 18, '0' )
//
//    left outer join Zpo_Latest_CDS as vg
//        on vg.Material = a.Product
//
//    left outer join I_ProductStorageLocationBasic as pl
//        on  pl.Plant           = a.Plant
//        and pl.StorageLocation = a.StorageLocation
//        and pl.Product         = a.Product
//
//    left outer join I_ProductTypeText_2 as prdtype
//        on  prdtype.ProductType = a.ProductType
//        and prdtype.Language    = 'E'
//
//{
//    key a.Plant,
//    key a.StorageLocation,
//    key ltrim( a.Product, '0' )          as Product,
//    key a.Batch,
//
//    prduct.YY1_LEVEL1_DESC_PRD            as zlevel1,
//    prduct.YY1_leveldesc_2_PRD            as zdesc2,
//    prduct.YY1_level3_desc_PRD            as zdesc3,
//
//    prduct.YY1_LEVEL1F4_PRD               as zlevel1_code,
//    prduct.YY1_LEVEL2_F4_PRD              as zlevel2_code,
//    prduct.YY1_Level3_PRD                 as zlevel3_code,
//
//    b.ProductDescription                  as ProductDes,
//
//    a.ProductGroup,
//    e.ProductGroupName                    as ProductGroupText,
//
//    a.ProductType,
//    prdtype.ProductTypeName               as ProductTypeText,
//
//    pl.WarehouseStorageBin                as StorageBin,
//    a.MaterialBaseUnit,
//
//   @Semantics.quantity.unitOfMeasure: 'MaterialBaseUnit'
//    @Aggregation.default: #SUM
//    a.MatlWrhsStkQtyInMatlBaseUnit       as Quantity,
//
//    @Semantics.amount.currencyCode: 'Currency'
//    @Aggregation.default: #SUM
//    a.StockValueInDisplayCurrency         as Amountin_LC,
//    pl.IsMarkedForDeletion as DL_Flag,
//
//    @Aggregation.default: #FORMULA
////    cast(
////        case
////            when a.MatlWrhsStkQtyInMatlBaseUnit = 0
////            then 0
////            else
////              a.StockValueInDisplayCurrency /
////              a.MatlWrhsStkQtyInMatlBaseUnit
////        end
////        as abap.dec(20,2)
////    ) as Rate,
//
//cast(
//    case
//        when a.MatlWrhsStkQtyInMatlBaseUnit = 0
//        then 0
//        else
//            cast( a.StockValueInDisplayCurrency as abap.dec(23,2) )
//            /
//            cast( a.MatlWrhsStkQtyInMatlBaseUnit as abap.dec(23,3) )
//    end
//    as abap.dec(20,2)
//) as Rate,
//
//
//    @Aggregation.default: #SUM
//
//    cast(
//    case
//        when zcap.zpass is not null and zcap.zpass <> ''
//        then cast( zcap.zpass as abap.dec(20,2) )
//        else vg.NetPriceAmount
//    end
//    as abap.dec(20,2)
//) as Zcap_Price,
//
//    @Aggregation.default: #SUM
//
//  
//
//cast(
//    case
//        when zcap.zpass is not null
//             and zcap.zpass <> ''
//
//        then
//            cast( zcap.zpass as abap.dec(15,2) )
//            *
//            cast(
//                a.MatlWrhsStkQtyInMatlBaseUnit
//                as abap.dec(15,3)
//            )
//
//        else
//            cast( vg.NetPriceAmount as abap.dec(15,2) )
//            *
//            cast(
//                a.MatlWrhsStkQtyInMatlBaseUnit
//                as abap.dec(15,3)
//            )
//    end
//    as abap.dec(17,2)
//) as Zcap_Value,
//
//   
//    a.Currency,
//
//    case
//        when a.MaterialBaseUnit = 'ST'
//        then 'PC'
//        else a.MaterialBaseUnit
//    end as Unit
//
//}
//where
//
//      a.ValuationAreaType = '1'
//  and a.InventoryStockType = '01'
//
//  and a.ProductType <> 'ZFRT'
//  and a.ProductType <> 'ZSFG'
//  and a.ProductType <> 'ZBYP'
//  and a.ProductType <> 'ZROH'
//
//  and a.MatlWrhsStkQtyInMatlBaseUnit > 0
  
