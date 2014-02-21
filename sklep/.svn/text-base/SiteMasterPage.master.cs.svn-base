using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;

public partial class SiteMasterPage : System.Web.UI.MasterPage
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void LogOut()
    {
        FormsAuthentication.SignOut();
        Roles.DeleteCookie();
        Session.Clear();
    }
}
