//@AbapCatalog.viewEnhancementCategory: [#NONE]
//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@EndUserText.label: 'GOODS MOVENT TYPE F4'
//@Metadata.ignorePropagatedAnnotations: true
//define view entity ZGOODS_MOVENT_TYPEF4 as select from data_source_name
//{
//    
//}




@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'GoodsRecepient'
@Search.searchable: true
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZGOODS_MOVENT_TYPEF4 as select distinct from   I_GoodsMovementTypeT
//I_MaterialDocumentItem_2
{
//@Search.defaultSearchElement: true
//    @Search.fuzzinessThreshold: 0.8
//key GoodsRecipientName,

@Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.8
  key GoodsMovementType,
  
  @Search.defaultSearchElement: true
    @Search.fuzzinessThreshold: 0.8
  key GoodsMovementTypeName
    
} //where GoodsRecipientName <> ''

where   GoodsMovementType is not initial
group by GoodsMovementType,
GoodsMovementTypeName
