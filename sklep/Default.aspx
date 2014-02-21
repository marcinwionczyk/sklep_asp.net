<%@ Page Title="" Language="C#" MasterPageFile="~/TwoColumnMasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="_Default"  %>
<asp:Content ContentPlaceHolderID="NavigationContentPlaceHolder" ID="Content1" runat="server">
    <h1 class="first">Kategorie</h1>

        <!-- Navigation with grid style -->
        <div style="margin:0 0 0 20px">
            <asp:TreeView ID="TreeView1" runat="server" LineImagesFolder="~/TreeLineImages" 
                ShowLines="True">
            <DataBindings>
            <asp:TreeNodeBinding TextField="nazwa" ValueField="Id" NavigateUrlField="url" />
            </DataBindings>
            </asp:TreeView>
         </div>
         <h1>Koszyk</h1>
    
    <asp:Table ID="koszykTable" runat="server" Width="245" ></asp:Table>
    <div class="loginform">
    <asp:Button ID="Wyczy��Button" runat="server" Text=" Wyczy�� " 
        onclick="Wyczy��Button_Click" onmouseover="this.style.cursor='hand';" 
            CssClass="button"/>
        <asp:Button ID="DoKasyButton" runat="server" 
            onclick="DoKasyButton_Click" Text=" Do kasy " 
            onmouseover="this.style.cursor='hand';" CssClass="button"/>
        </div>
        <!-- Login -->
        <a name="logowanie"></a>
        <h1>Logowanie</h1>
        <div class="loginform">
            <asp:Login ID="Login1" runat="server"
                ForeColor="#333333" TextLayout="TextOnTop" TitleText="" 
                onloggedin="Login1_LoggedIn" Width="200px" LoginButtonText=" Zaloguj " 
                VisibleWhenLoggedIn="False" onloggingin="Login1_LoggingIn">
                <TextBoxStyle Font-Size="1.5em" BorderColor="#C8C8C8" BorderStyle="Solid" 
                    BorderWidth="1px" Width="210px" />
                <LoginButtonStyle BorderStyle="Solid" 
                    BorderWidth="1px" />
                <LayoutTemplate>
                    <table border="0" cellpadding="1" cellspacing="0" 
                        style="border-collapse:collapse;">
                        <tr>
                            <td>
                                <table border="0" cellpadding="0" style="width:200px;">
                                    <tr>
                                        <td style="font-size:1.2em;" valign="middle">
                                            <asp:Label ID="UserNameLabel" runat="server" AssociatedControlID="UserName">Login:</asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:TextBox ID="UserName" runat="server" BorderColor="#C8C8C8" 
                                                BorderStyle="Solid" BorderWidth="1px" CssClass="field" Font-Size="1.5em" 
                                                Width="210px"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" 
                                                ControlToValidate="UserName" ErrorMessage="Prosz� poda� login." 
                                                ToolTip="Login jest wymagany." ValidationGroup="Login1">*</asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="font-size:1.2em;" valign="middle">
                                            <asp:Label ID="PasswordLabel" runat="server" AssociatedControlID="Password">Has�o:</asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:TextBox ID="Password" runat="server" BorderColor="#C8C8C8" 
                                                BorderStyle="Solid" BorderWidth="1px" CssClass="field" Font-Size="1.5em" 
                                                TextMode="Password" Width="210px"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" 
                                                ControlToValidate="Password" ErrorMessage="Password is required." 
                                                ToolTip="Has�o jest wymagane." ValidationGroup="Login1">*</asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:CheckBox ID="RememberMe" runat="server" 
                                                Text="Zapami�taj mnie nast�pnym razem" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" style="color:Red;">
                                            <asp:Literal ID="FailureText" runat="server" EnableViewState="False"></asp:Literal>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            <asp:Button ID="LoginButton" runat="server" CommandName="Login" 
                                                CssClass="button" Text=" Zaloguj " 
                                                ValidationGroup="Login1" /> &nbsp;
                                            <asp:Button ID="Button1" runat="server" CssClass="button" 
                                                Text="Zarejestruj si�" Width="104px" onclick="Button1_Click" />
                                        </td>
                                    </tr>
                                    <tr><td>
                                    <a href="mailto:admin@elsiko.com.pl?subject=Zapomnia�em%20has�a&body=moj%20login%20to"> zapomnia�em has�a </a>
                                    </td></tr>
                                </table>
                            </td>
                        </tr>
                    </table>
                </LayoutTemplate>
                <InstructionTextStyle Font-Italic="True" ForeColor="Black" />
                <LabelStyle Font-Size="1.2em" VerticalAlign="Middle" />
            </asp:Login>
            </div>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TwoColumnContentPlaceHolder" Runat="Server">
    <asp:MultiView ID="MultiView1" runat="server">
        <asp:View ID="ShopingView" runat="server">
            <h3><asp:Label ID="Label2" runat="server"></asp:Label></h3>
        <asp:DataList ID="DataList1" runat="server" DataKeyField="TowarID" DataSourceID="SqlDataSource1" 
        Width="100%" CellPadding="4" ForeColor="#333333" 
        onitemcommand="DataList1_ItemCommand" 
        onitemdatabound="DataList1_ItemDataBound">
            <FooterStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
            <AlternatingItemStyle BackColor="White" />
            <ItemStyle BackColor="#E3EAEB"  Font-Bold="true" />
            <SelectedItemStyle BackColor="White" Font-Bold="False" ForeColor="#333333" />
            <HeaderTemplate>
            <span style="float: right; width: 120px;">
            <span style="float: right;">Cena</span>
            j.m.
                <asp:Literal ID="Literal1" runat="server"></asp:Literal>
            </span>
            Nazwa towaru
            <span style="clear: right" />
            </HeaderTemplate>
            <HeaderStyle BackColor="#1C5E55" Font-Bold="True" ForeColor="White" />
            <SelectedItemTemplate>
                <span style="float: right; width: 116px;"><span style="float: right;">
                <asp:Label ID="cenajednostkowaLabel" runat="server" 
                    Text='<%# String.Format("{0:c}",Eval("cenajednostkowa")) %>' />
                </span>
                <asp:Label ID="JednostkamiaryLabel" runat="server" 
                    Text='<%# Eval("Jednostkamiary") %>'></asp:Label>
                </span>
                <asp:Label ID="TowarNazwaLabel" runat="server"
                    Text='<%# Eval("TowarNazwa") %>'></asp:Label>
                <p> 
                        <asp:LinkButton ID="DodajDoKoszykaLB" runat="server" CommandName="AddToBasket">wstaw do koszyka </asp:LinkButton> 
                        &nbsp;
                        <asp:TextBox ID="IloscTB" runat="server" Width="40px" Wrap="False" Text="1"></asp:TextBox> 
                        <asp:Label ID="JednostkamiaryLabel0" runat="server" 
                            Text='<%# Eval("Jednostkamiary") %>'></asp:Label>
                    </p>
                <asp:Label ID="OpisLabel" runat="server" 
                    Text='<%# Server.HtmlDecode(DataBinder.Eval(Container.DataItem, "Opistowaru").ToString()) %>'></asp:Label> 
                    
            </SelectedItemTemplate>
            <ItemTemplate>
                <span style="float: right; width: 116px;">
                <span style="float: right;">
                <asp:Label ID="cenajednostkowaLabel" runat="server" 
                    Text='<%# String.Format("{0:c}",Eval("cenajednostkowa")) %>' />
                </span>
                <asp:Label ID="JednostkamiaryLabel" runat="server" Text='<%# Eval("Jednostkamiary") %>'></asp:Label>
                </span>
                <asp:LinkButton ID="LinkButton1" runat="server" Text='<%# Eval("TowarNazwa") %>' CommandName="Select"></asp:LinkButton> 
                <span style="clear:right"></span>
                
            </ItemTemplate>
        </asp:DataList>
    
    <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
        ConnectionString="<%$ ConnectionStrings:home %>" 
        
        SelectCommand="SELECT [TowarID], [kategoriaID], [TowarNazwa], [Opistowaru], [Jednostkamiary], [cenajednostkowa] FROM [Towary] WHERE ([kategoriaID] = @kategoriaID)">
        <SelectParameters>
            <asp:QueryStringParameter DefaultValue="" Name="kategoriaID" 
                QueryStringField="tak" Type="Int32" />
        </SelectParameters>
    </asp:SqlDataSource>
        </asp:View>
        <asp:View ID="WelcomePageView" runat="server">
        <h1 class="block">Promocje</h1>
        <p>
        Z��cza : D-Sub : GN DB 9 �E�SKIE K�TOWE DO DRUKU <br /> 
        Stara cena: 1,60 z� <br />
        Nowa cena: 1,50 z�
        </p>
        </asp:View>
        <asp:View ID="NonLoggedDoKasyView" runat="server">
        <p>Aby sfinalizowa� zakup w sklepie <%=ConfigurationManager.AppSettings["NazwaFirmy"] %> nale�y si� 
            <asp:Button ID="RejestracjaButton" runat="server" Text="zarejestrowa�" 
                BorderStyle="None" BackColor="White" Font-Underline="False" 
                onclick="RejestracjaButton_Click" Font-Bold="True" ForeColor="#467AA7" 
                onmouseover="this.style.cursor='hand'; this.style.textDecoration = 'underline';" 
                onmouseout="this.style.textDecoration = 'none';" /> lub <a href="#logowanie">zalogowa�</a>.  Po zalogowaniu lub rejestracji, zostanie wy�wietlone podsumowanie zakupu. W podsumowaniu b�dzie mo�liwy wyb�r: sposobu p�atno�ci, rezygnacji z zakupu lub jego zatwierdzenia. </p>
                <p>W razie jakichkolwiek pyta� lub w�tpliwo�ci prosz� si� kontaktowa� z nami telefonicznie (tel. <%=ConfigurationManager.AppSettings["TelefonDoFirmy"] %>)</p>
        </asp:View>
        <asp:View ID="FinalizeShoppingView" runat="server">
    <div class="column1-unit">
    <div class="tabelka">
        <asp:Table ID="koszykszczeg�owy" runat="server" BorderStyle="Solid" 
                BorderWidth="4px" CellPadding="5" CellSpacing="5" GridLines="Both" 
            BackColor="#CCCCCC" BorderColor="White">
        </asp:Table>
        </div>
        </div>
        <hr class="clear-contentunit" />
        <h2>Spos�b zap�aty</h2>
        <asp:RadioButtonList ID="zap�ataRadioButtonList" runat="server">
        <asp:ListItem Value="za pobraniem">za pobraniem</asp:ListItem>
        <asp:ListItem Value="got�wka">przy odbiorze w siedzibie firmy</asp:ListItem>
        <asp:ListItem Value="przelew">przedp�ata przelewem</asp:ListItem>
        </asp:RadioButtonList>
            <br />
        <asp:Button ID="Akceptuj�ZakupButton" runat="server" Text=" Z�� zam�wienie " 
            onmouseover="this.style.cursor='hand';" BorderStyle="Solid" BorderWidth="1" 
                onclick="Akceptuj�ZakupButton_Click1" />
        <asp:Button ID="RezygnujeZZakupuButton" runat="server" Text="Rezygnuje z zakupu" 
                onmouseover="this.style.cursor='hand';" BorderStyle="Solid" BorderWidth="1" 
                onclick="RezygnujeZZakupuButton_Click" />
            <br />
            <br />
            <asp:Label ID="ThankYouLabel" runat="server"></asp:Label>
    </asp:View>
    <asp:View ID="RejestracjaView" runat="server">
        <asp:CreateUserWizard ID="CreateUserWizard1" runat="server" BorderWidth="0px" 
            CssClass="top" Height="522px" 
            AnswerLabelText="Odpowied�:" CancelButtonText="Anuluj" 
            CreateUserButtonText="Stw�rz konto u�ytkownika" 
            oncreateduser="CreateUserWizard1_CreatedUser" ContinueButtonType="Link" CreateUserButtonType="Link" 
            FinishCompleteButtonType="Link" FinishPreviousButtonType="Link" 
            oncontinuebuttonclick="CreateUserWizard1_ContinueButtonClick" 
            onfinishbuttonclick="CreateUserWizard1_FinishButtonClick" 
            StartNextButtonType="Link" StepNextButtonType="Link" 
            StepPreviousButtonType="Link" CancelDestinationPageUrl="~/Default.aspx" 
            oncancelbuttonclick="CreateUserWizard1_CancelButtonClick" >
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
                    Title="Stw�rz nowe konto" >
                </asp:CreateUserWizardStep>
                <asp:WizardStep runat="server" Title="Podaj swoje dane" StepType="Auto">
                <table>
                <tr>
                <td align="right">Imi�: </td><td>
                    <asp:TextBox ID="Imi�" runat="server" Width="90%" AutoCompleteType="FirstName"></asp:TextBox>
                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" 
                        ControlToValidate="Imi�" ErrorMessage="Prosz� poda� imi�" 
                        ValidationGroup="CUWnext">*</asp:RequiredFieldValidator>
                    <br />
                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" 
                        ControlToValidate="Imi�" Display="Dynamic" Font-Size="X-Small" 
                        ValidationExpression="[a-zA-Z��ʣьӏ���곜��]+" ValidationGroup="CUWnext">Imi� sk�ada si� wy��cznie z liter</asp:RegularExpressionValidator>
                    </td>
                </tr>
                    <tr>
                        <td align="right">
                            Nazwisko: </td>
                        <td>
                            <asp:TextBox ID="Nazwisko" runat="server" Width="90%" 
                                AutoCompleteType="LastName"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" 
                                ControlToValidate="Nazwisko" ErrorMessage="Prosz� podac nazwisko" 
                                ValidationGroup="CUWnext">*</asp:RequiredFieldValidator>
                            <br />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator9" runat="server" 
                                ControlToValidate="Nazwisko" Display="Dynamic" Font-Size="X-Small" 
                                ValidationExpression="[a-zA-Z��ʌ��ӏ������]+" ValidationGroup="CUWnext">Nazwisko sk�ada si� tylko z liter</asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Adres: </td>
                        <td>
                            <asp:TextBox ID="Adres" runat="server" Width="90%" 
                                AutoCompleteType="HomeStreetAddress"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" 
                                ControlToValidate="Adres" ErrorMessage="Prosz� poda� adres" 
                                ValidationGroup="CUWnext">*</asp:RequiredFieldValidator>
                            &nbsp;<br />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator10" 
                                runat="server" ControlToValidate="Adres" Font-Size="X-Small" 
                                ValidationExpression="[a-zA-Z�ƌʣ�ӏ������/., 0-9]+" 
                                ValidationGroup="CUWnext">tylko litery, cyfry, oraz znaki: my�lnik, kropka, przecinek, spacja, uko�nik</asp:RegularExpressionValidator>
                            <br />
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Kod pocztowy: </td>
                        <td>
                            <asp:TextBox ID="Kod" runat="server" Width="90%" AutoCompleteType="HomePhone"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" 
                                ControlToValidate="Kod" ErrorMessage="Prosz� poda� kod pocztowy" 
                                ValidationGroup="CUWnext">*</asp:RequiredFieldValidator>
                            <br />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" 
                                ControlToValidate="Kod" Display="Dynamic" Font-Size="X-Small" 
                                ValidationExpression="\d{2}-\d{3}" ValidationGroup="CUWnext">nieprawid�owy format kodu pocztowego</asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Miejscowo��: </td>
                        <td>
                            <asp:TextBox ID="Miejscowosc" runat="server" Width="90%" 
                                AutoCompleteType="HomeCity" ValidationGroup="CUWnext"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" 
                                ControlToValidate="Miejscowosc" ErrorMessage="Prosz� poda� miejscowo��" 
                                ValidationGroup="CUWnext">*</asp:RequiredFieldValidator>
                            <br />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator4" runat="server" 
                                ControlToValidate="Miejscowosc" Font-Size="X-Small" 
                                ValidationExpression="[a-zA-Z�ƌʣ�ӏ������. ]+" ValidationGroup="CUWnext">Nazwa miejscowo�ci sk�ada si� tylko z liter</asp:RegularExpressionValidator>
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
                                ControlToValidate="Telefon" ErrorMessage="Prosz� poda� telefon" 
                                ValidationGroup="CUWnext">*</asp:RequiredFieldValidator>
                            <br />
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator5" runat="server" 
                                ControlToValidate="Telefon" Font-Size="X-Small" 
                                ValidationExpression="(\(\d{2}\)\d{7}|\d{9})" ValidationGroup="CUWnext">nieprawid�owy numer telefonu (format numeru (AA)BBBBBBB lub BBBBBBBBB (kom�rka), AA - nr kierunkowy, B - pozosta�e cyfry)</asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            Fax: </td>
                        <td>
                            <asp:TextBox ID="Fax" runat="server" Width="90%" AutoCompleteType="Company"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator6" runat="server" 
                                ControlToValidate="Fax" 
                                ValidationExpression="\(\d{2}\)\d{7}" Display="Dynamic" 
                                Font-Size="X-Small">nieprawid�owy nr faxu (format numeru (AA)BBBBBBB, AA - nr kierunkowy, B - pozosta�e cyfry)</asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="2">
                         <center>Dane firmy (opcjonalne)</center></td>
                    </tr>
                    <tr>
                        <td align="right">
                            Nazwa Firmy:</td>
                        <td>
                            <asp:TextBox ID="Firma" runat="server" Width="90%"></asp:TextBox>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
                            NIP:</td>
                        <td>
                            <asp:TextBox ID="NIP" runat="server" Width="90%"></asp:TextBox>
                            <asp:RegularExpressionValidator ID="RegularExpressionValidator7" runat="server" 
                                ControlToValidate="NIP" 
                                ErrorMessage="prosze poda� numer NIP bez my�lnik�w (10 cyfr)" 
                                ValidationExpression="\d{10}">*</asp:RegularExpressionValidator>
                        </td>
                    </tr>
                    <tr>
                        <td align="right">
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
    </asp:View>
        
    </asp:MultiView>    
</asp:Content>
