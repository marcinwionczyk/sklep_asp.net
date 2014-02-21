using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Data;
using MainStuff;
using System.Collections;
using FreeTextBoxControls;

public partial class restricted_manager_Default : System.Web.UI.Page
{

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            PobierzKategorie();
            TreeView1.CollapseAll();
        }
        TBnadkat.Text = Label1.Text = Request["tak"];
        TextBox1.Text = Request["awzan"];
        TextBox2.Text = Request["takdan"];
    }
   
    protected void PobierzKategorie()
    {
        Kolekcjakategorii kategorie = new Kolekcjakategorii();
        TreeView1.DataSource = kategorie;
        TreeView1.DataBind();     
    }
    protected void BDodaj_Click(object sender, EventArgs e)
    {
        SqlConnection PołączenieSQL = new SqlConnection(ConfigurationManager.ConnectionStrings["home"].ConnectionString);
        try
        {
            PołączenieSQL.Open();
            SqlCommand KomendaSQL = PołączenieSQL.CreateCommand();
            KomendaSQL.CommandText = "INSERT INTO [dbo].[Kategoria] (" +
              "  nadkategoriaID, KatNazwa" +
              ") VALUES (" +
              "  @nadkategoriaID, @KatNazwa" +
              ")";
            KomendaSQL.Parameters.Add("@nadkategoriaID", SqlDbType.Int, 4);
            KomendaSQL.Parameters.Add("@KatNazwa", SqlDbType.NVarChar, 50);
            KomendaSQL.Parameters["@nadkategoriaID"].Value = Convert.ToInt32(TBnadkat.Text);
            KomendaSQL.Parameters["@KatNazwa"].Value = TBKatNazwa.Text;
            KomendaSQL.ExecuteNonQuery();
        }
        catch(Exception exc)
        {
            LDodajError.Text = "Dodanie kategorii nie powiodło się: " + exc.ToString();
        }
        finally
        {
            PołączenieSQL.Close();
        }
        PobierzKategorie();
    }
    protected void BUaktualnij_Click(object sender, EventArgs e)
    {
        SqlConnection PołączenieSQL = new SqlConnection(ConfigurationManager.ConnectionStrings["home"].ConnectionString);
        try
        {
            PołączenieSQL.Open();
            SqlCommand KomendaSQL = PołączenieSQL.CreateCommand();
            KomendaSQL.CommandText = "UPDATE [dbo].[Kategoria]" +
                "SET [nadkategoriaID] = @nadkategoriaID" +
                ",[KatNazwa] = @KatNazwa " +
                "WHERE (kategoriaID = @kategoriaID);";
            KomendaSQL.Parameters.Add("@nadkategoriaID", SqlDbType.Int, 4);
            KomendaSQL.Parameters.Add("@kategoriaID", SqlDbType.Int, 4);
            KomendaSQL.Parameters.Add("@KatNazwa", SqlDbType.NVarChar, 50);
            KomendaSQL.Parameters["@nadkategoriaID"].Value = Convert.ToInt32(TextBox2.Text);
            KomendaSQL.Parameters["@kategoriaID"].Value = Convert.ToInt32(Label1.Text);
            KomendaSQL.Parameters["@KatNazwa"].Value = TextBox1.Text;
            KomendaSQL.ExecuteNonQuery();
        }
        catch (Exception exc)
        {
            LDodajError.Text = "Uaktualnienie kategorii nie powiodło się: " + exc.ToString();
        }
        finally
        {
            PołączenieSQL.Close();
        }
        PobierzKategorie();
        TreeView1.CollapseAll();
    }

    protected void Busun_Click(object sender, EventArgs e)
    {
        using (SqlConnection PołączenieSQL = new SqlConnection(ConfigurationManager.ConnectionStrings["home"].ConnectionString))
        {
            PołączenieSQL.Open();
            SqlCommand KomendaSQL = PołączenieSQL.CreateCommand();
            SqlTransaction TransakcjaSQL;  
            TransakcjaSQL = PołączenieSQL.BeginTransaction("usunkategorie");
            KomendaSQL.Connection = PołączenieSQL;
            KomendaSQL.Transaction = TransakcjaSQL;
            try
            {
                KomendaSQL.CommandText = "DELETE FROM [dbo].[Towary]" +
                    "WHERE kategoriaID in (SELECT kategoriaID from dbo.Kategoria where (nadkategoriaID = @kategoriaID));" +
                    "DELETE FROM [dbo].[Kategoria] WHERE (nadkategoriaID = @kategoriaID);" +
                    "DELETE FROM [dbo].[Towary] WHERE (kategoriaID = @kategoriaID);" +
                    "DELETE FROM [dbo].[Kategoria] WHERE (kategoriaID = @kategoriaID);";
                KomendaSQL.Parameters.Add("@kategoriaID", SqlDbType.Int, 4);
                KomendaSQL.Parameters["@kategoriaID"].Value = Convert.ToInt32(Label1.Text);
                KomendaSQL.ExecuteNonQuery();
                TransakcjaSQL.Commit();
                TreeView1.CollapseAll();
            }
            catch (Exception exc)
            {
                LEdUsKategorie.Text = "Usunięcie kategorii nie powiodło się. Przyczyna: " + exc.ToString();
                try
                {
                    TransakcjaSQL.Rollback();
                }
                catch (Exception exc2)
                {
                    LEdUsKategorie.Text += ";;; " + exc2.ToString();
                }
            }   
        }
        
        PobierzKategorie();
    }
 
    protected void GridView1_SelectedIndexChanged(object sender, EventArgs e)
    {
        FormView1.PageIndex = GridView1.SelectedIndex + (GridView1.PageIndex * GridView1.PageSize);
    }

    protected void TreeView1_SelectedNodeChanged(object sender, EventArgs e)
    {
        ((TextBox)FormView1.Row.FindControl("kategoriaIDTextBox")).Text = Request["tak"];
    }

    protected void FormView1_ItemUpdating(object sender, FormViewUpdateEventArgs e)
    {
        foreach (DictionaryEntry entry in e.NewValues)
        {
            e.NewValues[entry.Key] = System.Web.HttpUtility.HtmlEncode(entry.Value.ToString());  
        }
    }
    
    protected void FormView1_ItemInserting(object sender, FormViewInsertEventArgs e)
    {
        foreach (DictionaryEntry entry in e.Values)
        {
            e.Values[entry.Key] = System.Web.HttpUtility.HtmlEncode(entry.Value.ToString());
        }
    }
    protected void FreeTextBox_DataBinding(object sender, EventArgs e)
    {
        ((FreeTextBox)sender).Text = Server.HtmlDecode(((FreeTextBox)sender).Text);
    }
    protected void kategoriaID_DataBinding(object sender, EventArgs e)
    {
        if (Request.QueryString["tak"] != null)
        {
            ((TextBox)sender).Text = Request["tak"].ToString();
        }
        else ((TextBox)sender).Text = string.Empty;
    }
    protected void kategoria_DataBinding(object sender, EventArgs e)
    {
        if (Request.QueryString["awzan"] != null)
            ((Label)sender).Text = Request["awzan"].ToString();
        else ((Label)sender).Text = string.Empty;
    }

    protected void GridView1_Sorted(object sender, EventArgs e)
    {
        FormView1.PageIndex = GridView1.SelectedIndex + (GridView1.PageIndex * GridView1.PageSize);
    }
}

