public class SIS_SyncStudentHDL 

{
      
    public static void updateStudent(List<Contact> conList)
    {
        if(conList != null && conList.size() > 0)
        {
            Map<Id,Contact> conMap = new Map<Id,Contact>();
            List<SIS_Student__c> studentListToUpdate = new List<SIS_Student__c>();
            for(Contact con: conList)
            {
                if(String.isNotBlank(con.Student__c))
                {
                    conMap.put(con.Student__c, con);
                }
            }
            if(conMap.keySet().size() > 0)
            {
                for(Id i: conMap.keySet())
                {
                    Contact cn = conMap.get(i);
                    SIS_Student__c stu = buildStudentRecord(cn);
                    stu.Id = i;
                    studentListToUpdate.add(stu); 
                }
                if(studentListToUpdate.size() > 0)
                {
                    update studentListToUpdate;
                }
            }
        }
    }
    public static void deleteStudent(List<Contact> conList)
    {
        if(conList != null && conList.size() > 0)
        {
            Set<Id> studentIdSet = new Set<Id>();
            for(contact con:conlist)
            {
                if(con.Student__c != null)
                {
                    studentIdSet.add(con.Student__c);
                }
            }
            List<SIS_Student__c> studentList = [SELECT Id
                                                 FROM SIS_Student__c 
                                                 WHERE Id IN :studentIdSet
                                                 LIMIT 50000];
            if(studentList != null && studentList.size() > 0)
            {
                delete studentList;
            }
        }
    }
    public static void createStudent(list<contact> contactlist)
    {
        system.debug('CONTACT LIST-------'+contactList);
        list<SIS_Student__c> Studentlist= new list<SIS_Student__c>();
        Map<id,id> stuConMap = new Map<id,id>();
        List<contact> conListToUpdate = new List<Contact>();
        for(contact cn:contactlist)
        {
            SIS_Student__c stu = buildStudentRecord(cn);
            system.debug('stu-------'+stu);
            Studentlist.add(stu);
        }
        insert Studentlist;
        system.debug('Studentlist-------'+Studentlist);
        if(studentList != null && studentList.size() > 0)
        {
            for(SIS_Student__c stu: studentList)
            {
                stuConMap.put(stu.Contact__c, stu.id);
            }
            for(Contact con: SIS_QueryUtility.getContacts(stuConMap.KeySet()))
            {
                if(stuConMap.containsKey(con.Id))
                {
                    Id StuId = stuConMap.get(Con.Id);
                    con.Student__c = stuId;
                    conListToUpdate.add(con);
                }
            }
            if(conListToUpdate.size() > 0)
            {
                update conListToUpdate;
            }
        }
    }
    
    public static SIS_Student__c buildStudentRecord(Contact cn)
    {
        if(cn != null)
        {
            SIS_Student__c stu = new SIS_Student__c();
            if(String.isNotBlank(cn.AccountId))
            {
                stu.Account__c = cn.AccountId;
            }
            if(String.isNotBlank(cn.Action_for_ALN_Contact__c))
            {
               stu.Action_for_ALN_Contact__c=cn.Action_for_ALN_Contact__c;
            }
            if(String.isNotBlank(cn.ALN_Award_Category__c))
            {
                stu.ALN_Award_Category__c=cn.ALN_Award_Category__c;
            }
            if(String.isNotBlank(cn.ALN_Award_Year__c))
            {
                stu.ALN_Award_Year__c=cn.ALN_Award_Year__c;
            }
            if(String.isNotBlank(cn.ALN_Contact_Status__c))
            {
                stu.ALN_Contact_Status__c=cn.ALN_Contact_Status__c;
            }
            if(String.isNotBlank(cn.ALU_Events_Attended__c))
            {
                stu.ALU_Events_Attended__c=cn.ALU_Events_Attended__c;
            }
             if(cn.Applicant_Last_Active_Date__c!= null)
            {
                stu.Applicant_Last_Active_Date__c=cn.Applicant_Last_Active_Date__c;
            }
            if(String.isNotBlank(cn.Applicant_Time_Zone__c))
            {
                stu.Applicant_Time_Zone__c=cn.Applicant_Time_Zone__c;
            }
            if(String.isNotBlank(cn.Application_Stage__c))
            {
                stu.Application_Stage__c=cn.Application_Stage__c;
            }
            if(cn.Applied_for_financial_Aid__c)
            {
                stu.Applied_for_financial_Aid__c=cn.Applied_for_financial_Aid__c;
            }
             if(String.isNotBlank(cn.AssistantName))
            {
                stu.AssistantName__c=cn.AssistantName;
            }
             if(String.isNotBlank(cn.AssistantPhone))
            {
                stu.AssistantPhone__c=cn.AssistantPhone;
            }
            if(cn.Birthdate!=null)
            {
                stu.Birthdate__c=cn.Birthdate;
            }
            if(String.isNotBlank(cn.Campus_Preference__c))
            {
                stu.Campus_Preference__c=cn.Campus_Preference__c;
            }
            if(String.isNotBlank(cn.Cohort__c))
            {
                stu.Cohort__c=cn.Cohort__c;
            }
            if(String.isNotBlank(cn.Contact_Address__c))
            {
                stu.Contact_Address__c=cn.Contact_Address__c;
            }
            if(cn.id!=null)
            {
                stu.Contact__c = cn.Id;
            }
            if(String.isNotBlank(cn.Twitter_Contact__c))
            {
                stu.Twitter_Contact__c=cn.Twitter_Contact__c;
            }
            if(String.isNotBlank(cn.Country_of_Residence__c))
            {
                stu.Country_of_Residence__c=cn.Country_of_Residence__c;
            }
            if(String.isNotBlank(cn.Department))
            {
                stu.Department__c=cn.Department;
            }
            if(String.isNotBlank(cn.Description))
            {
                stu.Description__c=cn.Description;
            }
            if(cn.DoNotCall)
            {
                stu.DoNotCall__c=cn.DoNotCall;
            }
            if(String.isNotBlank(cn.Email))
            {
                stu.Email__c=cn.Email;
            }
            if(String.isNotBlank(cn.Email_2__c))
            {
                stu.Email_2__c=cn.Email_2__c;
            }
            if(String.isNotBlank(cn.Email_3__c))
            {
                stu.Email_3__c=cn.Email_3__c;
            }
            if(cn.HasOptedOutOfEmail!=null)
            {
                stu.HasOptedOutOfEmail__c=cn.HasOptedOutOfEmail;
            }
            if(String.isNotBlank(cn.Student_Status__c))
            {
                stu.Student_Status__c=cn.Student_Status__c;
            }
            if(cn.Excel_ID__c!=null)
            {
                stu.Excel_ID__c=cn.Excel_ID__c;
            }
            if(cn.Fax!=null)
            {
                stu.Fax__c=cn.Fax;
            }
            if(cn.HasOptedOutOfFax)
            {
                stu.HasOptedOutOfFax__c=cn.HasOptedOutOfFax;
            }
            if(String.isNotBlank(cn.First_Name__c))
            {
                stu.First_Name__c=cn.First_Name__c;
            }
            if(cn.Fluid_Review_Submission_ID__c!=null)
            {
                stu.Fluid_Review_Submission_ID__c=cn.Fluid_Review_Submission_ID__c;
            }
            
            if(cn.HomePhone!=null)
            {
                stu.HomePhone__c=cn.HomePhone;
            }
            if(String.isNotBlank(cn.Industries__c))
            {
                stu.Industries__c=cn.Industries__c;
            }
            if(String.isNotBlank(cn.Job_Role_Category__c))
            {
                stu.Job_Role_Category__c=cn.Job_Role_Category__c;
            }
            if(String.isNotBlank(cn.Last_Name__c))
            {
                stu.Last_Name__c=cn.Last_Name__c;
            }
            if(cn.LastCURequestDate != null)
            {
                stu.LastCURequestDate__c=cn.LastCURequestDate;
            }
            if(cn.LastCUUpdateDate!=null)
            {
                stu.LastCUUpdateDate__c=cn.LastCUUpdateDate;
            }
            if(String.isNotBlank(cn.LeadSource))
            {
                stu.LeadSource__c=cn.LeadSource;
            }
            if(String.isNotBlank(cn.LinkedIn__c))
            {
                stu.LinkedIn__c=cn.LinkedIn__c;
            }
            if(String.isNotBlank(cn.MailingCity))
            {
                stu.MailingCity__c=cn.MailingCity;
            }
            if(String.isNotBlank(cn.MailingCountry))
            {
                stu.MailingCountry__c=cn.MailingCountry;
            }
            if(cn.MailingPostalCode!=null)
            {
                stu.MailingPostalCode__c=cn.MailingPostalCode;
            }
            if(String.isNotBlank(cn.MailingState))
            {
                stu.MailingState__c=cn.MailingState;
            }
            if(String.isNotBlank(cn.MailingStreet))
            {
                stu.MailingStreet__c=cn.MailingStreet;
            }
            if(cn.Meal_Plan__c)
            {
                stu.Meal_Plan__c=cn.Meal_Plan__c;
            }
            if(String.isNotBlank(cn.MiddleName))
            {
                stu.Middle_Name__c=cn.MiddleName;
            }
            if(cn.MobilePhone!=null)
            {
                stu.MobilePhone__c=cn.MobilePhone;
            }
            if(cn.Name_matches_passport__c)
            {
                stu.Name_matches_passport__c=cn.Name_matches_passport__c;
            }
            if(String.isNotBlank(cn.Nationality__c))
            {
                stu.Nationality__c=cn.Nationality__c;
            }
            if(String.isNotBlank(cn.Notes__c))
            {
                stu.Notes__c =cn.Notes__c; 
            }
            if(cn.OtherPhone!=null)
            { 
                stu.OtherPhone__c=cn.OtherPhone;
            }
            if(cn.OtherPostalCode!=null)
            {
                stu.OtherPostalCode__c=cn.OtherPostalCode;
            }
            if(String.isNotBlank(cn.OtherState))
            {
                stu.OtherState__c=cn.OtherState;
            }
            if(String.isNotBlank(cn.OtherStreet))
            {
                stu.OtherStreet__c=cn.OtherStreet;
            }
             if(cn.Passport_Number__c!=null)
            {
                stu.Passport_Number__c=cn.Passport_Number__c;
             }
             if(String.isNotBlank(cn.Password__c))
            {
                stu.Password__c=cn.Password__c;
            }
            if(cn.Phone!=null)
            {
                stu.Phone__c=cn.Phone;
            }
            if(cn.Phone_2__c!=null)
            {
                stu.Phone_2__c=cn.Phone_2__c;
            }
            if(cn.Phone_3__c!=null)
            {
                stu.Phone_3__c=cn.Phone_3__c;
            }
            if(String.isNotBlank(cn.Previous_Account_Owner__c))
            {
                stu.Previous_Account_Owner__c=cn.Previous_Account_Owner__c;
            }
            if(String.isNotBlank(cn.Previous_RM__c))
            {
                stu.Previous_RM__c=cn.Previous_RM__c;
            }
            if(String.isNotBlank(cn.Primary_Academic_Program__c))
            {
                stu.Primary_Academic_Program__c=cn.Primary_Academic_Program__c;
            }
            if(String.isNotBlank(cn.Primary_Department__c))
            {
                stu.Primary_Department__c=cn.Primary_Department__c;
            }
            if(String.isNotBlank(cn.Primary_Educational_Institution__c))
            {
                stu.Primary_Educational_Institution__c=cn.Primary_Educational_Institution__c;
            }
            if(String.isNotBlank(cn.Primary_Sports_Organization__c))
            {
                stu.Primary_Sports_Organization__c=cn.Primary_Sports_Organization__c;
            }
            if(String.isNotBlank(cn.Primary_Student_Organization__c))
            {
                stu.Primary_Student_Organization__c=cn.Primary_Student_Organization__c;
            }
            if(String.isNotBlank(cn.Profile_Bio__c))
            {
                stu.Profile_Bio__c=cn.Profile_Bio__c;
            }
            if(String.isNotBlank(cn.Reason_for_applying__c))
            {
                stu.Reason_for_applying__c=cn.Reason_for_applying__c;
            }
            if(String.isNotBlank(cn.Regional_Rep__c))
            {
                stu.Regional_Rep__c=cn.Regional_Rep__c;
            }
            if(cn.ReportsToId!=null)
            {
                stu.ReportsTo__c=cn.ReportsToId;
            }
            if(String.isNotBlank(cn.Residence__c))
            {
                stu.Residence__c=cn.Residence__c;
            }
            if(String.isNotBlank(cn.Role__c))
            {
                stu.Role__c=cn.Role__c;
            }
            if(String.isNotBlank(cn.Role_at_ALU__c))
            {
                stu.Role_at_ALU__c=cn.Role_at_ALU__c;
            }
            if(String.isNotBlank(cn.Room__c))
            {
                stu.Room__c=cn.Room__c;
            }
            if(String.isNotBlank(cn.Spoken_Languages__c))
            {
                stu.Spoken_Languages__c=cn.Spoken_Languages__c;
            }
            if(String.isNotBlank(cn.Title))
            {
                stu.Title__c=cn.Title;
            }
            if(String.isNotBlank(cn.Type__c))
            {
                stu.Type__c=cn.Type__c;
            }
            if(String.isNotBlank(cn.Username__c))
            {
                stu.Username__c=cn.Username__c;
            }
            if(String.isNotBlank(cn.Year_Group__c))
            {
                stu.Year_Group__c=cn.Year_Group__c;
            }
            return stu;
        }
        else
        {
            return null;
        }
    }
}