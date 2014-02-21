<%@ Page Title="" Language="C#" MasterPageFile="~/restricted/manager/ManagerMasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="restricted_manager_Default" ValidateRequest="False" %>
<%@ Register TagPrefix="FTB" Namespace="FreeTextBoxControls" Assembly="FreeTextBox" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="../../css/layout1_setup.css" rel="stylesheet" type="text/css" />
    <link href="../../css/layout1_mytext.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .style1
        {
            width: 105px;
        }
        </style>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="AdminContentPlaceHolder" Runat="Server">
    <div class="main">
<div class="main-content">
<h1 class="pagetitle">Zarz¹dzanie towarami</h1>
<h1 class="block">Kategorie</h1>
    <div class="column2-unit-left">
    <p>
    <asp:TreeView ID="TreeView1" runat="server" 
                LeafNodeStyle-ChildNodesPadding="0" LeafNodeStyle-HorizontalPadding="0" 
                LeafNodeStyle-VerticalPadding="0" NodeStyle-ChildNodesPadding="0" 
                LeafNodeStyle-NodeSpacing="0" NodeStyle-HorizontalPadding="0" 
                NodeStyle-NodeSpacing="0" NodeStyle-VerticalPadding="0" 
                ParentNodeStyle-ChildNodesPadding="0" ParentNodeStyle-HorizontalPadding="0" 
                ParentNodeStyle-VerticalPadding="0" ParentNodeStyle-NodeSpacing="0" 
                RootNodeStyle-ChildNodesPadding="0" RootNodeStyle-HorizontalPadding="0" 
                SelectedNodeStyle-HorizontalPadding="0" Width="1px" 
            MaxDataBindDepth="2" ImageSet="Arrows" LineImagesFolder="~/TreeLineImages" 
            ShowLines="True" onselectednodechanged="TreeView1_SelectedNodeChanged" >
        <ParentNodeStyle ChildNodesPadding="0px" 
            HorizontalPadding="0px" NodeSpacing="0px" VerticalPadding="0px" 
            Font-Bold="False" />
        <HoverNodeStyle Font-Underline="True" ForeColor="#5555DD" />

<SelectedNodeStyle HorizontalPadding="0px" Font-Underline="True" ForeColor="#5555DD" 
            VerticalPadding="0px"></SelectedNodeStyle>

        <RootNodeStyle ChildNodesPadding="0px" HorizontalPadding="0px" />
        <NodeStyle ChildNodesPadding="0px" Font-Names="Verdana" Font-Size="8pt" 
            ForeColor="Black" HorizontalPadding="5px" />
        <LeafNodeStyle ChildNodesPadding="0px" HorizontalPadding="0px" 
            NodeSpacing="0px" VerticalPadding="0px" />
            <DataBindings>
            <asp:TreeNodeBinding TextField="nazwa" ValueField="Id" NavigateUrlField="url"/>
            </DataBindings>
    </asp:TreeView>
    </p>
    </div>
    <div class="column2-unit-right">
    <h2>Dodaj kategoriê</h2>
        Wybierz z lewej strony kategoriê w której ma siê znaleŸæ podkategoria:<br />
&nbsp;<div class="tabelka">
        <table width="420px">
        <tbody>
        <tr><td>nadkategoria 
            <br />
                        (0 - kategoria g³ówna): </td>
        <td>
            <asp:TextBox ID="TBnadkat" runat="server" Width="100%"></asp:TextBox>
            </td></tr>
        <tr><td>nazwa:</td><td>
            <asp:TextBox ID="TBKatNazwa" runat="server" Width="100%"></asp:TextBox></td></tr>
        </tbody>
        </table>
        </div>
        <br />
        <p class="right">
            
            <asp:Button ID="BDodaj" runat="server" Text="Dodaj" 
                BorderStyle="Solid" onclick="BDodaj_Click"/>
        </p>
        <p><asp:Label ID="LDodajError" runat="server" ForeColor="Red"></asp:Label></p>
        <h2>Edytuj / usuñ kategoriê</h2>
        Wybierz z lewej strony kategoriê któr¹ chcesz edytowaæ b¹dŸ usun¹æ:
        <div class="tabelka">
        <table>
            <tr>
                <td class="style1">
                    &nbsp;nazwa kategorii:</td>
                <td>
                    
                    <asp:TextBox ID="TextBox1" runat="server" Width="100%"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style1">
                    
                    nadkategoria:</td>
                <td>
                    
                    <asp:TextBox ID="TextBox2" runat="server" Width="100%"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="style1">
                    
                    kategoria:</td>
                <td>
                    
                    <asp:Label ID="Label1" runat="server"></asp:Label>
                </td>
            </tr>
            </table>
         </div>
            <br />
        <p class="right">
           <asp:Button ID="BUaktualnij" runat="server" Text="Uaktualnij" 
                BorderStyle="Solid" onclick="BUaktualnij_Click" CssClass="button" /> &nbsp;
            <asp:Button ID="Busun" runat="server" Text="Usuñ" BorderStyle="Solid" 
                onclick="Busun_Click" />
                
        </p>
        <p>* usuniêcie kategorii powoduje usuniêcie wszystkich produktów w danej kategorii. 
            Nale¿y uprzednio przenieœæ wszystkie produkty do innej kategorii        </p>
        <p>
            <asp:Label ID="LEdUsKategorie" runat="server" ForeColor="Red"></asp:Label>
        </p>
        
    </div>
        
<h1 class="block">Towary</h1>
    <p>
        &nbsp;</p>
    <div class="tabelka">
        <asp:GridView ID="GridView1" runat="server" DataSourceID="SqlDataSource1" 
            AutoGenerateColumns="False" AllowSorting="True" 
            DataKeyNames="TowarID" AllowPaging="True" 
            onselectedindexchanged="GridView1_SelectedIndexChanged" 
            onsorted="GridView1_Sorted">
            <Columns>
                <asp:CommandField ShowSelectButton="True" />
                <asp:BoundField DataField="kategoriaID" HeaderText="kategoriaID" 
                    SortExpression="kategoriaID" >
                </asp:BoundField>
                <asp:BoundField DataField="TowarNazwa" HeaderText="Nazwa Towaru" 
                    SortExpression="TowarNazwa" HtmlEncode="False" >
                </asp:BoundField>
                <asp:BoundField DataField="Jednostkamiary" HeaderText="Jednostka miary" 
                    SortExpression="Jednostkamiary" >
                </asp:BoundField>
            </Columns>
            
        </asp:GridView>
    </div>
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
            ConnectionString="<%$ ConnectionStrings:home %>" 
            SelectCommand="SELECT kategoriaID, TowarNazwa, Opistowaru, Jednostkamiary, TowarID, cenajednostkowa FROM Towary ORDER BY kategoriaID" 
        DeleteCommand="DELETE FROM [Towary] WHERE [TowarID] = @original_TowarID" 
        InsertCommand="INSERT INTO Towary(kategoriaID, TowarNazwa, Opistowaru, Jednostkamiary, cenajednostkowa) VALUES (@kategoriaID, @TowarNazwa, @Opistowaru, @Jednostkamiary, @cenajednostkowa)" 
        OldValuesParameterFormatString="original_{0}" 
        
        UpdateCommand="UPDATE Towary SET kategoriaID = @kategoriaID, TowarNazwa = @TowarNazwa, Opistowaru = @Opistowaru, Jednostkamiary = @Jednostkamiary, cenajednostkowa = @cenajednostkowa WHERE (TowarID = @original_TowarID)">
        <DeleteParameters>
            <asp:Parameter Name="original_TowarID" Type="Object" />
        </DeleteParameters>
        <UpdateParameters>
            <asp:Parameter Name="kategoriaID" Type="Int32" />
            <asp:Parameter Name="TowarNazwa" Type="String" />
            <asp:Parameter Name="Opistowaru" Type="String" />
            <asp:Parameter Name="Jednostkamiary" Type="String" />
            <asp:Parameter Name="cenajednostkowa" />
            <asp:Parameter Name="original_TowarID" Type="Empty" />
        </UpdateParameters>
        <InsertParameters>
            <asp:Parameter Name="kategoriaID" Type="Int32" />
            <asp:Parameter Name="TowarNazwa" Type="String" />
            <asp:Parameter Name="Opistowaru" Type="String" />
            <asp:Parameter Name="Jednostkamiary" Type="String" />
            <asp:Parameter Name="cenajednostkowa" />
        </InsertParameters>
            </asp:SqlDataSource>
            <p>
    <asp:FormView ID="FormView1" runat="server" DataKeyNames="kategoriaID,TowarID" 
        DataSourceID="SqlDataSource1" Width="838px" onitemupdating="FormView1_ItemUpdating"  
                    oniteminserting="FormView1_ItemInserting" >
        <PagerSettings FirstPageText=" pierwsza " LastPageText=" ostatnia " 
            Mode="NumericFirstLast" NextPageText=" nastêpna " 
            PreviousPageText="poprzednia" />
        <EditItemTemplate>
            <table style="width:100%;">
                <tr>
                    <td align="right">
                        kategoriaID:<br />
                        (wybierz kategoriê z góry)</td>
                    <td>
                        <asp:TextBox ID="kategoriaIDTextBox" runat="server" 
                            Text='<%# Bind("kategoriaID") %>' />
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Nazwa Towaru:</td>
                    <td>
                        <asp:TextBox ID="TowarNazwaTextBox" runat="server" 
                            Text='<%# Bind("TowarNazwa") %>' />
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Jednostka miary:</td>
                    <td>
                        <asp:TextBox ID="JednostkamiaryTextBox" runat="server" 
                            Text='<%# Bind("Jednostkamiary") %>' />
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Cena jednostkowa:</td>
                    <td>
                        <asp:TextBox ID="CenajednostkowaTB" runat="server" 
                            Text='<%# Bind("cenajednostkowa", "{0:C}") %>'></asp:TextBox>
                    </td>
                </tr>
            </table>
            <br />
            Opis towaru:
            <br />
            <FTB:FreeTextBox runat="server" ID="FreeTextBoxEdit" Text='<%#Bind("Opistowaru")%>' OnDataBinding="FreeTextBox_DataBinding"></FTB:FreeTextBox>
            <br />
            <asp:LinkButton ID="UpdateButton" runat="server" CausesValidation="True" 
                CommandName="Update" Text="Uaktualnij" />
&nbsp;<asp:LinkButton ID="UpdateCancelButton" runat="server" CausesValidation="False" 
                CommandName="Cancel" Text="Anuluj" />
            <br />
        </EditItemTemplate>
        <InsertItemTemplate>
            <table style="width:100%;">
                <tr>
                    <td align="right">
                        kategoriaID:</td>
                    <td>
                        <asp:TextBox ID="kategoriaIDTextBox" runat="server" 
                            Text='<%# Bind("kategoriaID") %>' OnDataBinding="kategoriaID_DataBinding" />
                        <asp:Label ID="Label4" runat="server" ondatabinding="kategoria_DataBinding"></asp:Label>
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Nazwa Towaru:</td>
                    <td>
                        <asp:TextBox ID="TowarNazwaTextBox" runat="server" 
                            Text='<%# Bind("TowarNazwa") %>' MaxLength="50" />
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        Jednostka miary:</td>
                    <td>
                        <asp:TextBox ID="Jednostkamiary2TextBox" runat="server" 
                            Text='<%# Bind("Jednostkamiary") %>' /></td>
                </tr>
                <tr>
                    <td align="right">
                        Cena jednostkowa:
                    </td>
                    <td>
                        <asp:TextBox ID="CenaJednostkowaTB" runat="server" 
                            Text='<%# Bind("cenajednostkowa", "{0:C}") %>'></asp:TextBox>
                    </td>
                </tr>
            </table>
                <br />
                Opistowaru:
            <br />
            <FTB:FreeTextBox ID="InsertFreeTextBox" runat="server" Text='<%# Bind("Opistowaru") %>'></FTB:FreeTextBox>
            <br />
            <asp:LinkButton ID="InsertButton" runat="server" CausesValidation="True" 
                CommandName="Insert" Text="Wstaw" />
            &nbsp;<asp:LinkButton ID="InsertCancelButton" runat="server" 
                CausesValidation="False" CommandName="Cancel" Text="Anuluj" />
        </InsertItemTemplate>
        <ItemTemplate>
            <table>
                <tr>
                    <td>
                        kategoriaID:
                        <asp:Label ID="kategoriaIDLabel" runat="server" 
                            Text='<%# Eval("kategoriaID") %>' />
                    </td>
                </tr>
                <tr>
                    <td>
                        Nazwa Towaru:
                        <asp:Label ID="TowarNazwaLabel" runat="server" 
                            Text='<%# Eval("TowarNazwa") %>' />
                    </td>
                </tr>
                <tr>
                    <td>
                        Jednostka miary:
                        <asp:Label ID="JednostkamiaryLabel" runat="server" 
                            Text='<%# Eval("Jednostkamiary") %>' />
                    </td>
                </tr>
            </table>
            <asp:Label ID="Label3" runat="server" Text='<%# Server.HtmlDecode(DataBinder.Eval(Container.DataItem, "Opistowaru").ToString()) %>'></asp:Label>
            <br />
            <asp:LinkButton ID="EditButton" runat="server" CausesValidation="False" 
                CommandName="Edit" Text="Edytuj" />
            &nbsp;<asp:LinkButton ID="DeleteButton" runat="server" CausesValidation="False" 
                CommandName="Delete" Text="Usuñ" />
            &nbsp;<asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" 
                CommandName="New" Text="Nowy towar" />
        </ItemTemplate>
        <EmptyDataTemplate>
           
            <asp:LinkButton ID="NewButton" runat="server" CausesValidation="False" 
                CommandName="New" Text="Nowy towar" />
           
        </EmptyDataTemplate>
    </asp:FormView>  
    </p>     
    <br />
</div>
</div>
<div class="footer">
  <p>Copyright &copy; 2009 ElSiKo | All Rights Reserved</p><p class="credits">Design by <a href="http://www.1-2-3-4.info/" title="Strona Projektanta">Wolfgang</a> | Modified by <a href="http://www.marcinwionczyk.info" title="Strina domowa osoby modyfikuj¹cej">Marcin Wionczyk</a> | <a href="http://validator.w3.org/check?uri=referer" title="Validate XHTML code">XHTML 1.0</a> | <a href="http://jigsaw.w3.org/css-validator/" title="Validate CSS code">CSS 2.0</a></p>   
 </div>
 


</asp:Content>

