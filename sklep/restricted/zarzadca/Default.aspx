<%@ Page Title="" Language="C#" MasterPageFile="~/restricted/zarzadca/ZarzadcaMasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="restricted_zarzadca_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="AdminContentPlaceHolder" Runat="Server">
    
    <div class="main">
    <div class="main-content">
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:home %>" 
            
            
            SelectCommand="SELECT [TransakcjaID] FROM [zamowieniaKlientow] WHERE ([statuszamowienia] = @statuszamowienia) ORDER BY [DataZamowienia]">
        <SelectParameters>
            <asp:Parameter DefaultValue="oczekiwanie na zapłatę" Name="statuszamowienia" 
                Type="String" />
        </SelectParameters>
    </asp:SqlDataSource>
    Data dzisiejsza: <asp:Label ID="DataDzisiejszaL" runat="server" Text="Label"></asp:Label>
        <asp:DataList ID="DataList1" runat="server" CellPadding="4" 
            DataKeyField="TransakcjaID" DataSourceID="SqlDataSource1" ForeColor="#333333" 
            onitemcommand="DataList1_ItemCommand" onitemdatabound="DataList1_ItemDataBound" 
            Width="100%" onitemcreated="DataList1_ItemCreated">
            <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
            <AlternatingItemStyle BackColor="White" />
            <ItemStyle BackColor="#E3EAEB" />
            <SelectedItemStyle BackColor="#C5BBAF" Font-Bold="True" ForeColor="#333333" />
            <HeaderTemplate>
                <span style="float: left; width:150px">Od kiedy</span>
                <span style="float: left; width: 325px">Nr Transakcji</span>
                <span style="float: left; width: 110px">Forma płatności</span>
                <span style="float: left; width: 100px">Do zapłaty</span>
            </HeaderTemplate>
            <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
            <ItemTemplate>
                
                <asp:HiddenField ID="HiddenField" runat="server" Value='<%# Eval("TransakcjaID") %>'/>    
                
                <asp:Label ID="OdKiedy" runat="server"></asp:Label>
                <asp:Label ID="NrTransakcji" runat="server"></asp:Label>
                <asp:Label ID="FormaPłatności" runat="server"></asp:Label>
                <asp:Label ID="DoZapłaty" runat="server"></asp:Label>
                <asp:LinkButton ID="ponaglenie" runat="server">Ponaglenie</asp:LinkButton>
                <asp:LinkButton ID="LinkButton1" runat="server">Zapłacono</asp:LinkButton>
                <br />
                <div class="column2-unit-left">
                    Dane klienta:
                </div>
                <div class="column2-unit-right">
                    Zamówienie:</div>
                
            </ItemTemplate>
        </asp:DataList>
        <br />
    </div>
    </div>
</asp:Content>

