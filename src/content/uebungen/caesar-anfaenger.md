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
image: /images/AK_Riddle_0002.jpg
---

# Caesar-Chiffre — Anfänger

Du findest in deinem Schulrucksack einen geheimen Zettel mit einem verschlüsselten Code. Kannst du ihn lesen?

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
  var PUZZLES=[
    {c:'GX ELVW HLQ KDFNHU',s:'DU BIST EIN HACKER',hints:['Julius Caesar selbst hat immer um genau 3 Stellen verschoben.','Schau dir das G an — welcher Buchstabe steht 3 Stellen davor?','Verschiebung: 3']},
    {c:'TJDIFS',s:'SICHER',hints:['Ganz klein — fast nichts verschoben.','Einen einzigen Schritt zurück im Alphabet.','Verschiebung: 1']},
    {c:'TRURVZ',s:'GEHEIM',hints:['A und N landen auf dem gleichen Buchstaben — genau die Hälfte des Alphabets.','Auch bekannt als ROT13.','Verschiebung: 13']},
    {c:'UFXXBTWY',s:'PASSWORT',hints:['Fünf Schritte zurück.','UF am Anfang — was könnte das bedeuten?','Verschiebung: 5']},
    {c:'JWXWHV',s:'ANONYM',hints:['Neun Schritte zurück.','J ist der 10. Buchstabe — wer steht 9 Stellen davor?','Verschiebung: 9']}
  ];
  var puzzleIdx=0;
  var CIPHER=PUZZLES[0].c,SOLUTION=PUZZLES[0].s,HINTS=PUZZLES[0].hints.slice();

  var root=document.getElementById('caesar-root');
  if(!root)return;

  var shift=0,hintsUsed=0,solved=false;
  var CW=28; // cell width px

  var st=document.createElement('style');
  st.textContent=[
    '.cz{margin:1.5rem 0 3rem;font-family:"Public Sans",sans-serif}',

    // Band wrapper
    '.cz-slider{background:#1f1934;padding:1.25rem 0 0;margin-bottom:0;position:relative}',
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
    // Letter mapping grid
    '.cz-mapping{display:none;margin-top:1rem;padding-top:.75rem;border-top:1px solid rgba(234,232,224,.08)}',
    '.cz-mapping.on{display:flex;flex-wrap:wrap;gap:2px}',
    '.cz-map-pair{display:flex;flex-direction:column;align-items:center;min-width:22px}',
    '.cz-map-cipher{font-family:"iA Writer Mono S",monospace;font-size:.75rem;font-weight:bold;color:#d8ff01;line-height:1.4}',
    '.cz-map-plain{font-family:"iA Writer Mono S",monospace;font-size:.75rem;font-weight:bold;color:#eae8e0;line-height:1.4}',
    '.cz-map-space{min-width:10px}',

    // Hints
    '.cz-hints{margin-top:1rem}',
    '.cz-hint-btn{display:inline-flex;align-items:center;gap:.4rem;padding:.45rem .9rem;background:transparent;border:1px solid rgba(81,0,255,.4);color:rgba(81,0,255,.85);font-family:"iA Writer Mono S",monospace;font-size:.72rem;font-weight:bold;letter-spacing:.07em;text-transform:uppercase;cursor:pointer;transition:background .12s,border-color .12s}',
    '.cz-hint-btn:hover:not([disabled]){background:rgba(81,0,255,.1);border-color:#5100ff}',
    '.cz-hint-btn[disabled]{opacity:.4;cursor:default}',
    '.cz-hint-text{margin-top:.6rem;padding:.6rem .9rem;background:rgba(81,0,255,.07);border-left:2px solid #5100ff;font-size:.85rem;line-height:1.55;color:rgba(234,232,224,.8);font-family:"Public Sans",sans-serif;display:none}',
    '.cz-hint-text.on{display:block}',

    // Puzzle header
    '.cz-puzzle-head{background:#1f1934;padding:1rem 1.25rem .75rem;border-bottom:1px solid rgba(234,232,224,.08)}',
    '.cz-puzzle-meta{font-family:"iA Writer Mono S",monospace;font-size:10px;letter-spacing:.1em;text-transform:uppercase;color:#9e9c95;margin:0 0 .3rem}',
    '.cz-puzzle-cipher{font-family:"iA Writer Mono S",monospace;font-size:1.25rem;font-weight:bold;color:#eae8e0;letter-spacing:.12em;word-break:break-all}',

    // Success
    '.cz-success{display:none;background:#1f1934;padding:2rem 1.25rem;text-align:center;margin-top:0;border-top:2px solid #d8ff01}',
    '.cz-flag{font-family:"iA Writer Mono S",monospace;font-size:1.4rem;font-weight:bold;color:#d8ff01;letter-spacing:.1em;margin:0 0 .75rem;animation:cz-pulse 1s ease infinite alternate}',
    '@keyframes cz-pulse{from{opacity:.7}to{opacity:1}}',
    '.cz-success-msg{font-family:"Public Sans",sans-serif;font-size:.9rem;color:rgba(234,232,224,.8);line-height:1.6;max-width:420px;margin:0 auto .75rem}',
    '.cz-badge{display:inline-flex;align-items:center;gap:.5rem;padding:.4rem .9rem;background:rgba(216,255,1,.12);border:1px solid #d8ff01;font-family:"iA Writer Mono S",monospace;font-size:.75rem;font-weight:bold;color:#d8ff01;text-transform:uppercase;letter-spacing:.07em;margin-top:.5rem}',
    '.cz-next-btn{display:inline-block;margin-top:1.25rem;padding:.6rem 1.5rem;background:rgba(216,255,1,.1);border:1px solid #d8ff01;color:#d8ff01;font-family:"iA Writer Mono S",monospace;font-size:.8rem;font-weight:bold;letter-spacing:.08em;text-transform:uppercase;cursor:pointer;transition:background .12s}',
    '.cz-next-btn:hover{background:rgba(216,255,1,.2)}'
  ].join('');
  document.head.appendChild(st);

  root.innerHTML=
    '<div class="cz">'+
      '<div class="cz-puzzle-head">'+
        '<div class="cz-puzzle-meta">Rätsel <span id="czPuzzleNum">1 / 5</span></div>'+
        '<div class="cz-puzzle-cipher" id="czCurrentCipher">'+CIPHER+'</div>'+
      '</div>'+
      '<div class="cz-slider">'+
        '<div class="cz-band-label">Klartext (fest)</div>'+
        '<div class="cz-band-outer plain-outer" id="czPlainOuter">'+
          '<div class="cz-band-inner" id="czPlainBand"></div>'+
        '</div>'+
        '<div class="cz-band-label" style="margin-top:.6rem">Geheimtext (schiebt sich →/←)</div>'+
        '<div class="cz-band-outer" id="czCipherOuter">'+
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
        '<div class="cz-mapping" id="czMapping"></div>'+
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
        '<button type="button" class="cz-next-btn" id="czNext">→ Nächstes Wort</button>'+
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

  function drawConnections(){
    var slider=root.querySelector('.cz-slider');
    var po=document.getElementById('czPlainOuter');
    var co=document.getElementById('czCipherOuter');
    if(!po||!co)return;
    var sr=slider.getBoundingClientRect();
    var pr=po.getBoundingClientRect();
    var cr=co.getBoundingClientRect();
    var y1=pr.bottom-sr.top;
    var y2=cr.top-sr.top;
    var svgH=cr.bottom-sr.top;
    var svgW=sr.width;

    var svg=document.createElementNS('http://www.w3.org/2000/svg','svg');
    svg.style.cssText='position:absolute;top:0;left:0;width:'+svgW+'px;height:'+svgH+'px;pointer-events:none;z-index:3;overflow:visible';

    var seen={};
    var lines=[];
    CIPHER.split('').forEach(function(ch){
      if(ch===' '||seen[ch])return;
      seen[ch]=true;
      var ci=ALPHA.indexOf(ch);
      var x=(ci-shift)*CW+CW/2;
      if(x<4||x>svgW-4)return;
      var line=document.createElementNS('http://www.w3.org/2000/svg','line');
      line.setAttribute('x1',x);line.setAttribute('y1',y1);
      line.setAttribute('x2',x);line.setAttribute('y2',y2);
      line.setAttribute('stroke','#d8ff01');
      line.setAttribute('stroke-width','1.5');
      var len=y2-y1;
      line.style.strokeDasharray=len;
      line.style.strokeDashoffset=len;
      svg.appendChild(line);
      lines.push(line);
    });
    slider.appendChild(svg);

    // Stagger animate in
    lines.forEach(function(l,i){
      setTimeout(function(){l.style.transition='stroke-dashoffset .25s ease';l.style.strokeDashoffset='0';},i*30);
    });
  }

  function buildMapping(){
    var el=document.getElementById('czMapping');
    el.innerHTML='';
    var plain=decode(CIPHER,shift);
    CIPHER.split('').forEach(function(cipherCh,i){
      if(cipherCh===' '){
        var sp=document.createElement('div');
        sp.className='cz-map-space';
        el.appendChild(sp);
        return;
      }
      var pair=document.createElement('div');
      pair.className='cz-map-pair';
      var top=document.createElement('span');
      top.className='cz-map-cipher';
      top.textContent=cipherCh;
      var bot=document.createElement('span');
      bot.className='cz-map-plain';
      bot.textContent=plain[i];
      pair.appendChild(top);
      pair.appendChild(bot);
      el.appendChild(pair);
    });
    el.classList.add('on');
  }

  function solve(){
    solved=true;
    document.getElementById('czFlag').textContent='✓ '+SOLUTION;
    document.getElementById('czSuccess').style.display='block';
    document.getElementById('czMinus').disabled=true;
    document.getElementById('czPlus').disabled=true;
    buildMapping();
    setTimeout(drawConnections,350);
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

  function loadPuzzle(idx){
    puzzleIdx=idx;
    var p=PUZZLES[idx];
    CIPHER=p.c; SOLUTION=p.s; HINTS=p.hints.slice();
    shift=0; hintsUsed=0; solved=false;

    document.getElementById('czCurrentCipher').textContent=CIPHER;
    document.getElementById('czPuzzleNum').textContent=(idx+1)+' / '+PUZZLES.length;

    cipherCells.forEach(function(cell,j){
      cell.classList.toggle('in-msg',CIPHER.indexOf(ALPHA[j%26])!==-1);
    });

    var oldSvg=root.querySelector('.cz-slider svg');
    if(oldSvg)oldSvg.remove();
    var m=document.getElementById('czMapping');
    m.innerHTML=''; m.classList.remove('on');

    document.getElementById('czSuccess').style.display='none';
    document.getElementById('czMinus').disabled=false;
    document.getElementById('czPlus').disabled=false;
    document.getElementById('czHintBtn').disabled=false;
    document.getElementById('czHintBtn').textContent='💡 Tipp anzeigen (3 verfügbar)';
    var ht=document.getElementById('czHintText');
    ht.classList.remove('on'); ht.textContent='';
    update();
  }

  document.getElementById('czNext').addEventListener('click',function(){
    loadPuzzle((puzzleIdx+1)%PUZZLES.length);
  });

  update();
})();
</script>

<div id="caesar-encode-root"></div>

<script>
(function(){
  var ALPHA='ABCDEFGHIJKLMNOPQRSTUVWXYZ';
  var encShift=3;
  var root=document.getElementById('caesar-encode-root');
  if(!root)return;

  var st=document.createElement('style');
  st.textContent=[
    '.czenc{margin:2rem 0 3rem;font-family:"Public Sans",sans-serif}',
    '.czenc-head{font-family:"iA Writer Mono S",monospace;font-size:10px;letter-spacing:.1em;text-transform:uppercase;color:#1f1934;margin:0 0 .5rem}',
    '.czenc-card{background:#1f1934;padding:1.25rem}',
    '.czenc-row{display:flex;align-items:center;gap:.75rem;margin-bottom:1rem;flex-wrap:wrap}',
    '.czenc-input{flex:1;min-width:0;background:rgba(234,232,224,.06);border:1px solid rgba(234,232,224,.2);color:#eae8e0;font-family:"iA Writer Mono S",monospace;font-size:1rem;font-weight:bold;letter-spacing:.1em;padding:.5rem .75rem;text-transform:uppercase;outline:none;transition:border-color .15s;box-sizing:border-box}',
    '.czenc-input:focus{border-color:rgba(234,232,224,.5)}',
    '.czenc-shift{display:flex;align-items:center;gap:.4rem;flex-shrink:0}',
    '.czenc-num{font-family:"iA Writer Mono S",monospace;font-size:1.4rem;color:#d8ff01;font-weight:bold;min-width:2rem;text-align:center;font-variant-numeric:tabular-nums}',
    '.czenc-out-label{font-family:"iA Writer Mono S",monospace;font-size:10px;letter-spacing:.1em;text-transform:uppercase;color:#9e9c95;margin:0 0 .3rem}',
    '.czenc-output{font-family:"iA Writer Mono S",monospace;font-size:1.1rem;font-weight:bold;color:#d8ff01;letter-spacing:.12em;min-height:1.8rem;word-break:break-all}'
  ].join('');
  document.head.appendChild(st);

  root.innerHTML=
    '<div class="czenc">'+
      '<div class="czenc-head">Verschlüssle selbst — bis zu 16 Zeichen</div>'+
      '<div class="czenc-card">'+
        '<div class="czenc-row">'+
          '<input class="czenc-input" id="czencInput" maxlength="16" placeholder="DEIN TEXT" autocomplete="off" spellcheck="false">'+
          '<div class="czenc-shift">'+
            '<button type="button" class="cz-btn" id="czencMinus">−</button>'+
            '<span class="czenc-num" id="czencNum">3</span>'+
            '<button type="button" class="cz-btn" id="czencPlus">+</button>'+
          '</div>'+
        '</div>'+
        '<div class="czenc-out-label">Dein Geheimtext:</div>'+
        '<div class="czenc-output" id="czencOutput">—</div>'+
      '</div>'+
    '</div>';

  function encode(text,s){
    return text.toUpperCase().split('').map(function(ch){
      if(ch===' ')return ' ';
      var idx=ALPHA.indexOf(ch);
      if(idx===-1)return ch;
      return ALPHA[(idx+s)%26];
    }).join('');
  }

  function upd(){
    var v=document.getElementById('czencInput').value;
    document.getElementById('czencOutput').textContent=encode(v,encShift)||'—';
    document.getElementById('czencNum').textContent=encShift;
  }

  document.getElementById('czencInput').addEventListener('input',upd);
  document.getElementById('czencMinus').addEventListener('click',function(){encShift=(encShift-1+26)%26;upd();});
  document.getElementById('czencPlus').addEventListener('click',function(){encShift=(encShift+1)%26;upd();});

  upd();
})();
</script>
