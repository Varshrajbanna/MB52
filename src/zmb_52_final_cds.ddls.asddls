@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'MB 52 FINAL CDS'
@Metadata.ignorePropagatedAnnotations: true

@UI.headerInfo:{
typeName: 'MB52 REPORT',
typeNamePlural: 'MB52 REPORT',
title:{ value: '' },
description: { value: 'Product'  }
}
@UI.presentationVariant: [ {
//  sortOrder: [{ by: 'Material', direction: #DESC }],
  visualizations: [{ type: #AS_LINEITEM }]
} ]

define view entity ZMB_52_FINAL_CDS
  as select from ZMB_MB52_CDS

{

          @UI.lineItem       : [{ position: 1 }]
          @UI.selectionField : [{position: 5 }]
        // @Consumption.valueHelpDefinition: [ { entity: { name: 'I_PLANT', element: 'Plant' } } ]
        //  @Consumption.valueHelpDefinition: [ { entity: { name: 'ZI_MAINTAIN_PLANNING_PLANT', element: 'MaintenancePlanningPlant' } } ]

      @Consumption.valueHelpDefinition: [ { entity: { name: 'ZPLANT_F4_F4', element: 'Plant' } } ]

          @EndUserText.label : 'Plant'

  key     Plant,







            @Consumption.filter.hidden: true
          @UI.lineItem       : [{ position: 2 }]
          @Search.defaultSearchElement: true
          @EndUserText.label : 'Level 1 Description'
          @Consumption.valueHelpDefinition: [{entity: { name: 'zpRODUCTlevel1desc_f4', element: 'Level1'}  }]

          @UI.selectionField : [{position: 25 }]
  key     zlevel1,

     @Consumption.filter.hidden: true
          @UI.lineItem       : [{ position: 3 }]
          @EndUserText.label : 'Level 2 Description'
          @Consumption.valueHelpDefinition: [{entity: { name: 'Zprdctlevel2fdescf4', element: 'YY1_LEVEL2_F4_PRD'}  }]

          @UI.selectionField : [{position: 26 }]

  key     zdesc2,
 @Consumption.filter.hidden: true
          @UI.lineItem       : [{ position: 4 }]
          @EndUserText.label : 'Level 3 Description'
          @Consumption.valueHelpDefinition: [{entity: { name: 'Zlevel3desc', element: 'YY1_Level3_PRD'}  }]

          @UI.selectionField : [{position: 27 }]

  key     zdesc3,

          @UI.lineItem       : [{ position: 5 }]
          //  @Consumption.valueHelpDefinition: [ { entity: { name: 'I_StorageLocationStdVH', element: 'StorageLocation' }
          @Consumption.valueHelpDefinition: [ { entity: { name: 'ZSTOR_LOCTION_F4', element: 'StorageLocation' } } ]
          @EndUserText.label : 'Storage Location'

  key     StorageLocation,


          @Search.fuzzinessThreshold: 0.8
          @UI.lineItem       : [{ position: 6 }]
          @UI.identification : [{position: 10}]
          @EndUserText.label : 'Material'
          @UI.selectionField : [{position: 10 }]
           @Consumption.semanticObject    : 'Material'
          @Consumption.valueHelpDefinition: [
                 { entity         :  { name:    'zmat_f4',
                              element: 'Product' }
                 }]
  key     Product,



          @UI.lineItem       : [{ position: 7 }]
          @Consumption.filter.hidden: true
          @EndUserText.label : 'Material Description'
  key     ProductDes,
          //  @UI.lineItem       : [{ position: 7 }]
          //  @EndUserText.label : 'Material Description'
          //  //@UI.hidden: true
          //  key productdes : abap.char(80);

          @UI.lineItem       : [{ position: 8 }]
          @EndUserText.label : 'Storage Bin'
  key     StorageBin,
          @UI.lineItem       : [{ position: 9 }]
          @EndUserText.label : 'unit'
  key     cast ( Unit  as abap.unit( 3 ) )       as Unit,



          @UI.lineItem       : [{ position: 10 }]
          @EndUserText.label : 'Quantity'
          @Semantics.quantity.unitOfMeasure: 'Unit'
          @Aggregation.default:#SUM
  key     cast( Quantity  as abap.dec( 30, 3 ) ) as Quantity,


          @UI.lineItem       : [{ position: 11 }]
          @EndUserText.label : 'Rate '
          @Aggregation.default:#SUM

  key     Rate,



          @UI.lineItem       : [{ position: 12 }]
          @EndUserText.label : 'Amount_in_LC'
          @Semantics.amount.currencyCode: 'currency'
          @Aggregation.default      : #SUM
  key     Amountin_LC,
          @UI.lineItem       : [{ position: 13 }]
          @EndUserText.label : 'Cap Price'

          @Aggregation.default      : #SUM
  key     Zcap_Price,

          @UI.lineItem       : [{ position: 13 }]
          @EndUserText.label : 'Cap Value'
          @Aggregation.default      : #SUM
  key     Zcap_Value,

          @UI.lineItem       : [{ position: 14 }]
          @EndUserText.label : 'Batch'
          @Consumption.valueHelpDefinition: [ { entity: { name: 'Zbatch_f4', element: 'Batch' } } ]

  key     Batch,

          @UI.lineItem       : [{ position: 15 }]
          @EndUserText.label : 'Material Type'
          @UI.selectionField : [{position: 15 }]
          @Consumption.valueHelpDefinition: [
           { entity         :  { name:    'ZPRODUCT_TYPEF4_MB52',
                        element: 'ProductType' }
           }]
  key     ProductType,
          @UI.lineItem       : [{ position: 16 }]
          @Consumption.filter.hidden: true
          @EndUserText.label : 'Material Type Text'
  key     ProductTypeText,

          @UI.lineItem       : [{ position: 17 }]
          @Consumption.filter.hidden: true
          @EndUserText.label : 'DL_Flag'
  key     DL_Flag,

          @UI.lineItem       : [{ position: 18 }]
          @EndUserText.label : 'Material Group'
          @UI.selectionField : [{position: 20 }]
          @Consumption.valueHelpDefinition: [
           { entity         :  { name:    'zproductgrp',
                        element: 'ProductGroup' }
           }]
  key     ProductGroup,

          @Consumption.filter.hidden: true
          @UI.lineItem       : [{ position: 19 }]
          @EndUserText.label : 'Material Group Text'
  key     ProductGroupText,


          @Consumption.filter.hidden: true
          @UI.lineItem       : [{ position: 20 }]
          @EndUserText.label: 'Currency'
  key     Currency,

         // @Consumption.filter.hidden: true
          @Consumption.valueHelpDefinition: [{entity: { name: 'zpRODUCTlevel1desc_f4', element: 'Level1'}  }]
          @UI.selectionField : [{position: 25 }]
          @EndUserText.label: 'Level 1 Description'
          
          @UI.lineItem: [{
    position: 21,
    label: 'Level 1 Code'
}]
//          @UI.lineItem       : [{ position: 21 }]
//          @EndUserText.label : 'leve1 code'
  key     zlevel1_code,
         // @Consumption.filter.hidden: true
                   @Consumption.valueHelpDefinition: [{entity: { name: 'Zprdctlevel2fdescf4', element: 'YY1_LEVEL2_F4_PRD'}  }]
                   @UI.selectionField : [{position: 26 }]
                    @EndUserText.label: 'Level 2 Description'
         
        @UI.lineItem: [{
    position: 22,
    label: 'Level 2 Code'
}]
  key     zlevel2_code,
          //@Consumption.filter.hidden: true
           @Consumption.valueHelpDefinition: [{entity: { name: 'Zlevel3desc', element: 'YY1_Level3_PRD'}  }]
                    @UI.selectionField : [{position: 27 }]
                     @EndUserText.label: 'Level 3 Description'
          
          @UI.lineItem: [{
    position: 23,
    label: 'Level 3 Code'
}]
  key     zlevel3_code



}



//

//@AbapCatalog.viewEnhancementCategory: [#NONE]
//@AccessControl.authorizationCheck: #NOT_REQUIRED
//@EndUserText.label: 'MB 52 FINAL CDS'
//@Metadata.ignorePropagatedAnnotations: true
//
//@UI.headerInfo:{
//typeName: 'MB52 REPORT',
//typeNamePlural: 'MB52 REPORT',
//title:{ value: '' },
//description: { value: 'Product'  }
//}
//@UI.presentationVariant: [ {
////  sortOrder: [{ by: 'Material', direction: #DESC }],
//  visualizations: [{ type: #AS_LINEITEM }]
//} ]
//
//define view entity ZMB_52_FINAL_CDS
//  as select from ZMB_MB52_CDS
//
//{
//
//          @UI.lineItem       : [{ position: 1 }]
//          @UI.selectionField : [{position: 5 }]
//        // @Consumption.valueHelpDefinition: [ { entity: { name: 'I_PLANT', element: 'Plant' } } ]
//        //  @Consumption.valueHelpDefinition: [ { entity: { name: 'ZI_MAINTAIN_PLANNING_PLANT', element: 'MaintenancePlanningPlant' } } ]
//
//      @Consumption.valueHelpDefinition: [ { entity: { name: 'ZPLANT_F4_F4', element: 'Plant' } } ]
//
//          @EndUserText.label : 'Plant'
//
//  key     Plant,
//
//
//
//
//
//
//
//            @Consumption.filter.hidden: true
//          @UI.lineItem       : [{ position: 2 }]
//          @Search.defaultSearchElement: true
//          @EndUserText.label : 'Level 1 Description'
//          @Consumption.valueHelpDefinition: [{entity: { name: 'zpRODUCTlevel1desc_f4', element: 'Level1'}  }]
//
//          @UI.selectionField : [{position: 25 }]
//  key     zlevel1,
//
//     @Consumption.filter.hidden: true
//          @UI.lineItem       : [{ position: 3 }]
//          @EndUserText.label : 'Level 2 Description'
//          @Consumption.valueHelpDefinition: [{entity: { name: 'Zprdctlevel2fdescf4', element: 'YY1_LEVEL2_F4_PRD'}  }]
//
//          @UI.selectionField : [{position: 26 }]
//
//  key     zdesc2,
// @Consumption.filter.hidden: true
//          @UI.lineItem       : [{ position: 4 }]
//          @EndUserText.label : 'Level 3 Description'
//          @Consumption.valueHelpDefinition: [{entity: { name: 'Zlevel3desc', element: 'YY1_Level3_PRD'}  }]
//
//          @UI.selectionField : [{position: 27 }]
//
//  key     zdesc3,
//
//          @UI.lineItem       : [{ position: 5 }]
//          //  @Consumption.valueHelpDefinition: [ { entity: { name: 'I_StorageLocationStdVH', element: 'StorageLocation' }
//          @Consumption.valueHelpDefinition: [ { entity: { name: 'ZSTOR_LOCTION_F4', element: 'StorageLocation' } } ]
//          @EndUserText.label : 'Storage Location'
//
//  key     StorageLocation,
//
//
//          @Search.fuzzinessThreshold: 0.8
//          @UI.lineItem       : [{ position: 6 }]
//          @UI.identification : [{position: 10}]
//          @EndUserText.label : 'Material'
//          @UI.selectionField : [{position: 10 }]
//          @Consumption.valueHelpDefinition: [
//                 { entity         :  { name:    'zmat_f4',
//                              element: 'Product' }
//                 }]
//  key     Product,
//
//
//
//          @UI.lineItem       : [{ position: 7 }]
//          @Consumption.filter.hidden: true
//          @EndUserText.label : 'Material Description'
//  key     ProductDes,
//          //  @UI.lineItem       : [{ position: 7 }]
//          //  @EndUserText.label : 'Material Description'
//          //  //@UI.hidden: true
//          //  key productdes : abap.char(80);
//
//          @UI.lineItem       : [{ position: 8 }]
//          @EndUserText.label : 'Storage Bin'
//  key     StorageBin,
//          @UI.lineItem       : [{ position: 9 }]
//          @EndUserText.label : 'unit'
//  key     cast ( Unit  as abap.unit( 3 ) )       as Unit,
//
//
//
//          @UI.lineItem       : [{ position: 10 }]
//          @EndUserText.label : 'Quantity'
//          @Semantics.quantity.unitOfMeasure: 'Unit'
//          @Aggregation.default:#SUM
//  key     cast( Quantity  as abap.dec( 30, 3 ) ) as Quantity,
//
//
//          @UI.lineItem       : [{ position: 11 }]
//          @EndUserText.label : 'Rate '
//          @Aggregation.default:#SUM
//
//  key     Rate,
//
//
//
//          @UI.lineItem       : [{ position: 12 }]
//          @EndUserText.label : 'Amount_in_LC'
//          @Semantics.amount.currencyCode: 'currency'
//          @Aggregation.default      : #SUM
//  key     Amountin_LC,
//          @UI.lineItem       : [{ position: 13 }]
//          @EndUserText.label : 'Cap Price'
//
//          @Aggregation.default      : #SUM
//  key     Zcap_Price,
//
//          @UI.lineItem       : [{ position: 13 }]
//          @EndUserText.label : 'Cap Value'
//          @Aggregation.default      : #SUM
//  key     Zcap_Value,
//
//          @UI.lineItem       : [{ position: 14 }]
//          @EndUserText.label : 'Batch'
//          @Consumption.valueHelpDefinition: [ { entity: { name: 'Zbatch_f4', element: 'Batch' } } ]
//
//  key     Batch,
//
//          @UI.lineItem       : [{ position: 15 }]
//          @EndUserText.label : 'Material Type'
//          @UI.selectionField : [{position: 15 }]
//          @Consumption.valueHelpDefinition: [
//           { entity         :  { name:    'ZPRODUCT_TYPEF4_MB52',
//                        element: 'ProductType' }
//           }]
//  key     ProductType,
//          @UI.lineItem       : [{ position: 16 }]
//          @Consumption.filter.hidden: true
//          @EndUserText.label : 'Material Type Text'
//  key     ProductTypeText,
//
//          @UI.lineItem       : [{ position: 17 }]
//          @Consumption.filter.hidden: true
//          @EndUserText.label : 'DL_Flag'
//  key     DL_Flag,
//
//          @UI.lineItem       : [{ position: 18 }]
//          @EndUserText.label : 'Material Group'
//          @UI.selectionField : [{position: 20 }]
//          @Consumption.valueHelpDefinition: [
//           { entity         :  { name:    'zproductgrp',
//                        element: 'ProductGroup' }
//           }]
//  key     ProductGroup,
//
//          @Consumption.filter.hidden: true
//          @UI.lineItem       : [{ position: 19 }]
//          @EndUserText.label : 'Material Group Text'
//  key     ProductGroupText,
//
//
//          @Consumption.filter.hidden: true
//          @UI.lineItem       : [{ position: 20 }]
//          @EndUserText.label: 'Currency'
//  key     Currency,
//
//         // @Consumption.filter.hidden: true
//          @Consumption.valueHelpDefinition: [{entity: { name: 'zpRODUCTlevel1desc_f4', element: 'Level1'}  }]
//          @UI.selectionField : [{position: 25 }]
//          @EndUserText.label: 'Level 1 Description'
//          
//          @UI.lineItem: [{
//    position: 21,
//    label: 'Level 1 Code'
//}]
////          @UI.lineItem       : [{ position: 21 }]
////          @EndUserText.label : 'leve1 code'
//  key     zlevel1_code,
//         // @Consumption.filter.hidden: true
//                   @Consumption.valueHelpDefinition: [{entity: { name: 'Zprdctlevel2fdescf4', element: 'YY1_LEVEL2_F4_PRD'}  }]
//                   @UI.selectionField : [{position: 26 }]
//                    @EndUserText.label: 'Level 2 Description'
//         
//        @UI.lineItem: [{
//    position: 22,
//    label: 'Level 2 Code'
//}]
//  key     zlevel2_code,
//          //@Consumption.filter.hidden: true
//           @Consumption.valueHelpDefinition: [{entity: { name: 'Zlevel3desc', element: 'YY1_Level3_PRD'}  }]
//                    @UI.selectionField : [{position: 27 }]
//                     @EndUserText.label: 'Level 3 Description'
//          
//          @UI.lineItem: [{
//    position: 23,
//    label: 'Level 3 Code'
//}]
//  key     zlevel3_code
//
//
//
//}
