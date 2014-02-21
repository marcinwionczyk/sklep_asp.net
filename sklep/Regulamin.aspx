<%@ Page Title="" Language="C#" MasterPageFile="~/1ColumnMasterPage.master" AutoEventWireup="true" CodeFile="Regulamin.aspx.cs" Inherits="Regulamin" %>

<asp:Content ID="Content1" ContentPlaceHolderID="SingleColumnContentPlaceHolder" Runat="Server">
<h1 class="pagetitle">Regulamin Sklepu Internetowego <%=ConfigurationManager.AppSettings["NazwaSklepu"] %></h1>
   <p>
       Regulamin Sklepu Internetowego <%=ConfigurationManager.AppSettings["NazwaSklepu"] %> określa zasady składania zamówień oraz sprzedaży sprzętu sieciowego, komputerowego i 
        akcesorii firmy <%=ConfigurationManager.AppSettings["NazwaFirmy"] %> za pośrednictwem Sklepu Internetowego <%=ConfigurationManager.AppSettings["NazwaSklepu"] %>.</p>
    <h1>
        WARUNKI OGÓLNE, WARUNKI ZAMAWIANIA I SPRZEDAŻY:</h1>
    <ol>
        <li>Właścicielem Sklepu Internetowego <%=ConfigurationManager.AppSettings["NazwaSklepu"] %> jest firma <%=ConfigurationManager.AppSettings["NazwaFirmy"] %> mieszącą się pod adresem <%=ConfigurationManager.AppSettings["AdresFirmy"] %>, <%=ConfigurationManager.AppSettings["KodpocztowyFirmy"] %> <%=ConfigurationManager.AppSettings["MiejscowoscFirmy"] %>. Telefon: <%=ConfigurationManager.AppSettings["TelefonDoFirmy"] %>, fax: <%=ConfigurationManager.AppSettings["FaxDoFirmy"] %>, NIP: 
            <%=ConfigurationManager.AppSettings["NIPFirmy"] %><br />
            </li>
        <li>Zamówienia na produkty <%=ConfigurationManager.AppSettings["NazwaSklepu"] %> 
            można składać za pośrednictwem strony WWW znajdującej się pod adresem
            <a href="http://<%=ConfigurationManager.AppSettings["NazwaSklepu"] %>">http://<%=ConfigurationManager.AppSettings["NazwaSklepu"] %></a>
            </li>
        <li>Zamówienia są przyjmowane 24 godziny na 
            dobę przez cały rok</li>
        <li>Zamówienia złożone w dni powszednie po godz. 14.00, w soboty, w niedziele oraz w święta będą rozpatrywane następnego dnia roboczego. </li>
        <li>Warunkiem koniecznym do realizacji zamówienia jest dokonanie rejestracji w systemie Sklepu Internetowego <%=ConfigurationManager.AppSettings["NazwaSklepu"] %>. Podanie numeru telefonu oraz adresu e-mail jest niezbędne do potwierdzenia przyjęcia i potwierdzenia realizacji zamówienia. Zamówienia, których nie uda się potwierdzić w ciągu 3 dni roboczych, nie będą realizowane. Każde zamówienie przyjęte do realizacji zostanie potwierdzone telefonicznie lub drogą elektroniczną. Do klientów, którzy nie zgodzą się na podanie swojego 
            numeru telefonu, zamówienie zostanie wysłane Pocztą Polską.</li>
        <li>Zamówienia potwierdzone do realizacji nie mogą być anulowane.</li>
        <li>Zamówienia, co do których istnieją jakiekolwiek wątpliwości będą weryfikowane przez obsługę sklepu, zamówienie takie może zostać anulowane przez Sklep. Zamawiający zostanie poinformowany o tym fakcie. </li>
        <li>Zamówiony towar będzie dostarczany przesyłką kurierską (firma Pocztex), lub za pośrednictwem Poczty Polskiej, w zależności od miejsca wysłania towaru. Za opóźnienia wynikające z działania Poczty Polskiej nie odpowiadamy.</li>
        <li><strong>Koszty dostarczenia:</strong> dla zamówień na kwotę do 150 zł brutto koszt wysyłki wynosi 10 zł przy płatności kartą płatniczą oraz przelewem, przesyłka za pobraniem wynosi 15zł. Dla zamówień przekraczających kwotę 150 zł brutto towar jest wysyłany na koszt firmy <%=ConfigurationManager.AppSettings["NazwaFirmy"] %>. </li>
        <li>Ceny w Sklepie Internetowym <%=ConfigurationManager.AppSettings["NazwaSklepu"] %>
            wyrażone są w złotych polskich i zawierają podatek VAT (ceny brutto). W przypadku zakupu towaru na który wprowadzona jest błedna cena, przez obsługę sklepu bądź błąd serwera kupujący zostanie poinformowany o tym fakcie a zamówienie zostanie anulowane. </li>
        <li>W przypadku braku towaru w magazynie Zamawiający jest informowany o tym fakcie i związanym z tym wydłużeniem czasu realizacji zamówienia. Jeżeli Zamawiający nie wyrazi zgody na wydłużenie czasu realizacji zamówienia może całkowicie zrezygnować z zamówienia bądź też 
            zrezygnować tylko z pozycji, która wydłuża czas realizacji zamówienia.</li>
        <li>Do każdej przesyłki dołączony jest dowód zakupu (faktura VAT lub paragon fiskalny). W przypadku, gdy Zamawiający jest płatnikiem podatku VAT (np. podmioty gospodarcze) uprasza się o wcześniejsze przesłanie faksem upoważnienia do wystawienia faktury VAT bez podpisu odbiorcy na numer faksu: <%=ConfigurationManager.AppSettings["FaxDoFirmy"] %>. </li>
        <li>Zamówienia realizowane są tylko na terytorium Polski.</li>
        <li>W przypadku wyboru sposobu płatności przelewem, towar jest wysyłany w momencie otrzymania środków pieniężnych na konto bankowe w wysokości 100% wartości zamówienia.
            </li>
        <li>W Sklepie Internetowym <%=ConfigurationManager.AppSettings["NazwaSklepu"] %> nie 
            są honorowane karty stałego klienta. </li>
        <li>Wszelkie zwroty wysyłane na koszt Firmy <%=ConfigurationManager.AppSettings["NazwaFirmy"] %> nie są przyjmowane, chyba że nastąpiły wcześniej inne ustalenia.
            </li>
        <li>Zwrot należy wysłać bez kwoty pobraniowej. W innym przypadku firma <%=ConfigurationManager.AppSettings["NazwaFirmy"] %> nie odbierze przesyłki.
            </li>
        <li>Klient ma prawo - zgodnie z art. 7 Ustawy z dnia 2 marca 2000 r. o ochronie niektórych praw konsumentów oraz o odpowiedzialności za szkodę wyrządzoną przez produkt niebezpieczny – odstąpić od umowy sprzedaży bez podania przyczyn składając stosowne oświadczenie na piśmie w terminie do dziesięciu dni od daty otrzymania produktu.</li>
        <li>Wzór stosownego oświadczenia należy pobrać <a href="docs/odstodumowy.pdf" target="_blank"><strong>
            ::tutaj::</strong></a> wydrukować i wypełnić. W przypadku odstąpienia od umowy Klient jest zobowiązany do odesłania na własny koszt zakupionych Produktów w oryginalnym opakowaniu wraz z wypełnionym oświadczeniem i dołączonym oryginalnym dowodem zakupu (paragon fiskalny lub 
            faktura VAT). Zwracany produkt nie może nosić śladów używania, być uszkodzony, 
            dotyczy także opakowania.</li>
        <li>Pieniądze za zwrócony Produkt Klient otrzyma przelewem na wskazany w oświadczeniu numer rachunku bankowego w przeciągu 7 dni roboczych od momentu otrzymania zwróconego Produktu. Koszty odesłania Produktu nie podlegają zwrotowi.</li>
        <li>Złożenie zamówienia w sklepie internetowym <%=ConfigurationManager.AppSettings["NazwaSklepu"] %> jest prawnie wiążącą umową kupna-sprzedaży.</li>
        <li>Sklep <%=ConfigurationManager.AppSettings["NazwaSklepu"] %> zastrzega sobie 
            możliwość braku dostępności określonego towaru, o czym klient zostanie 
            poinformowany.
            <br /></li>
        <li>Użytkownik rejestrując sie na sklepie 
            internetowym <%=ConfigurationManager.AppSettings["NazwaSklepu"] %> wyraża zgodę na otrzymywanie informacji 
            handlowych od firmy <%=ConfigurationManager.AppSettings["NazwaFirmy"] %><br />
            </li>
    </ol>
    <h1>
        WARUNKI REKLAMACJI :</h1>
    <ol>
        <li>Podstawą przyjęcia reklamacji jest dowód zakupu towaru (paragon fiskalny lub faktura VAT). </li>
        <li>Na wszystkie reklamowane produkty z tytułu niezgodności towaru z umową zakupione w naszym sklepie przyznawana jest 24 miesięczna odpowiedzialność sprzedawcy. </li>
        <li>Koszt przesyłki reklamowanego towaru pokrywa kupujący. </li>
        <li>Zgłoszenie reklamacyjne musi być złożone na wypełnionym czytelnie formularzu, którego wzór należy pobrać <strong>
            <a href="docs/reklamacja.pdf">::tutaj::</a></strong>
            </li>
        <li>Reklamacja zostanie rozpatrzona i odesłana w ciągu 14 dni od daty dostarczenia uszkodzonego towaru pod adres firmy: <%=ConfigurationManager.AppSettings["AdresFirmy"] %>, <%=ConfigurationManager.AppSettings["KodpocztowyFirmy"]%>  <%=ConfigurationManager.AppSettings["MiejscowoscFirmy"]%></li>
        <li>Różnice wynikające z indywidualnych ustawień komputera Klienta (kolor, proporcje itp.) nie mogą być podstawą reklamacji zakupionego towaru.</li>
        <li>Reklamacji podlegają wyłącznie wady ukryte powstałe z winy producenta w nowo zakupionych towarach.</li>
        <li>Reklamacji nie podlegają uszkodzenia mechaniczne, nie wpływające na prawidłową pracę urządzenia (rysy, wgniecenia powstałe n.p. na skutek transportu)</li>
        <li>W przypadku gdy towar jest niezgodny z umową kupujący może żądać: 
            <ul>
                <li>w pierwszej kolejności - nieodpłatnej naprawy.</li>
                <li>jeśli naprawa jest niemożliwa lub wymaga nadmiernych kosztów albo jeżeli sprzedawca nie zdoła uczynić zadość takiemu żądaniu w odpowiednim czasie towar zostanie wymieniony na nowy.</li>
            </ul>
        </li>
        <li>Przesyłki z wymienionymi produktami odsyłane są za pośrednictwem Poczty Polskiej, przesyłką zwykłą, chyba że klient zażyczy sobie aby wysyłka była na jego koszt.
            </li>
        <li>Dane dotyczące przelewu bankowego na 
            konto:<br />
            <br />
            
            Nazwa banku: <%=ConfigurationManager.AppSettings["BankFirmy"] %><br />
            Numer konta: <%=ConfigurationManager.AppSettings["KontoFirmy"] %><br />
            Tytuł przelewu: Zapłata za ... (nr zamówienia + data)<br />
            </li>
    </ol>
    <p>
        <strong>Rejestracja w Sklepie 
        Internetowym <%=ConfigurationManager.AppSettings["NazwaSklepu"] %> oznacza akceptację postanowień regulaminu oraz umożliwia składanie zamówień.</strong></p>

</asp:Content>

