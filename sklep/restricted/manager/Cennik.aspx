<%@ Page Title="" Language="C#" MasterPageFile="~/restricted/manager/ManagerMasterPage.master" AutoEventWireup="true" CodeFile="Cennik.aspx.cs" Inherits="restricted_manager_Cennik" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="../../css/layout1_setup.css" rel="stylesheet" type="text/css" />
    <link href="../../css/layout1_mytext.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="AdminContentPlaceHolder" Runat="Server">
<div class="main">
<div class="main-content">
<h1 class="pagetitle">Zarządzanie cennikiem</h1>
<div class="tabelka">
<asp:GridView ID="GridView1" 
        runat="server" AllowPaging="True" 
        AutoGenerateColumns="False" DataKeyNames="TowarID" 
        DataSourceID="SqlDataSource1" >
        <Columns>
            <asp:CommandField ShowEditButton="True" />
            <asp:BoundField DataField="kategoriaID" HeaderText="kategoriaID" 
                ReadOnly="True" SortExpression="kategoriaID" />
            <asp:BoundField DataField="TowarNazwa" HeaderText="Nazwa towaru" 
                ReadOnly="True" SortExpression="TowarNazwa" />
            <asp:BoundField DataField="Jednostkamiary" HeaderText="j.m." 
                ReadOnly="True" SortExpression="Jednostka miary" />
                <asp:BoundField DataField="cenajednostkowa" HeaderText="Cena" 
                SortExpression="Cena" DataFormatString="{0:c}" />
        </Columns>
        <EditRowStyle Width="80px" />
    </asp:GridView>
    </div>

    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:home %>" 
            SelectCommand="SELECT [kategoriaID], [TowarNazwa], [Opistowaru], [Jednostkamiary], [cenajednostkowa], [TowarID] FROM [Towary] ORDER BY [kategoriaID]" 
        OldValuesParameterFormatString="original_{0}" 
        
        
        
        UpdateCommand="UPDATE [Towary] SET [cenajednostkowa] = @cenajednostkowa WHERE [TowarID] = @original_TowarID">
        <UpdateParameters>
            <asp:Parameter Name="cenajednostkowa" Type="Decimal" />
            <asp:Parameter Name="original_TowarID" Type="Empty" />
        </UpdateParameters>
            </asp:SqlDataSource>
    
    &nbsp;
    </div>
</div>
<div class="footer">
  <p>Copyright &copy; 2009 ElSiKo | All Rights Reserved</p><p class="credits">Design by <a href="http://www.1-2-3-4.info/" title="Strona Projektanta">Wolfgang</a> | Modified by <a href="http://www.marcinwionczyk.info" title="Strina domowa osoby modyfikującej">Marcin Wionczyk</a> | <a href="http://validator.w3.org/check?uri=referer" title="Validate XHTML code">XHTML 1.0</a> | <a href="http://jigsaw.w3.org/css-validator/" title="Validate CSS code">CSS 2.0</a></p></div></asp:Content>