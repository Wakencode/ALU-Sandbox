public class SIS_OtherContactsComponent 
{
    public String recordType{get;set;}
    public String ocId{get;set;}
    public String formTitle{get;set;}
    public String rType{get;set;}
    public SIS_Other_Contact__c otherCon{get;set;}
    
    public SIS_OtherContactsComponent()
    {
        otherCon = new SIS_Other_Contact__c();
    }
    
    public String getDomId()
    {
        if(String.isNotBlank(recordType))
        {
            if(recordType == 'Emergency Contact')
            {
                return '-EC';
            }
            else
            {
                return '-PG';
            }
        }
        else if(String.isNotBlank(rType))
        {
            if(rType == 'Emergency Contact')
            {
                return '-EC';
            }
            else
            {
                return '-PG';
            }
        }
        else
        {
            return '';
        }
    }

    public List<SIS_Other_Contact__c> getOcList()
    {
        if(String.isNotBlank(recordType))
        {
            Cookie coo = Apexpages.currentPage().getCookies().get('con');
            system.debug(coo+'---'+coo.getValue());
            if(coo != null)
            {
                return [SELECT Id,Name,Student__c,Phone_Number__c,Alternate_Phone_Number__c,Email_Address__c,Street_Address__c,City__c,Province_or_State__c,Country__c,Zip_Code__c,Relation_to_me__c
                        FROM   SIS_Other_Contact__c
                        WHERE  RecordType.Name =: recordType
                        AND    Student__c =: coo.getValue()
                        LIMIT  2];
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
    
    public String getbuttonText()
    {
        if(String.isNotBlank(recordType))
        {
            return recordType.toLowerCase();
        }
        else
        {
            return null;
        }
    }

    @RemoteAction
    public static String saveOtherContact(SIS_Other_Contact__c oc, String studentId, String recType)
    {
        try
        {
            List<RecordType> rcType = [SELECT Id FROM RecordType WHERE sObjectType='SIS_Other_Contact__c' AND Name =: recType LIMIT 1];
            if(rcType != null && rcType.size() > 0)
            {
                oc.RecordTypeId = rcType[0].Id;
                upsert oc;
                return 'Success';
            }
            else
            {
                return 'ERROR while trying to create '+recType+' contact - Record Type Not Found';
            }
        }
        catch(Exception e)
        {
            system.debug(e.getMessage()+'--'+e.getLineNumber());
            return 'ERROR while trying to create '+recType+' contact - '+e.getMessage();
        }
    }
    
    @RemoteAction
    public static Object editOtherContact(String studentId, String recType)
    {
        try
        {
            if(String.isNotBlank(studentId))
            {
                List<SIS_Other_Contact__c> oc = [SELECT Id,Name,Phone_Number__c,Alternate_Phone_Number__c,Email_Address__c,Street_Address__c,City__c,Province_or_State__c,Country__c,
                                                        Zip_Code__c,Relation_to_me__c
                                                 FROM   SIS_Other_Contact__c
                                                 WHERE  Id =: studentId
                                                 LIMIT  1];
                if(oc != null && oc.size() > 0)
                {
                    return oc[0];
                }
                else
                {
                    return 'ERROR while trying to edit '+recType+' contact - Record Not Found';
                }
            }
            else
            {
                return 'ERROR while trying to edit '+recType+' contact - Record ID Not Found.';
            }
        }
        catch(Exception e)
        {
            system.debug(e.getMessage()+'--'+e.getLineNumber());
            return 'ERROR while trying to edit '+recType+' contact - '+e.getMessage();
        }
    }
    
    @RemoteAction
    public static String deleteOtherContact(String recordId)
    {
        try
        {
            if(String.isNotBlank(recordId))
            {
                delete new SIS_Other_Contact__c(Id=recordId);
                return 'Successfully deleted';
            }
            else
            {
                return 'ERROR while trying to delete other contact - Record ID Not Found.';
            }
        }
        catch(Exception e)
        {
            system.debug(e.getMessage()+'--'+e.getLineNumber());
            return 'ERROR while trying to delete other contact - '+e.getMessage();
        }
    }
}