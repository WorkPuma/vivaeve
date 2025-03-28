
      var bp;

      if (window.__console_path__) {
        bp = window.__console_path__;
      } else {
        var st=document.getElementsByTagName('script');
        var au=st[st.length - 1].src;
        bp = au.replace('apic-import.js', '');
      }

      var legacyScriptsCount = 0;
      function styleDocument() {
        document.addEventListener('WebComponentsReady', function() {
          setTimeout(function() {
            function shouldAddDocumentStyle(n) {
              return n.nodeType === Node.ELEMENT_NODE && n.localName === 'style' && !n.hasAttribute('scope');
            }
            const CustomStyleInterface = window.ShadyCSS.CustomStyleInterface;
            const candidates = document.querySelectorAll('style');
            for (let i = 0; i < candidates.length; i++) {
              const candidate = candidates[i];
              if (shouldAddDocumentStyle(candidate)) {
                CustomStyleInterface.addCustomStyle(candidate);
              }
            }
          }, 1000);
        });
      }
      function loadConsoleWhenDone(){
        legacyScriptsCount++
        if(legacyScriptsCount==3 && isLegacy()==true){
          loadConsole();
          styleDocument();
        }
      }
      function addScript(src, onLoadCallback) {
        var s = document.createElement('script');
        s.setAttribute('nomodule', '');
        s.src = bp + src;
        s.onload = onLoadCallback;
        document.body.appendChild(s);
      }
    addScript('./vendor.js',loadConsoleWhenDone);addScript('polyfills/core-js.c54a2cfc5c515e908a81db4704fbe204.js',loadConsoleWhenDone);addScript('polyfills/systemjs.7f2f505ec63ab981209af53ce7f0f503.js',loadConsoleWhenDone);addScript('polyfills/regenerator-runtime.6d5da0232f4ab85670e271f840b48b03.js',loadConsoleWhenDone);function loadConsole() {try{s = document.createElement('script');s.innerHTML = 'window.importShim = s => import(s)';document.body.appendChild(s);}catch(e){console.log(e);};try{!function(){function e(e,o){return new Promise((function(t,n){document.head.appendChild(Object.assign(document.createElement("script"),{src:e,onload:t,onerror:n},o?{type:"module"}:void 0))}))}var o=[];function t(){"noModule"in HTMLScriptElement.prototype?window.importShim(bp+"api-console-37db0d6e.js"):System.import(bp+"legacy/api-console-27b1c6af.js")}"fetch"in window||o.push(e(bp+"polyfills/fetch.0e67b62a23f4e9bd88d6d0485c24e420.js",!1)),"noModule"in HTMLScriptElement.prototype&&!("importShim"in window)&&o.push(e(bp+"polyfills/dynamic-import.08b86a7f56c6f0d65265654299b16d74.js",!1)),(!("attachShadow"in Element.prototype)||!("getRootNode"in Element.prototype)||window.ShadyDOM&&window.ShadyDOM.force)&&o.push(e(bp+"polyfills/webcomponents.d43d14353b5efb829a6185511b3e4dbf.js",!1)),!("noModule"in HTMLScriptElement.prototype)&&"getRootNode"in Element.prototype&&o.push(e(bp+"polyfills/custom-elements-es5-adapter.cff507bc95ad1d6bf1a415cc9c8852b0.js",!1)),o.length?Promise.all(o).then(t):t()}()}catch(e){console.log(e);};}
    function isLegacy() {
      const script = document.createElement('script');
      return !('noModule' in script);
    }
    if(isLegacy()==false){
      loadConsole();
    }
    