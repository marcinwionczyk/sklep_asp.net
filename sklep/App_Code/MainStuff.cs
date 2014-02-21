using System;
using System.Web;
using System.Web.Profile;
using System.Web.Security;
using System.Data;
using System.Data.Sql;
using System.Security.Cryptography;
using System.Data.SqlClient;
using System.Data.SqlTypes;
using System.Collections;
using System.Collections.Generic;
using System.Xml;
using System.Text.RegularExpressions;
using Microsoft.SqlServer.Server;
using System.Text;
using System.Configuration;
using System.Web.UI;
using System.ComponentModel;
using System.Web.UI.WebControls;
using System.Data.Common;
using System.Globalization;
using System.Net.Mail; 


/// <summary>
/// Summary description for MainStuff
/// </summary>
/// 
namespace MainStuff
{
    public class Transakcja
    {
        public enum StatusZamówienia
        {
            OczekiwanieNaZapłatę,
            ZamówieniePrzyjęto,
            WydawanieTowaru,
            TowarWysłano,
            ZamówienieZrealizowane
        }
        private Klient _klient;
        private List<PozycjaZamowienia> _pozycje = new List<PozycjaZamowienia>();
        private DateTime _DataZakupu;
        private Guid _TransakcjaID;
        private Transakcja.StatusZamówienia _status;
        private string _formapłatności;
        /// <summary>
        /// Wczytuje Transakcje z bazy danych
        /// </summary>
        /// <param name="TransakcjaID">Klucz identyfikujący transakcje</param>
        public string Imie { get { return _klient.Imie; } }
        public string Nazwisko { get { return _klient.Nazwisko; } }
        public string Adres { get { return _klient.Adres; } }
        public string Email { get { return _klient.email; } }
        public string KodPocztowy { get { return _klient.KodPocztowy; } }
        public string Miejscowosc { get { return _klient.Miejscowosc; } }
        public string NazwaFirmy { get { return _klient.NazwaFirmy; } }
        public string NIP { get { return _klient.NIP; } }
        public string Telefon { get { return _klient.Telefon; } }
        public string REGON { get { return _klient.REGON; } }
        public string nrFaktury
        {
            get
            {
                string[] abc = _TransakcjaID.ToString().Split('-');
                string toreturn = string.Empty;
                foreach (string a in abc)
                    toreturn += long.Parse(a, NumberStyles.AllowHexSpecifier).ToString() + "/";
                return toreturn;
            }
        }
        public double sumabrutto
        {
            get {
            double suma = 0;
            foreach (PozycjaZamowienia p in _pozycje)
            {
                suma += p.CenaJednostkowa;
            }
            return suma;
            }
        }
        public double sumanetto
        {
            get { return (sumabrutto / 1.22) ; }
        }
        public void ponaglenie()
        {
            SmtpClient client = new SmtpClient();
            client.DeliveryMethod = SmtpDeliveryMethod.Network;
            MailAddress from = new MailAddress("wiono@interia.pl");
            MailAddress to = new MailAddress(_klient.email);
            MailMessage newmail = new MailMessage(from, to);
            newmail.Subject = "ElSiKo. Nie zapłacono za zamówienie nr: " + this.nrFaktury;
            StringBuilder sb = new StringBuilder();
            sb.AppendLine("W dniu " + _DataZakupu.Date.ToLongDateString() + " w sklepie ElSiKo  zostały zamówione następujące rzeczy: ");
            foreach (PozycjaZamowienia p in _pozycje)
            {
                sb.AppendLine(p.ilosc + " " + p.jednostkamiary + " x " + p.nazwatowaru + ", Wartość: " + string.Format("{0:c}",p.WartoscPozycji()));
            }
            sb.AppendLine("RAZEM: " + string.Format("{0:c}",this.sumabrutto));
            sb.AppendLine();
            sb.AppendLine("Proszę wspomnianą kwotę wpłacić na nr konta: " + ConfigurationManager.AppSettings["KontoFirmy"].ToString());
            sb.AppendLine(ConfigurationManager.AppSettings["NazwaFirmy"].ToString() +  "P.H.U. Sieci, Elektronika, Komputery.");
            sb.AppendLine(ConfigurationManager.AppSettings["AdresFirmy"].ToString());
            sb.AppendLine(ConfigurationManager.AppSettings["KodpocztowyFirmy"].ToString() + " " + ConfigurationManager.AppSettings["MiejscowoscFirmy"].ToString());
            sb.AppendLine("Tytułem: " + nrFaktury);
            newmail.Body = sb.ToString();
            client.Send(newmail);
        }
        public Transakcja(Guid TransakcjaID)
        {
            if (TransakcjaID != Guid.Empty)
                _TransakcjaID = TransakcjaID;
            else return;
            using (SqlConnection PołączenieSQL = new SqlConnection(ConfigurationManager.ConnectionStrings["home"].ConnectionString))
            {
                PołączenieSQL.Open();
                SqlCommand KomendaSQL1 = PołączenieSQL.CreateCommand();
                KomendaSQL1.Connection = PołączenieSQL;
                SqlCommand KomendaSQL2 = PołączenieSQL.CreateCommand();
                KomendaSQL2.Connection = PołączenieSQL;
                try
                {
                    KomendaSQL1.CommandText = "SELECT składasiez.TowarID, Towary.TowarNazwa, składasiez.ilosc, Towary.Jednostkamiary, składasiez.cenajednostkowa FROM składasiez INNER JOIN Towary ON składasiez.TowarID = Towary.TowarID WHERE (składasiez.TransakcjaID = @TransakcjaID)";
                    KomendaSQL1.Parameters.Add("@TransakcjaID", SqlDbType.UniqueIdentifier);
                    KomendaSQL1.Parameters["@TransakcjaID"].Value = _TransakcjaID;
                    KomendaSQL2.CommandText = "SELECT UserId, DataZamowienia, statuszamowienia, formaPlatnosci FROM zamowieniaKlientow WHERE (TransakcjaID = @TransakcjaID)"; KomendaSQL2.Parameters.Add("@TransakcjaID", SqlDbType.UniqueIdentifier);
                    KomendaSQL2.Parameters["@TransakcjaID"].Value = _TransakcjaID;
                    SqlDataReader OdczytSQL = KomendaSQL1.ExecuteReader();
                    if (OdczytSQL.HasRows)
                        while (OdczytSQL.Read())
                        {
                            PozycjaZamowienia p = new PozycjaZamowienia();
                            p.Id = OdczytSQL.GetGuid(OdczytSQL.GetOrdinal("TowarID")).ToString();
                            p.nazwatowaru = OdczytSQL.GetString(OdczytSQL.GetOrdinal("TowarNazwa"));
                            p.ilosc = Convert.ToUInt32(OdczytSQL.GetValue(OdczytSQL.GetOrdinal("ilosc")));
                            p.jednostkamiary = OdczytSQL.GetString(OdczytSQL.GetOrdinal("Jednostkamiary"));
                            p.CenaJednostkowa = Convert.ToDouble(OdczytSQL.GetValue(OdczytSQL.GetOrdinal("cenajednostkowa")));
                            _pozycje.Add(p);
                        }
                    OdczytSQL.Close();
                    OdczytSQL = KomendaSQL2.ExecuteReader(CommandBehavior.SingleRow);
                    if (OdczytSQL.HasRows)
                    {
                        OdczytSQL.Read();
                        Guid userID = OdczytSQL.GetGuid(OdczytSQL.GetOrdinal("UserId"));
                        Klient k = new Klient(userID);
                        _klient = k;
                        _DataZakupu = OdczytSQL.GetDateTime(1);
                        string status = OdczytSQL.GetString(2);
                        switch (status)
                        {
                            case "oczekiwanie na zapłatę":
                                {
                                    _status = StatusZamówienia.OczekiwanieNaZapłatę;
                                    break;
                                }
                            case "zamówienie przyjęto":
                                {
                                    _status = StatusZamówienia.ZamówieniePrzyjęto;
                                    break;
                                }
                            case "wydawanie towaru":
                                {
                                    _status = StatusZamówienia.WydawanieTowaru;
                                    break;
                                }
                            case "towar wysłano":
                                {
                                    _status = StatusZamówienia.TowarWysłano;
                                    break;
                                }
                            case "zamówienie zrealizowane":
                                {
                                    _status = StatusZamówienia.ZamówienieZrealizowane;
                                    break;
                                }
                        }
                        _formapłatności = OdczytSQL.GetString(3);

                    }
                }
                finally { PołączenieSQL.Close(); }
            }
        }
        public void ZmienStatus(Transakcja.StatusZamówienia st)
        {
            _status = st;
            string status = "";
            switch (st)
            {
                case StatusZamówienia.OczekiwanieNaZapłatę: 
                    { status = "oczekiwanie na zapłatę"; break; }
                case StatusZamówienia.TowarWysłano:
                    { status = "towar wysłano"; break; }
                case StatusZamówienia.WydawanieTowaru:
                    { status = "wydawanie towaru"; break; }
                case StatusZamówienia.ZamówieniePrzyjęto:
                    { status = "zamówienie przyjęto"; break; }
                case StatusZamówienia.ZamówienieZrealizowane:
                    { status = "zamówienie zrealizowane"; break; }
            }
            using (SqlConnection PołączenieSQL = new SqlConnection(ConfigurationManager.ConnectionStrings["home"].ConnectionString))
            {
                PołączenieSQL.Open();
                SqlCommand KomendaSQL = PołączenieSQL.CreateCommand();
                KomendaSQL.Connection = PołączenieSQL;
                KomendaSQL.CommandText = "UPDATE [dbo].[zamowieniaKlientow] SET [statuszamowienia] = @status WHERE [TransakcjaID] = @TransakcjaID";
                KomendaSQL.Parameters.Add("@status", SqlDbType.VarChar, 50);
                KomendaSQL.Parameters["@status"].Value = status;
                KomendaSQL.Parameters.Add("@TransakcjaID", SqlDbType.UniqueIdentifier);
                KomendaSQL.Parameters["@TransakcjaID"].Value = _TransakcjaID;
                KomendaSQL.ExecuteNonQuery();
            }
        }
        public void Usuń()
        {
            if (_status != StatusZamówienia.ZamówienieZrealizowane)
                return;
            using(SqlConnection PołączenieSQL = new SqlConnection(ConfigurationManager.ConnectionStrings["home"].ConnectionString))
            {
                PołączenieSQL.Open();
                SqlCommand KomendaSQL = PołączenieSQL.CreateCommand();
                KomendaSQL.Connection = PołączenieSQL;
                SqlTransaction TransakcjaSQL = PołączenieSQL.BeginTransaction("usuwaniezamówień");
                KomendaSQL.Transaction = TransakcjaSQL;
                StringBuilder Command = new StringBuilder();
                Command.AppendLine("DELETE FROM [składasiez] WHERE ([TransakcjaID] = @TransakcjaID);");
                Command.AppendLine("DELETE FROM [zamowieniaKlientow] WHERE ([TransakcjaID] = @TransakcjaID);");
                KomendaSQL.CommandText =  Command.ToString();
                KomendaSQL.Parameters.Add("@TransakcjaID",SqlDbType.UniqueIdentifier);
                KomendaSQL.Parameters["@TransakcjaID"].Value = _TransakcjaID;
                try {
                    TransakcjaSQL.Save("przedusunięciem");
                    KomendaSQL.ExecuteNonQuery();
                    TransakcjaSQL.Commit();
                }
                catch
                {
                    TransakcjaSQL.Rollback("przedusunięciem");
                }
                finally
                {
                    PołączenieSQL.Close();
                }
            }
        }
    }
    public class Klient
    {
        private Guid _klientID;
        private string _Imie;
        private string _Nazwisko;
        private string _Adres;
        private string _KodPocztowy;
        private string _Miejscowosc;
        private string _Telefon;
        private string _NazwaFirmy;
        private string _Nip;
        private string _REGON;
        private string _email;
        public Guid ID { get { return _klientID; } }
        public string Imie { get { return _Imie; } }
        public string Nazwisko { get { return _Nazwisko; } }
        public string Adres { get { return _Adres; } }
        public string KodPocztowy { get { return _KodPocztowy; } }
        public string Miejscowosc { get { return _Miejscowosc; } }
        public string Telefon { get { return _Telefon; } }
        public string NazwaFirmy { get { return _NazwaFirmy; } }
        public string NIP { get { return _Nip; } }
        public string REGON { get { return _REGON; } }
        public string email { get { return _email; } }
        public Klient()
        {
            try
            {
                MembershipUser user = Membership.GetUser();
                if (Roles.IsUserInRole(user.UserName, "klient"))
                {
                    this._klientID = new Guid(user.ProviderUserKey.ToString());
                    ProfileCommon profil = (ProfileCommon)ProfileCommon.Create(user.UserName, true);
                    this._Imie = profil.Imie;
                    this._Nazwisko = profil.Nazwisko;
                    this._Adres = profil.Adres;
                    this._email = user.Email;
                    this._KodPocztowy = profil.KodPocztowy;
                    this._Miejscowosc = profil.Miejscowość;
                    this._NazwaFirmy = profil.NazwaFirmy;
                    this._Nip = profil.NIP;
                    this._REGON = profil.REGON;
                    this._Telefon = profil.Telefon;
                }
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
            }
        }
        public Klient(Guid klientID)
        {
            try
            {
                MembershipUser user = Membership.GetUser(klientID);
                this._klientID = klientID;
                ProfileCommon profil = (ProfileCommon)ProfileCommon.Create(user.UserName, true);
                this._Imie = profil.Imie;
                this._Nazwisko = profil.Nazwisko;
                this._Adres = profil.Adres;
                this._email = user.Email;
                this._KodPocztowy = profil.KodPocztowy;
                this._Miejscowosc = profil.Miejscowość;
                this._NazwaFirmy = profil.NazwaFirmy;
                this._Nip = profil.NIP;
                this._REGON = profil.REGON;
                this._Telefon = profil.Telefon;
            }
            catch (Exception ex)
            {
                Console.WriteLine(ex.ToString());
            }
        }
    }
    public class PozycjaZamowienia : Towar
    {
        public uint ilosc;
        public string removeURL;
        public PozycjaZamowienia(Towar p, string url)
        {
            this.Id = p.Id;
            this.nazwatowaru = p.nazwatowaru;
            this.CenaJednostkowa = p.CenaJednostkowa;
            this.jednostkamiary = p.jednostkamiary;
            this.ilosc = 1;
            this.removeURL = url;
        }
        public PozycjaZamowienia()
        {
        }
        public double WartoscPozycji()
        {
            return (this.CenaJednostkowa * this.ilosc);
        }
    }
    public class Zamówienie
    {
        private Hashtable _zamówienia = new Hashtable();
        private double _Vat = 0.22;
        public double Vat {
            set {
                double[] stawkiVat = new double[] {0, 0.07, 0.22 };
                foreach(double a in stawkiVat)
                    if (value == a)
                        _Vat = value;
            }
            get { return _Vat; }
        }
        public double CałkowitaWartość()
        {
            if (_zamówienia.Count == 0) return 0.0;
            else
            {
                IEnumerator pozycja = _zamówienia.Values.GetEnumerator();
                double suma = 0;
                while (pozycja.MoveNext())
                {
                    suma += ((PozycjaZamowienia)pozycja.Current).WartoscPozycji();
                }
                return suma;
            }
        }
        public double CalkowitaWartoscZVAT()
        {
            return (CałkowitaWartość() * (1 + this._Vat));
        }
        public PozycjaZamowienia this[string Id]
        {
            get
            {
                return (PozycjaZamowienia)_zamówienia[Id];
            }
        }
        public void dodaj(PozycjaZamowienia p)
        {
            if (_zamówienia[p.Id] == null)
            {
                _zamówienia.Add(p.Id, p);
            }
            else
            {
                PozycjaZamowienia oI = (PozycjaZamowienia)_zamówienia[p.Id];
                oI.ilosc = oI.ilosc + 1;
            }
        }
        public void usun(PozycjaZamowienia p)
        {
            if (_zamówienia[p.Id] != null)
                _zamówienia.Remove(p.Id);
        }

        public void zmienilosc(PozycjaZamowienia p, uint ilosc)
        {
            if (ilosc > 0)
            {
                if ((_zamówienia[p.Id]) != null)
                {
                    PozycjaZamowienia oI = (PozycjaZamowienia)_zamówienia[p.Id];
                    oI.ilosc = ilosc;
                }
                else 
                {
                    p.ilosc = ilosc;
                    _zamówienia.Add(p.Id, p);
                }
            }
            else _zamówienia.Remove(p.Id);
        }
        public void wyczysc()
        {
            _zamówienia.Clear();
        }
        public int IlePozycji()
        {
            return (_zamówienia.Count);
        }
        public void Pokazkoszyk(ref Table T)
        {
            if (_zamówienia.Count == 0) 
                return;
            TableHeaderRow hr = new TableHeaderRow();
            TableHeaderCell hc = new TableHeaderCell();
            hc.Text = "Nazwa Towaru";
            hc.Width = 125;
            hr.Cells.Add(hc);
            hc = new TableHeaderCell();
            hc.Text = "Ilość";
            hc.Width = 40;
            hr.Cells.Add(hc);
            hc = new TableHeaderCell();
            hc.Width = 25;
            hc.Text = "j.m.";
            hr.Cells.Add(hc);
            hc = new TableHeaderCell();
            hc.Text = "Wartość";
            hc.Width = 60;
            hr.Cells.Add(hc);
            T.Rows.Add(hr);

            IEnumerator pozycja = _zamówienia.Values.GetEnumerator();
            while (pozycja.MoveNext())
            {
                PozycjaZamowienia p = ((PozycjaZamowienia)pozycja.Current);
                TableRow r = new TableRow();
                // nazwa towaru
                TableCell c = new TableCell();
                c.Width = 125;
                c.Wrap = true;
                c.Text = p.nazwatowaru + "<br />" + "<a href=" + p.removeURL + ">usuń</a>";
                r.Cells.Add(c);
                // ilość
                c = new TableCell();
                c.Width = 30;
                c.HorizontalAlign = HorizontalAlign.Right;
                c.Text = p.ilosc.ToString() + " ";
                r.Cells.Add(c);
                // jednostka miary
                c = new TableCell();
                c.Width = 25;
                c.Text = p.jednostkamiary;
                r.Cells.Add(c);
                c = new TableCell();
                c.HorizontalAlign = HorizontalAlign.Right;
                c.Text = string.Format("{0:c}", p.CenaJednostkowa * p.ilosc);
                r.Cells.Add(c);
                T.Rows.Add(r);
            }

            // Stopka
            TableFooterRow fr = new TableFooterRow();
            TableCell tc = new TableCell();
            tc.ColumnSpan = 4;
            tc.HorizontalAlign = HorizontalAlign.Right;
            tc.Text = "<b>Do zapłaty: </b>" + string.Format("{0:c}", this.CałkowitaWartość());
            fr.Cells.Add(tc);
            T.Rows.Add(fr);
        }
        public void PokazSzczegółowyKoszyk(ref Table T)
        {
            if (_zamówienia.Count == 0)
                return;
            TableHeaderRow hr = new TableHeaderRow();
            TableHeaderCell hc = new TableHeaderCell();
            hc.Text = "Nazwa Towaru";
            hc.Width = 250;
            hr.Cells.Add(hc);
            hc = new TableHeaderCell();
            hc.Text = "Ilość";
            hr.Cells.Add(hc);
            hc = new TableHeaderCell();
            hc.Text = "Cena jednostkowa";
            hr.Cells.Add(hc);
            hc = new TableHeaderCell();
            hc.Text = "Wartość";
            hr.Cells.Add(hc);
            T.Rows.Add(hr);

            IEnumerator pozycja = _zamówienia.Values.GetEnumerator();
            while (pozycja.MoveNext())
            {
                PozycjaZamowienia p = ((PozycjaZamowienia)pozycja.Current);
                TableRow r = new TableRow();
                // nazwa towaru
                TableCell c = new TableCell();
                c.Text = p.nazwatowaru;
                c.Wrap = true;
                r.Cells.Add(c);
                // ilość
                c = new TableCell();
                c.Text = p.ilosc.ToString() + " " + p.jednostkamiary;
                r.Cells.Add(c);
                c = new TableCell();
                c.HorizontalAlign = HorizontalAlign.Right;
                c.Text = string.Format("{0:c}", p.CenaJednostkowa);
                r.Cells.Add(c);
                c = new TableCell();
                c.HorizontalAlign = HorizontalAlign.Right;
                c.Text = string.Format("{0:c}", p.CenaJednostkowa * p.ilosc);
                r.Cells.Add(c);
                T.Rows.Add(r);
            }

            // Stopka
            TableFooterRow fr = new TableFooterRow();
            TableCell tc = new TableCell();
            tc.ColumnSpan = 4;
            tc.HorizontalAlign = HorizontalAlign.Right;
            tc.Text = "<b>Do zapłaty: </b>" + string.Format("{0:c}", this.CałkowitaWartość());
            fr.Cells.Add(tc);
            T.Rows.Add(fr);
        }
        public bool WstawDoBazyZamówienie(Klient k, string formapłatności)
        {
            bool _toreturn;
            using (SqlConnection PołączenieSQL = new SqlConnection(ConfigurationManager.ConnectionStrings["home"].ConnectionString))
            {
                PołączenieSQL.Open();
                SqlCommand KomendaSQL = PołączenieSQL.CreateCommand();
                SqlCommand KomendaSQL2 = PołączenieSQL.CreateCommand();
                SqlTransaction TransakcjaSQL;  
                TransakcjaSQL = PołączenieSQL.BeginTransaction("dodajzamowienie");
                KomendaSQL.Connection = PołączenieSQL;
                KomendaSQL.Transaction = TransakcjaSQL;
                KomendaSQL2.Connection = PołączenieSQL;
                KomendaSQL2.Transaction = TransakcjaSQL;
                Guid TransakcjaID = Guid.Empty;
                try
                {
                    KomendaSQL.CommandText = "INSERT INTO [zamowieniaKlientow] ([UserId], [formaPlatnosci], [statuszamowienia], [DataZamowienia]) OUTPUT inserted.TransakcjaID VALUES (@UserId, @formaPlatnosci, @statuszamowienia, @DataZamowienia)";
                    KomendaSQL.Parameters.Add("@UserID", SqlDbType.UniqueIdentifier);
                    KomendaSQL.Parameters["@UserID"].Value = k.ID;
                    KomendaSQL.Parameters.Add("@formaPlatnosci", SqlDbType.VarChar, 50);
                    KomendaSQL.Parameters["@formaPlatnosci"].Value = formapłatności;
                    KomendaSQL.Parameters.Add("@statuszamowienia", SqlDbType.VarChar, 50);
                    KomendaSQL.Parameters["@statuszamowienia"].Value = "zamówienie przyjęto";
                    KomendaSQL.Parameters.Add("@DataZamowienia", SqlDbType.DateTime);
                    KomendaSQL.Parameters["@DataZamowienia"].Value = DateTime.Now;
                    TransakcjaID = new Guid(KomendaSQL.ExecuteScalar().ToString());
                    if (TransakcjaID != Guid.Empty && TransakcjaID != null)
                    {
                        KomendaSQL2.CommandText = "INSERT INTO [składasiez]([TowarID],[TransakcjaID],[ilosc],[cenajednostkowa]) VALUES (@TowarID, @TransakcjaID, @ilosc, @cenajednostkowa)";
                        KomendaSQL2.Parameters.Add("@TowarID", SqlDbType.UniqueIdentifier);
                        KomendaSQL2.Parameters.Add("@TransakcjaID", SqlDbType.UniqueIdentifier);
                        KomendaSQL2.Parameters.Add("@ilosc", SqlDbType.SmallInt);
                        KomendaSQL2.Parameters.Add("@cenajednostkowa",SqlDbType.Money);
                        IEnumerator pozycja = _zamówienia.Values.GetEnumerator();
                        while (pozycja.MoveNext())
                        {
                            PozycjaZamowienia p = ((PozycjaZamowienia)pozycja.Current);
                            KomendaSQL2.Parameters["@TowarID"].Value = new Guid(p.Id);
                            KomendaSQL2.Parameters["@TransakcjaID"].Value = TransakcjaID;
                            KomendaSQL2.Parameters["@ilosc"].Value = p.ilosc;
                            KomendaSQL2.Parameters["@cenajednostkowa"].Value = p.CenaJednostkowa;
                            KomendaSQL2.ExecuteNonQuery();
                        }

                    }
                    TransakcjaSQL.Commit();
                    _toreturn = true;
                }
                catch (Exception Exc1)
                {
                    Console.WriteLine("Dodanie zamówienia do bazy danych nie powiodło się, przyczyna: " + Exc1.Message);
                    _toreturn = false;
                    try { TransakcjaSQL.Rollback("dodajzamowienie"); }
                    catch (Exception Exc2) { Console.WriteLine("Cofnięcie transakcji dodania zamówienia nie powiodło się, przyczyna: " + Exc2.Message); _toreturn = false; }
                }
            }
            return _toreturn;
        }
    }
    public class Towar
    {
        private string _TowarID;
        private string _towarNazwa;
        private double _cenajednostkowa;
        private string _jm;
        
        public string Id
        {
            get { return _TowarID; }
            set { _TowarID = value; }
        }

        public string nazwatowaru
        {
            get { return _towarNazwa; }
            set { _towarNazwa = value; }
        }
        
        public double CenaJednostkowa
        {
            get { return _cenajednostkowa; }
            set { _cenajednostkowa = value; }
        }
        public string jednostkamiary
        {
            get { return _jm; }
            set { _jm = value; }
        }
    }
    /// Klasy dotyczace wyświetlania kategorii w kontrolce TreeView1
    #region CategoryStuff
    /// <summary>
    /// Klasa reprezentująca kategorię
    /// </summary>
    /// <see cref="http://weblogs.asp.net/gunnarpeipman/archive/2007/10/01/asp-net-and-hierarchical-data.aspx"/>
    public class Kategoria
    {
        
        private int _KategoriaID = 0;
        private string _nazwaKategorii;
        private Kategoria _Nadkategoria; // rodzic
        private IList<Kategoria> _podkategorie; // kategorie potomne
        
        public int Id
        {
            get { return this._KategoriaID; }
            set { this._KategoriaID = value; }
        }
        public string nazwa
        {
            get { return this._nazwaKategorii; }
            set { this._nazwaKategorii = value; }
        }
        public Kategoria nadkategoria
        {
            get { return this._Nadkategoria; }
            set { this._Nadkategoria = value; }
        }
        public IList<Kategoria> podkategorie
        {
            get { return this._podkategorie; }
            set { this._podkategorie = value; }
        }
        public string url
        {
            get
            {
                string temp;
                if (nadkategoria == null)
                    temp = "0";
                else
                    temp = Convert.ToString(nadkategoria.Id);
                return HttpContext.Current.Request.Url.AbsolutePath + "?tak=" + Convert.ToString(Id) + "&takdan=" + temp + "&awzan=" + HttpUtility.UrlEncode(nazwa);
            }
        }
    }
    /// <summary>
    /// Kolekcja kategorii implementująca interfejs IHierarchicalEnumerable
    /// </summary>
    /// <see cref="http://weblogs.asp.net/gunnarpeipman/archive/2007/10/01/asp-net-and-hierarchical-data.aspx"/>
    public class Kolekcjakategorii : IHierarchicalEnumerable
    {
        private IList<Kategoria> ListaKategorii = null;
        /// <summary>
        /// Konstruktor klasy
        /// </summary>
        /// <param name="ListaPodkategorii"> Lista wszystkich podkategorii. </param>
        public Kolekcjakategorii(IList<Kategoria> ListaKategorii)
        {
            this.ListaKategorii = ListaKategorii;
        }

        public Kolekcjakategorii()
        {
            IList<Kategoria> kategorie = new List<Kategoria>();
       Kategoria kategoria;
       IEnumerator<Kategoria> enumerator = (IEnumerator<Kategoria>)kategorie.GetEnumerator();
       SqlConnection PołączenieSQL = new SqlConnection(ConfigurationManager.ConnectionStrings["home"].ConnectionString);
       using (PołączenieSQL)
       {
           try
           {
               PołączenieSQL.Open();
               SqlCommand KomendaSQL = PołączenieSQL.CreateCommand();
               KomendaSQL.Connection = PołączenieSQL;
               KomendaSQL.CommandText = "SELECT [kategoriaID]"
                   + ",[nadkategoriaID]"
                   + ",[KatNazwa] "
                   + "FROM [dbo].[Kategoria] ";
               SqlDataReader OdczytSQL = KomendaSQL.ExecuteReader();
               while (OdczytSQL.Read())
               {
                   kategoria = new Kategoria();
                   if (OdczytSQL.GetInt32(1) == 0)
                   {
                       kategoria.nadkategoria = null;
                       kategoria.Id = OdczytSQL.GetInt32(0);
                       kategoria.nazwa = OdczytSQL.GetString(2);
                       kategorie.Add(kategoria);
                   }
                   else
                   {
                       enumerator = (IEnumerator<Kategoria>)kategorie.GetEnumerator();
                       while (enumerator.MoveNext())
                           if (enumerator.Current.Id == OdczytSQL.GetInt32(1))
                               break;
                       kategoria.nadkategoria = enumerator.Current;
                       kategoria.Id = OdczytSQL.GetInt32(0);
                       kategoria.nazwa = OdczytSQL.GetString(2);
                       IList<Kategoria> podkat = enumerator.Current.podkategorie;
                       if (podkat == null)
                           podkat = new List<Kategoria>();
                       podkat.Add(kategoria);
                       enumerator.Current.podkategorie = podkat;
                       kategorie.Add(kategoria);
                   }
               }
           }
           finally { PołączenieSQL.Close(); }
       }
       enumerator = (IEnumerator<Kategoria>)kategorie.GetEnumerator();
       IList<Kategoria> kategoriegłówne = new List<Kategoria>();
       while (enumerator.MoveNext())
           if (enumerator.Current.nadkategoria == null)
               kategoriegłówne.Add(enumerator.Current);
           else break;
       enumerator.Dispose();
       this.ListaKategorii = kategoriegłówne;
        }
        /// <summary>
        /// Zwraca zaimplementowaną metodę interfejsu IHierarchicalEnumerable
        /// GetHierarchyData
        /// </summary>
        /// <param name="o">objekt kategorii
        /// </param>   
        public IHierarchyData GetHierarchyData(object o)
        {
            return new SpisKategorii((Kategoria)o);
        }
        /// <summary>
        /// Zwraca enumerator
        /// </summary>
        public IEnumerator GetEnumerator()
        {
            return ListaKategorii.GetEnumerator();
        }
    }
    /// <summary>
    /// Klasa reprezentująca spis kategorii w postaci schierarchizowanej
    /// </summary>
    /// <see cref="http://weblogs.asp.net/gunnarpeipman/archive/2007/10/01/asp-net-and-hierarchical-data.aspx"/>
    public class SpisKategorii : IHierarchyData
    {
        private Kategoria _kategoria;
        /// <summary>
        /// Konstruktor klasy
        /// </summary>
        /// <param name="kategoria">Kategoria wraz z wszystkimi podkategoriami</param>
        public SpisKategorii(Kategoria kategoria)
        {
            this._kategoria = kategoria;
        }
        /// <summary>
        /// Pobiera wszystkie kategorie w bieżącej kategorii
        /// </summary>
        /// <returns>obiekt reprezentujący wszystkie podkategorie w bierzącej kategorii</returns>
        public IHierarchicalEnumerable GetChildren()
        {
            return new Kolekcjakategorii(this._kategoria.podkategorie);
        }
        /// <summary>
        /// zwraca nadrzędną kategorię
        /// </summary>
        /// <returns>zwraca nadrzędną kategorię</returns>
        public IHierarchyData GetParent()
        {
            return new SpisKategorii(this._kategoria.nadkategoria);
        }
        /// <summary>
        /// sprawdza czy dana kategoria ma jakieś podkategorie
        /// </summary>
        public bool HasChildren
        {
            get
            {
                if (this._kategoria.podkategorie == null)
                    return false;
                return (this._kategoria.podkategorie.Count > 0);
            }
        }
        /// <summary>
        /// zwraca kategorię
        /// </summary>
        public object Item
        {
            get { return _kategoria; }
        }
        /// <summary>
        /// zwraca ścieżke do kategorii
        /// </summary>
        public string Path
        {
            get
            {
                Kategoria kategoria = this._kategoria;
                string s = Convert.ToString(this._kategoria.nazwa);
                while ((kategoria = kategoria.nadkategoria) != null)
                    s = Convert.ToString(kategoria.nazwa) + " : " + s;
                return s.Trim();
            }
        }
        public string Type
        {
            get { return this._kategoria.ToString(); }
        }
    }
    /// <summary>
    /// Klasa odpowiedzialna za wczytywanie listy kategorii
    /// </summary>
    #endregion
}
