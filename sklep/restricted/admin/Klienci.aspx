<%@ Page Title="" Language="C#" MasterPageFile="~/restricted/admin/AdminMasterPage.master" AutoEventWireup="true" CodeFile="Klienci.aspx.cs" Inherits="restricted_admin_klienci" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="AdminContentPlaceHolder" Runat="Server">
    <div class="main">
<div class="main-content">
<h1 class="pagetitle">Klienci</h1>
    <asp:DataList ID="DataList1" runat="server" 
        oncancelcommand="DataList1_CancelCommand" oneditcommand="DataList1_EditCommand" 
        onitemcommand="DataList1_ItemCommand" onupdatecommand="DataList1_UpdateCommand">
         <ItemTemplate>
              <asp:LinkButton id="button1" runat="server" Text="pokaż szczegóły" CommandName="select" />
              <%# DataBinder.Eval(Container.DataItem, "imie") %>
              <%# DataBinder.Eval(Container.DataItem, "nazwisko") %>
              login: <%# DataBinder.Eval(Container.DataItem, "login") %>
                 </ItemTemplate>
                <EditItemTemplate>
                    login:<asp:Label 
                        ID="Llogin" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "login") %>'></asp:Label>
                    <br />
                    Imię:
                    <asp:TextBox 
                        ID="TBimie" runat="server" Width="100%" Text='<%# DataBinder.Eval(Container.DataItem, "imie") %>'></asp:TextBox>
                    Nazwisko:
                    <asp:TextBox ID="TBnazwisko" runat="server" Width="100%" Text='<%# DataBinder.Eval(Container.DataItem, "nazwisko") %>'></asp:TextBox>
                    email:
                    <asp:TextBox ID="TBemail" runat="server" Width="100%" Text='<%# DataBinder.Eval(Container.DataItem, "email") %>'></asp:TextBox>
                    <br />
                    &nbsp;adres:
                    <asp:TextBox ID="TBadres" runat="server" Width="100%" Text='<%# DataBinder.Eval(Container.DataItem, "adres") %>'></asp:TextBox>
                    kod pocztowy:
                    <asp:TextBox ID="TBkod" runat="server" Width="100%" Text='<%# DataBinder.Eval(Container.DataItem, "kod") %>'></asp:TextBox>
                    miejscowość:
                    <asp:TextBox ID="TBmiejscowosc" runat="server" Width="100%" Text='<%# DataBinder.Eval(Container.DataItem, "miejscowosc") %>'></asp:TextBox>
                    telefon:
                    <asp:TextBox ID="TBtelefon" runat="server" Width="100%" Text='<%# DataBinder.Eval(Container.DataItem, "telefon") %>'></asp:TextBox>
                    Nazwa Firmy:
                    <asp:TextBox ID="TBfirma" runat="server" Width="100%" Text='<%# DataBinder.Eval(Container.DataItem, "firma") %>'></asp:TextBox>
                    NIP:<asp:TextBox ID="TBnip" runat="server" Width="100%" Text='<%# DataBinder.Eval(Container.DataItem, "nip") %>'></asp:TextBox>
                    REGON:
                    <asp:TextBox ID="TBREGON" runat="server" Width="100%" Text='<%# DataBinder.Eval(Container.DataItem, "regon") %>'></asp:TextBox>
                    <br />
                    <asp:CheckBox ID="CheckBox1" runat="server" Text="zresetuj hasło" />
                    <br />
                    może się logować ?: <asp:DropDownList ID="DropDownList" runat="server">
                        <asp:ListItem>tak</asp:ListItem>
                        <asp:ListItem>nie</asp:ListItem>
                    </asp:DropDownList>
                    <asp:TextBox ID="TBhaslo" runat="server" Width="100%" Text='nowe hasło'></asp:TextBox>
                    <br />
                    <asp:LinkButton ID="LBzapisz" runat="server" CommandName="update">Zapisz</asp:LinkButton>
                    &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CommandName="cancel">Anuluj</asp:LinkButton>
                    
                </EditItemTemplate>
                <SelectedItemTemplate>
                 <%# DataBinder.Eval(Container.DataItem, "imie") %> <%# DataBinder.Eval(Container.DataItem, "nazwisko") %>, login: <%# DataBinder.Eval(Container.DataItem, "login") %>, email: <%# DataBinder.Eval(Container.DataItem, "email") %> <br />
                adres: <%# DataBinder.Eval(Container.DataItem, "adres") %>, <%# DataBinder.Eval(Container.DataItem, "kod") %> <%# DataBinder.Eval(Container.DataItem, "miejscowosc") %> <br />
                telefon: <%# DataBinder.Eval(Container.DataItem, "telefon") %> <br />
                Nazwa firmy: <%# DataBinder.Eval(Container.DataItem, "firma") %> <br />
                NIP: <%# DataBinder.Eval(Container.DataItem, "nip") %> <br />
                REGON: <%# DataBinder.Eval(Container.DataItem, "regon") %> <br />
                data ostatniego logowania: <%# DataBinder.Eval(Container.DataItem, "aktywnosc", "{0:d}")%>, może się logować ?: <%# DataBinder.Eval(Container.DataItem,"isapproved") %>
                <br />
                     <asp:LinkButton ID="LinkButton1" runat="server" CommandName="edit">Edytuj dane</asp:LinkButton>
                </SelectedItemTemplate>
    </asp:DataList>
    <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
</div>
</div>
<div class="footer">

      <p>Copyright &copy; 2009 ElSiKo | All Rights Reserveddded</p><p class="credits">Design by <a href="http://www.1-2-3-4.info/" title="Strona Projektanta">Wolfgang</a> | Modified by <a href="http://www.marcinwionczyk.info" title="Strina domowa osoby modyfikującej">Marcin Wionczyk</a> | <a href="http://validator.w3.org/check?uri=referer" title="Validate XHTML code">XHTML 1.0</a> | <a href="http://jigsaw.w3.org/css-validator/" title="Validate CSS code">CSS 2.0</a></p></div>
</asp:Content>

