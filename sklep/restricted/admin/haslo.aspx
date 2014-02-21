<%@ Page Title="" Language="C#" MasterPageFile="~/restricted/admin/AdminMasterPage.master" AutoEventWireup="true" CodeFile="haslo.aspx.cs" Inherits="restricted_admin_haslo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="AdminContentPlaceHolder" Runat="Server">
    <div class="main">
  
      <!-- B.1 MAIN CONTENT -->
      <div class="main-content">
      <div style="margin: 50px auto 50px auto;">
          <asp:ChangePassword ID="ChangePassword1" runat="server" UserName="admin" 
              CancelDestinationPageUrl="~/restricted/admin/Default.aspx" 
              ContinueDestinationPageUrl="~/restricted/admin/Default.aspx" 
              SuccessPageUrl="~/restricted/admin/Default.aspx">
          </asp:ChangePassword>
          </div>
      </div>
      </div>
      <div class="footer">
      <p>Copyright &copy; 2009 ElSiKo | All Rights Reserveddded</p><p class="credits">Design by <a href="http://www.1-2-3-4.info/" title="Strona Projektanta">Wolfgang</a> | Modified by <a href="http://www.marcinwionczyk.info" title="Strina domowa osoby modyfikującej">Marcin Wionczyk</a> | <a href="http://validator.w3.org/check?uri=referer" title="Validate XHTML code">XHTML 1.0</a> | <a href="http://jigsaw.w3.org/css-validator/" title="Validate CSS code">CSS 2.0</a></p></div>
</asp:Content>

