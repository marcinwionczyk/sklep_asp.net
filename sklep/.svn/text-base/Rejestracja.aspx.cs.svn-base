using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MainStuff;
using System.Web.Security;

public partial class Rejestracja : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {

    }
    protected void CreateUserWizard1_CreatedUser(object sender, EventArgs e)
    {
        if (!Roles.RoleExists("klient"))
            Roles.CreateRole("klient");
            Roles.AddUserToRole(CreateUserWizard1.UserName,"klient");
    }

    protected void CreateUserWizard1_FinishButtonClick(object sender, WizardNavigationEventArgs e)
    {
        ProfileCommon userProfile = (ProfileCommon)ProfileCommon.Create(CreateUserWizard1.UserName, true);
        userProfile.Adres = Server.HtmlEncode(Adres.Text);
        userProfile.Imie = Server.HtmlEncode(Imię.Text);
        userProfile.Nazwisko = Server.HtmlEncode(Nazwisko.Text);
        userProfile.KodPocztowy = Server.HtmlEncode(Kod.Text);
        userProfile.Miejscowość = Server.HtmlEncode(Miejscowosc.Text);
        userProfile.Telefon = Server.HtmlEncode(Telefon.Text);
        userProfile.Fax = Server.HtmlEncode(Fax.Text);
        userProfile.NazwaFirmy = Server.HtmlEncode(Firma.Text);
        userProfile.NIP = Server.HtmlEncode(NIP.Text);
        userProfile.REGON = Server.HtmlEncode(REGON.Text);
        userProfile.Save();
    }
    protected void CreateUserWizard1_ContinueButtonClick(object sender, EventArgs e)
    {
        Response.Redirect(ResolveClientUrl("Default.aspx"));
    }
}
