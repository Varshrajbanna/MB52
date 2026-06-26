@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'ORDER ID F4'
@Metadata.ignorePropagatedAnnotations: true
define view entity ZORDER_ID_F4 as select from ZMB51_REP as A
{
   
    @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.8
   key A.OrderID 
}

where A.OrderID is not initial 
