<%@ Page Title="" Language="C#" MasterPageFile="~/restricted/manager/ManagerMasterPage.master" AutoEventWireup="true" CodeFile="haslo.aspx.cs" Inherits="restricted_manager_haslo" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<link href="../../css/layout1_setup.css" rel="stylesheet" type="text/css" />
    <link href="../../css/layout1_mytext.css" rel="stylesheet" type="text/css" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="AdminContentPlaceHolder" Runat="Server">
<div class="main">
<div class="main-content">
    <asp:ChangePassword ID="ChangePassword1" runat="server" CancelDestinationPageUrl="~/restricted/manager/Default.aspx" ContinueDestinationPageUrl="~/restricted/manager/Default.aspx" SuccessPageUrl="~/restricted/manager/Default.aspx">
    </asp:ChangePassword>
</div>
</div>
<div class="footer">
  <p>Copyright &copy; 2009 ElSiKo | All Rights Reserved</p><p class="credits">Design by <a href="http://www.1-2-3-4.info/" title="Strona Projektanta">Wolfgang</a> | Modified by <a href="http://www.marcinwionczyk.info" title="Strina domowa osoby modyfikującej">Marcin Wionczyk</a> | <a href="http://validator.w3.org/check?uri=referer" title="Validate XHTML code">XHTML 1.0</a> | <a href="http://jigsaw.w3.org/css-validator/" title="Validate CSS code">CSS 2.0</a></p></div>
</asp:Content>

