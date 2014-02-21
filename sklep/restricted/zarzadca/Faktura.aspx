<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Faktura.aspx.cs" Inherits="restricted_zarzadca_Faktura" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="../../css/layout1_text.css" rel="stylesheet" type="text/css" />
    <link href="../../css/layout1_setup.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div class="main">
    <div class="main-content">
        <table style="width:100%;">
            <tr>
                <td rowspan="2">
                <h2>SPRZEDAWCA</h2>
                    <%=ConfigurationManager.AppSettings["NazwaFirmy"]  %> P.H.U. Sieci, Elektronika, Komputery. <br />
                    <%=ConfigurationManager.AppSettings["AdresFirmy"] %> <br /> <%=ConfigurationManager.AppSettings["KodpocztowyFirmy"] %> <%=ConfigurationManager.AppSettings["MiejscowoscFirmy"] %> <br />
                    Telefon: <%=ConfigurationManager.AppSettings["TelefonDoFirmy"] %> <br />
                    NIP: <%=ConfigurationManager.AppSettings["NIPFirmy"]%>
                    
                    </td>
                <td align="right">
                    <h1>FAKTURA</h1></td>
            </tr>
            <tr>
                <td align="right">
                    Nr faktury: 
                    <asp:Literal ID="NrFaktury" runat="server"></asp:Literal><br />
                    Data: <%=DateTime.Now.ToShortDateString() %>
                    </td>
            </tr>
        </table>
        <div class="column2-unit-right">
        <h2>NABYWCA</h2>
        <asp:Literal ID="LFirmaNazwa" runat="server"></asp:Literal> <br />
        <asp:Literal ID="LImie" runat="server"></asp:Literal>
        <asp:Literal ID="LNazwisko" runat="server"></asp:Literal> <br />
        <asp:Literal ID="LAdres" runat="server"></asp:Literal> <br />
        <asp:Literal ID="LKodPocztowy" runat="server"></asp:Literal>
        <asp:Literal ID="LMiejscowosc" runat="server"></asp:Literal> <br />
        Telefon: <asp:Literal ID="LTelefon" runat="server"></asp:Literal><br />
        Fax: <asp:Literal ID="LFax" runat="server"></asp:Literal><br />
        E-Mail: <asp:Literal ID="LEmail" runat="server"></asp:Literal> <br />
        NIP: <asp:Literal ID="NIP" runat="server"></asp:Literal>
        </div>
        
        <hr class="clear-contentunit" />
        <h2></h2>
        <div class="tabelka">
        <asp:Table ID="Table1" runat="server">
        <asp:TableHeaderRow>
        <asp:TableHeaderCell>l.p.</asp:TableHeaderCell>
        <asp:TableHeaderCell>Nazwa towaru</asp:TableHeaderCell>
        <asp:TableHeaderCell>j.m.</asp:TableHeaderCell>
        <asp:TableHeaderCell>Ilość</asp:TableHeaderCell>
        <asp:TableHeaderCell>Cena netto</asp:TableHeaderCell>
        <asp:TableHeaderCell>Wartość netto</asp:TableHeaderCell>
        <asp:TableHeaderCell>Stawka VAT</asp:TableHeaderCell>
        <asp:TableHeaderCell>Warość VAT</asp:TableHeaderCell>
        <asp:TableHeaderCell>Wartość Brutto</asp:TableHeaderCell>
        </asp:TableHeaderRow>
        
        </asp:Table>
        </div>
    </div>
    </div>
    </form>
</body>
</html>
