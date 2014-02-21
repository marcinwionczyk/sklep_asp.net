using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Security;
using System.Data;
using System.Net.Mail;
using System.Configuration;
using System.Text;

public partial class restricted_admin_Default : System.Web.UI.Page
{
    private DataView CreateDataSource(string rola)
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
        dt.Columns.Add(new DataColumn("aktywnosc", typeof(DateTime)));
        dt.Columns.Add(new DataColumn("isapproved", typeof(string)));
        foreach (string worker in Roles.GetUsersInRole(rola))
        {
           MembershipUser user = Membership.GetUser(worker);
           ProfileCommon userProfile = (ProfileCommon)ProfileCommon.Create(worker, true);
           dr = dt.NewRow();
           dr[0] = userProfile.Imie;
           dr[1] = userProfile.Nazwisko;
           dr[2] = worker;
           dr[3] = user.Email;
           dr[4] = userProfile.Adres;
           dr[5] = userProfile.KodPocztowy;
           dr[6] = userProfile.Miejscowość;
           dr[7] = userProfile.Telefon;
           dr[8] = userProfile.NIP;
           dr[9] = user.LastLoginDate;
           dr[10] = user.IsApproved ? "tak" : "nie";
           dt.Rows.Add(dr);
        }
        
        DataView dv = new DataView(dt);
        return dv;
    }

    void Page_Load(Object Sender, EventArgs e)
    {

        if (!IsPostBack)
        {
            BindList1();
            BindList2();
        }
    }

    void BindList1()
    {
        DataList1.DataSource = CreateDataSource("zarzadca");
        DataList1.DataBind();
    }
    void BindList2()
    {
        DataList2.DataSource = CreateDataSource("manager");
        DataList2.DataBind();
    }

    public void DataList1_ItemCommand(object Sender, DataListCommandEventArgs e)
    {
        string cmd = ((LinkButton)e.CommandSource).CommandName;
        if (cmd == "select")
            DataList1.SelectedIndex = e.Item.ItemIndex;
        BindList1();
    }

    protected void DataList1_EditCommand(object source, DataListCommandEventArgs e)
    {
        DataList1.EditItemIndex = (int)e.Item.ItemIndex;
        BindList1();
    }
    protected void DataList1_CancelCommand(object source, DataListCommandEventArgs e)
    {
        DataList1.EditItemIndex = -1;
        BindList1();
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
        userProfile.NIP = ((System.Web.UI.WebControls.TextBox)e.Item.FindControl("TBnip")).Text;
        bool resetpassword = ((CheckBox)e.Item.FindControl("CheckBox1")).Checked;
        if (resetpassword)
        {
            LabelA.Text = "nowe hasło dla " + user.UserName + ": " + user.ResetPassword();
            SmtpClient client = new SmtpClient();
            client.DeliveryMethod = SmtpDeliveryMethod.Network;
            client.EnableSsl = true;
            MailAddress from = new MailAddress("wiono@interia.pl");
            MailAddress to = new MailAddress(user.Email);
            MailMessage newmail = new MailMessage(from, to);
            newmail.Subject = "Elsiko.com.pl - Twoje hasło zostało zresetowane";
            StringBuilder sb = new StringBuilder();
            sb.AppendLine(LabelA.Text);
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
        BindList1();
    }
   
    protected void DataList2_EditCommand(object source, DataListCommandEventArgs e)
    {
        DataList2.EditItemIndex = (int)e.Item.ItemIndex;
        BindList2();
    }
    public void DataList2_ItemCommand(object source, DataListCommandEventArgs e)
    {
        string cmd = ((LinkButton)e.CommandSource).CommandName;
        if (cmd == "select")
            DataList2.SelectedIndex = e.Item.ItemIndex;
        BindList2();
    }

    protected void DataList2_UpdateCommand(object source, DataListCommandEventArgs e)
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
        userProfile.NIP = ((System.Web.UI.WebControls.TextBox)e.Item.FindControl("TBnip")).Text;
        bool resetpassword = ((CheckBox)e.Item.FindControl("PasswordResetCB")).Checked;
        if (resetpassword)
        {
            LabelA.Text = "nowe hasło dla " + user.UserName + ": " + user.ResetPassword();
            SmtpClient client = new SmtpClient();
            client.EnableSsl = true;
            client.DeliveryMethod = SmtpDeliveryMethod.Network;
            MailAddress from = new MailAddress("wiono@interia.pl");
            MailAddress to = new MailAddress(user.Email);
            MailMessage newmail = new MailMessage(from, to);
            newmail.Subject = "Elsiko.com.pl - Twoje hasło zostało zresetowane";
            StringBuilder sb = new StringBuilder();
            sb.AppendLine(LabelA.Text);
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
        DataList2.EditItemIndex = -1;
        BindList2();
    }
    protected void DataList2_CancelCommand(object source, DataListCommandEventArgs e)
    {
        DataList2.EditItemIndex = -1;
        BindList2();
    }
  
    protected void CreateUserWizard1_FinishButtonClick(object sender, WizardNavigationEventArgs e)
    {
        
        switch (DropDownList1.SelectedIndex)
        {
            case 0:
                {
                    Roles.AddUserToRole(CreateUserWizard1.UserName, "zarzadca");
                    break;
                }
            case 1:
                {
                    Roles.AddUserToRole(CreateUserWizard1.UserName, "manager");
                    break;
                }
        }
        ProfileCommon p = (ProfileCommon)ProfileCommon.Create(CreateUserWizard1.UserName, true);
        p.SetPropertyValue("Adres", Adres.Text);
        p.SetPropertyValue("Imie", Imię.Text);
        p.SetPropertyValue("Nazwisko", Nazwisko.Text);
        p.SetPropertyValue("KodPocztowy", Kod.Text);
        p.SetPropertyValue("Miejscowość", Miejscowosc.Text);
        p.SetPropertyValue("Telefon", Telefon.Text);
        p.SetPropertyValue("NIP", NIP.Text);
        p.Save();
    }

}
