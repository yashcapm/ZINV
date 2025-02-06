@EndUserText.label: 'Projection View For Journal Entry'
@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity ZI_JOURNAL
  provider contract transactional_query
  as projection on ZR_JOURNAL
{

  key SalesOrder,
  key SalesOrderItem,
      Material,
      Plant,
      CustomerPriceGroup,
      MaterialByCustomer,
      PurchaseOrderByShipToParty,
      SoldToParty,
      @EndUserText.label: 'Date From'
      CreationDate,
      @EndUserText.label: 'Date To'
      CreatitoDate,
      /* Associations */
      _SalesOrder
}
