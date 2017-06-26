public class SIS_SyncContactHDL 
{
    public static boolean run = true;
    
    public static boolean runOnce()
    {
        if(run)
        {
            run = false;
            return true;
        }
        else
        {
            return run;
        }
    }
    
    public static void updateContact(List<SIS_Student__c> studentList)
    {
        if(studentList != null && studentList.size() > 0)
        {
            Map<Id,SIS_Student__c> stuMap = new Map<Id,SIS_Student__c>();
            List<contact> contactListToUpdate = new List<contact>();
            for(SIS_Student__c stu: studentList)
            {
                if(String.isNotBlank(stu.Contact__c))
                {
                    stuMap.put(stu.Contact__c, stu);
                }
            }
            if(stuMap.keySet().size() > 0)
            {
                for(Id i: stuMap.keySet())
                {
                    SIS_Student__c stu = stuMap.get(i);
                    Contact cn = buildContactRecord(stu);
                    cn.Id = i;
                    contactListToUpdate.add(cn); 
                }
                
                if(contactListToUpdate.size() > 0)
                {
                    update contactListToUpdate;
                }
            }
        }
    }
   /* public static void deleteContact(List<SIS_Student__c> studentList)
    {
        if(studentList != null && studentList.size() > 0)
        {
            Set<Id> contactIdSet = new Set<Id>();
            for(SIS_Student__c stu:studentlist)
            {
                if(stu.Contact__c != null)
                {
                    contactIdSet.add(stu.Contact__c);
                }
            }
            List<Contact> contactList = [SELECT Id
                                         FROM contact
                                         WHERE Id IN :contactIdSet
                                         LIMIT 50000];
            if(contactList != null && contactList.size() > 0)
            {
                delete contactList;
            }
        }
    }*/
    public static void createContact(list<SIS_Student__c> studentlist)
    {
       
        list<contact> Contactlist = new list<contact>();
        Map<id,id> stuConMap = new Map<id,id>();
        List<SIS_Student__c> stuListToUpdate = new List<SIS_Student__c>();
        for(SIS_Student__c st: studentlist)
        {
            contact cn = buildcontactRecord(st);
            
            Contactlist.add(cn);
        }
        insert Contactlist;
        
        if(ContactList != null && ContactList.size() > 0)
        {
            for(Contact cn: ContactList)
            {
                stuConMap.put(cn.student__c, cn.id);
            }
            for(SIS_Student__c stu:SIS_QueryUtility.getstudents(stuConMap.KeySet()))
            {
                if(stuConMap.containsKey(stu.Id))
                {
                    Id ConId = stuConMap.get(stu.Id);
                    stu.contact__c = ConId;
                    stuListToUpdate.add(stu);
                }
                
            }
            if(stuListToUpdate.size() > 0)
            {
                update stuListToUpdate;
            }
        }
    }

    public static contact buildContactRecord(SIS_Student__c st)
    {
        if(st != null)
        {
           Contact con = new Contact();
            if(String.isNotBlank(st.Account__c))
            {
                con.AccountId = st.Account__c;
            }
            if(String.isNotBlank(st.Action_for_ALN_Contact__c))
            {
               con.Action_for_ALN_Contact__c=st.Action_for_ALN_Contact__c;
            }
            if(String.isNotBlank(st.ALN_Award_Category__c))
            {
                con.ALN_Award_Category__c=st.ALN_Award_Category__c;
            }
            if(String.isNotBlank(st.ALN_Award_Year__c))
            {
                con.ALN_Award_Year__c=st.ALN_Award_Year__c;
            }
            if(String.isNotBlank(st.ALN_Contact_Status__c))
            {
                con.ALN_Contact_Status__c=st.ALN_Contact_Status__c;
            }
            if(String.isNotBlank(st.ALU_Events_Attended__c))
            {
                con.ALU_Events_Attended__c=st.ALU_Events_Attended__c;
            }
             if(st.Applicant_Last_Active_Date__c!= null)
            {
                con.Applicant_Last_Active_Date__c=st.Applicant_Last_Active_Date__c;
            }
            if(String.isNotBlank(st.Applicant_Time_Zone__c))
            {
                con.Applicant_Time_Zone__c=st.Applicant_Time_Zone__c;
            }
            if(String.isNotBlank(st.Application_Stage__c))
            {
                con.Application_Stage__c=st.Application_Stage__c;
            }
            if(st.Applied_for_financial_Aid__c)
            {
                con.Applied_for_financial_Aid__c=st.Applied_for_financial_Aid__c;
            }
             if(String.isNotBlank(st.AssistantName__c))
            {
                con.AssistantName=st.AssistantName__c;
            }
             if(String.isNotBlank(st.AssistantPhone__c))
            {
                con.AssistantPhone=st.AssistantPhone__c;
            }
            if(st.Birthdate__c!=null)
            {
                con.Birthdate=st.Birthdate__c;
            }
            if(String.isNotBlank(st.Campus_Preference__c))
            {
                con.Campus_Preference__c=st.Campus_Preference__c;
            }
            if(String.isNotBlank(st.Cohort__c))
            {
                con.Cohort__c=st.Cohort__c;
            }
            if(String.isNotBlank(st.Contact_Address__c))
            {
                con.Contact_Address__c=st.Contact_Address__c;
            }
            if(st.Id != null)
            {
                con.Student__c = st.Id;
            }
            if(String.isNotBlank(st.Twitter_Contact__c))
            {
                con.Twitter_Contact__c=st.Twitter_Contact__c;
            }
            if(String.isNotBlank(st.Country_of_Residence__c))
            {
                con.Country_of_Residence__c=st.Country_of_Residence__c;
            }
            if(String.isNotBlank(st.Department__c))
            {
                con.Department=st.Department__c;
            }
            if(String.isNotBlank(st.Description__c))
            {
                con.Description=st.Description__c;
            }
            if(st.DoNotCall__c)
            {
                con.DoNotCall=st.DoNotCall__c;
            }
            if(String.isNotBlank(st.Email__c))
            {
                con.Email=st.Email__c;
            }
            if(String.isNotBlank(st.Email_2__c))
            {
                con.Email_2__c=st.Email_2__c;
            }
            if(String.isNotBlank(st.Email_3__c))
            {
                con.Email_3__c=st.Email_3__c;
            }
            if(st.HasOptedOutOfEmail__c!=null)
            {
                con.HasOptedOutOfEmail=st.HasOptedOutOfEmail__c;
            }
            if(String.isNotBlank(st.Student_Status__c))
            {
                con.Student_Status__c=st.Student_Status__c;
            } 
            if(st.Excel_ID__c!=null)
            {
                con.Excel_ID__c=st.Excel_ID__c;
            }
            if(st.Fax__c!=null)
            {
                con.Fax=st.Fax__c;
            }
            if(st.HasOptedOutOfFax__c)
            {
                con.HasOptedOutOfFax=st.HasOptedOutOfFax__c;
            }
            if(String.isNotBlank(st.First_Name__c))
            {
                con.FirstName =st.First_Name__c;
            }
            if(st.Fluid_Review_Submission_ID__c!=null)
            {
                con.Fluid_Review_Submission_ID__c=st.Fluid_Review_Submission_ID__c;
            }
            if(st.HomePhone__c!=null)
            {
                con.HomePhone=st.HomePhone__c;
            }
            if(String.isNotBlank(st.Industries__c))
            {
                con.Industries__c=st.Industries__c;
            }
            if(String.isNotBlank(st.Job_Role_Category__c))
            {
                con.Job_Role_Category__c=st.Job_Role_Category__c;
            }
            if(String.isNotBlank(st.Last_Name__c))
            {
                con.LastName=st.Last_Name__c;
            }
            if(String.isNotBlank(st.LeadSource__c))
            {
                con.LeadSource=st.LeadSource__c;
            }
            if(String.isNotBlank(st.LinkedIn__c))
            {
                con.LinkedIn__c=st.LinkedIn__c;
            }
            if(String.isNotBlank(st.MailingCity__c))
            {
                con.MailingCity=st.MailingCity__c;
            }
            if(String.isNotBlank(st.MailingCountry__c))
            {
                con.MailingCountry=st.MailingCountry__c;
            }
            if(st.MailingPostalCode__c!=null)
            {
                con.MailingPostalCode=st.MailingPostalCode__c;
            }
            if(String.isNotBlank(st.MailingState__c))
            {
                con.MailingState=st.MailingState__c;
            }
            if(String.isNotBlank(st.MailingStreet__c))
            {
                con.MailingStreet=st.MailingStreet__c;
            }
            if(st.Meal_Plan__c)
            {
                con.Meal_Plan__c=st.Meal_Plan__c;
            }
            if(String.isNotBlank(st.Middle_Name__c))
            {
                con.MiddleName=st.Middle_Name__c;
            }
            if(st.MobilePhone__c!=null)
            {
                con.MobilePhone=st.MobilePhone__c;
            }
            if(st.Name_matches_passport__c)
            {
                con.Name_matches_passport__c=st.Name_matches_passport__c;
            }
            if(String.isNotBlank(st.Nationality__c))
            {
                con.Nationality__c=st.Nationality__c;
            }
            if(String.isNotBlank(st.Notes__c))
            {
                con.Notes__c =st.Notes__c; 
            }
            if(st.OtherPhone__c!=null)
            { 
                con.OtherPhone=st.OtherPhone__c;
            }
            if(st.OtherPostalCode__c!=null)
            {
                con.OtherPostalCode=st.OtherPostalCode__c;
            }
            if(String.isNotBlank(st.OtherState__c))
            {
                con.OtherState=st.OtherState__c;
            }
            if(String.isNotBlank(st.OtherStreet__c))
            {
                con.OtherStreet=st.OtherStreet__c;
            }
             if(st.Passport_Number__c!=null)
            {
                con.Passport_Number__c=st.Passport_Number__c;
             }
             if(String.isNotBlank(st.Password__c))
            {
                con.Password__c=st.Password__c;
            }
            if(st.Phone__c!=null)
            {
                con.Phone=st.Phone__c;
            }
            if(st.Phone_2__c!=null)
            {
                con.Phone_2__c=st.Phone_2__c;
            }
            if(st.Phone_3__c!=null)
            {
                con.Phone_3__c=st.Phone_3__c;
            }
            if(String.isNotBlank(st.Previous_Account_Owner__c))
            {
                con.Previous_Account_Owner__c=st.Previous_Account_Owner__c;
            }
            if(String.isNotBlank(st.Previous_RM__c))
            {
                con.Previous_RM__c=st.Previous_RM__c;
            }
            if(String.isNotBlank(st.Primary_Academic_Program__c))
            {
                con.Primary_Academic_Program__c=st.Primary_Academic_Program__c;
            }
            if(String.isNotBlank(st.Primary_Department__c))
            {
                con.Primary_Department__c=st.Primary_Department__c;
            }
            if(String.isNotBlank(st.Primary_Educational_Institution__c))
            {
                con.Primary_Educational_Institution__c=st.Primary_Educational_Institution__c;
            }
            if(String.isNotBlank(st.Primary_Sports_Organization__c))
            {
                con.Primary_Sports_Organization__c=st.Primary_Sports_Organization__c;
            }
            if(String.isNotBlank(st.Primary_student_Organization__c))
            {
                con.Primary_student_Organization__c=st.Primary_student_Organization__c;
            }
            if(String.isNotBlank(st.Profile_Bio__c))
            {
                con.Profile_Bio__c=st.Profile_Bio__c;
            }
            if(String.isNotBlank(st.Reason_for_applying__c))
            {
                con.Reason_for_applying__c=st.Reason_for_applying__c;
            }
            if(String.isNotBlank(st.Regional_Rep__c))
            {
                con.Regional_Rep__c=st.Regional_Rep__c;
            }
            if(st.ReportsTo__c != null)
            {
                con.ReportsToId = st.ReportsTo__c;
            }
            if(String.isNotBlank(st.Residence__c))
            {
                con.Residence__c=st.Residence__c;
            }
            if(String.isNotBlank(st.Role__c))
            {
                con.Role__c=st.Role__c;
            }
            if(String.isNotBlank(st.Role_at_ALU__c))
            {
                con.Role_at_ALU__c=st.Role_at_ALU__c;
            }
            if(String.isNotBlank(st.Room__c))
            {
                con.Room__c=st.Room__c;
            }
            if(String.isNotBlank(st.Spoken_Languages__c))
            {
                con.Spoken_Languages__c=st.Spoken_Languages__c;
            }
            if(String.isNotBlank(st.Title__c))
            {
                con.Title=st.Title__c;
            }
            if(String.isNotBlank(st.Type__c))
            {
                con.Type__c=st.Type__c;
            }
            if(String.isNotBlank(st.Username__c))
            {
                con.Username__c=st.Username__c;
            }
            if(String.isNotBlank(st.Year_Group__c))
            {
                con.Year_Group__c=st.Year_Group__c;
            }
            return con;
        }
        else
        {
            return null;
        }
    }
    
}