@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Journaal Item Basic View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity ZCM_JOURNALITEM as select from I_SalesOrderItem
association [1..1] to I_SalesOrder as _SalesOrder on $projection.SalesOrder = _SalesOrder.SalesOrder
                                                  and _SalesOrder.OverallSDProcessStatus <> 'C'
{
    key SalesOrder,
    key SalesOrderItem,
        Material,
        Plant,
        CustomerPriceGroup,
        MaterialByCustomer,
        PurchaseOrderByShipToParty,
        TransactionCurrency,
        OrderQuantityUnit,
         @Semantics.quantity.unitOfMeasure: 'OrderQuantityUnit'
        OrderQuantity,
        
        
        
//        OrderQuantity,
        @Semantics.amount.currencyCode: 'TransactionCurrency'
        NetAmount,
        _SalesOrder.SoldToParty,
        _SalesOrder.CreationDate,
        _SalesOrder.CreationDate as CreatitoDate,
        _SalesOrder.BillingCompanyCode as CompanyCode,
        'Text Id NUmber' as Text, 
        _SalesOrder.YY1_StudyID_SDH,
        
        
        
        
        _SalesOrder
        
}
