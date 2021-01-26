# TAB - CONTENT

![alt text](https://github.com/rdpanek/tab-trenink/raw/master/content/mindMap.jpeg "MindMap")

**TEST STACK**
* TEST STACK Live / Let's tests
* ClashOfTestStack, konference, offline meetupy
* TAB a mise
* Jak TAB probíhá + sdílený dokument

**Proč a co testujeme?**
* uživatelská spokojenost ( typy chyb )
* pátý princip testování -> hledání chyb -> motivace testera / vyvojare. Neni pravda, ze vyvojar pomuze. Proto musi byt tester inovatorem.
* typy automatizovaných testů

**FE a BE**
* infra
* microservice
* komunikace

**Tools / Frameworks / Stack**
* Javascript / Java / Kotlin / Swift / PHP / Python / Go / C
   * Co jazyk, to nastroj to i zpusob pouziti = metodika
* RobotFramework
* Cucumber (Java / Selenium)
* Pupik, playwright, Cypress (retry test, https://www.electronjs.org/)
   * + PhantomJS, Casperjs
   * Pupik = Headless Chrome Node API". Puppeteer is a Node library which provides a high-level API to control headless Chrome over the DevTools Protocol
   * Play = Node library to automate Chromium, Firefox and WebKit with a single API (By Microsoft). It is a Node library to automate the Chromium, WebKit and Firefox browsers with a single API (cross-browser)
   * tabulka https://github.com/rdpanek/tab-trenink/blob/master/content/frameworks.png
   * pupik, cypress = Dispatching events, play = devtoolsProtocol nebo podobne v pripade non-chromium browseru.
   * **Anatomie kliknuti / Browser Event Model**
      * Selenium
        * v ChromeDriver = HTTP Server, ktery vystavuje api, napr. click:
        * | `session/:sessionId/element/:id/click` <= command WebDriver Protocol
        * | `&ExecuteClickElement` in a chromeDriver
        * | trigger event.push `MouseEvenet(kMovedMouse)` -> `MouseEvenet(kPressedMouse)` -> `MouseEvenet(kReleasedMouse)` -> `web_view->DispatchMouseEvents(events) -> session->GetCurrentFrameID()`
          * https://chromedevtools.github.io/devtools-protocol/tot/Input/#method-dispatchMouseEvent
        * | WebSocket `WebViewImpl::DispatchMouseEvents(events)` -> `client.SendCommand("Input.dispatchMouseEvent", params)`
        * v vse co chromeDriver dela je to, ze je to tenky wrapper nad DevTools, vyuziva debug prikazu a podoba se kliknuti klienta, je to nejlepsi pristup pro simulaci experience klienta
     * Pupik je WS client a pristupuje k Devtools na primo ( kratsi cesta nez pres selenium, ale pouze pro chrome ) pupik je na stejne urovni jako cromedriver
     * Cypress nepouziva debug protocol, funguje jako Selenium 1 a dispatchuje DOM events primo, coz je kratsi cesta, ale 
        * spatne prenositelna mezi jinymi prohlizeci, takze problem pro cross-browser a cross-sites testing, protoze
        * https://chromedevtools.github.io/devtools-protocol/tot/Page/#method-navigate mu nic nerika
        * zde naopak prave nastupuje vyhoda selenia
        * v Volani Input.dispatchMouseEvent pomoci WebSocket Message (Selenium)
        * | OS Specific routing
        * | Find actual element x/y
        * L-> `CGPostMouseEvent(position, ...)` na Unix / MacOS, rozdilny nez na Windows a nez na Linuxu (operating system specific)
        * L-> `SendInput(input.size(), input.data(), ...)` Windows
        * L-> `XTestFakeButtonEvent(display_, button_number, ... )` Linux
     * Vysledek
        * lepsi pristup je `Simulating Native Events` (Selenium & Puppeteer)
        * DispatchEvents (Cypress)
     * Rozdil muze byt v implementaci dodatecnych funkcich / eventu / domen
     * Selenium & Browser bugs => lze vyrazne vyresit patternem 1:1:1
        * Not Bi-Directional yet because it’s an Http server. This means things like collecting network events or console logs is very hard => nevadi, protoze mame DevTools
     * Cypress si dal za ukol vytvorit dobre prostredi pro vyvojare
        * Problem s multi-tab testingem.
        * jQuery-based API.
        * Pro paralelismus je potreba vendor-locked software
     * Pupik je pro chrome a pro firefox
        * neni bran jako testovaci nastroj, ale spise automatizacni
     * Z pohledu performance, stability a debuggingu jsou si vicemene podobne.
     * Co se dnes ucit? => Tema: Event based test automation
     * Chromium ( vyuziva chrome, edge, opera a dalsi desitky dalsich ( hotove jadro, ekosystem doplnku atp.), uzivatelske rozhrani, vykreslovaciho jadra Blink a engine JavaScript V8
     * WebKit se pouziva na MacOS, v iOS jak v chrome tak i v safari. Google take commituje do WebKitu uz jen kvuli podpore AMP.
* Webdriver.io
* Canarytrace
* SauceLabs, browserstack
* Selenium (selenium grid)
* XCode
* Android Studio
* Postman
* k6.io
* Gatling
* Jmeter
* Smartmeter
* Blazemeter
* Taurus
* Dynatrace
* MySQL, PostreSQL, MSSQL, Oracle, Mongo
* Elasticsearch
* Kibana
* Grafana
* Logstash
* Beats
* Git / TIG
* VPN
* VNC
* TCP Dump / Wireshark
* IDE a editory
* Lens
* Docker, PodMan, 

**Clouds**
* AWS
* Digitalocean
* Azure
* VPS
* Google Cloud Platform
* Elasticsearch Cloud

**Syntaxe**
* HTML
* CSS
* JSON 
* XML

**Interface a protokoly**
* REST-API
* GraphQL
* TCP a UDP
* Websockety
* Fronty

**Orchestration**
* Docker
* Kubernetes
* Openshift
* Terraform

**Security**
* https
* certifikáty

**Services**
* Proxy
* F5
* nginx

**Hardware**
* Fyzický hw / virtuální hw
* Datacentra
* HDD / SSD => I/O operace

**KPI / metriky / logy**
* CPU
* RAM
* I/O
* Troughput
* ResponseTime
* TTFB
* logy / rotace logů / live reporting

**Operační systémy**
* Windows, Linux, Unix
* syntaxe příkazů
* ssh
* cp
* mv
* ls
* cat
* vim
    * módy
* tail -f -n100 ./server.log

### Browser
- Co je úkolem browseru
- HTML, CSS, Javascript, Webasembly
- Buď doménový specialista a drž se v obraze
    - https://www.chromestatus.com/features#milestone%3D75
    - https://twitter.com/ChromiumDev
- Jak funguje browser
- Jak fungují webovky
- AMP
    - https://www.vzhurudolu.cz/ebook-amp/
- PWA
- Selektory
    * xPath https://devhints.io/xpath
    * CSS Selector

**DevTools**
- Prozkoumat prvek
- Network > SaveHar
- Blocking Request
- Hlavicky
- Console (funkce, querySelector, xPathSelector, addEventListener)
   - `CMD`+`Shift`+`P`
      - ![alt text](https://github.com/rdpanek/tab-trenink/raw/master/content/devToolsFunkce.png "DevTools")
   - `document.querySelectorAll('*')`
   - `$x('//a')`
   - `window.addEventListener('click', function() {alert("TAB")})`
- CodeCoverage
- Overrides > Local Modifications
- Snippets

**Web Api**
- performanceEntries, performanceMark (https://developer.mozilla.org/en-US/docs/Web/API)

**Rychlost nacitani webu**
- Nefunkcionální metriky rychlosti načítání webu
    - slidy
    - metriky
    - javascript a priorita načítání zdrojů
    - heroElementy
    - https://httparchive.org/
- RUM & syntetické měření
    - https://g.co/chromeuxdash
    - https://crux.run/
    - Případovky https://wpostats.com/
    - Web Performance Testy
- Nástroje a zdroje
    - Lighthouse
    - https://speedcurve.com/
    - https://www.webpagetest.org/
    - https://search.google.com/test/mobile-friendly?id=W3KAzTwD4LLoglewG2Fclg
- Audits a performance
    - Vahy https://docs.google.com/spreadsheets/d/1up5rxd4EMCoMaxH8cppcK1x76n6HLx0e7jxb0e0FXvc/edit#gid=0
- Performance > SaveProfile


## Test Automation
TODO: diagram testautomatizace FE
- konvencni pristup (RobotFramework, Selenium+Java) = pristup stary 10let
- Canarytrace

**Větvení programu v automatizovaném testu**
![alt text](https://github.com/rdpanek/tab-trenink/raw/master/content/alzaDiv.png "Alza div")

> Proč se v rámci E2E GUI test automatizace věnovat prohlížeči a javascriptu?
```javascript
// Example 1
const targetElement = document.querySelector('div.ticket_summary__submit div.fortuna_button--yellow')
const config = { attributes: true, childList: true, subtree: true };
let callback = function(mutationsList, observer) {
    let acceptChangesButton = document.querySelector('div.ticket_summary__submit div.fortuna_button--yellow')
    if ( acceptChangesButton != null ) {
        console.log('Fortuna yellow button detected!')
        acceptChangesButton.click()
    }
    console.log('Any changes on bet button detected!')
};
const observer = new MutationObserver(callback);
observer.observe(targetElement, config);

// Example 2
setInterval(()=>{let targetButton=document.querySelector('div.ticket_summary__submit div.fortuna_button--yellow');if(targetButton!=null){targetButton.click()}},100);
```

> Odstranění elementu podle zIndexu
```javascript
$.map($('body *'), function(e,n) {
   let zindex = $(e).css('z-index')
      if (zindex > 0) {
      console.log(zindex)
      console.log(e)
      // e.remove()
   }
})
```

