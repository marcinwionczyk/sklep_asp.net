using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MainStuff;

public partial class restricted_zarzadca_Default : System.Web.UI.Page
{
 
    protected void Page_Load(object sender, EventArgs e)
    {
        if(!Page.IsPostBack)
        {
            DataDzisiejszaL.Text = DateTime.Today.ToLongDateString();
        }
    }

    protected void DataList1_ItemCommand(object source, DataListCommandEventArgs e)
    {
        DataList1.SelectedIndex = e.Item.ItemIndex;
        DataList1.DataBind();
        string cmd = ((LinkButton)e.CommandSource).CommandName;
        if (cmd == "Ponaglenie")
        {
            string g = ((HiddenField)e.Item.FindControl("HiddenField")).Value.ToString();
        }
    }

    protected void DataList1_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item)
        {
            string g = ((HiddenField)e.Item.FindControl("HiddenField")).Value;
        }
    }
    protected void DataList1_ItemCreated(object sender, DataListItemEventArgs e)
    {

    }
}
