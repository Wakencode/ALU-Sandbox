public class SIS_FileUpload 
{
    public SIS_File__c file{get;set;}

    public SIS_FileUpload()
    {
        String stuId = SIS_Utility.getCookie('con');

        if(String.isNotBlank(stuId))
        {
            List<SIS_File__c> files = SIS_QueryUtility.getFiles(stuId, 'Medical');
            if(files != null && files.size() > 0)
            {
                file = files[0];
            }
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
    
    @RemoteAction
    public static String removeFile(String fileId)
    {
        if(String.isNotBlank(fileId))
        {
            try
            {
                delete [SELECT Id FROM SIS_File__c WHERE Id =: fileId LIMIT 1];
                return 'File has been removed successfully.';
            }
            catch(Exception e)
            {
                return e.getMessage()+' - '+e.getLineNumber();
            }
        }
        else
        {
            return 'File ID not found, please contact your administrator.';
        }
    }
}