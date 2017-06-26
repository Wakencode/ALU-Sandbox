public virtual class SIS_MyAccountTab
{
    public Contact con{get;set;}
    public SIS_Student__c stu{get;set;}
    public Id studentId{get;set;}
    public String street{get;set;}
    public String city{get;set;}
    public String state{get;set;}
    public String zipcode{get;set;}
    public String country{get;set;}
    public String userImage{get;set;}
    public String recordType{get;set;}
    public String rType{get;set;}
    
    public SIS_MyAccountTab()
    {
        Cookie coo = Apexpages.currentPage().getCookies().get('con');
        List<SIS_Student__c> studentDetails = new List<SIS_Student__c>();
        if(coo != null)
        {
            studentId = coo.getValue();
        }
        else
        {
            studentId = Apexpages.currentPage().getParameters().get('con');
        }
        studentDetails = SIS_QueryUtility.getStudents(new Set<Id>{studentId});
        if(studentDetails.size() > 0)
        {
            stu = studentDetails[0];
            String folderName = stu.Id+'-'+stu.Last_Name__c;
            List<SIS_File__c> fileList = [SELECT Id FROM SIS_File__c WHERE Uploaded_By_Student__c =: stu.Id AND Name = 'ProfilePic' AND Type__c = 'Profile Pic' LIMIT 1];
            if(fileList != null && fileList.size() > 0)
            {
                userImage = 'https://'+Label.SIS_Amazon_Host+'/'+Label.SIS_Amazon_Bucket_Name+'/'+folderName+'/'+'ProfilePic';
            }
        }
    }
    
    public String getDomId()
    {
        if(String.isNotBlank(recordType))
        {
            if(recordType == 'Emergency Contact')
            {
                return '-EC';
            }
            else
            {
                return '-PG';
            }
        }
        else if(String.isNotBlank(rType))
        {
            if(rType == 'Emergency Contact')
            {
                return '-EC';
            }
            else
            {
                return '-PG';
            }
        }
        else
        {
            return '';
        }
    }
    
    public void save()
    {
        try
        {
            update stu;
        }
        catch(Exception e)
        {
            
        }
    }
    
    @RemoteAction
    public static string saveMyInfo(String stuId, String email, String phone, String street, String city, String state, String zipCode, String country)
    {
        try
        {
            if(String.isNotBlank(stuId))
            {
                SIS_Student__c stu = new SIS_Student__c();
                stu.Id = stuId;
                stu.Email__c = email;
                stu.Phone__c = phone;
                stu.MailingStreet__c = street;
                stu.MailingCity__c = city;
                stu.MailingState__c = state;
                stu.MailingPostalCode__c = zipCode;
                stu.MailingCountry__c = country;
                update stu;
                return 'Success';
            }
            else
            {
                return 'Your session has been expired. Please login again.';
            }
        }
        catch(Exception e)
        {
            return 'ERROR: An error has occurred while saving your information - '+e.getMessage()+' at line #'+e.getLineNumber();
        }
    }
    
    @RemoteAction
    public static String fileUpload(String name, Blob body, String contentType, String stuId, String fileType)
    {
        system.debug(name+'---'+body+'---'+contentType+'---'+stuId);
        if(String.isNotBlank(name) && body != null && String.isNotBlank(contentType) && String.isNotBlank(stuId))
        {
            try
            {
                SIS_Student__c stu = [SELECT Id,Last_Name__c,Contact__c FROM SIS_Student__c WHERE Id =: stuId LIMIT 1][0];
                if(stu != null)
                {
                    return SIS_AmazonFileUpload.uploadFile(body, name, contentType, stu, fileType);
                }
                else
                {
                    return 'Your session has been expired, please login again and upload the file.';
                }
            }
            catch(Exception e)
            {
                return e.getMessage()+' - '+e.getLineNumber();
            }
        }
        else
        {
            return 'Your session has been expired, please login again and upload the file.';
        }
    }
}