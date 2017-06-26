public class SIS_Homepage
{
    public String studentId{get;set;}
    
    public PageReference onLoadAction()
    {
        studentId = SIS_Utility.getCookie('con');
        if(String.isNotBlank(studentId))
        {
            return null;
        }
        else
        {
            return new PageReference('/apex/SIS_login').setRedirect(True);
        }
    }
}