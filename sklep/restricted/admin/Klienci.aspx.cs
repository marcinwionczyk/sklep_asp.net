using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Security;
using System.Net.Mail;
using System.Text;
using System.Configuration;
using MainStuff;

public partial class restricted_admin_klienci : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
            BindList();
    }
    void BindList()
    {
        DataList1.DataSource = DataSource();
        DataList1.DataBind();
    }
    private DataView DataSource()
    {
        DataTable dt = new DataTable();
        DataRow dr;
        dt.Columns.Add(new DataColumn("imie",typeof(string)));
        dt.Columns.Add(new DataColumn("nazwisko", typeof(string)));
        dt.Columns.Add(new DataColumn("login", typeof(string)));
        dt.Columns.Add(new DataColumn("email", typeof(string)));
        dt.Columns.Add(new DataColumn("adres", typeof(string)));
        dt.Columns.Add(new DataColumn("kod", typeof(string)));
        dt.Columns.Add(new DataColumn("miejscowosc", typeof(string)));
        dt.Columns.Add(new DataColumn("telefon", typeof(string)));
        dt.Columns.Add(new DataColumn("nip", typeof(string)));
        dt.Columns.Add(new DataColumn("firma", typeof(string)));
        dt.Columns.Add(new DataColumn("regon", typeof(string)));
        dt.Columns.Add(new DataColumn("aktywnosc", typeof(DateTime)));
        dt.Columns.Add(new DataColumn("isapproved", typeof(string)));
        foreach (string klient in Roles.GetUsersInRole("klient"))
        {
           MembershipUser user = Membership.GetUser(klient);
           Klient k = new Klient(new Guid(user.ProviderUserKey.ToString()));
           dr = dt.NewRow();
           dr[0] = k.Imie;
           dr[1] = k.Nazwisko;
           dr[2] = klient;
           dr[3] = k.email;
           dr[4] = k.Adres;
           dr[5] = k.KodPocztowy;
           dr[6] = k.Miejscowosc;
           dr[7] = k.Telefon;
           dr[8] = k.NIP;
           dr[9] = k.NazwaFirmy;
           dr[10] = k.REGON;
           dr[11] = user.LastLoginDate;
           dr[12] = user.IsApproved ? "tak" : "nie";
           dt.Rows.Add(dr);
        }   
        DataView dv = new DataView(dt);
        return dv;
    }

    public void DataList1_ItemCommand(object source, DataListCommandEventArgs e)
    {
        string cmd = ((LinkButton)e.CommandSource).CommandName;
        if (cmd == "select")
            DataList1.SelectedIndex = e.Item.ItemIndex;
        BindList();
    }
    protected void DataList1_EditCommand(object source, DataListCommandEventArgs e)
    {
        DataList1.EditItemIndex = (int)e.Item.ItemIndex;
        BindList();
    }

    protected void DataList1_UpdateCommand(object source, DataListCommandEventArgs e)
    {
        string login = ((System.Web.UI.WebControls.Label)e.Item.FindControl("Llogin")).Text;
        ProfileCommon userProfile = (ProfileCommon)ProfileCommon.Create(login, true);
        MembershipUser user = Membership.GetUser(login);
        userProfile.Imie = ((System.Web.UI.WebControls.TextBox)e.Item.FindControl("TBimie")).Text;
        userProfile.Nazwisko = ((System.Web.UI.WebControls.TextBox)e.Item.FindControl("TBnazwisko")).Text;
        user.Email = ((System.Web.UI.WebControls.TextBox)e.Item.FindControl("TBemail")).Text;
        userProfile.Adres = ((System.Web.UI.WebControls.TextBox)e.Item.FindControl("TBadres")).Text;
        userProfile.KodPocztowy = ((System.Web.UI.WebControls.TextBox)e.Item.FindControl("TBkod")).Text;
        userProfile.Miejscowość = ((System.Web.UI.WebControls.TextBox)e.Item.FindControl("TBmiejscowosc")).Text;
        userProfile.Telefon = ((System.Web.UI.WebControls.TextBox)e.Item.FindControl("TBtelefon")).Text;
        userProfile.NazwaFirmy = ((System.Web.UI.WebControls.TextBox)e.Item.FindControl("TBfirma")).Text;
        userProfile.REGON = ((System.Web.UI.WebControls.TextBox)e.Item.FindControl("TBREGON")).Text;
        userProfile.NIP = ((System.Web.UI.WebControls.TextBox)e.Item.FindControl("TBnip")).Text;
        bool changepassword = ((CheckBox)e.Item.FindControl("CheckBox1")).Checked;
        if (changepassword)
        {

            Label1.Text = "nowe hasło dla użytkownika " + user.UserName + ": " + user.ResetPassword();
            SmtpClient client = new SmtpClient();
            client.DeliveryMethod = SmtpDeliveryMethod.Network;
            client.EnableSsl = true;
            MailAddress from = new MailAddress("wiono@interia.pl");
            MailAddress to = new MailAddress(user.Email);
            MailMessage newmail = new MailMessage(from, to);
            newmail.Subject = ConfigurationManager.AppSettings["NazwaSklepu"] + " - Twoje hasło zostało zresetowane";
            StringBuilder sb = new StringBuilder();
            sb.AppendLine(Label1.Text);
            sb.AppendLine("zaloguj się i zmień swoje hasło");
            newmail.Body = sb.ToString();
            client.Send(newmail);
        }
        string maybeloggedin = ((System.Web.UI.WebControls.DropDownList)e.Item.FindControl("DropDownList")).SelectedValue;
        if (maybeloggedin == "tak")
            user.IsApproved = true;
        else user.IsApproved = false;
        userProfile.Save();
        Membership.UpdateUser(user);
        DataList1.EditItemIndex = -1;
        BindList();
    }
    protected void DataList1_CancelCommand(object source, DataListCommandEventArgs e)
    {
        DataList1.EditItemIndex = -1;
        BindList();
    }
}
