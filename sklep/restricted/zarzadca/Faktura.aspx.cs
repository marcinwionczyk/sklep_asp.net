using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;

public partial class restricted_zarzadca_Faktura : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            NrFaktury.Text = (DateTime.Now.ToFileTime() - DateTime.Today.ToFileTime()).ToString();
        }
    }
}
