public class SIS_QueryUtility
{
    public static List<SIS_Student__c> getStudents(Set<Id> studentIds)
    {
        if(studentIds != null)
        {
         
            return [SELECT Id,Account__c,Action_for_ALN_Contact__c,ALN_Award_Category__c,Contact__c, 
                            ALN_Award_Year__c,ALN_Contact_Status__c,ALU_Events_Attended__c,Applicant_Last_Active_Date__c,Applicant_Time_Zone__c,Application_Stage__c,
                            Applied_for_financial_Aid__c,AssistantName__c,AssistantPhone__c,Birthdate__c,Campus_Preference__c,Campus_Preference__r.Name,Cohort__c,Contact_Address__c,Twitter_Contact__c,
                            Country_of_Residence__c,Department__c,Description__c,DoNotCall__c,Email__c,Email_2__c,Email_3__c,HasOptedOutOfEmail__c,Student_Status__c,Excel_ID__c,Fax__c,
                            HasOptedOutOfFax__c,First_Name__c,Fluid_Review_Submission_ID__c,HomePhone__c,Industries__c,Job_Role_Category__c,Last_Name__c,LastCURequestDate__c,
                            LastCUUpdateDate__c,LeadSource__c,LinkedIn__c,MailingCity__c,MailingCountry__c,MailingPostalCode__c,MailingState__c,MailingStreet__c,Meal_Plan__c,
                            Middle_Name__c,MobilePhone__c,Name_matches_passport__c,Nationality__c,Notes__c,OtherPhone__c,OtherPostalCode__c,OtherState__c,OtherStreet__c,
                            Passport_Number__c,Password__c,Phone__c,Phone_2__c,Phone_3__c,Previous_Account_Owner__c,Previous_RM__c,Primary_Academic_Program__c,
                            Primary_Department__c,Primary_Educational_Institution__c,Primary_Sports_Organization__c,Full_Name__c,Name, 
                            Primary_Student_Organization__c,Profile_Bio__c,Reason_for_applying__c,Regional_Rep__c,ReportsTo__c,Residence__c,Role__c,
                            Role_at_ALU__c,Room__c,Spoken_Languages__c,Title__c,Type__c,Username__c,Year_Group__c,ALUEmail__c                    
                    FROM   SIS_Student__c
                    WHERE  Id IN: studentIds
                    LIMIT  50000];
        }
        else
        {
            return null;
        }
    }
    
    public static List<Contact> getContacts(Set<Id> contactIds)
    {
        
        if(contactIds != null)
        {
            return [SELECT Id,AccountId,Action_for_ALN_Contact__c,ALN_Award_Category__c,student__c,
                            ALN_Award_Year__c,ALN_Contact_Status__c,ALU_Events_Attended__c,Applicant_Last_Active_Date__c,Applicant_Time_Zone__c,Application_Stage__c,
                            Applied_for_financial_Aid__c,AssistantName,AssistantPhone,Birthdate,Campus_Preference__c,Campus_Preference__r.Name,Cohort__c,Contact_Address__c,Twitter_Contact__c,
                            Country_of_Residence__c,Department,Description,DoNotCall,Email,Email_2__c,Email_3__c,HasOptedOutOfEmail,Student_Status__c,Excel_ID__c,Fax,
                            HasOptedOutOfFax,First_Name__c,Fluid_Review_Submission_ID__c,HomePhone,Industries__c,Job_Role_Category__c,Last_Name__c,LastCURequestDate,
                            LastCUUpdateDate,LeadSource,LinkedIn__c,MailingCity,MailingCountry,MailingPostalCode,MailingState,MailingStreet,Meal_Plan__c,
                            MiddleName,MobilePhone,Name_matches_passport__c,Nationality__c,Notes__c,OtherPhone,OtherPostalCode,OtherState,OtherStreet,
                            Passport_Number__c,Password__c,Phone,Phone_2__c,Phone_3__c,Previous_Account_Owner__c,Previous_RM__c,Primary_Academic_Program__c,
                            Primary_Department__c,Primary_Educational_Institution__c,Primary_Sports_Organization__c,
                            Primary_Student_Organization__c,Profile_Bio__c,Reason_for_applying__c,Regional_Rep__c,ReportsToId,Residence__c,Role__c,
                            Role_at_ALU__c,Room__c,Spoken_Languages__c,Title,Type__c,Username__c,Year_Group__c
                    FROM   contact
                    WHERE  Id IN: contactIds
                    LIMIT  50000];
        }
        else
        {
            return null;
        }
    }
    
    public static List<SIS_File__c> getFiles(String studentId, String fileType)
    {
        if(String.isNotBlank(studentId) && String.isNotBlank(fileType))
        {
            return [SELECT Id,File_Link__c,Name 
                   FROM   SIS_File__c 
                   WHERE  Uploaded_By_Student__c =: studentId 
                   AND    Type__c =: fileType 
                   LIMIT  50000];
        }
        else
        {
            return null;
        }
    }
    
    public static List<hed__Course_Enrollment__c> getCourseConnections(String contactId, Set<Id> programIDs)
    {
        if(String.isNotBlank(contactId))
        {
            return [SELECT Id,hed__Affiliation__c,Name,hed__Contact__c,hed__Account__c,hed__Course_Offering__c,hed__Credits_Attempted__c,hed__Course_Offering__r.hed__Course__r.hed__Course_ID__c,
                           hed__Credits_Earned__c,hed__Grade__c,hed__Primary__c,hed__Program_Enrollment__c,hed__Status__c,hed__Course_Offering__r.hed__Course__r.Name
                    FROM   hed__Course_Enrollment__c
                    WHERE  hed__Contact__c =: contactId
                    AND    hed__Program_Enrollment__c IN: programIDs
                    LIMIT  50000];
        }
        else
        {
            return null;
        }
    }
    
    public static List<hed__Program_Enrollment__c> getProgramEnrollments(String contactId)
    {
        if(String.isNotBlank(contactId))
        {
            return [SELECT Id,Name,hed__Admission_Date__c,hed__Affiliation__c,hed__Application_Submitted_Date__c,hed__Class_Standing__c,hed__Graduation_Year__c,hed__Contact__c,
                           hed__Credits_Attempted__c,hed__Credits_Earned__c,hed__Eligible_to_Enroll__c,hed__End_Date__c,hed__Enrollment_Status__c,hed__GPA__c,Major_Minor__c,
                           hed__Account__c,hed__Start_Date__c,hed__Account__r.Name
                    FROM   hed__Program_Enrollment__c 
                    WHERE  hed__Contact__c =: contactId 
                    LIMIT  50000];
        }
        else
        {
            return null;
        }
    }
    
    public static List<SIS_Policy__c> getPolicies(String studentId)
    {
        if(String.isNotBlank(studentId))
        {
            List<SIS_Student__c> stuList = getStudents(new Set<Id>{studentId});
            if(stuList != null && stuList.size() == 1 && stuList[0].Campus_Preference__c != null)
            {
                return [SELECT Id,Name,Summary__c,S3_Link__c,Category__c,Campus__c 
                        FROM   SIS_Policy__c 
                        WHERE  Campus__c =: stuList[0].Campus_Preference__c
                        ORDER  BY Name ASC 
                        LIMIT  50000];
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