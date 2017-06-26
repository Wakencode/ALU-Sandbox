public class SIS_login
{
    public String Password {get; set;}
    public String username {get; set;}
    public cookie con;
    public cookie clientCookie;
    public Boolean forgotPanel {get; set;}
    public Contact FP_Contact {get; set;}
    public SIS_Student__c student{get;set;}
    List<Contact> conlist;
    map<string,Contact> map1;
    List<SIS_Student__c> stuList;
    Map<String,SIS_Student__c> stuMap;
    
    public SIS_login()
    {
        forgotPanel = false;
        student = new SIS_Student__c();
        stuList = [SELECT Id,Username__c,Password__c,Last_Name__c,Email__c,Account__c
                   FROM   SIS_Student__c
                   WHERE  Username__c != null AND Username__c != ''
                   LIMIT  50000];

        stuMap = new Map<String,SIS_Student__c>();

        if(!stulist.isempty())
        {
            For(SIS_Student__c stu: stulist)
            {
                If(stu.Username__c!=null)
                {
                    stuMap.put(stu.Username__c,stu);
                }
            }
        }
    }
    
    public pageReference savelogin()
    {
        If(username=='' || username==null || password=='' || password==null)
        {
            Apexpages.addMessage(new Apexpages.Message(ApexPages.Severity.FATAL,'Username or Password cannot be blank.'));
            return null;
        }
        else
        {
            If(!stuMap.keyset().contains(username))
            {
                Apexpages.addMessage(new Apexpages.Message(ApexPages.Severity.FATAL,'Username doesn\'t exist.'));
                return null;
            }
            else 
            {
                SIS_Student__c stu = stuMap.get(username);
                if(stu.Password__c!=password)
                {
                    Apexpages.addMessage(new Apexpages.Message(ApexPages.Severity.FATAL,'Password doesn\'t match.'));
                    return null;
                }
                else
                {
                    con = new Cookie('con',stu.id,null,-1,false);
                    PageReference pr = new PageReference ('/apex/SIS_Homepage?tab=account');
                    pr.setCookies(new Cookie[]{con});
                    pr.setredirect(true);                   
                    return pr;
                }
            }
        }
    }
    
    public void forgotPassword()
    {
        forgotPanel = true;
    }
    
    public void closeForgotPwd()
    {
        forgotPanel = false;
    }
    
    public void receivePassword()
    {
        If(student.Username__c!=null && student.Username__c!='')
        {
            If(!stuMap.containsKey(student.Username__c))
            {
                Apexpages.addMessage(new Apexpages.Message(ApexPages.Severity.ERROR,'No User is registered with this Username.'));
            }
            else
            {
                forgotPanel = false;
                SIS_Student__c stu = stuMap.get(student.Username__c);
                if(String.isNotBlank(stu.Email__c))
                {
                    string[] toAddresses = new string[]{stu.Email__c};
                    Messaging.SingleEmailMessage mail = new Messaging.SingleEmailMessage();
                    mail.setToAddresses(toAddresses);
                    mail.setSubject('ALU SIS Portal - Password Recovery');
                    mail.setHTMLBody('Hi '+stu.Last_Name__c+',<br/><br/><b>Username</b> = '+stu.Username__c+'<br/><b>Password</b> = '+stu.Password__c+'<br/><br/>Thanks<br/>ALU SIS Portal');
                    Messaging.sendEmail(new Messaging.SingleEmailMessage[]{mail});
                    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.CONFIRM,'Sent Successfully.');
                    ApexPages.addMessage(myMsg);
                }
                else
                {
                    ApexPages.Message myMsg = new ApexPages.Message(ApexPages.Severity.ERROR,'Email ID not found for this username.');
                    ApexPages.addMessage(myMsg);
                }
            }
        }
        else
        {
            Apexpages.addMessage(new Apexpages.Message(ApexPages.Severity.WARNING,'Please enter E-mail ID.'));
        }
    }
}