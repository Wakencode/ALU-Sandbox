public class SIS_AmazonFileUpload
{
    public static String uploadFile(Blob body, String name, String contentType, SIS_Student__c student, String fileType)
    {
        try
        {
            if(body != null && String.isNotBlank(name) && String.isNotBlank(contentType) && student != null)
            {
                String attachmentBody = EncodingUtil.base64Encode(body);
                String formattedDateString = Datetime.now().formatGMT('EEE, dd MMM yyyy HH:mm:ss z');
                String key = Label.SIS_Amazon_Key;
                String secret = Label.SIS_Amazon_Secret;
                String bucketname = Label.SIS_Amazon_Bucket_Name;
                String host = Label.SIS_Amazon_Host;
                String method = 'PUT';
                String filename = name;
                String folderName = student.Id+'-'+student.Last_Name__c;
                
                HttpRequest req = new HttpRequest();
                req.setMethod(method);
                req.setEndpoint('http://' + bucketname + '.' + host + '/' + folderName + '/' + filename);
                req.setHeader('Host', bucketname + '.' + host);
                req.setHeader('Content-Length', String.valueOf(attachmentBody.length()));
                req.setHeader('Content-Encoding', 'UTF-8');
                req.setHeader('Content-type', contentType);
                req.setHeader('Connection', 'keep-alive');
                req.setHeader('Date', formattedDateString);
                req.setHeader('ACL', 'public-read');
                
                Blob blobBody = EncodingUtil.base64Decode(attachmentBody);
                req.setBodyAsBlob(blobBody);
                filename = filename.replaceAll(' ', '');
                String stringToSign = 'PUT\n\n' + contentType + '\n' + formattedDateString + '\n' +  '/' + bucketname +  '/' + folderName + '/' + filename;
                String encodedStringToSign = EncodingUtil.urlEncode(stringToSign, 'UTF-8');
                system.debug('stringToSign='+stringToSign);
                
                Blob mac = Crypto.generateMac('HMACSHA1', blob.valueof(stringToSign),blob.valueof(secret));
                String signed = EncodingUtil.base64Encode(mac);
                String authHeader = 'AWS' + ' ' + key + ':' + signed;
                req.setHeader('Authorization',authHeader);
                String decoded = EncodingUtil.urlDecode(encodedStringToSign, 'UTF-8');
                
                Http http = new Http();
                HTTPResponse res = http.send(req);
                String response = res.getBody();
                System.debug('*Resp:' + response);
                System.debug('RESPONSE STRING: ' + res.toString());
                System.debug('RESPONSE STATUS: ' + res.getStatus());
                System.debug('STATUS_CODE: ' + res.getStatusCode());
                if(res.getStatus() == 'OK' && res.getStatusCode() == 200)
                {
                    List<SIS_File__c> fileList = new List<SIS_File__c>();
                    if(String.isNotBlank(fileType) && fileType == 'Profile Pic')
                    {
                        fileList = [SELECT Id FROM SIS_File__c WHERE Uploaded_By_Student__c =: student.Id AND Name = 'ProfilePic' AND Type__c = 'Profile Pic' LIMIT 1];
                    }
                    if(fileList == null || fileList.size() == 0)
                    {
                        SIS_File__c file = new SIS_File__c();
                        file.Name = fileName;
                        file.Uploaded_By_Student__c = student.Id;
                        file.Type__c = fileType;
                        file.File_Link__c = 'https://'+Label.SIS_Amazon_Host+'/'+Label.SIS_Amazon_Bucket_Name+'/'+folderName+'/'+filename;

                        insert file;
                    }
                    return 'File uploaded successfully.';
                }
                else
                {
                    return res.toString();
                }
            }
            else
            {
                return null;
            }
        }
        catch(Exception e)
        {
            return 'ERROR: Uploading file to Amazon - '+e.getMessage()+' - '+e.getLineNumber();
        }
    }
}