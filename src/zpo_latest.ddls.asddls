@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Purchase Order Latest'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity Zpo_Latest as select from I_PurchaseOrderItemAPI01 as a
{
    key max( a.PurchaseOrder ) as PurchaseOrder,
        a.Material
}
group by
    a.Material
