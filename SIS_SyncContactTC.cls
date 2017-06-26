@isTest
public class SIS_SyncContactTC{
    Static  testMethod void TestInsertContact(){
        //create a contact
        List<RecordType> stuRecordType = [SELECT Id FROM RecordType WHERE sObjectType = 'Contact' AND Name = 'Student' LIMIT 1];
        if(stuRecordType != null && stuRecordType.size() > 0)
        {
            Test.startTest();
            contact c = test_utility.createcontact(stuRecordType[0].id);
             //Contact c = new Contact(LastName ='testname',Email ='it@gmail.com', Student__c = null, RecordTypeId = stuRecordType[0].id);
            insert c;
            //verify that we get the correct result
            Contact  con = [Select Student__c from Contact where Id =: c.Id ];
            system.assertnotequals(con.Student__c,null);
            Test.stopTest();
        }
    }
    
     Static  testMethod void TestDeleteContact(){
     
         //first creating a contact then delete the contact
         List<RecordType> stuRecordType = [SELECT Id FROM RecordType WHERE sObjectType = 'Contact' AND Name = 'Student' LIMIT 1];
        if(stuRecordType != null && stuRecordType.size() > 0)
        {
            Test.startTest();
            contact c = test_utility.createcontact(stuRecordType[0].id);
            insert c;
            
           Database.DeleteResult result = Database.delete(c,false);
           //Contact c = new Contact(LastName ='testname',Email ='it@gmail.com', Student__c = null, RecordTypeId = stuRecordType[0].id);
          // verify that we get the correct result
           system.assert(result.isSuccess());
           Test.stopTest();
        }
     
     } 
     
     
     
     /*static testmethod void testcatchmethod(){
         List<RecordType> stuRecordType = [SELECT Id FROM RecordType WHERE sObjectType = 'Contact' AND Name = 'Student' LIMIT 1];
        if(stuRecordType != null && stuRecordType.size() > 0)
        {
         Test.startTest();
         contact c = TestDataFactory.createcontact(stuRecordType[0].id);
         insert c;
         Database.DeleteResult result = Database.delete(c,false);
         contact cnt = [select LastName,Email from contact where id  =: c.id ];
         
         cnt.email ='ag@gmail.com';
         update cnt;
         test.stoptest();
         }
       
     }*/
}