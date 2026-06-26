@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Order Rate Amount'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity Zpo_Rateamt as select from Zpo_Latest as a
inner join I_PurchaseOrderItemAPI01 as b on ( b.PurchaseOrder = a.PurchaseOrder )
{
    key a.Material ,
        b.DocumentCurrency,
        @Semantics.amount.currencyCode: 'DocumentCurrency'
        sum( b.NetPriceAmount ) as NetPriceAmount
}
where ( b.MaterialType = 'ZCAP' )
group by
    a.Material,
    b.DocumentCurrency
