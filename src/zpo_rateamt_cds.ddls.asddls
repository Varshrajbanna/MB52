

     
     @AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Zpo_Rateamt CDS'
@Metadata.ignorePropagatedAnnotations: true
define view entity Zpo_Rateamt_CDS as select from Zpo_Latest_CDS as a
inner join I_PurchaseOrderItemAPI01 as b on ( b.PurchaseOrder = a.PurchaseOrder )
{
    key a.Material ,
        b.DocumentCurrency,
        @Semantics.amount.currencyCode: 'DocumentCurrency'
      // sum (  b.NetPriceAmount   ) as NetPriceAmount
       
        sum( cast(  a.NetPriceAmount as abap.dec( 13, 2 )  ) )  as NetPriceAmount
}
where ( b.MaterialType = 'ZCAP' )
group by
    a.Material,
    b.DocumentCurrency
   
     
//

///@AbapCatalog.viewEnhancementCategory: [#NONE]
//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@EndUserText.label: 'Zpo_Rateamt CDS'
//@Metadata.ignorePropagatedAnnotations: true
//define view entity Zpo_Rateamt_CDS as select from Zpo_Latest_CDS as a
//inner join I_PurchaseOrderItemAPI01 as b on ( b.PurchaseOrder = a.PurchaseOrder )
//{
//    key a.Material ,
//    key    b.PurchaseOrderItem,
//        b.DocumentCurrency,
//        @Semantics.amount.currencyCode: 'DocumentCurrency'
//        sum (b.NetPriceAmount  )   as NetPriceAmount
//}
//where ( b.MaterialType = 'ZCAP' )
//group by
//    a.Material,
//    b.DocumentCurrency,
//  // b.NetPriceAmount,
//     b.PurchaseOrderItem
