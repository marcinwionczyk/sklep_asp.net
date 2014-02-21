<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMasterPage.master" AutoEventWireup="true" CodeFile="Rejestracja.aspx.cs" Inherits="Rejestracja" %>

<%@ Register assembly="CheckboxValidator" namespace="TensaiLabs.Web.Controls" tagprefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <link href="css/layout2_setup.css" rel="stylesheet" type="text/css" />
    <link href="css/layout2_text.css" rel="stylesheet" type="text/css" />
    <style type="text/css">
        .style3
    {
        width: 132px;
    }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="SiteContentPlaceHolder" Runat="Server">
    <div class="main">
 
      <!-- B.1 MAIN NAVIGATION -->
      <div class="main-navigation">

        <!-- Navigation Level 3 -->
        <div class="round-border-topright"></div>
        <h1 class="first">Kategorie</h1>

        <!-- Navigation with grid style -->
        <dl class="nav3-grid">
          <dt><a href="#">Navlink 11</a></dt>
          <dt><a href="#">Navlink 12</a></dt>
            <dd><a href="#">Navlink 121</a></dd>
            <dd><a href="#">Navlink 122</a></dd>

            <dd><a href="#">Navlink 123</a></dd>		
          <dt><a href="#">Navlink 13</a></dt>
          <dt><a href="#">Navlink 14</a></dt>
          <dt><a href="#">Navlink 15</a></dt>
        </dl>                        
    </div>
    <div class="main-content">
    <h1 class="pagetitle">Rejestracja</h1>
    <br />
        <asp:CreateUserWizard ID="CreateUserWizard1" runat="server" BorderWidth="0px" 
            CssClass="top" Height="522px" 
            AnswerLabelText="Odpowiedź:" CancelButtonText="Anuluj" 
            CreateUserButtonText="Stwórz konto użytkownika" 
            oncreateduser="CreateUserWizard1_CreatedUser" 
            CancelButtonType="Link" ContinueButtonType="Link" CreateUserButtonType="Link" 
            FinishCompleteButtonType="Link" FinishPreviousButtonType="Link" 
            oncontinuebuttonclick="CreateUserWizard1_ContinueButtonClick" 
            onfinishbuttonclick="CreateUserWizard1_FinishButtonClick" 
            StartNextButtonType="Link" StepNextButtonType="Link" 
            StepPreviousButtonType="Link" >
            <FinishCompleteButtonStyle BorderColor="Black" BorderStyle="Solid" 
                BorderWidth="1px" />
            <ContinueButtonStyle BorderColor="Black" BorderStyle="Solid" 
                BorderWidth="1px" />
            <NavigationButtonStyle BorderColor="Black" BorderStyle="Solid" 
                BorderWidth="1px" />
            <TextBoxStyle Width="90%" />
            <CreateUserButtonStyle BorderColor="Black" BorderStyle="Solid" 
                BorderWidth="1px" />
            <FinishPreviousButtonStyle BorderColor="Black" BorderStyle="Solid" 
                BorderWidth="1px" />
            <CancelButtonStyle BorderColor="Black" BorderStyle="Solid" BorderWidth="1px" />
            <WizardSteps>
                <asp:CreateUserWizardStep ID="CreateUserWizardStep1" runat="server" 
                    Title="Stwórz nowe konto">
                </asp:CreateUserWizardStep>
                <asp:WizardStep runat="server" Title="Podaj swoje dane" StepType="Auto">
                <table>
                <tr>
                <td align="right" class="style3">Imię: </td><td>
                    <asp:TextBox ID="Imię" runat="server" Width="90%" AutoCompleteType="FirstName"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="Imię" ErrorMessage="Proszę podać imię" 
                        ValidationGroup="CUWnext">*</asp:RequiredFieldValidator>
                    <br />
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                        ControlToValidate="Imię" Display="Dynamic" Font-Size="X-Small" 
                        ValidationExpression="[a-zA-ZĄĆĘŁŃŚÓŹŻąćęłśńóźż]+" ValidationGroup="CUWnext">Imię składa się wyłącznie z liter</asp:RegularExpressionValidator>
                    </td>
                </tr>
                    <tr>
                        <td align="right" class="style3">
                            Nazwisko: </td>
                        <td>
                            <asp:TextBox ID="Nazwisko" runat="server" Width="90%" 
                                AutoCompleteType="LastName"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                ControlToValidate="Nazwisko" ErrorMessage="Proszę podac nazwisko" 
                                ValidationGroup="CUWnext">*</asp:RequiredFieldValidator>
                            <br />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator9" runat="server" 
                                ControlToValidate="Nazwisko" Display="Dynamic" Font-Size="X-Small" 
                                ValidationExpression="[a-zA-ZĄĆĘŚŁŃÓŹŻąćęłńśóźż]+" ValidationGroup="CUWnext">Nazwisko składa się tylko z liter</asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" class="style3">
                            Adres: </td>
                        <td>
                            <asp:TextBox ID="Adres" runat="server" Width="90%" 
                                AutoCompleteType="HomeStreetAddress"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                                ControlToValidate="Adres" ErrorMessage="Proszę podać adres" 
                                ValidationGroup="CUWnext">*</asp:RequiredFieldValidator>
                            &nbsp;<br />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator10" 
                                runat="server" ControlToValidate="Adres" Font-Size="X-Small" 
                                ValidationExpression="[a-zA-ZĄĆŚĘŁŃÓŹŻąćęłńśóźż/., 0-9]+" 
                                ValidationGroup="CUWnext">tylko litery, cyfry, oraz znaki: myślnik, kropka, przecinek, spacja, ukośnik</asp:RegularExpressionValidator>
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" class="style3">
                            Kod pocztowy: </td>
                        <td>
                            <asp:TextBox ID="Kod" runat="server" Width="90%" AutoCompleteType="HomePhone"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                                ControlToValidate="Kod" ErrorMessage="Proszę podać kod pocztowy" 
                                ValidationGroup="CUWnext">*</asp:RequiredFieldValidator>
                            <br />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                                ControlToValidate="Kod" Display="Dynamic" Font-Size="X-Small" 
                                ValidationExpression="\d{2}-\d{3}" ValidationGroup="CUWnext">nieprawidłowy format kodu pocztowego</asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" class="style3">
                            Miejscowość: </td>
                        <td>
                            <asp:TextBox ID="Miejscowosc" runat="server" Width="90%" 
                                AutoCompleteType="HomeCity" ValidationGroup="CUWnext"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                                ControlToValidate="Miejscowosc" ErrorMessage="Proszę podać miejscowość" 
                                ValidationGroup="CUWnext">*</asp:RequiredFieldValidator>
                            <br />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" 
                                ControlToValidate="Miejscowosc" Font-Size="X-Small" 
                                ValidationExpression="[a-zA-ZĄĆŚĘŁŃÓŹŻąćęłńśóźż. ]+" ValidationGroup="CUWnext">Nazwa miejscowości składa się tylko z liter</asp:RegularExpressionValidator>
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td align="right" class="style3">
                            Telefon: </td>
                        <td>
                            <asp:TextBox ID="Telefon" runat="server" Width="90%" 
                                AutoCompleteType="Cellular"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                                ControlToValidate="Telefon" ErrorMessage="Proszę podać telefon" 
                                ValidationGroup="CUWnext">*</asp:RequiredFieldValidator>
                            <br />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" 
                                ControlToValidate="Telefon" Font-Size="X-Small" 
                                ValidationExpression="(\(\d{2}\)\d{7}|\d{9})" ValidationGroup="CUWnext">nieprawidłowy numer telefonu (format numeru (AA)BBBBBBB lub BBBBBBBBB (komórka), AA - nr kierunkowy, B - pozostałe cyfry)</asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" class="style3">
                            Fax: </td>
                        <td>
                            <asp:TextBox ID="Fax" runat="server" Width="90%" AutoCompleteType="Company"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" 
                                ControlToValidate="Fax" 
                                ValidationExpression="\(\d{2}\)\d{7}" Display="Dynamic" 
                                Font-Size="X-Small">nieprawidłowy nr faxu (format numeru (AA)BBBBBBB, AA - nr kierunkowy, B - pozostałe cyfry)</asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                         <center>Dane firmy (opcjonalne)</center></td>
                    </tr>
                    <tr>
                        <td align="right" class="style3">
                            Nazwa Firmy:</td>
                        <td>
                            <asp:TextBox ID="Firma" runat="server" Width="90%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" class="style3">
                            NIP:</td>
                        <td>
                            <asp:TextBox ID="NIP" runat="server" Width="90%"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server" 
                                ControlToValidate="NIP" 
                                ErrorMessage="prosze podać numer NIP bez myślników (10 cyfr)" 
                                ValidationExpression="\d{10}">*</asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td align="right" class="style3">
                            REGON:</td>
                        <td>
                            <asp:TextBox ID="REGON" runat="server" Width="90%"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator8" runat="server" 
                                ControlToValidate="REGON" ErrorMessage="nr REGON na 9 lub 14 cyfr" 
                                ValidationExpression="(\d{9}|\d{14})" ValidationGroup="CUWnext">*</asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
&nbsp;<asp:ValidationSummary ID="ValidationSummary1" runat="server" 
                                ValidationGroup="CUWnext" DisplayMode="List" />
                        </td>
                    </tr>
                </table>
                </asp:WizardStep>
                <asp:CompleteWizardStep ID="CompleteWizardStep1" runat="server">
                </asp:CompleteWizardStep>
            </WizardSteps>
        </asp:CreateUserWizard>
    </div>
</div>
<div class="footer">

      <p>Copyright &copy; 2009 ElSiKo | All Rights Reserved <br />
      Template design by <a href="http://1234.info" target="_blank">1234.info</a>  | Modified by <a href="http://marcinwionczyk.info">Marcin Wionczyk</a> <br /> 
      <a href="http://validator.w3.org/check?uri=referer" title="Validate XHTML code"> XHTML 1.0</a>, <a href="http://jigsaw.w3.org/css-validator/" title="Validate CSS code">CSS 2.0</a> validated</p></div></asp:Content>