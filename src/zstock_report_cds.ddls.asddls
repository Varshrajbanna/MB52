
@EndUserText.label: 'RESPONCE CDS'
@Metadata.allowExtensions: true
@ObjectModel: {
    query: {
        implementedBy: 'ABAP:ZSTOCK_REPORT_CLASS'
    }
}
@UI.headerInfo:{ 
typeName: 'MB52 REPORT',
typeNamePlural: 'MB52 REPORT',
title:{ value: '' },
description: { value: 'product'  }
}
@UI.presentationVariant: [ {
//  sortOrder: [{ by: 'Material', direction: #DESC }],
  visualizations: [{ type: #AS_LINEITEM }]    
} ] 
@Search.searchable: true
define custom entity ZSTOCK_REPORT_CDS

{

      @UI.lineItem       : [{ position: 1 }]
      @UI.selectionField : [{position: 5 }]
    // @Consumption.valueHelpDefinition: [ { entity: { name: 'I_PLANT', element: 'Plant' } } ]
           @Consumption.valueHelpDefinition: [ { entity: { name: 'ZI_MAINTAIN_PLANNING_PLANT', element: 'MaintenancePlanningPlant' } } ]
    
      @EndUserText.label : 'Plant'
  key   plant            : abap.char( 4 );
  
   @UI.lineItem       : [{ position: 2 }]
      @Search.defaultSearchElement: true
      @EndUserText.label : 'Level 1 Description'
           @Consumption.valueHelpDefinition: [{entity: { name: 'zpRODUCTlevel1desc_f4', element: 'Level1'}  }]
//                @Consumption.valueHelpDefinition: [{entity: { name: 'zpRODUCTlevel1_f4', element: 'Level1'}  }]
      
      @UI.selectionField : [{position: 25 }]
    key   zlevel1            : abap.char( 30 );
      
       @UI.lineItem       : [{ position: 3 }]
      @EndUserText.label : 'Level 2 Description'
           @Consumption.valueHelpDefinition: [{entity: { name: 'Zprdctlevel2fdescf4', element: 'YY1_LEVEL2_F4_PRD'}  }]
//              @Consumption.valueHelpDefinition: [{entity: { name: 'ZPRODUCTLEVEL_2', element: 'Level2'}  }]
      
            @UI.selectionField : [{position: 26 }]
      
  key     zdesc2              : abap.char( 30 );

      @UI.lineItem       : [{ position: 4 }]
      @EndUserText.label : 'Level 3 Description'
           @Consumption.valueHelpDefinition: [{entity: { name: 'Zlevel3desc', element: 'YY1_Level3_PRD'}  }]
//             @Consumption.valueHelpDefinition: [{entity: { name: 'ZPRODUCTLEVEL_3', element: 'Level3'}  }]
      
            @UI.selectionField : [{position: 27 }]
      
   key    zdesc3             : abap.char( 30 );
      
      @UI.lineItem       : [{ position: 5 }]
     //  @Consumption.valueHelpDefinition: [ { entity: { name: 'I_StorageLocationStdVH', element: 'StorageLocation' }
             @Consumption.valueHelpDefinition: [ { entity: { name: 'ZSTOR_LOCTION_F4', element: 'StorageLocation' } } ]
      @EndUserText.label : 'Storage Location'

  key storagelocation    : abap.char( 4 );
 
      
        @Search.fuzzinessThreshold: 0.8
      @UI.lineItem       : [{ position: 6 }]
      @UI.identification : [{position: 10}]
      @EndUserText.label : 'Material'
@UI.selectionField : [{position: 10 }]
 @Consumption.valueHelpDefinition: [
        { entity         :  { name:    'zmat_f4',
                     element: 'Product' }
        }]
  key product            : abap.char( 40 );
  
  
  
  @UI.lineItem       : [{ position: 7 }]
@Consumption.filter.hidden: true
@EndUserText.label : 'Material Description'
key productdes : abap.char(80);
//  @UI.lineItem       : [{ position: 7 }]
//  @EndUserText.label : 'Material Description'
//  //@UI.hidden: true
//  key productdes : abap.char(80); 
   
   @UI.lineItem       : [{ position: 8 }]
      @EndUserText.label : 'Storage Bin'
  key Storagebin : abap.char( 10 );
  
   @UI.lineItem       : [{ position: 9 }]
      @EndUserText.label : 'unit'
 key      unit : abap.unit(3);
  
//      
      @UI.lineItem       : [{ position: 10 }]
      @EndUserText.label : 'Quantity'
      @Semantics.quantity.unitOfMeasure: 'unit'
      @Aggregation.default:#SUM
 key    quantity           : abap.quan( 30, 3 );

      
         @UI.lineItem       : [{ position: 11 }]
      @EndUserText.label : 'Rate '
     @Aggregation.default:#SUM  
     
  key   rate : abap.dec( 20,2);
      
      
      
       @UI.lineItem       : [{ position: 12 }]
      @EndUserText.label : 'Amount_in_LC'
      @Semantics.amount.currencyCode: 'currency'
      @Aggregation.default      : #SUM
   key   Amountin_LC : abap.curr( 30,2);
      
       @UI.lineItem       : [{ position: 13 }]
      @EndUserText.label : 'Cap Price'
      
      @Aggregation.default      : #SUM
   key   Zcap_Price : abap.dec(30,2);
  
   @UI.lineItem       : [{ position: 13 }]
      @EndUserText.label : 'Cap Value'
      @Aggregation.default      : #SUM
  key   Zcap_Value : abap.dec(30,2);
      
      @UI.lineItem       : [{ position: 14 }]
      @EndUserText.label : 'Batch'
        @Consumption.valueHelpDefinition: [ { entity: { name: 'Zbatch_f4', element: 'Batch' } } ]
     
  key batch              : abap.char( 10 );
  
    @UI.lineItem       : [{ position: 15 }]
      @EndUserText.label : 'Material Type'
      @UI.selectionField : [{position: 15 }]
       @Consumption.valueHelpDefinition: [
        { entity         :  { name:    'ZPRODUCT_TYPEF4_MB52',
                     element: 'ProductType' }
        }]
   key  producttype        : abap.char( 10 );
  
  @UI.lineItem       : [{ position: 16 }]
  @Consumption.filter.hidden: true
      @EndUserText.label : 'Material Type Text'
 key producttypetext : abap.char(25);
      
       @UI.lineItem       : [{ position: 17 }]
       @Consumption.filter.hidden: true
      @EndUserText.label : 'DL_Flag'
   key    DL_Flag : abap.char(20);
      
      @UI.lineItem       : [{ position: 18 }]
      @EndUserText.label : 'Material Group'
      @UI.selectionField : [{position: 20 }]
       @Consumption.valueHelpDefinition: [
        { entity         :  { name:    'zproductgrp',
                     element: 'ProductGroup' }
        }]
   key    productgroup       : abap.char( 10 );
      
      @Consumption.filter.hidden: true
      @UI.lineItem       : [{ position: 19 }]
      @EndUserText.label : 'Material Group Text'
   key  productgrouptext       : abap.char( 10 );
  
  @Consumption.filter.hidden: true
       @UI.lineItem       : [{ position: 20 }]
      @EndUserText.label: 'Currency'
 key currency : abap.cuky( 5 );
 
 @Consumption.filter.hidden: true
 
  @UI.lineItem       : [{ position: 21 }]
      @EndUserText.label : 'leve1 code'
  key zlevel1_code              : abap.char( 10 );
  @Consumption.filter.hidden: true
  @UI.lineItem       : [{ position: 22 }]
      @EndUserText.label : 'level2 code'
  key zlevel2_code              : abap.char( 10 );
  @Consumption.filter.hidden: true
  @UI.lineItem       : [{ position: 23 }]
      @EndUserText.label : 'level3 code'
  key zlevel3_code              : abap.char( 10 );
  
 
  
 
  
          
}





























//
//@EndUserText.label: 'RESPONCE CDS'
//@Metadata.allowExtensions: true
//@ObjectModel: {
//    query: {
//        implementedBy: 'ABAP:ZSTOCK_REPORT_CLASS'
//    }
//}
//
//@UI.headerInfo:{ 
//typeName: 'MB52 REPORT',
//typeNamePlural: 'MB52 REPORT',
//title:{ value: '' },
//description: { value: 'product'  }
//}
//@UI.presentationVariant: [ {
////  sortOrder: [{ by: 'Material', direction: #DESC }],
//  visualizations: [{ type: #AS_LINEITEM }]    
//} ] 
//
//@Search.searchable: true
//define custom entity ZSTOCK_REPORT_CDS
//
//{
//
//      @UI.lineItem       : [{ position: 1 }]
//      @UI.selectionField : [{position: 5 }]
//    // @Consumption.valueHelpDefinition: [ { entity: { name: 'I_PLANT', element: 'Plant' } } ]
//           @Consumption.valueHelpDefinition: [ { entity: { name: 'ZI_MAINTAIN_PLANNING_PLANT', element: 'MaintenancePlanningPlant' } } ]
//    
//      @EndUserText.label : 'Plant'
//  key   plant            : abap.char( 4 );
//  
//
//
//   
//  
//   @UI.lineItem       : [{ position: 2 }]
//     @Search.defaultSearchElement: true
//      @EndUserText.label : 'Level 1 Description'
//           @Consumption.valueHelpDefinition: [{entity: { name: 'zpRODUCTlevel1desc_f4', element: 'Level1'}  }]
////                @Consumption.valueHelpDefinition: [{entity: { name: 'zpRODUCTlevel1_f4', element: 'Level1'}  }]
//      
//      @UI.selectionField : [{position: 25 }]
//    key   zlevel1            : abap.char( 30 );
//      
//       @UI.lineItem       : [{ position: 3 }]
//      @EndUserText.label : 'Level 2 Description'
//           @Consumption.valueHelpDefinition: [{entity: { name: 'Zprdctlevel2fdescf4', element: 'YY1_LEVEL2_F4_PRD'}  }]
////              @Consumption.valueHelpDefinition: [{entity: { name: 'ZPRODUCTLEVEL_2', element: 'Level2'}  }]
//      
//            @UI.selectionField : [{position: 26 }]
//      
//  key     zdesc2              : abap.char( 30 );
//
//      @UI.lineItem       : [{ position: 4 }]
//      @EndUserText.label : 'Level 3 Description'
//           @Consumption.valueHelpDefinition: [{entity: { name: 'Zlevel3desc', element: 'YY1_Level3_PRD'}  }]
////             @Consumption.valueHelpDefinition: [{entity: { name: 'ZPRODUCTLEVEL_3', element: 'Level3'}  }]
//      
//            @UI.selectionField : [{position: 27 }]
//      
//   key    zdesc3             : abap.char( 30 );
//      
//      @UI.lineItem       : [{ position: 5 }]
//     //  @Consumption.valueHelpDefinition: [ { entity: { name: 'I_StorageLocationStdVH', element: 'StorageLocation' }
//             @Consumption.valueHelpDefinition: [ { entity: { name: 'ZSTOR_LOCTION_F4', element: 'StorageLocation' } } ]
//      @EndUserText.label : 'Storage Location'
//
//  key storagelocation    : abap.char( 4 );
// 
//      
//        @Search.fuzzinessThreshold: 0.8
//      @UI.lineItem       : [{ position: 6 }]
//      @UI.identification : [{position: 10}]
//      @EndUserText.label : 'Material'
//@UI.selectionField : [{position: 10 }]
// @Consumption.valueHelpDefinition: [
//        { entity         :  { name:    'zmat_f4',
//                     element: 'Product' }
//        }]
//  key product            : abap.char( 40 );
//  
//  
//  
//  @UI.lineItem       : [{ position: 7 }]
//@Consumption.filter.hidden: true
//@EndUserText.label : 'Material Description'
//key productdes : abap.char(80);
////  @UI.lineItem       : [{ position: 7 }]
////  @EndUserText.label : 'Material Description'
////  //@UI.hidden: true
////  key productdes : abap.char(80); 
//   
//   @UI.lineItem       : [{ position: 8 }]
//      @EndUserText.label : 'Storage Bin'
//  key Storagebin : abap.char( 10 );
//  
//   @UI.lineItem       : [{ position: 9 }]
//      @EndUserText.label : 'unit'
// key      unit : abap.unit(3);
//  
////      
//      @UI.lineItem       : [{ position: 10 }]
//      @EndUserText.label : 'Quantity'
//      @Semantics.quantity.unitOfMeasure: 'unit'
//     @Aggregation.default:#SUM
// key    quantity           : abap.quan( 30, 3 );
//
//      
//         @UI.lineItem       : [{ position: 11 }]
//      @EndUserText.label : 'Rate '
//     @Aggregation.default:#SUM  
//     
//  key   rate : abap.dec( 20,2);
//      
//      
//      
//       @UI.lineItem       : [{ position: 12 }]
//      @EndUserText.label : 'Amount_in_LC'
//      @Semantics.amount.currencyCode: 'currency'
//      @Aggregation.default      : #SUM
//   key   Amountin_LC : abap.curr( 30,2);
//      
//       @UI.lineItem       : [{ position: 13 }]
//      @EndUserText.label : 'Cap Price'
//      @Aggregation.default      : #SUM
//   key   Zcap_Price : abap.dec(31,2);
//  
//   @UI.lineItem       : [{ position: 13 }]
//      @EndUserText.label : 'Cap Value'
//      @Aggregation.default      : #SUM
//  key   Zcap_Value : abap.dec(31,2);
//      
//      @UI.lineItem       : [{ position: 14 }]
//      @EndUserText.label : 'Batch'
//        @Consumption.valueHelpDefinition: [ { entity: { name: 'Zbatch_f4', element: 'Batch' } } ]
//     
//  key batch              : abap.char( 10 );
//  
//    @UI.lineItem       : [{ position: 15 }]
//      @EndUserText.label : 'Material Type'
//      @UI.selectionField : [{position: 15 }]
//       @Consumption.valueHelpDefinition: [
//        { entity         :  { name:    'ZPRODUCT_TYPEF4_MB52',
//                     element: 'ProductType' }
//        }]
//   key  producttype        : abap.char( 10 );
//  
//  @UI.lineItem       : [{ position: 16 }]
//  @Consumption.filter.hidden: true
//      @EndUserText.label : 'Material Type Text'
// key producttypetext : abap.char(25);
//      
//       @UI.lineItem       : [{ position: 17 }]
//       @Consumption.filter.hidden: true
//      @EndUserText.label : 'DL_Flag'
//   key    DL_Flag : abap.char(20);
//      
//      @UI.lineItem       : [{ position: 18 }]
//      @EndUserText.label : 'Material Group'
//      @UI.selectionField : [{position: 20 }]
//       @Consumption.valueHelpDefinition: [
//        { entity         :  { name:    'zproductgrp',
//                     element: 'ProductGroup' }
//        }]
//   key    productgroup       : abap.char( 10 );
//      
//      @Consumption.filter.hidden: true
//      @UI.lineItem       : [{ position: 19 }]
//      @EndUserText.label : 'Material Group Text'
//   key  productgrouptext       : abap.char( 10 );
//  
//  @Consumption.filter.hidden: true
//       @UI.lineItem       : [{ position: 20 }]
//      @EndUserText.label: 'Currency'
// key currency : abap.cuky( 5 );
// 
// @Consumption.filter.hidden: true
// 
//  @UI.lineItem       : [{ position: 21 }]
//      @EndUserText.label : 'leve1 code'
//  key zlevel1_code              : abap.char( 10 );
//  @Consumption.filter.hidden: true
//  @UI.lineItem       : [{ position: 22 }]
//      @EndUserText.label : 'level2 code'
//  key zlevel2_code              : abap.char( 10 );
//  @Consumption.filter.hidden: true
//  @UI.lineItem       : [{ position: 23 }]
//      @EndUserText.label : 'level3 code'
//  key zlevel3_code              : abap.char( 10 );
//  
// 
//  
// 
//  
//          
//}













