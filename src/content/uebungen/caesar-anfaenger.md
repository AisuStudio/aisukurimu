---
title: "Caesar-Chiffre — Anfänger"
description: "Dreh das Chiffrier-Rad und knacke deinen ersten Code. Julius Caesar hätte es nie gedacht."
category: hacking
subtype: raetsel
level: 1
platforms: [browser]
duration: 8
tags: [kryptographie, caesar, code-knacken, anfaenger]
date: 2026-07-02
published: true
---

# Caesar-Chiffre — Anfänger

Du findest in deinem Schulrucksack einen geheimen Zettel. Auf dem Zettel steht:

> **GX ELVW HLQ KDFNHU**

Jemand hat dir eine Nachricht hinterlassen — aber verschlüsselt. Kannst du sie lesen?

---

## Was ist eine Caesar-Chiffre?

Julius Caesar — der römische Feldherr — hat vor über 2000 Jahren eine simple aber clevere Methode erfunden, um Nachrichten geheim zu halten: Er hat jeden Buchstaben um eine feste Anzahl von Stellen im Alphabet verschoben.

**Beispiel mit Verschiebung 1:**
`A → B · B → C · C → D · ... · Z → A`

**Beispiel mit Verschiebung 3:**
`A → D · B → E · C → F · ... · Z → C`

Um zu entschlüsseln, dreht man einfach die Richtung um — also zurück.

---

## Deine Aufgabe

Finde die Verschiebung und entschlüssle die Nachricht. Dreh das Rad mit **−** und **+**.

<div id="caesar-root"></div>

<script>
(function(){
  var ALPHA='ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  var CIPHER='GX ELVW HLQ KDFNHU';
  var SOLUTION='DU BIST EIN HACKER';
  var HINTS=[
    'Julius Caesar selbst hat immer um genau 3 Stellen verschoben.',
    'Schau dir das G an — welcher Buchstabe steht 3 Stellen davor im Alphabet?',
    'Die richtige Verschiebung ist 3. Versuch es!'
  ];

  var root=document.getElementById('caesar-root');
  if(!root)return;

  var shift=0,hintsUsed=0,solved=false;
  var CW=28; // cell width px

  var st=document.createElement('style');
  st.textContent=[
    '.cz{margin:1.5rem 0 3rem;font-family:"Public Sans",sans-serif}',

    // Band wrapper
    '.cz-slider{background:#1f1934;padding:1.25rem 0 0;margin-bottom:0}',
    '.cz-band-label{font-family:"iA Writer Mono S",monospace;font-size:10px;letter-spacing:.1em;text-transform:uppercase;color:#9e9c95;margin:0 0 .3rem;padding:0 1.25rem}',
    '.cz-band-outer{overflow:hidden;position:relative;border-top:1px solid rgba(234,232,224,.06)}',
    '.cz-band-outer.plain-outer{border-top:none}',
    // The actual scrolling band — wider than the viewport
    '.cz-band-inner{display:flex;width:max-content;will-change:transform}',
    '.cz-band-inner.slides{transition:transform .18s cubic-bezier(.4,0,.2,1)}',
    '.cz-cell{display:inline-flex;align-items:center;justify-content:center;width:'+CW+'px;height:36px;font-family:"iA Writer Mono S",monospace;font-size:.78rem;font-weight:bold;flex-shrink:0;box-sizing:border-box}',
    '.cz-cell-plain{color:#eae8e0}',
    '.cz-cell-cipher{color:#d8ff01;background:rgba(216,255,1,.06)}',
    '.cz-cell-cipher.in-msg{background:#d8ff01;color:#1f1934}',
    // Fade edges
    '.cz-band-outer::before,.cz-band-outer::after{content:"";position:absolute;top:0;bottom:0;width:28px;z-index:2;pointer-events:none}',
    '.cz-band-outer::before{left:0;background:linear-gradient(to right,#1f1934,transparent)}',
    '.cz-band-outer::after{right:0;background:linear-gradient(to left,#1f1934,transparent)}',
    // Center pin
    '.cz-pin{position:absolute;top:0;bottom:0;left:50%;transform:translateX(-50%);width:2px;background:rgba(234,232,224,.15);pointer-events:none;z-index:1}',

    // Controls
    '.cz-controls{background:#1f1934;padding:1rem 1.25rem 1.25rem;display:flex;align-items:center;gap:1rem;border-top:1px solid rgba(234,232,224,.08)}',
    '.cz-btn{display:inline-flex;align-items:center;justify-content:center;width:3rem;height:3rem;background:rgba(234,232,224,.08);border:1px solid rgba(234,232,224,.18);color:#eae8e0;font-family:"iA Writer Mono S",monospace;font-size:1.4rem;font-weight:bold;cursor:pointer;transition:background .12s,border-color .12s;flex-shrink:0;-webkit-user-select:none;user-select:none;line-height:1}',
    '.cz-btn:hover:not([disabled]){background:rgba(234,232,224,.15);border-color:rgba(234,232,224,.4)}',
    '.cz-btn[disabled]{opacity:.35;cursor:default}',
    '.cz-shift-display{font-family:"iA Writer Mono S",monospace;font-size:.7rem;color:#9e9c95;letter-spacing:.08em;text-transform:uppercase;flex:1;text-align:center}',
    '.cz-shift-display span{display:block;font-size:2.2rem;color:#d8ff01;line-height:1.1;letter-spacing:0;font-weight:bold;font-variant-numeric:tabular-nums}',

    // Decoded
    '.cz-decode{background:#1f1934;padding:.75rem 1.25rem 1.25rem;border-top:1px solid rgba(234,232,224,.08)}',
    '.cz-decode-label{font-family:"iA Writer Mono S",monospace;font-size:10px;letter-spacing:.1em;text-transform:uppercase;color:#9e9c95;margin:0 0 .4rem}',
    '.cz-decoded{font-family:"iA Writer Mono S",monospace;font-size:1.1rem;font-weight:bold;color:#eae8e0;letter-spacing:.1em;transition:color .2s;word-break:break-all}',
    '.cz-decoded.good{color:#d8ff01}',

    // Hints
    '.cz-hints{margin-top:1rem}',
    '.cz-hint-btn{display:inline-flex;align-items:center;gap:.4rem;padding:.45rem .9rem;background:transparent;border:1px solid rgba(81,0,255,.4);color:rgba(81,0,255,.85);font-family:"iA Writer Mono S",monospace;font-size:.72rem;font-weight:bold;letter-spacing:.07em;text-transform:uppercase;cursor:pointer;transition:background .12s,border-color .12s}',
    '.cz-hint-btn:hover:not([disabled]){background:rgba(81,0,255,.1);border-color:#5100ff}',
    '.cz-hint-btn[disabled]{opacity:.4;cursor:default}',
    '.cz-hint-text{margin-top:.6rem;padding:.6rem .9rem;background:rgba(81,0,255,.07);border-left:2px solid #5100ff;font-size:.85rem;line-height:1.55;color:rgba(234,232,224,.8);font-family:"Public Sans",sans-serif;display:none}',
    '.cz-hint-text.on{display:block}',

    // Success
    '.cz-success{display:none;background:#1f1934;padding:2rem 1.25rem;text-align:center;margin-top:0;border-top:2px solid #d8ff01}',
    '.cz-flag{font-family:"iA Writer Mono S",monospace;font-size:1.4rem;font-weight:bold;color:#d8ff01;letter-spacing:.1em;margin:0 0 .75rem;animation:cz-pulse 1s ease infinite alternate}',
    '@keyframes cz-pulse{from{opacity:.7}to{opacity:1}}',
    '.cz-success-msg{font-family:"Public Sans",sans-serif;font-size:.9rem;color:rgba(234,232,224,.8);line-height:1.6;max-width:420px;margin:0 auto .75rem}',
    '.cz-badge{display:inline-flex;align-items:center;gap:.5rem;padding:.4rem .9rem;background:rgba(216,255,1,.12);border:1px solid #d8ff01;font-family:"iA Writer Mono S",monospace;font-size:.75rem;font-weight:bold;color:#d8ff01;text-transform:uppercase;letter-spacing:.07em;margin-top:.5rem}',
    '.cz-restart{display:block;margin:1rem auto 0;padding:.5rem 1.2rem;background:transparent;border:1px solid rgba(234,232,224,.2);color:rgba(234,232,224,.6);font-family:"iA Writer Mono S",monospace;font-size:.7rem;letter-spacing:.07em;text-transform:uppercase;cursor:pointer;transition:border-color .12s}',
    '.cz-restart:hover{border-color:rgba(234,232,224,.5)}'
  ].join('');
  document.head.appendChild(st);

  root.innerHTML=
    '<div class="cz">'+
      '<div class="cz-slider">'+
        '<div class="cz-band-label">Klartext (fest)</div>'+
        '<div class="cz-band-outer plain-outer">'+
          '<div class="cz-band-inner" id="czPlainBand"></div>'+
        '</div>'+
        '<div class="cz-band-label" style="margin-top:.6rem">Geheimtext (schiebt sich →/←)</div>'+
        '<div class="cz-band-outer">'+
          '<div class="cz-pin"></div>'+
          '<div class="cz-band-inner slides" id="czCipherBand"></div>'+
        '</div>'+
      '</div>'+
      '<div class="cz-controls">'+
        '<button type="button" class="cz-btn" id="czMinus" title="Verschiebung verringern (←)">−</button>'+
        '<div class="cz-shift-display">Verschiebung<span id="czShiftNum">0</span></div>'+
        '<button type="button" class="cz-btn" id="czPlus" title="Verschiebung erhöhen (→)">+</button>'+
      '</div>'+
      '<div class="cz-decode">'+
        '<div class="cz-decode-label">Deine entschlüsselte Nachricht:</div>'+
        '<div class="cz-decoded" id="czDecoded">? ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?</div>'+
      '</div>'+
      '<div class="cz-hints">'+
        '<button type="button" class="cz-hint-btn" id="czHintBtn">💡 Tipp anzeigen (3 verfügbar)</button>'+
        '<div class="cz-hint-text" id="czHintText"></div>'+
      '</div>'+
      '<div class="cz-success" id="czSuccess">'+
        '<div class="cz-flag" id="czFlag"></div>'+
        '<div class="cz-success-msg">'+
          'Du hast die Caesar-Chiffre geknackt! Julius Caesar hätte das nicht gefallen.<br>'+
          'Die Verschiebung war <strong style="color:#d8ff01">3</strong> — genau die Zahl, die Caesar am liebsten benutzt hat.'+
        '</div>'+
        '<div class="cz-badge">🔓 Badge: Code-Knacker</div>'+
        '<button type="button" class="cz-restart" id="czRestart">↺ Nochmal versuchen</button>'+
      '</div>'+
    '</div>';

  // Build PLAIN band once — 26 cells, never moves
  var plainBand=document.getElementById('czPlainBand');
  for(var i=0;i<26;i++){
    var p=document.createElement('span');
    p.className='cz-cell cz-cell-plain';
    p.textContent=ALPHA[i];
    plainBand.appendChild(p);
  }

  // Build CIPHER band — 52 cells (alphabet twice) so sliding never runs out
  var cipherBand=document.getElementById('czCipherBand');
  var cipherCells=[];
  for(var j=0;j<52;j++){
    var c=document.createElement('span');
    c.className='cz-cell cz-cell-cipher';
    c.textContent=ALPHA[j%26];
    // Mark letters that appear in the cipher message
    if(CIPHER.indexOf(ALPHA[j%26])!==-1) c.classList.add('in-msg');
    cipherBand.appendChild(c);
    cipherCells.push(c);
  }

  function decode(text,s){
    return text.split('').map(function(ch){
      if(ch===' ')return ' ';
      var idx=ALPHA.indexOf(ch.toUpperCase());
      if(idx===-1)return ch;
      return ALPHA[(idx-s+26*10)%26];
    }).join('');
  }

  function update(){
    // Only the cipher band slides — plain band is untouched
    cipherBand.style.transform='translateX(-'+(shift*CW)+'px)';
    document.getElementById('czShiftNum').textContent=shift;
    var dec=decode(CIPHER,shift);
    var el=document.getElementById('czDecoded');
    el.textContent=dec;
    el.classList.toggle('good',dec===SOLUTION);
    if(!solved && dec===SOLUTION) solve();
  }

  function solve(){
    solved=true;
    document.getElementById('czFlag').textContent='✓ '+SOLUTION;
    document.getElementById('czSuccess').style.display='block';
    document.getElementById('czMinus').disabled=true;
    document.getElementById('czPlus').disabled=true;
    try{
      var b=JSON.parse(localStorage.getItem('ak_badges')||'[]');
      if(b.indexOf('caesar-anfaenger')===-1){b.push('caesar-anfaenger');localStorage.setItem('ak_badges',JSON.stringify(b));}
    }catch(e){}
  }

  document.getElementById('czMinus').addEventListener('click',function(){
    if(solved)return;
    shift=(shift-1+26)%26;
    update();
  });
  document.getElementById('czPlus').addEventListener('click',function(){
    if(solved)return;
    shift=(shift+1)%26;
    update();
  });

  document.addEventListener('keydown',function(e){
    if(solved)return;
    if(e.key==='ArrowLeft'||e.key==='ArrowDown'){shift=(shift-1+26)%26;update();}
    if(e.key==='ArrowRight'||e.key==='ArrowUp'){shift=(shift+1)%26;update();}
  });

  document.getElementById('czHintBtn').addEventListener('click',function(){
    if(hintsUsed>=HINTS.length)return;
    var ht=document.getElementById('czHintText');
    ht.textContent=HINTS[hintsUsed];
    ht.classList.add('on');
    hintsUsed++;
    var rem=HINTS.length-hintsUsed;
    var btn=document.getElementById('czHintBtn');
    if(rem===0){btn.disabled=true;btn.textContent='💡 Keine Tipps mehr';}
    else{btn.textContent='💡 Noch ein Tipp ('+rem+' übrig)';}
  });

  document.getElementById('czRestart').addEventListener('click',function(){
    shift=0;hintsUsed=0;solved=false;
    document.getElementById('czSuccess').style.display='none';
    document.getElementById('czMinus').disabled=false;
    document.getElementById('czPlus').disabled=false;
    document.getElementById('czHintBtn').disabled=false;
    document.getElementById('czHintBtn').textContent='💡 Tipp anzeigen (3 verfügbar)';
    document.getElementById('czHintText').classList.remove('on');
    update();
  });

  update();
})();
</script>

---

## Was hast du gelernt?

Die Caesar-Chiffre ist **2000 Jahre alt** — und heute gilt sie als vollkommen unsicher. Warum? Weil es nur 25 mögliche Verschiebungen gibt. Ein Computer kann alle 25 in einer Millisekunde ausprobieren.

Moderne Verschlüsselung funktioniert anders — aber das Grundprinzip (Buchstaben oder Bits verschieben und vertauschen) steckt in fast jeder Verschlüsselung drin.

Im nächsten Level lernst du, wie du eine Verschiebung knackst, wenn du sie **nicht kennst** — mit Häufigkeitsanalyse.
