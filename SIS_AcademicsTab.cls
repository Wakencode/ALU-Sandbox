public class SIS_AcademicsTab extends SIS_MyAccountTab
{
    public Map<Id,String> programIdNameMap{get;set;}
    public String email{get;set;}
    
    public Map<Id,List<hed__Course_Enrollment__c>> getGrades()
    {
        if(stu != null && stu.Contact__c != null)
        {
            List<hed__Program_Enrollment__c> programs = SIS_QueryUtility.getProgramEnrollments(stu.Contact__c);
            set<Id> programIDs = new Set<Id>();
            programIdNameMap = new Map<Id,String>();
            Map<Id,List<hed__Course_Enrollment__c>> courseProgramMap = new Map<Id,List<hed__Course_Enrollment__c>>();
            
            if(programs != null && programs.size() > 0)
            {
                for(hed__Program_Enrollment__c pro: programs)
                {
                    programIDs.add(pro.Id);
                    if(pro.hed__Account__c != null)
                    {
                        programIdNameMap.put(pro.Id, pro.hed__Account__r.Name);
                    }
                }
                List<hed__Course_Enrollment__c> courseConnections = SIS_QueryUtility.getCourseConnections(stu.Contact__c, programIDs);
                if(courseConnections != null && courseConnections.size() > 0)
                {
                    for(hed__Course_Enrollment__c cc: courseConnections)
                    {
                        if(!courseProgramMap.containsKey(cc.hed__Program_Enrollment__c))
                        {
                            courseProgramMap.put(cc.hed__Program_Enrollment__c, new List<hed__Course_Enrollment__c>());
                        }
                        courseProgramMap.get(cc.hed__Program_Enrollment__c).add(cc);
                    }
                    return courseProgramMap;
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
        else
        {
            return null;
        }
    }
    
    @RemoteAction
    public static String sendUnofficialTranscript(String email, String fName, String coo)
    {
        try
        {
            PageReference pdf;
            Blob attbody;
            Messaging.EmailFileAttachment efa1 = new Messaging.EmailFileAttachment();
            List<Messaging.SingleEmailMessage> mails = new List<Messaging.SingleEmailMessage>();
            Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage(); 
            List<Messaging.Emailfileattachment> fileAttachments = new List<Messaging.Emailfileattachment>();
            pdf = Page.SIS_UnofficialTranscriptPDF;
            pdf.getParameters().put('con',coo);
            //pdf = new PageReference('http://sissandbox-alu.cs88.force.com/SIS_UnofficialTranscriptPDF?con='+coo);
            //Cookie counter = new Cookie('con', coo, null,-1,false);
            //pdf.setCookies(new Cookie[]{counter});
    		//pdf.setredirect(true);
    		if(!Test.IsRunningTest())
    		{
    			attbody = pdf.getContent();
    		    efa1.setFileName('ALU Transcript.pdf');
    			efa1.setBody(attbody);
    			fileAttachments.add(efa1);
    			system.debug(email);
    			system.debug(fName);
    			system.debug(coo);
    			system.debug(pdf);
    			system.debug(fileAttachments);
    		}
            string htmlbody = '';
            String subject = 'ALU - Unofficial Transcript';
            htmlbody = 'Hi '+fName+',<br/><br/>Please find the attached unofficial transcript requested by you.<br/><br/>From<br/>ALU Support Team';
            mail.setSubject(subject);
            mail.setToAddresses(new String[]{email});
            mail.setHtmlBody(htmlbody);
            mail.setFileAttachments(fileAttachments);
    		mails.add(mail);
            Messaging.sendEmail(mails);
            return 'Success';
        }
        catch(Exception e)
        {
            system.debug(e.getMessage());
            return e.getMessage();
        }
    }
}