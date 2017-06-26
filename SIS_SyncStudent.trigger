trigger SIS_SyncStudent on Contact (after insert, after update,after delete) 
{
    try
    {
        List<Contact> conList = new List<Contact>();
        List<Contact> stuList = new List<Contact>();
        List<RecordType> stuRecordType = [SELECT Id FROM RecordType WHERE sObjectType = 'Contact' AND Name = 'Student' LIMIT 1];
        if(stuRecordType != null && stuRecordType.size() > 0 && Trigger.New != null && Trigger.New.size() > 0)
        {
        
            for(Contact con: Trigger.New)
            {
                if(con.RecordTypeId == stuRecordType[0].Id)
                {
                    conList.add(con);
                }
            }
           
            if( conList.size() > 0 && trigger.isInsert )
            {
                for(Contact c: conList)
                {
                    if(String.isBlank(c.Student__c))
                    {
                        stuList.add(c);
                    }
                }
            }
      
  
        }
        if(Trigger.isInsert && stuList.size() > 0 )
        {
           SIS_SyncStudentHDL.createStudent(stuList);
        }
        if(Trigger.isUpdate && conList.size() > 0)
        {
            SIS_SyncStudentHDL.updateStudent(conList);
        }
        if(Trigger.isDelete && Trigger.Old != null && Trigger.Old.size() > 0)
        {
            SIS_SyncStudentHDL.deleteStudent(Trigger.Old);
        }
    
    }
    catch(Exception e)
    {
        system.debug(e.getMessage()+'---'+e.getLineNumber());  
    } 
}