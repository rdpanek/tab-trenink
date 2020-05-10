# TAB - CONTENT

![alt text](https://github.com/rdpanek/tab-trenink/raw/master/content/mindMap.jpeg "MindMap")

**TEST STACK**
* TEST STACK Live / Let's tests
* ClashOfTestStack, konference, offline meetupy
* TAB a mise
* Jak TAB probíhá + sdílený dokument

**Proč a co testujeme?**
* uživatelská spokojenost
* pátý princip testování -> hledání chyb
* typy automatizovaných testů

**FE a BE**
* infra
* microservice
* komunikace
TODO: diagram komunikace mezi FE / BE

**Clouds**
* AWS
* Digitalocean
* Azure
* VPS
* Google Cloud Platform
* Elasticsearch Cloud

**Tools / Frameworks**
* Javascript / Java / Kotlin / Swift / PHP / Python / Go 
* RobotFramework
* Cucumber (Java / Selenium)
* Webdriver.io
* SauceLabs
* Selenium (selenium grid)
* k6.io
* Gatling
* Jmeter
* Smartmeter
* Blazemeter
* Taurus
* MySQL, PostreSQL, MSSQL, Oracle, Mongo
* Elasticsearch
* Kibana
* Grafana
* Logstash
* Beats
* Git / TIG
* XCode
* Android Studio
* Postman
* SOAP UI
* VPN
* VNC
* TCP Dump / Wireshark
* IDE a editory

**Syntaxe**
* HTML
* CSS
* JSON 
* XML

**Interface a protokoly**
* REST-API
* GraphQL
* SOAP
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

#rychlost-nacitani-webu
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
- wpt / canarytrace

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
      // e.delete()
   }
})
```

