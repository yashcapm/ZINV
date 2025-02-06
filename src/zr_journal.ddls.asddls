@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Root View For Journal Entry'
define root view entity ZR_JOURNAL
  as select from ZCM_JOURNALITEM
{
  key SalesOrder,
  key SalesOrderItem,
      Material,
      Plant,
      CustomerPriceGroup,
      MaterialByCustomer,
      PurchaseOrderByShipToParty,
      SoldToParty,
      CreationDate,
      CreatitoDate,
      /* Associations */
      _SalesOrder



}
