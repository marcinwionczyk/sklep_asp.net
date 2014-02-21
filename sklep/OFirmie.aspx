<%@ Page Title="" Language="C#" MasterPageFile="~/1ColumnMasterPage.master" AutoEventWireup="true" CodeFile="OFirmie.aspx.cs" Inherits="OFirmie" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SingleColumnContentPlaceHolder" Runat="Server">
<h1 class="pagetitle">O Firmie</h1>
<h1>Dane firmy</h1>
    <table style="width: 60%;">
        <tr>
            <td align="right" style="width: 104px">
                Nazwa sklepu:
            </td>
            <td>
                <%=ConfigurationManager.AppSettings["NazwaFirmy"] %> P.H.U. Sieci, Elektronika, Komputery.
            </td>
        </tr>
        <tr>
            <td align="right" style="width: 104px">
                Adres: 
            </td>
            <td>
                <%=ConfigurationManager.AppSettings["AdresFirmy"] %> <br /> <%=ConfigurationManager.AppSettings["KodpocztowyFirmy"] %> <%=ConfigurationManager.AppSettings["MiejscowoscFirmy"] %></td>
        </tr>
        <tr>
            <td align="right" style="width: 104px">
                tel./fax:
            </td>
            <td>
                <%=ConfigurationManager.AppSettings["TelefonDoFirmy"] %></td>
        </tr>
        
        <tr>
            <td align="right" style="width: 104px">
                NIP: </td>
            <td>
                <%=ConfigurationManager.AppSettings["NIPFirmy"]%></td>
        </tr>
        <tr>
            <td style="width: 104px" align="right">
                REGON: </td>
            <td>
            <%=ConfigurationManager.AppSettings["REGONFirmy"]%></td>
        </tr>
    </table>
    <h2>Historia</h2>
    <p>Firma <%=ConfigurationManager.AppSettings["NazwaFirmy"] %> rozpoczęła działalność w 1992 roku i od początku świadczyła usługi w zakresie sprzedaży i serwisowania komuterów oraz kas fiskalnych. w 1996 roku poszerzyliśmy ofertę o usługę serwisową oferowanych produktów, a od 2003 roku udostępniamy internet okolicznym mieszkańcom i instytucjom oraz zajmujemy się budową sieci światłowodowych, radiowych i kablowych.
    </p>
       <p> Dysponujemy dostępem do Dolnośląskiej Sieci Szkieletowej wykonnej w technologii DWDM <cite>Dense Wavelength Division Multiplexing</cite>, o przepustowości do 3 Tb/s. </p>
  
</asp:Content>

