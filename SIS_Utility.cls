public class SIS_Utility
{
    public static String getCookie(String cookieName)
    {
        if(String.isNotBlank(cookieName))
        {
            Cookie coo = Apexpages.currentPage().getCookies().get(cookieName);
            if(coo != null)
            {
                return coo.getValue();
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