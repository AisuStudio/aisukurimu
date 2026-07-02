---
title: "Assembler-Alarm"
description: "Knack die erste Sicherheitstür mit dem NOT-Befehl. Dein erstes Bit-Manöver."
category: hacking
subtype: raetsel
level: 1
platforms: [browser]
duration: 5
tags: [assembler, binaer, logik, not-gate, anfaenger]
date: 2026-07-02
published: true
image: /images/AK_EX_0011.jpg
---

# Assembler-Alarm

## Schalte den Alarm aus.

<div id="alarm-root"></div>

<script>
(function(){
  var root=document.getElementById('alarm-root');
  if(!root)return;

  var H=String.fromCharCode(0x2550),V=String.fromCharCode(0x2551);
  var TL=String.fromCharCode(0x2554),TR=String.fromCharCode(0x2557);
  var BL=String.fromCharCode(0x255a),BR=String.fromCharCode(0x255d);
  var ML=String.fromCharCode(0x2560),MR=String.fromCharCode(0x2563);
  var HL=String.fromCharCode(0x2500),AR=String.fromCharCode(0x25ba);
  var TC=String.fromCharCode(0x2564),BC=String.fromCharCode(0x2567);
  var MC=String.fromCharCode(0x256a),VL=String.fromCharCode(0x2502);
  var DOT=String.fromCharCode(0xb7);
  function rep(c,n){return Array(n+1).join(c);}
  function row(s,w){var p=w-s.length;return V+s+(p>0?rep(' ',p):'')+V;}
  function spRow(a,b,w1,w2){var p1=w1-a.length,p2=w2-b.length;return V+a+(p1>0?rep(' ',p1):'')+VL+b+(p2>0?rep(' ',p2):'')+V;}

  function gNOT(b){return b.map(function(x){return x?0:1;});}
  function gAND(b,m){return b.map(function(x,i){return x&m[i];});}
  function gOR(b,m){return b.map(function(x,i){return x|m[i];});}
  function gXOR(b,m){return b.map(function(x,i){return x^m[i];});}
  function gNAND(b,m){return b.map(function(x,i){return (x&m[i])?0:1;});}

  var W=34;
  function makeCircuit(sector,g,mask,tgt){
    var pre=8-g.length-2;
    var gl='  EINGANG '+rep(HL,pre)+'['+g+']'+rep(HL,5)+AR+' ALARM';
    var ml=mask?'  FESTWERT: '+mask.map(function(b){return '  '+b;}).join(''):'';
    var tl='  Ziel-Ausgang:'+tgt.map(function(b){return '  '+b;}).join('');
    var lines=[TL+rep(H,W)+TR,row('  ALARMANLAGE '+DOT+' SEKTOR '+sector,W),ML+rep(H,W)+MR,row('',W),row(gl,W)];
    lines.push(mask?row(ml,W):row('',W));
    lines.push(row(tl,W));
    lines.push(BL+rep(H,W)+BR);
    return lines.join('\n');
  }

  var C1=10,C2=36;
  var SD=[
    [spRow(' NOT      ',' Dreht jeden Bit um',C1,C2),
     spRow('          ','   NOT( 0 ) = 1  → "aus 0 mach 1"',C1,C2),
     spRow('          ','   NOT( 1 ) = 0  → "aus 1 mach 0"',C1,C2)],
    [spRow(' AND      ',' Beide müssen 1 sein → gibt 1',C1,C2),
     spRow('          ','   AND( 1,1 ) = 1  AND( 0,1 ) = 0',C1,C2)],
    [spRow(' OR       ',' Mindestens einer muss 1 sein → 1',C1,C2),
     spRow('          ','   OR( 0,1 ) = 1   OR( 0,0 ) = 0',C1,C2)],
    [spRow(' XOR      ',' Genau einer - nicht beide → 1',C1,C2),
     spRow('          ','   XOR( 1,0 ) = 1  XOR( 1,1 ) = 0',C1,C2)],
    [spRow(' NAND     ',' NOT(AND) - immer das Gegenteil',C1,C2),
     spRow('          ','   NAND(1,1) = 0    NAND(0,1) = 1',C1,C2)]
  ];
  function makeSpick(upTo){
    var rows=[TL+rep(H,C1)+TC+rep(H,C2)+TR,spRow(' BEFEHL   ',' WAS PASSIERT',C1,C2),ML+rep(H,C1)+MC+rep(H,C2)+MR];
    for(var i=0;i<=upTo;i++){SD[i].forEach(function(r){rows.push(r);});if(i<upTo)rows.push(ML+rep(H,C1)+MC+rep(H,C2)+MR);}
    rows.push(BL+rep(H,C1)+BC+rep(H,C2)+BR);
    return rows.join('\n');
  }

  var PUZZLES=[
    {sector:'A',gate:'NOT',mask:null,target:[0,0,0,0],fn:gNOT,
     ep:[{t:'Das '},{t:'NOT-Gate (Nicht-Tor)',l:1,b:1},{t:' dreht jeden Bit um: aus 0 wird 1, aus 1 wird 0. Der Alarm schaltet sich aus, wenn der Ausgang '},{t:'0 0 0 0',l:1,b:1},{t:' zeigt. Welcher Eingang ergibt das?'}]},
    {sector:'B',gate:'AND',mask:[1,1,1,1],target:[1,0,1,0],fn:gAND,
     ep:[{t:'Das '},{t:'AND-Gate (UND-Tor)',l:1,b:1},{t:' gibt nur 1 aus, wenn BEIDE Eingänge 1 sind. Festwert: '},{t:'1 1 1 1',l:1,b:1},{t:'. Bringe den Ausgang auf '},{t:'1 0 1 0',l:1,b:1},{t:'.'}]},
    {sector:'C',gate:'OR',mask:[1,0,1,0],target:[1,1,1,1],fn:gOR,
     ep:[{t:'Das '},{t:'OR-Gate (ODER-Tor)',l:1,b:1},{t:' gibt 1 aus, wenn mindestens EIN Eingang 1 ist. Festwert: '},{t:'1 0 1 0',l:1,b:1},{t:'. Ziel: Ausgang '},{t:'1 1 1 1',l:1,b:1},{t:'.'}]},
    {sector:'D',gate:'XOR',mask:[1,0,1,0],target:[1,1,1,1],fn:gXOR,
     ep:[{t:'Das '},{t:'XOR-Gate (Entweder-Oder)',l:1,b:1},{t:' gibt 1 aus, wenn GENAU EIN Eingang 1 ist — nicht beide. Festwert: '},{t:'1 0 1 0',l:1,b:1},{t:'. Ziel: '},{t:'1 1 1 1',l:1,b:1},{t:'.'}]},
    {sector:'E',gate:'NAND',mask:[1,1,1,1],target:[0,1,0,1],fn:gNAND,
     ep:[{t:'Das '},{t:'NAND-Gate (NICHT-UND)',l:1,b:1},{t:' ist NOT(AND) — das Gegenteil von AND. Der Grundbaustein jeder CPU. Festwert: '},{t:'1 1 1 1',l:1,b:1},{t:'. Ziel: '},{t:'0 1 0 1',l:1,b:1},{t:'.'}]}
  ];

  var pIdx=0,bits=[0,0,0,0],pSolved=false;

  var st=document.createElement('style');
  st.textContent=
    '.aa{margin:1.5rem 0 3rem;font-family:"iA Writer Mono S",monospace}'+
    '.aa-top{display:flex;align-items:stretch;margin:0 0 20px}'+
    '.aa pre.aa-circuit{background:#9e9c95!important;color:#1f1934!important;padding:1.5rem 1.25rem!important;margin:0!important;font-size:.82rem!important;line-height:1.7;overflow-x:auto;white-space:pre;border:none!important;border-radius:4px 0 0 4px;flex:1;min-width:0}'+
    '.aa-explain{background:rgba(81,0,255,.85);padding:.8rem 1rem 1.25rem;font-size:.88rem;line-height:1.65;color:#eae8e0;margin:0;font-family:"Public Sans",sans-serif;border-radius:0 4px 4px 0;flex:1;min-width:0}'+
    '.aa-spick{background:#150f28;padding:1rem 1.25rem 1.25rem;margin:0;border-radius:4px 4px 0 0}'+
    '.aa-spick-head{font-size:10px;letter-spacing:.1em;text-transform:uppercase;color:#d8ff01;font-weight:bold;margin:0 0 .6rem}'+
    '.aa pre.aa-spick-pre{color:#eae8e0!important;font-size:.78rem!important;line-height:1.7;margin:0!important;white-space:pre;overflow-x:auto;border:none!important;background:#150f28!important}'+
    '.aa-io{background:rgba(21,15,40,.9);padding:1.1rem 1.25rem 1.5rem;margin:0;border-radius:0 0 4px 4px}'+
    '.aa-io-row{display:flex;align-items:center;gap:.75rem;margin:.25rem 0 1rem;flex-wrap:wrap}'+
    '.aa-io-row:last-child{margin-bottom:0}'+
    '.aa-io-label{font-size:11px;letter-spacing:.1em;text-transform:uppercase;color:#eae8e0;min-width:5.5rem;flex-shrink:0;font-weight:bold}'+
    '.aa-bits{display:flex;gap:.4rem}'+
    '.aa-bit{width:2.8rem;height:2.8rem;display:inline-flex;align-items:center;justify-content:center;font-size:1.15rem;font-weight:bold;cursor:pointer;border:2px solid rgba(234,232,224,.45);background:rgba(234,232,224,.08);color:#eae8e0;transition:all .1s;-webkit-user-select:none;user-select:none}'+
    '.aa-bit.on{background:#d8ff01;border-color:#d8ff01;color:#1f1934}'+
    '.aa-out-bit{width:2.8rem;height:2.8rem;display:inline-flex;align-items:center;justify-content:center;font-size:1.15rem;font-weight:bold;border:2px solid rgba(234,232,224,.2);color:rgba(234,232,224,.4);background:transparent;transition:all .15s}'+
    '.aa-out-bit.zero{color:#d8ff01;border-color:#d8ff01;background:rgba(216,255,1,.08)}'+
    '.aa-out-bit.one{color:#a07cff;border-color:rgba(160,124,255,.5)}'+
    '.aa-success{display:none;background:#1f1934;padding:1.5rem 1.25rem;text-align:center;border-top:2px solid #d8ff01}'+
    '.aa-flag{font-size:1.1rem;font-weight:bold;color:#d8ff01;letter-spacing:.08em;margin:0 0 .75rem;animation:aa-pulse 1s ease infinite alternate}'+
    '@keyframes aa-pulse{from{opacity:.7}to{opacity:1}}'+
    '.aa-next-btn{margin-top:.5rem;padding:.5rem 1.4rem;background:#d8ff01;color:#1f1934;border:none;font-weight:bold;font-size:.9rem;cursor:pointer;letter-spacing:.05em;font-family:"iA Writer Mono S",monospace}'+
    '.aa-win-msg{font-family:"Public Sans",sans-serif;font-size:.9rem;color:rgba(234,232,224,.8);line-height:1.65;margin:.5rem 0;max-width:400px;margin-left:auto;margin-right:auto}'+
    '.aa-badge{display:inline-flex;align-items:center;gap:.5rem;padding:.4rem .9rem;background:rgba(216,255,1,.12);border:1px solid #d8ff01;font-size:.75rem;font-weight:bold;color:#d8ff01;text-transform:uppercase;letter-spacing:.07em;margin-top:.75rem}';
  document.head.appendChild(st);

  var wrap=document.createElement('div'); wrap.className='aa';
  var top=document.createElement('div'); top.className='aa-top';
  var cirPre=document.createElement('pre'); cirPre.className='aa-circuit';
  top.appendChild(cirPre);
  var exp=document.createElement('div'); exp.className='aa-explain';
  var eLbl=document.createElement('span');
  eLbl.style.cssText='display:block;font-size:10px;letter-spacing:.12em;text-transform:uppercase;color:#d8ff01;font-weight:bold;margin-bottom:.45rem;font-family:"iA Writer Mono S",monospace';
  eLbl.textContent='AUFGABE';
  exp.appendChild(eLbl);
  top.appendChild(exp);
  wrap.appendChild(top);
  var spick=document.createElement('div'); spick.className='aa-spick';
  var spickH=document.createElement('div'); spickH.className='aa-spick-head'; spickH.textContent='BEFEHLSREFERENZ (Dein Spickzettel)';
  var spickPre=document.createElement('pre'); spickPre.className='aa-spick-pre';
  spick.appendChild(spickH); spick.appendChild(spickPre);
  wrap.appendChild(spick);
  var io=document.createElement('div'); io.className='aa-io';
  var inRow=document.createElement('div'); inRow.className='aa-io-row';
  var inLbl=document.createElement('span'); inLbl.className='aa-io-label'; inLbl.textContent='Eingang';
  var inBits=document.createElement('div'); inBits.className='aa-bits'; inBits.id='aaIn';
  inRow.appendChild(inLbl); inRow.appendChild(inBits);
  var outRow=document.createElement('div'); outRow.className='aa-io-row';
  var outLbl=document.createElement('span'); outLbl.className='aa-io-label'; outLbl.textContent='Ausgang';
  var outBits=document.createElement('div'); outBits.className='aa-bits'; outBits.id='aaOut';
  outRow.appendChild(outLbl); outRow.appendChild(outBits);
  io.appendChild(inRow); io.appendChild(outRow);
  wrap.appendChild(io);
  var succ=document.createElement('div'); succ.className='aa-success';
  wrap.appendChild(succ);
  root.appendChild(wrap);

  function buildExplain(ep){
    while(exp.childNodes.length>1)exp.removeChild(exp.lastChild);
    var body=document.createElement('span'); body.style.color='#eae8e0';
    ep.forEach(function(p){
      var el;
      if(p.l||p.b){el=document.createElement('span');if(p.b)el.style.fontWeight='bold';if(p.l)el.style.color='#d8ff01';el.textContent=p.t;}
      else{el=document.createTextNode(p.t);}
      body.appendChild(el);
    });
    exp.appendChild(body);
  }

  function showSuccess(i){
    succ.style.display='block';
    while(succ.firstChild)succ.removeChild(succ.firstChild);
    var fl=document.createElement('div'); fl.className='aa-flag';
    fl.textContent=(i<PUZZLES.length-1)?'Sektor '+PUZZLES[i].sector+' deaktiviert!':'Alle Sektoren deaktiviert!';
    succ.appendChild(fl);
    if(i<PUZZLES.length-1){
      var nb=document.createElement('button'); nb.type='button'; nb.className='aa-next-btn';
      nb.textContent='Nächste Aufgabe →';
      nb.addEventListener('click',function(){loadPuzzle(i+1);});
      succ.appendChild(nb);
    } else {
      var wm=document.createElement('div'); wm.className='aa-win-msg';
      var p1=document.createElement('p'); p1.style.margin='0 0 .25rem'; p1.textContent='NOT, AND, OR, XOR, NAND — das ist die Sprache jeder CPU.';
      var p2=document.createElement('p'); p2.style.margin='0'; p2.textContent='Du hast alle 5 Logikgatter gemeistert.';
      wm.appendChild(p1); wm.appendChild(p2);
      var bg=document.createElement('div'); bg.className='aa-badge'; bg.textContent='Badge: Logic-Master';
      succ.appendChild(wm); succ.appendChild(bg);
      try{var bgs=JSON.parse(localStorage.getItem('ak_badges')||'[]');if(bgs.indexOf('assembler-alarm-1')===-1){bgs.push('assembler-alarm-1');localStorage.setItem('ak_badges',JSON.stringify(bgs));}}catch(e){}
    }
  }

  function render(){
    var p=PUZZLES[pIdx];
    var out=p.fn(bits,p.mask);
    var inEl=document.getElementById('aaIn'); inEl.innerHTML='';
    bits.forEach(function(b,i){
      var btn=document.createElement('button'); btn.type='button';
      btn.className='aa-bit'+(b?' on':''); btn.textContent=b;
      btn.addEventListener('click',function(){if(pSolved)return;bits[i]=bits[i]?0:1;render();});
      inEl.appendChild(btn);
    });
    var outEl=document.getElementById('aaOut'); outEl.innerHTML='';
    out.forEach(function(b){
      var sp=document.createElement('span');
      sp.className='aa-out-bit '+(b?'one':'zero'); sp.textContent=b;
      outEl.appendChild(sp);
    });
    if(!pSolved&&out.every(function(b,i){return b===p.target[i];})){pSolved=true;showSuccess(pIdx);}
  }

  function loadPuzzle(i){
    pIdx=i; bits=[0,0,0,0]; pSolved=false;
    succ.style.display='none';
    var p=PUZZLES[i];
    cirPre.textContent=makeCircuit(p.sector,p.gate,p.mask,p.target);
    buildExplain(p.ep);
    spickPre.textContent=makeSpick(i);
    render();
  }

  loadPuzzle(0);
})();
</script>
