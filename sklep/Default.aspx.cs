using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using MainStuff;
using System.Web.Security;
using System.Data;
using System.ComponentModel;
using System.Collections;
using System.Text.RegularExpressions;

public partial class _Default : System.Web.UI.Page
{
    #region Zmienne sesyjne
    public string kat
    {
        set { Session["kat"] = value; }
        get { return Session["kat"] == null ? string.Empty : Convert.ToString(Session["kat"]); }
    }
    public Zamówienie Zamawiane{
        set { Session["zamowienie"] = value; }
        get { return Session["zamowienie"] == null ? new Zamówienie() : (Zamówienie)Session["zamowienie"]; }
    }

    public Towar wybranytowar
    {
        set { Session["wybranytowar"] = value; }
        get { return Session["wybranytowar"] == null ? new Towar() : (Towar)Session["wybranytowar"]; }
    }
    #endregion
    
    protected void Page_Load(object sender, EventArgs e)
    {
        
        if (!Page.IsPostBack)
        {
            PobierzKategorie();
            TreeView1.CollapseAll();
            string tak = Request["tak"];
            Regex isNumber = new Regex("^[0-9]+$");
            if (tak == null || isNumber.IsMatch(tak))
                DataList1.DataBind();
            if ((! string.IsNullOrEmpty(tak)) && isNumber.IsMatch(tak))
            {
                MultiView1.SetActiveView(ShopingView);
                Label2.Text = "<h2> " + getTreePath(Request["tak"]) + " </h2>";
                kat = Request["tak"];
            }
            else MultiView1.SetActiveView(WelcomePageView);
            
                Zamawiane.Pokazkoszyk(ref koszykTable);
            string remove = Request.QueryString["remove"];
            if (remove != null)
            {
                Zamawiane.usun(Zamawiane[remove]);
                if (isNumber.IsMatch(kat))
                    Response.Redirect(Request.Url.GetLeftPart(UriPartial.Path) + "?tak=" + kat);
            }
        }

    }
    #region Wypełnianie kategorii
    protected void PobierzKategorie()
    {
        Kolekcjakategorii kategorie = new Kolekcjakategorii();
        TreeView1.DataSource = kategorie;
        TreeView1.DataBind();

    }
    public string getTreePath(string value)
    {
        TreeNodeCollection nodes = TreeView1.Nodes;
        string toreturn = "";
        try
        {
            foreach (TreeNode node in nodes)
            {
                foreach (TreeNode childnode in node.ChildNodes)
                    if (childnode.Value == value)
                    {
                        toreturn = childnode.DataPath;
                        break;
                    }
                if (toreturn != "")
                    break;
            }
        }
        finally
        {
        }
        return toreturn;
    }
    #endregion

    
    protected void Login1_LoggedIn(object sender, EventArgs e)
    {
        if (Roles.IsUserInRole(Login1.UserName, "administrator"))
            Login1.DestinationPageUrl = "~/restricted/admin/Default.aspx";
        if (Roles.IsUserInRole(Login1.UserName, "klient"))
        {
            Login1.DestinationPageUrl = "~/Default.aspx";
        }
        if (Roles.IsUserInRole(Login1.UserName, "manager"))
            Login1.DestinationPageUrl = "~/restricted/manager/Default.aspx";
        if (Roles.IsUserInRole(Login1.UserName, "zarzadca"))
            Login1.DestinationPageUrl = "~/restricted/zarzadca/Default.aspx";
    }
    
    #region Lista towarów pobierana z bazy danych
    protected void DataList1_ItemCommand(object source, DataListCommandEventArgs e)
    {
        DataList1.SelectedIndex = e.Item.ItemIndex;
        DataList1.DataBind();
        string cmd = ((LinkButton)e.CommandSource).CommandName;
        if (cmd == "AddToBasket")
        {
            Zamówienie z = Zamawiane;
            string removeURL = Request.Url.GetLeftPart(UriPartial.Path) + "?remove=" + wybranytowar.Id;

            PozycjaZamowienia p = new PozycjaZamowienia(wybranytowar, removeURL);
            string iloscstr = ((TextBox)e.Item.FindControl("IloscTB")).Text;
            uint ilosc;
            if (uint.TryParse(iloscstr, out ilosc))
                z.zmienilosc(p, ilosc);
            wybranytowar = null;
            Zamawiane = z;
        }
        Zamawiane.Pokazkoszyk(ref koszykTable);
    }
    protected void DataList1_ItemDataBound(object sender, DataListItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.SelectedItem)
        {
            Towar t = new Towar();
            t.CenaJednostkowa = Convert.ToDouble(DataBinder.Eval(e.Item.DataItem, "cenajednostkowa").ToString());
            t.Id = DataBinder.Eval(e.Item.DataItem, "TowarID").ToString();
            t.nazwatowaru = DataBinder.Eval(e.Item.DataItem, "TowarNazwa").ToString();
            t.jednostkamiary = DataBinder.Eval(e.Item.DataItem, "Jednostkamiary").ToString();
            wybranytowar = t;
        }
    }
    #endregion
    #region Przyciski koszyka
    protected void WyczyśćButton_Click(object sender, EventArgs e)
    {
        Zamawiane.wyczysc();
        Zamawiane.Pokazkoszyk(ref koszykTable);
    }

    protected void DoKasyButton_Click(object sender, EventArgs e)
    {
        if (!User.Identity.IsAuthenticated && Zamawiane.IlePozycji() > 0)
        {
            MultiView1.SetActiveView(NonLoggedDoKasyView);
            Zamawiane.Pokazkoszyk(ref koszykTable);
        }
        if (User.IsInRole("klient") && Zamawiane.IlePozycji() > 0)
        {
            MultiView1.SetActiveView(FinalizeShoppingView);
            Zamawiane.PokazSzczegółowyKoszyk(ref koszykszczegółowy);
        }
    }
    protected void AkceptujęZakupButton_Click1(object sender, EventArgs e)
    {
        if (User.IsInRole("klient") && Zamawiane.IlePozycji() > 0)
        {
            Guid klientID = new Guid(Membership.GetUser().ProviderUserKey.ToString());
            Klient k = new Klient(klientID);
            if (Zamawiane.WstawDoBazyZamówienie(k, zapłataRadioButtonList.SelectedValue))
            {
                Zamawiane.wyczysc();
                ThankYouLabel.Text = "Dziękujemy za złożenie zamówienia. Zapraszamy ponownie";
            }
            
        }
    }
    #endregion
    protected void RejestracjaButton_Click(object sender, EventArgs e)
    {
        DoKasyButton.Enabled = false;
        MultiView1.SetActiveView(RejestracjaView);
        Zamawiane.Pokazkoszyk(ref koszykTable);
    }
    #region CreateUserWizard actions
    protected void CreateUserWizard1_CreatedUser(object sender, EventArgs e)
    {
        if (!Roles.RoleExists("klient"))
            Roles.CreateRole("klient");
        Roles.AddUserToRole(CreateUserWizard1.UserName, "klient");

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
    #endregion
    protected void CreateUserWizard1_CancelButtonClick(object sender, EventArgs e)
    {
        DoKasyButton.Enabled = true;
    }
    protected void RezygnujeZZakupuButton_Click(object sender, EventArgs e)
    {
        Zamawiane.wyczysc();
        MultiView1.SetActiveView(WelcomePageView);
    }
    protected void Button1_Click(object sender, EventArgs e)
    {
        MultiView1.SetActiveView(RejestracjaView);
    }
    protected void Login1_LoggingIn(object sender, LoginCancelEventArgs e)
    {
        if (Roles.IsUserInRole(Login1.UserName, "klient") && (Zamawiane.IlePozycji() > 0))
        {
            MultiView1.SetActiveView(ShopingView);
            Login1.Visible = false;
        }
    }
}
