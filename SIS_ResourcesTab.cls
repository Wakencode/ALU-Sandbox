public class SIS_ResourcesTab 
{
    public Map<String, List<SIS_Policy__c>> getPolicyMap()
    {
        Cookie coo = Apexpages.currentPage().getCookies().get('con');
        if(coo != null)
        {
            List<SIS_Policy__c> policies = SIS_QueryUtility.getPolicies(coo.getValue());
            system.debug(policies);
            if(policies != null && policies.size() > 0)
            {
                Map<String, List<SIS_Policy__c>> policyMap = new Map<String, List<SIS_Policy__c>>();
                for(SIS_Policy__c p: policies)
                {
                    if(!policyMap.containsKey(p.Category__c))
                    {
                        policyMap.put(p.Category__c, new List<SIS_Policy__c>());
                    }
                    policyMap.get(p.Category__c).add(p);
                }
                system.debug(policyMap);
                return policyMap;
            }
            else
            {
                return null;
            }
        }
        else
        {
            return null;
        }
    }
}