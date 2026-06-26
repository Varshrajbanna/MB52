@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'PO LATEST CDS'
@Metadata.ignorePropagatedAnnotations: true
define view entity Zpo_Latest_CDS as select from I_PurchaseOrderItemAPI01 as a
left outer join Zpo_Latest  as B on (  B.PurchaseOrder = a.PurchaseOrder  and B.Material = a.Material )
{
    //key max( a.PurchaseOrder ) as PurchaseOrder,
      key   a.Material,
    ///  max( a.PurchaseOrder ) as PurchaseOrder,
    B.PurchaseOrder as PurchaseOrder,
        

    cast(  a.NetPriceAmount as abap.dec( 13, 2 )  )   as NetPriceAmount
}
where a.MaterialType = 'ZCAP'
      and B.PurchaseOrder <> ''



group by
    a.Material,
    a.NetPriceAmount,
    B.PurchaseOrder
   

    
    
// @AbapCatalog.viewEnhancementCategory: [#NONE]
//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@EndUserText.label: 'PO LATEST CDS'
//@Metadata.ignorePropagatedAnnotations: true
//define view entity Zpo_Latest_CDS as select from I_PurchaseOrderItemAPI01 as a
//{
//    key max( a.PurchaseOrder ) as PurchaseOrder,
//        a.Material,
//        
//
//     cast(  a.NetPriceAmount as abap.dec( 13, 2 )  ) as NetPriceAmount
//}
//where a.MaterialType = 'ZCAP'
//group by
//    a.Material,
//    a.NetPriceAmount
   

    
    
    
//    @AbapCatalog.viewEnhancementCategory: [#NONE]
//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@EndUserText.label: 'PO LATEST CDS'
//@Metadata.ignorePropagatedAnnotations: true
//define view entity Zpo_Latest_CDS as select from I_PurchaseOrderItemAPI01 as a
//{
//    key max( a.PurchaseOrder ) as PurchaseOrder,
//        a.Material
//}
//where a.MaterialType = 'ZCAP'
//group by
//    a.Material
//
