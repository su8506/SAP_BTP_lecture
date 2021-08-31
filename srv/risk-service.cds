using { sap.ui.riskmanagement as my } from '../db/schema';
 
@path: 'service/risk' //서비스명
service RiskService {
  /* 권한 없이 서비스 세팅
  entity Risks as projection on my.Risks;
    annotate Risks with @odata.draft.enabled; //odata.draft.enabled 초안 저장 기능
  entity Mitigations as projection on my.Mitigations;
    annotate Mitigations with @odata.draft.enabled;
  //entity BusinessPartners as projection on my.BusinessPartners; 
    */
    
    //권한 추가한 서비스 세팅
  entity Risks @(restrict : [
            {
                grant : [ 'READ' ],
                to : [ 'RiskViewer03' ]
            },
            {
                grant : [ '*' ],
                to : [ 'RiskManager03' ]
            }
        ]) as projection on my.Risks;
//### END OF INSERT
    annotate Risks with @odata.draft.enabled;
 
//### BEGIN OF INSERT
  entity Mitigations @(restrict : [
            {
                grant : [ 'READ' ],
                to : [ 'RiskViewer03' ]
            },
            {
                grant : [ '*' ],
                to : [ 'RiskManager03' ]
            }
        ]) as projection on my.Mitigations;
//### END OF INSERT
    annotate Mitigations with @odata.draft.enabled;


//view 생성 시 파라미터 사용 가능
  view riskmit as
    select A.ID, A.title, A.owner, B.description
    from my.Risks as A inner join my.Mitigations as B
    on A.miti_id = B.ID;
}