@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Journal TMG'
@Metadata.allowExtensions: true
define root view entity ZR_JOURNAL_TMG as select from ztt_journalitem

{
  key fdate as Fdate ,
  key tdate as Tdate, 
      text
}
