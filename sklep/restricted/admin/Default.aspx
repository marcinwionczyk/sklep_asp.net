<%@ Page Title="" Language="C#" MasterPageFile="~/restricted/admin/AdminMasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="restricted_admin_Default" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="AdminContentPlaceHolder" Runat="Server">
    <div class="main">
  
      <!-- B.1 MAIN CONTENT -->
      <div class="main-content">
        
        <!-- Pagetitle -->
        <h1 class="pagetitle">Pracownicy</h1>
        <h1 class="block"> &nbsp; Pracownicy odpowiedzialni za obs³ugê transakcji</h1>
            <asp:DataList id="DataList1" runat="server" 
              OnItemCommand="DataList1_ItemCommand" RepeatColumns="1" 
              oncancelcommand="DataList1_CancelCommand" 
              oneditcommand="DataList1_EditCommand" 
              onupdatecommand="DataList1_UpdateCommand">
              
              <ItemTemplate>
              <asp:LinkButton id="button1" runat="server" Text="poka¿ szczegó³y" CommandName="select" />
              <%# DataBinder.Eval(Container.DataItem, "imie") %>
              <%# DataBinder.Eval(Container.DataItem, "nazwisko") %>
              login: <%# DataBinder.Eval(Container.DataItem, "login") %>
                 </ItemTemplate>
                <EditItemTemplate>
                    login:<asp:Label 
                        ID="Llogin" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "login") %>'></asp:Label>
                    <br />
                    Imiê:
                    <asp:TextBox 
                        ID="TBimie" runat="server" Width="100%" Text='<%# DataBinder.Eval(Container.DataItem, "imie") %>'></asp:TextBox>
                    <br />
                    Nazwisko:
                    <asp:TextBox ID="TBnazwisko" runat="server" Width="100%" Text='<%# DataBinder.Eval(Container.DataItem, "nazwisko") %>'></asp:TextBox>
                    <br />
                    email:
                    <asp:TextBox ID="TBemail" runat="server" Width="100%" Text='<%# DataBinder.Eval(Container.DataItem, "email") %>'></asp:TextBox>
                    <br />
                    adres:<asp:TextBox ID="TBadres" runat="server" Width="100%" Text='<%# DataBinder.Eval(Container.DataItem, "adres") %>'></asp:TextBox>
                    <br />
                    kod pocztowy:
                    <asp:TextBox ID="TBkod" runat="server" Width="100%" Text='<%# DataBinder.Eval(Container.DataItem, "kod") %>'></asp:TextBox>
                    <br />
                    miejscowoœæ:
                    <asp:TextBox ID="TBmiejscowosc" runat="server" Width="100%" Text='<%# DataBinder.Eval(Container.DataItem, "miejscowosc") %>'></asp:TextBox>
                    <br />
                    telefon:
                    <asp:TextBox ID="TBtelefon" runat="server" Width="100%" Text='<%# DataBinder.Eval(Container.DataItem, "telefon") %>'></asp:TextBox>
                    NIP:<asp:TextBox ID="TBnip" runat="server" Width="100%" Text='<%# DataBinder.Eval(Container.DataItem, "nip") %>'></asp:TextBox>
                    <br />
                    <asp:CheckBox ID="CheckBox1" runat="server" Text="zresetuj has³o" />
                    <br />
                    <br />
                    mo¿e siê logowaæ ?: <asp:DropDownList ID="DropDownList" runat="server">
                        <asp:ListItem>tak</asp:ListItem>
                        <asp:ListItem>nie</asp:ListItem>
                    </asp:DropDownList>
                    <br />
                    <asp:LinkButton ID="LBzapisz" runat="server" CommandName="update">Zapisz</asp:LinkButton>
                    &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CommandName="cancel">Anuluj</asp:LinkButton>
                    
                </EditItemTemplate>
                <SelectedItemTemplate>
                 <%# DataBinder.Eval(Container.DataItem, "imie") %> <%# DataBinder.Eval(Container.DataItem, "nazwisko") %>, login: <%# DataBinder.Eval(Container.DataItem, "login") %>, email: <%# DataBinder.Eval(Container.DataItem, "email") %> <br />
                adres: <%# DataBinder.Eval(Container.DataItem, "adres") %>, <%# DataBinder.Eval(Container.DataItem, "kod") %> <%# DataBinder.Eval(Container.DataItem, "miejscowosc") %> <br />
                telefon: <%# DataBinder.Eval(Container.DataItem, "telefon") %> <br />
                NIP: <%# DataBinder.Eval(Container.DataItem, "nip") %> <br />
                data ostatniego logowania: <%# DataBinder.Eval(Container.DataItem, "aktywnosc", "{0:d}")%>,<br />
                    
                    mo¿e siê logowaæ ?: <%# DataBinder.Eval(Container.DataItem,"isapproved") %>
                <br />
                     <asp:LinkButton ID="LinkButton1" runat="server" CommandName="edit">Edytuj dane</asp:LinkButton>
                </SelectedItemTemplate>
                </asp:DataList>
                <br />
          <asp:Label ID="LabelA" runat="server"></asp:Label>
          <br />
                <h1 class="block">&nbsp;Pracownicy odpowiedzialni za zaopatrzenie i ofertê handlow¹</h1>
          <asp:DataList ID="DataList2" runat="server" 
              oneditcommand="DataList2_EditCommand" 
              onitemcommand="DataList2_ItemCommand" 
              onupdatecommand="DataList2_UpdateCommand" 
              oncancelcommand="DataList2_CancelCommand">
          <ItemTemplate>
          <asp:LinkButton id="button1" runat="server" Text="poka¿ szczegó³y" CommandName="select" />
              <%# DataBinder.Eval(Container.DataItem, "imie") %>
              <%# DataBinder.Eval(Container.DataItem, "nazwisko") %>, 
              login: 
              <%# DataBinder.Eval(Container.DataItem, "login") %>
          </ItemTemplate>
          <EditItemTemplate>
          login:<asp:Label 
                        ID="Llogin" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "login") %>'></asp:Label>
                    <br />
                    Imiê:
                    <asp:TextBox 
                        ID="TBimie" runat="server" Width="100%" Text='<%# DataBinder.Eval(Container.DataItem, "imie") %>'></asp:TextBox>
                    Nazwisko:
                    <asp:TextBox ID="TBnazwisko" runat="server" Width="100%" Text='<%# DataBinder.Eval(Container.DataItem, "nazwisko") %>'></asp:TextBox>
                    email:
                    <asp:TextBox ID="TBemail" runat="server" Width="100%" Text='<%# DataBinder.Eval(Container.DataItem, "email") %>'></asp:TextBox>
                    <br />
              <br />
                    adres:<asp:TextBox ID="TBadres" runat="server" Width="100%" Text='<%# DataBinder.Eval(Container.DataItem, "adres") %>'></asp:TextBox>
                    kod pocztowy:
                    <asp:TextBox ID="TBkod" runat="server" Width="100%" Text='<%# DataBinder.Eval(Container.DataItem, "kod") %>'></asp:TextBox>
                    miejscowoœæ:
                    <asp:TextBox ID="TBmiejscowosc" runat="server" Width="100%" Text='<%# DataBinder.Eval(Container.DataItem, "miejscowosc") %>'></asp:TextBox>
                    telefon:
                    <asp:TextBox ID="TBtelefon" runat="server" Width="100%" Text='<%# DataBinder.Eval(Container.DataItem, "telefon") %>'></asp:TextBox>
                    NIP:<asp:TextBox ID="TBnip" runat="server" Width="100%" 
                  Text='<%# DataBinder.Eval(Container.DataItem, "nip") %>' Height="20px"></asp:TextBox>
                    <br />
              <asp:CheckBox ID="PasswordResetCB" runat="server" Text="zresetuj has³o" />
              <br />
                    mo¿e siê logowaæ ?: <asp:DropDownList ID="DropDownList" runat="server">
                        <asp:ListItem>tak</asp:ListItem>
                        <asp:ListItem>nie</asp:ListItem>
                    </asp:DropDownList>
                    <br />
                    <asp:LinkButton ID="LBzapisz" runat="server" CommandName="update">Zapisz</asp:LinkButton>
                    &nbsp;<asp:LinkButton ID="LinkButton2" runat="server" CommandName="cancel">Anuluj</asp:LinkButton>
          </EditItemTemplate>
              <SelectedItemTemplate>
                   <%# DataBinder.Eval(Container.DataItem, "imie") %> <%# DataBinder.Eval(Container.DataItem, "nazwisko") %>, login: <%# DataBinder.Eval(Container.DataItem, "login") %>, email: <%# DataBinder.Eval(Container.DataItem, "email") %> <br />
                adres: <%# DataBinder.Eval(Container.DataItem, "adres") %>, <%# DataBinder.Eval(Container.DataItem, "kod") %> <%# DataBinder.Eval(Container.DataItem, "miejscowosc") %> <br />
                telefon: <%# DataBinder.Eval(Container.DataItem, "telefon") %> <br />
                NIP: <%# DataBinder.Eval(Container.DataItem, "nip") %> <br />
                data ostatniego logowania: <%# DataBinder.Eval(Container.DataItem, "aktywnosc", "{0:d}")%>, mo¿e siê logowaæ ?: <%# DataBinder.Eval(Container.DataItem,"isapproved") %>
                <br />
                     <asp:LinkButton ID="LinkButton1" runat="server" CommandName="edit">Edytuj dane</asp:LinkButton>
              </SelectedItemTemplate>
          </asp:DataList>      
                <p>
                    <asp:Label ID="LabelB" runat="server"></asp:Label></p>
          <h2>Dodaj nowego pracownika</h2>
          <asp:CreateUserWizard ID="CreateUserWizard1" runat="server" BorderWidth="0px" 
            CssClass="searchform" 
            AnswerLabelText="OdpowiedŸ:" CancelButtonText="Anuluj" 
            CreateUserButtonText="Stwórz konto u¿ytkownika" 
            CancelButtonType="Link" ContinueButtonType="Link" CreateUserButtonType="Link" 
            FinishCompleteButtonType="Link" FinishPreviousButtonType="Link"  
            StartNextButtonType="Link" StepNextButtonType="Link" 
            StepPreviousButtonType="Link" 
              ContinueDestinationPageUrl="~/restricted/admin/Default.aspx" 
              LoginCreatedUser="False" 
              onfinishbuttonclick="CreateUserWizard1_FinishButtonClick" >
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
                <asp:WizardStep ID="WizardStep1" runat="server" Title="Podaj swoje dane" StepType="Finish">
                <table>
                <tr>
                <td align="right">Imiê: </td><td>
                    <asp:TextBox ID="Imiê" runat="server" Width="90%" AutoCompleteType="FirstName"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="Imiê" ErrorMessage="Proszê podaæ imiê" 
                        ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                    <br />
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" 
                        ControlToValidate="Imiê" Display="Dynamic" Font-Size="X-Small" 
                        ValidationExpression="[a-zA-Z¥ÆÊ£ÑŒÓ¯¹æê³œñóŸ¿]+" ValidationGroup="CreateUserWizard1">Imiê sk³ada siê wy³¹cznie z liter</asp:RegularExpressionValidator>
                    </td>
                </tr>
                    <tr>
                        <td align="right">
                            Nazwisko: </td>
                        <td>
                            <asp:TextBox ID="Nazwisko" runat="server" Width="90%" 
                                AutoCompleteType="LastName"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                ControlToValidate="Nazwisko" ErrorMessage="Proszê podac nazwisko" 
                                ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                            <br />
                            <asp:RegularExpressionValidator ID="NazwiskoRegularExpressionValidator" runat="server" 
                                ControlToValidate="Nazwisko" Display="Dynamic" Font-Size="X-Small" 
                                ValidationExpression="[a-zA-Z¥ÆÊŒ£ÑÓ¯¹æê³ñœóŸ¿]+" ValidationGroup="CreateUserWizard1">Nazwisko sk³ada siê tylko z liter</asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Adres: </td>
                        <td>
                            <asp:TextBox ID="Adres" runat="server" Width="90%" 
                                AutoCompleteType="HomeStreetAddress"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                                ControlToValidate="Adres" ErrorMessage="Proszê podaæ adres" 
                                ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                            &nbsp;<br />
                            <asp:RegularExpressionValidator ID="AdresRegularExpressionValidator" 
                                runat="server" ControlToValidate="Adres" Font-Size="X-Small" 
                                ValidationExpression="[a-zA-Z¥ÆŒÊ£ÑÓ¯¹æê³ñœóŸ¿/., 0-9]+" 
                                ValidationGroup="CreateUserWizard1">tylko litery, cyfry, oraz znaki: myœlnik, kropka, przecinek, spacja, ukoœnik</asp:RegularExpressionValidator>
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Kod pocztowy: </td>
                        <td>
                            <asp:TextBox ID="Kod" runat="server" Width="90%" AutoCompleteType="HomePhone"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                                ControlToValidate="Kod" ErrorMessage="Proszê podaæ kod pocztowy" 
                                ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                            <br />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" 
                                ControlToValidate="Kod" Display="Dynamic" Font-Size="X-Small" 
                                ValidationExpression="\d{2}-\d{3}" ValidationGroup="CreateUserWizard1">nieprawid³owy format kodu pocztowego</asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Miejscowoœæ: </td>
                        <td>
                            <asp:TextBox ID="Miejscowosc" runat="server" Width="90%" 
                                AutoCompleteType="HomeCity" ValidationGroup="CreateUserWizard1"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                                ControlToValidate="Miejscowosc" ErrorMessage="Proszê podaæ miejscowoœæ" 
                                ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                            <br />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" 
                                ControlToValidate="Miejscowosc" Font-Size="X-Small" 
                                ValidationExpression="[a-zA-Z¥ÆŒÊ£ÑÓ¯¹æê³ñœóŸ¿. ]+" ValidationGroup="CreateUserWizard1">Nazwa miejscowoœci sk³ada siê tylko z liter</asp:RegularExpressionValidator>
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Telefon: </td>
                        <td>
                            <asp:TextBox ID="Telefon" runat="server" Width="90%" 
                                AutoCompleteType="Cellular"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" 
                                ControlToValidate="Telefon" ErrorMessage="Proszê podaæ telefon" 
                                ValidationGroup="CreateUserWizard1">*</asp:RequiredFieldValidator>
                            <br />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server" 
                                ControlToValidate="Telefon" Font-Size="X-Small" 
                                ValidationExpression="(\(\d{2}\)\d{7}|\d{9})" ValidationGroup="CreateUserWizard1">nieprawid³owy numer telefonu (format numeru (AA)BBBBBBB lub BBBBBBBBB (komórka), AA - nr kierunkowy, B - pozosta³e cyfry)</asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            NIP:</td>
                        <td>
                            <asp:TextBox ID="NIP" runat="server" Width="90%"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="NIPRegularExpressionValidator" runat="server" 
                                ControlToValidate="NIP" 
                                ErrorMessage="prosze podaæ numer NIP bez myœlników (10 cyfr)" 
                                ValidationExpression="\d{10}">*</asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Rola:</td>
                        <td>
                            <asp:DropDownList ID="DropDownList1" runat="server">
                                <asp:ListItem>Obs³uga transakcji</asp:ListItem>
                                <asp:ListItem>Zaopatrzenie, oferta sklepowa</asp:ListItem>
                            </asp:DropDownList>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
&nbsp;<asp:ValidationSummary ID="ValidationSummary1" runat="server" 
                                ValidationGroup="CreateUserWizard1" DisplayMode="List" />
                        </td>
                    </tr>
                </table>
                </asp:WizardStep>
                <asp:CompleteWizardStep ID="CompleteWizardStep1" runat="server">
                </asp:CompleteWizardStep>
            </WizardSteps>
        </asp:CreateUserWizard>
</div></div><div class="footer">

      <p>Copyright &copy; 2009 ElSiKo | All Rights Reserveddded</p><p class="credits">Design by <a href="http://www.1-2-3-4.info/" title="Strona Projektanta">Wolfgang</a> | Modified by <a href="http://www.marcinwionczyk.info" title="Strina domowa osoby modyfikuj¹cej">Marcin Wionczyk</a> | <a href="http://validator.w3.org/check?uri=referer" title="Validate XHTML code">XHTML 1.0</a> | <a href="http://jigsaw.w3.org/css-validator/" title="Validate CSS code">CSS 2.0</a></p></div></asp:Content>