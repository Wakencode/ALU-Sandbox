trigger SIS_SyncContact on SIS_Student__c (after insert, after update) 
{
    if(SIS_SyncContactHDL.runOnce())
    {       
        try
        {
            List<SIS_Student__c> stuList = new List<SIS_Student__c>();
            
            if(Trigger.isInsert)
            {
                for(SIS_Student__c c: Trigger.New)
                {
                    if(String.isBlank(c.contact__c))
                    {
                        stuList.add(c);
                    }
                }
                SIS_SyncContactHDL.createContact(stuList);
            }
            if(Trigger.isUpdate)
            {
                SIS_SyncContactHDL.updateContact(Trigger.New);
            }
            /*if(Trigger.isDelete)
            {
                SIS_SyncContactHDL.deleteContact(Trigger.Old);
            } */   
        }
        catch(Exception e)
        {
            system.debug(e.getMessage()+'---'+e.getLineNumber());  
        }
    }
}