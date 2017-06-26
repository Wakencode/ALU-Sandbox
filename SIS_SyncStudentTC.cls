@isTest
public class SIS_SyncStudentTC
{

    Static testMethod void TestInsertStudent()
    {
       Test.startTest();   
       SIS_Student__c stdnt = test_utility.createstudent();
       insert stdnt;
       
       //verify that we get the correct result
       SIS_Student__c student = [select Last_Name__c,contact__c from SIS_Student__c where id =: stdnt.id];
       system.assertnotequals(student.contact__c,null);
       Test.StopTest();
    }
    /*Static testMethod void TestDeleteStudent()
    {
        Test.startTest();
        SIS_Student__c stdnt = TestDataFactory.CreateStudent();
        insert stdnt;

        //delete the student
        Database.DeleteResult res = Database.delete(stdnt,false);
        //verify that we get the correct result
        system.assert(res.isSuccess());
        Test.stopTest();
      
     }*/
    static testmethod void TestUpdateStudent()
    {
        
         
       SIS_Student__c stdnt = test_utility.createstudent();

       insert stdnt;
       
       Test.startTest(); 
       
       SIS_SyncContactHDL.run = true;
       SIS_Student__c std = [select Last_Name__c,Email__c,Action_for_ALN_Contact__c,(select email from Student__r) from SIS_Student__c where Id =: stdnt.Id ];
       std.email__c='gist@gmail.com';
       update std;  
       contact c = std.student__r;
       contact ct = [select email,Lastname from contact where id =: c.id];
       system.assertequals(ct.email,'gist@gmail.com');
       Test.stopTest();
    }
      
}