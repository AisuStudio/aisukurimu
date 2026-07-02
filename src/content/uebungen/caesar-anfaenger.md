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
  var CORRECT_SHIFT=3;
  var HINTS=[
    'Julius Caesar selbst hat immer um genau 3 Stellen verschoben.',
    'Schau dir das G an — welcher Buchstabe ergibt als erstes Wort etwas mit Sinn?',
    'Die richtige Verschiebung ist 3. Versuch es!'
  ];

  var root=document.getElementById('caesar-root');
  if(!root)return;

  // Hide static content after the puzzle div (none here, but safety)
  var prose=document.querySelector('.prose');

  var shift=0,hintsUsed=0,solved=false;

  // Inject CSS
  var st=document.createElement('style');
  st.textContent=[
    '.cz{margin:1.5rem 0 3rem;font-family:"Public Sans",sans-serif}',

    // Alphabet slider
    '.cz-slider{background:#1f1934;padding:1.5rem 1.5rem 1rem;margin-bottom:0}',
    '.cz-row-label{font-family:"iA Writer Mono S",monospace;font-size:10px;letter-spacing:.1em;text-transform:uppercase;color:#9e9c95;margin:0 0 .3rem}',
    '.cz-row{display:flex;overflow:hidden;gap:0;margin-bottom:.75rem;position:relative}',
    '.cz-cell{display:inline-flex;align-items:center;justify-content:center;width:calc(100%/13);min-width:22px;height:32px;font-family:"iA Writer Mono S",monospace;font-size:.75rem;font-weight:bold;flex-shrink:0;transition:background .15s,color .15s}',
    '.cz-cell.plain{color:#eae8e0;background:transparent}',
    '.cz-cell.cipher{color:#d8ff01;background:rgba(216,255,1,0.07)}',
    '.cz-cell.match{background:#5100ff;color:#fff}',
    '.cz-cell.cipher.match{background:#d8ff01;color:#1f1934}',
    '.cz-divider{border:none;border-top:1px solid rgba(234,232,224,.12);margin:0}',

    // Controls
    '.cz-controls{background:#1f1934;padding:1rem 1.5rem 1.25rem;display:flex;align-items:center;gap:1rem;flex-wrap:wrap}',
    '.cz-btn{display:inline-flex;align-items:center;justify-content:center;width:2.75rem;height:2.75rem;background:rgba(234,232,224,.08);border:1px solid rgba(234,232,224,.2);color:#eae8e0;font-family:"iA Writer Mono S",monospace;font-size:1.2rem;font-weight:bold;cursor:pointer;transition:background .12s,border-color .12s;flex-shrink:0;-webkit-user-select:none;user-select:none}',
    '.cz-btn:hover{background:rgba(234,232,224,.15);border-color:rgba(234,232,224,.4)}',
    '.cz-shift-display{font-family:"iA Writer Mono S",monospace;font-size:.75rem;color:#9e9c95;letter-spacing:.08em;text-transform:uppercase;flex:1;min-width:80px}',
    '.cz-shift-display span{display:block;font-size:2rem;color:#d8ff01;line-height:1;letter-spacing:0;font-weight:bold;font-variant-numeric:tabular-nums}',

    // Decoded message
    '.cz-decode{background:#1f1934;padding:.75rem 1.5rem 1.25rem;border-top:1px solid rgba(234,232,224,.08)}',
    '.cz-decode-label{font-family:"iA Writer Mono S",monospace;font-size:10px;letter-spacing:.1em;text-transform:uppercase;color:#9e9c95;margin:0 0 .4rem}',
    '.cz-decoded{font-family:"iA Writer Mono S",monospace;font-size:1.1rem;font-weight:bold;color:#eae8e0;letter-spacing:.08em;transition:color .2s}',
    '.cz-decoded.good{color:#d8ff01}',

    // Hints
    '.cz-hints{margin-top:1rem}',
    '.cz-hint-btn{display:inline-flex;align-items:center;gap:.4rem;padding:.45rem .9rem;background:transparent;border:1px solid rgba(81,0,255,.4);color:rgba(81,0,255,0.85);font-family:"iA Writer Mono S",monospace;font-size:.72rem;font-weight:bold;letter-spacing:.07em;text-transform:uppercase;cursor:pointer;transition:background .12s,border-color .12s}',
    '.cz-hint-btn:hover:not([disabled]){background:rgba(81,0,255,.1);border-color:#5100ff}',
    '.cz-hint-btn[disabled]{opacity:.4;cursor:default}',
    '.cz-hint-text{margin-top:.6rem;padding:.6rem .9rem;background:rgba(81,0,255,.07);border-left:2px solid #5100ff;font-size:.85rem;line-height:1.55;color:rgba(234,232,224,.8);font-family:"Public Sans",sans-serif;display:none}',
    '.cz-hint-text.on{display:block}',

    // Success
    '.cz-success{display:none;background:#1f1934;padding:2rem 1.5rem;text-align:center;margin-top:0;border-top:2px solid #d8ff01}',
    '.cz-flag{font-family:"iA Writer Mono S",monospace;font-size:1.5rem;font-weight:bold;color:#d8ff01;letter-spacing:.1em;margin:0 0 .5rem;animation:cz-pulse 1s ease infinite alternate}',
    '@keyframes cz-pulse{from{opacity:.7}to{opacity:1}}',
    '.cz-success-msg{font-family:"Public Sans",sans-serif;font-size:.95rem;color:rgba(234,232,224,.8);line-height:1.6;max-width:400px;margin:0 auto .75rem}',
    '.cz-badge{display:inline-flex;align-items:center;gap:.5rem;padding:.4rem .9rem;background:rgba(216,255,1,.12);border:1px solid #d8ff01;font-family:"iA Writer Mono S",monospace;font-size:.75rem;font-weight:bold;color:#d8ff01;text-transform:uppercase;letter-spacing:.07em;margin-top:.5rem}',
    '.cz-restart{display:block;margin:1rem auto 0;padding:.5rem 1.2rem;background:transparent;border:1px solid rgba(234,232,224,.2);color:rgba(234,232,224,.6);font-family:"iA Writer Mono S",monospace;font-size:.7rem;letter-spacing:.07em;text-transform:uppercase;cursor:pointer;transition:border-color .12s}',
    '.cz-restart:hover{border-color:rgba(234,232,224,.5)}'
  ].join('');
  document.head.appendChild(st);

  // Build HTML
  root.innerHTML=
    '<div class="cz">'+
      '<div class="cz-slider">'+
        '<div class="cz-row-label">Klartext (zum Entschlüsseln)</div>'+
        '<div class="cz-row" id="czPlain"></div>'+
        '<hr class="cz-divider">'+
        '<div class="cz-row-label" style="margin-top:.6rem">Geheimtext (verschlüsselt)</div>'+
        '<div class="cz-row" id="czCipher"></div>'+
      '</div>'+
      '<div class="cz-controls">'+
        '<button type="button" class="cz-btn" id="czMinus">−</button>'+
        '<div class="cz-shift-display">Verschiebung<span id="czShiftNum">0</span></div>'+
        '<button type="button" class="cz-btn" id="czPlus">+</button>'+
      '</div>'+
      '<div class="cz-decode">'+
        '<div class="cz-decode-label">Deine Nachricht:</div>'+
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

  function decode(text,s){
    return text.split('').map(function(ch){
      if(ch===' ')return ' ';
      var idx=ALPHA.indexOf(ch.toUpperCase());
      if(idx===-1)return ch;
      return ALPHA[(idx-s+26*10)%26];
    }).join('');
  }

  function renderAlphabet(){
    var plain=document.getElementById('czPlain');
    var cipher=document.getElementById('czCipher');
    plain.innerHTML='';
    cipher.innerHTML='';
    for(var i=0;i<26;i++){
      var p=document.createElement('span');
      p.className='cz-cell plain';
      p.textContent=ALPHA[i];
      // Highlight letters that appear in the cipher text
      var cipherLetter=ALPHA[(i+shift)%26];
      if(CIPHER.indexOf(cipherLetter)!==-1) p.classList.add('match');
      plain.appendChild(p);

      var c=document.createElement('span');
      c.className='cz-cell cipher';
      c.textContent=ALPHA[(i+shift)%26];
      if(CIPHER.indexOf(ALPHA[(i+shift)%26])!==-1) c.classList.add('match');
      cipher.appendChild(c);
    }
  }

  function renderDecode(){
    var dec=decode(CIPHER,shift);
    var el=document.getElementById('czDecoded');
    el.textContent=dec;
    el.classList.toggle('good',dec===SOLUTION);
    document.getElementById('czShiftNum').textContent=shift;
  }

  function checkSolved(){
    if(solved)return;
    if(decode(CIPHER,shift)===SOLUTION){
      solved=true;
      document.getElementById('czFlag').textContent='✓ '+SOLUTION;
      document.getElementById('czSuccess').style.display='block';
      document.getElementById('czMinus').disabled=true;
      document.getElementById('czPlus').disabled=true;
      // Save badge to localStorage
      try{var b=JSON.parse(localStorage.getItem('ak_badges')||'[]');if(b.indexOf('caesar-anfaenger')===-1){b.push('caesar-anfaenger');localStorage.setItem('ak_badges',JSON.stringify(b));}}catch(e){}
    }
  }

  document.getElementById('czMinus').addEventListener('click',function(){
    if(solved)return;
    shift=(shift-1+26)%26;
    renderAlphabet();renderDecode();checkSolved();
  });
  document.getElementById('czPlus').addEventListener('click',function(){
    if(solved)return;
    shift=(shift+1)%26;
    renderAlphabet();renderDecode();checkSolved();
  });

  // Keyboard support
  document.addEventListener('keydown',function(e){
    if(solved)return;
    if(e.key==='ArrowLeft'||e.key==='ArrowDown'){shift=(shift-1+26)%26;renderAlphabet();renderDecode();checkSolved();}
    if(e.key==='ArrowRight'||e.key==='ArrowUp'){shift=(shift+1)%26;renderAlphabet();renderDecode();checkSolved();}
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
    renderAlphabet();renderDecode();
  });

  renderAlphabet();
  renderDecode();
})();
</script>

---

## Was hast du gelernt?

Die Caesar-Chiffre ist **2000 Jahre alt** — und heute gilt sie als vollkommen unsicher. Warum? Weil es nur 25 mögliche Verschiebungen gibt. Ein Computer kann alle 25 in einer Millisekunde ausprobieren.

Moderne Verschlüsselung funktioniert anders — aber das Grundprinzip (Buchstaben oder Bits verschieben und vertauschen) steckt in fast jeder Verschlüsselung drin.

Im nächsten Level lernst du, wie du eine Verschiebung knackst, wenn du sie **nicht kennst** — mit Häufigkeitsanalyse.
