// Plugin lokal: menyesuaikan 6 layar desain atas dengan UI aplikasi Flutter DesaKu.
// Jalankan di halaman "Page 1" pada file Figma DesaKu.

const C = { P:'4A1D6B', PD:'341050', PS:'F1E8F8', MR:'6E1423', GO:'D9A441', GL:'F4DFA8', BG:'F8F5FB', TX:'241A2E', TM:'5E5368', BD:'E3D9EC', OK:'1E8E5A', DG:'C62B3B', IN:'2F6FB5', WA:'B27A00', OR:'D2691E', WH:'FFFFFF' };
const W = { 400:'Regular', 500:'Medium', 600:'SemiBold', 700:'Bold', 800:'ExtraBold', 900:'Black' };

const ICONS = {
  bank:'M4 10v7h3v-7H4zm6 0v7h3v-7h-3zM2 22h19v-3H2v3zm14-12v7h3v-7h-3zm-4.5-9L2 6v2h19V6l-9.5-5z',
  bell:'M12 22c1.1 0 2-.9 2-2h-4c0 1.1.89 2 2 2zm6-6v-5c0-3.07-1.64-5.64-4.5-6.32V4c0-.83-.67-1.5-1.5-1.5s-1.5.67-1.5 1.5v.68C7.63 5.36 6 7.92 6 11v5l-2 2v1h16v-1l-2-2z',
  card:'M20 4H4c-1.11 0-1.99.89-1.99 2L2 18c0 1.11.89 2 2 2h16c1.11 0 2-.89 2-2V6c0-1.11-.89-2-2-2zm0 14H4v-6h16v6zm0-10H4V6h16v2z',
  event:'M17 12h-5v5h5v-5zM16 1v2H8V1H6v2H5c-1.11 0-1.99.9-1.99 2L3 19c0 1.1.89 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2h-1V1h-2zm3 18H5V8h14v11z',
  heart:'M12 21.35l-1.45-1.32C5.4 15.36 2 12.28 2 8.5 2 5.42 4.42 3 7.5 3c1.74 0 3.41.81 4.5 2.09C13.09 3.81 14.76 3 16.5 3 19.58 3 22 5.42 22 8.5c0 3.78-3.4 6.86-8.55 11.54L12 21.35z',
  newspaper:'M22 3l-1.67 1.67L18.67 3 17 4.67 15.33 3l-1.66 1.67L12 3l-1.67 1.67L8.67 3 7 4.67 5.33 3 3.67 4.67 2 3v16c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V3zM11 19H4v-6h7v6zm9 0h-7v-2h7v2zm0-4h-7v-2h7v2zm0-4H4V8h16v3z',
  home:'M10 20v-6h4v6h5v-8h3L12 3 2 12h3v8z',
  person:'M12 12c2.21 0 4-1.79 4-4s-1.79-4-4-4-4 1.79-4 4 1.79 4 4 4zm0 2c-2.67 0-8 1.34-8 4v2h16v-2c0-2.66-5.33-4-8-4z',
  clock:'M11.99 2C6.47 2 2 6.48 2 12s4.47 10 9.99 10C17.52 22 22 17.52 22 12S17.52 2 11.99 2zM12 20c-4.42 0-8-3.58-8-8s3.58-8 8-8 8 3.58 8 8-3.58 8-8 8zm.5-13H11v6l5.25 3.15.75-1.23-4.5-2.67z',
  pin:'M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7zm0 9.5c-1.38 0-2.5-1.12-2.5-2.5s1.12-2.5 2.5-2.5 2.5 1.12 2.5 2.5-1.12 2.5-2.5 2.5z',
  chev:'M10 6L8.59 7.41 13.17 12l-4.58 4.59L10 18l6-6z',
  caltoday:'M20 3h-1V1h-2v2H7V1H5v2H4c-1.1 0-2 .9-2 2v16c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2zm0 18H4V8h16v13z',
  edit:'M3 17.25V21h3.75L17.81 9.94l-3.75-3.75L3 17.25zM20.71 7.04c.39-.39.39-1.02 0-1.41l-2.34-2.34c-.39-.39-1.02-.39-1.41 0l-1.83 1.83 3.75 3.75 1.83-1.83z',
  arrow:'M12 4l-1.41 1.41L16.17 11H4v2h12.17l-5.58 5.59L12 20l8-8z',
  back:'M20 11H7.83l5.59-5.59L12 4l-8 8 8 8 1.41-1.41L7.83 13H20v-2z',
  backios:'M17.77 3.77L16 2 6 12l10 10 1.77-1.77L9.54 12z',
  login:'M11 7L9.6 8.4l2.6 2.6H2v2h10.2l-2.6 2.6L11 17l5-5-5-5zm9 12h-8v2h8c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2h-8v2h8v14z',
  lock:'M18 8h-1V6c0-2.76-2.24-5-5-5S7 3.24 7 6v2H6c-1.1 0-2 .9-2 2v10c0 1.1.9 2 2 2h12c1.1 0 2-.9 2-2V10c0-1.1-.9-2-2-2zm-6 9c-1.1 0-2-.9-2-2s.9-2 2-2 2 .9 2 2-.9 2-2 2zM9 8V6c0-1.66 1.34-3 3-3s3 1.34 3 3v2H9z',
  eyeoff:'M12 7c2.76 0 5 2.24 5 5 0 .65-.13 1.26-.36 1.83l2.92 2.92c1.51-1.26 2.7-2.89 3.43-4.75-1.73-4.39-6-7.5-11-7.5-1.4 0-2.74.25-3.98.7l2.16 2.16C10.74 7.13 11.35 7 12 7zM2 4.27l2.28 2.28.46.46C3.08 8.3 1.78 10.02 1 12c1.73 4.39 6 7.5 11 7.5 1.55 0 3.03-.3 4.38-.84l.42.42L19.73 22 21 20.73 3.27 3 2 4.27zM7.53 9.8l1.55 1.55c-.05.21-.08.43-.08.65 0 1.66 1.34 3 3 3 .22 0 .44-.03.65-.08l1.55 1.55c-.67.33-1.41.53-2.2.53-2.76 0-5-2.24-5-5 0-.79.2-1.53.53-2.2zm4.31-.78l3.15 3.15.02-.16c0-1.66-1.34-3-3-3l-.17.01z',
  info:'M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm1 15h-2v-6h2v6zm0-8h-2V7h2v2z',
  send:'M2.01 21L23 12 2.01 3 2 10l15 2-15 2z',
  doc:'M14 2H6c-1.1 0-1.99.9-1.99 2L4 20c0 1.1.89 2 1.99 2H18c1.1 0 2-.9 2-2V8l-6-6zm2 16H8v-2h8v2zm0-4H8v-2h8v2zm-3-5V3.5L18.5 9H13z',
  people:'M16 11c1.66 0 2.99-1.34 2.99-3S17.66 5 16 5c-1.66 0-3 1.34-3 3s1.34 3 3 3zm-8 0c1.66 0 2.99-1.34 2.99-3S9.66 5 8 5C6.34 5 5 6.34 5 8s1.34 3 3 3zm0 2c-2.33 0-7 1.17-7 3.5V19h14v-2.5c0-2.33-4.67-3.5-7-3.5zm8 0c-.29 0-.62.02-.97.05 1.16.84 1.97 1.97 1.97 3.45V19h6v-2.5c0-2.33-4.67-3.5-7-3.5z',
  verified:'M12 1L3 5v6c0 5.55 3.84 10.74 9 12 5.16-1.26 9-6.45 9-12V5l-9-4zm-2 16l-4-4 1.41-1.41L10 14.17l6.59-6.59L18 9l-8 8z',
  hourglass:'M6 2v6h.01L6 8.01 10 12l-4 4 .01.01H6V22h12v-5.99h-.01L18 16l-4-4 4-3.99-.01-.01H18V2H6zm10 14.5V20H8v-3.5l4-4 4 4zm-4-5l-4-4V4h8v3.5l-4 4z',
  check:'M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm-2 15l-5-5 1.41-1.41L10 14.17l7.59-7.59L19 8l-9 9z',
  checkbox:'M19 5v14H5V5h14m0-2H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2V5c0-1.1-.9-2-2-2z',
  phone:'M6.62 10.79c1.44 2.83 3.76 5.14 6.59 6.59l2.2-2.2c.27-.27.67-.36 1.02-.24 1.12.37 2.33.57 3.57.57.55 0 1 .45 1 1V20c0 .55-.45 1-1 1-9.39 0-17-7.61-17-17 0-.55.45-1 1-1h3.5c.55 0 1 .45 1 1 0 1.25.2 2.45.57 3.57.11.35.03.74-.25 1.02l-2.2 2.2z',
  logout:'M17 7l-1.41 1.41L18.17 11H8v2h10.17l-2.58 2.58L17 17l5-5zM4 5h8V3H4c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h8v-2H4V5z',
  sms:'M20 2H4c-1.1 0-1.99.9-1.99 2L2 22l4-4h14c1.1 0 2-.9 2-2V4c0-1.1-.9-2-2-2zM9 11H7V9h2v2zm4 0h-2V9h2v2zm4 0h-2V9h2v2z',
  save:'M17 3H5c-1.11 0-2 .9-2 2v14c0 1.1.89 2 2 2h14c1.1 0 2-.9 2-2V7l-4-4zm-5 16c-1.66 0-3-1.34-3-3s1.34-3 3-3 3 1.34 3 3-1.34 3-3 3zm3-10H5V5h10v4z',
  camera:'M9 2L7.17 4H4c-1.1 0-2 .9-2 2v12c0 1.1.9 2 2 2h16c1.1 0 2-.9 2-2V6c0-1.1-.9-2-2-2h-3.17L15 2H9zm3 15c-2.76 0-5-2.24-5-5s2.24-5 5-5 5 2.24 5 5-2.24 5-5 5z',
  upload:'M9 16h6v-6h4l-7-7-7 7h4zm-4 2h14v2H5z',
  checkout:'M16.59 7.58L10 14.17l-3.59-3.58L5 12l5 5 8-8zM12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12 2zm0 18c-4.42 0-8-3.58-8-8s3.58-8 8-8 8 3.58 8 8-3.58 8-8 8z',
  image:'M21 19V5c0-1.1-.9-2-2-2H5c-1.1 0-2 .9-2 2v14c0 1.1.9 2 2 2h14c1.1 0 2-.9 2-2zM8.5 13.5l2.5 3.01L14.5 12l4.5 6H5l3.5-4.5z'
};

// ---------------------------------------------------------------- helpers
function hex(h) { return { r: parseInt(h.slice(0,2),16)/255, g: parseInt(h.slice(2,4),16)/255, b: parseInt(h.slice(4,6),16)/255 }; }
function solid(h, o) { const p = { type:'SOLID', color: hex(h) }; if (o !== undefined) p.opacity = o; return p; }

function I(name, size, color) {
  const n = figma.createNodeFromSvg('<svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg"><path d="' + ICONS[name] + '" fill="#' + color + '"/></svg>');
  n.name = 'icon/' + name; n.resize(size, size); return n;
}

function T(str, o) {
  o = o || {};
  const t = figma.createText();
  t.fontName = { family:'Roboto', style: W[o.w || 400] };
  t.characters = str;
  t.fontSize = o.size || 16;
  t.fills = [solid(o.c || C.TX, o.op)];
  if (o.lh) t.lineHeight = { unit:'PERCENT', value: o.lh * 100 };
  if (o.ls) t.letterSpacing = { unit:'PIXELS', value: o.ls };
  if (o.align) t.textAlignHorizontal = o.align;
  if (o.fillw) { t.textAutoResize = 'HEIGHT'; t.resize(100, t.height); }
  return t;
}

function AL(dir, o) {
  o = o || {};
  const f = figma.createFrame();
  f.name = o.name || 'frame';
  f.layoutMode = dir;
  f.primaryAxisSizingMode = 'AUTO';
  f.counterAxisSizingMode = 'AUTO';
  f.itemSpacing = o.gap || 0;
  const p = Array.isArray(o.pad) ? o.pad : [o.pad || 0, o.pad || 0, o.pad || 0, o.pad || 0];
  f.paddingTop = p[0]; f.paddingRight = p[1]; f.paddingBottom = p[2]; f.paddingLeft = p[3];
  f.fills = o.fill ? [solid(o.fill, o.fillOp)] : [];
  if (o.stroke) { f.strokes = [solid(o.stroke, o.strokeOp)]; f.strokeWeight = o.sw || 1; f.strokeAlign = 'INSIDE'; }
  f.cornerRadius = o.r || 0;
  if (o.ai) f.counterAxisAlignItems = o.ai;
  if (o.pi) f.primaryAxisAlignItems = o.pi;
  if (o.shadow) f.effects = [{ type:'DROP_SHADOW', color:{ r:hex(C.P).r, g:hex(C.P).g, b:hex(C.P).b, a:0.06 }, offset:{x:0,y:5}, radius:14, spread:0, visible:true, blendMode:'NORMAL' }];
  f.clipsContent = !!o.clip;
  if (o.w || o.h) {
    f.resize(o.w || f.width, o.h || f.height);
    const hAxis = dir === 'HORIZONTAL' ? 'primaryAxisSizingMode' : 'counterAxisSizingMode';
    const vAxis = dir === 'HORIZONTAL' ? 'counterAxisSizingMode' : 'primaryAxisSizingMode';
    f[hAxis] = o.w ? 'FIXED' : 'AUTO';
    f[vAxis] = o.h ? 'FIXED' : 'AUTO';
  }
  return f;
}

function add(p, c, o) {
  o = o || {};
  p.appendChild(c);
  if (o.fw) c.layoutSizingHorizontal = 'FILL';
  if (o.fh) c.layoutSizingVertical = 'FILL';
  return c;
}
function grow(p, c) { p.appendChild(c); c.layoutGrow = 1; return c; }

function softCard(name) { return AL('VERTICAL', { pad:16, fill:C.WH, stroke:C.BD, r:18, shadow:true, name: name || 'SoftCard' }); }

function chip(label, color, icon) {
  const c = AL('HORIZONTAL', { gap:5, pad:[4,10,4,10], fill:color, fillOp:0.12, stroke:color, strokeOp:0.5, r:20, ai:'CENTER', name:'StatusChip' });
  if (icon) c.appendChild(I(icon, 16, color));
  c.appendChild(T(label, { w:700, c:color }));
  return c;
}

function iconLine(icon, text, color) {
  const r = AL('HORIZONTAL', { gap:10, pad:[4,0,4,0], name:'IconLine' });
  r.counterAxisAlignItems = 'MIN';
  r.appendChild(I(icon, 20, color || C.P));
  add(r, T(text, { lh:1.3, fillw:true }), { fw:true });
  return r;
}

function sectionHeader(title, action) {
  const r = AL('HORIZONTAL', { gap:8, ai:'CENTER', name:'SectionHeader' });
  const bar = figma.createRectangle(); bar.resize(4, 18); bar.cornerRadius = 2; bar.fills = [solid(C.GO)]; bar.name = 'ornamen emas';
  r.appendChild(bar);
  grow(r, T(title, { size:18, w:800 }));
  if (action) r.appendChild(T(action, { w:700, c:C.P }));
  return r;
}

function infoBanner(text, o) {
  o = o || {};
  const color = o.color || C.MR;
  const b = AL('HORIZONTAL', { gap:10, pad:14, fill:color, fillOp:0.08, stroke:color, strokeOp:0.4, r:14, name:'InfoBanner' });
  b.counterAxisAlignItems = 'MIN';
  b.appendChild(I(o.icon || 'info', 24, color));
  const col = AL('VERTICAL', { gap:3, name:'teks' }); grow(b, col);
  if (o.title) add(col, T(o.title, { w:800, c:color, fillw:true }), { fw:true });
  add(col, T(text, { lh:1.4, fillw:true }), { fw:true });
  return b;
}

function helpCard(title, lines) {
  const b = AL('HORIZONTAL', { gap:10, pad:14, fill:C.GL, fillOp:0.35, stroke:C.GO, strokeOp:0.6, r:16, name:'HelpCard' });
  b.counterAxisAlignItems = 'MIN';
  b.appendChild(I('info', 26, C.MR));
  const col = AL('VERTICAL', { gap:4, name:'teks' }); grow(b, col);
  add(col, T(title, { w:800, c:C.MR, fillw:true }), { fw:true });
  for (const l of lines) add(col, T(l, { lh:1.4, fillw:true }), { fw:true });
  return b;
}

function primaryBtn(label, icon, color) {
  const b = AL('HORIZONTAL', { gap:8, fill: color || C.P, r:14, ai:'CENTER', pi:'CENTER', h:54, name:'Tombol - ' + label });
  b.appendChild(T(label, { w:800, c:C.WH }));
  if (icon) b.appendChild(I(icon, 20, C.GL));
  return b;
}
function outlineBtn(label, icon, color) {
  color = color || C.P;
  const b = AL('HORIZONTAL', { gap:8, stroke:color, sw:1.4, r:14, ai:'CENTER', pi:'CENTER', h:52, name:'Tombol - ' + label });
  b.appendChild(T(label, { w:800, c:color }));
  if (icon) b.appendChild(I(icon, 20, color));
  return b;
}

function field(o) {
  const f = AL('VERTICAL', { gap:6, name:'Field - ' + o.label });
  const lr = AL('HORIZONTAL', { ai:'CENTER', name:'label' }); add(f, lr, { fw:true });
  grow(lr, T(o.label, { w:700 }));
  if (o.counter) lr.appendChild(T(o.counter, { c:C.TM }));
  const box = AL('HORIZONTAL', { gap:10, pad:[17,14,17,14], fill:C.PS, fillOp:0.45, stroke:C.BD, r:12, ai:'CENTER', name:'Input' }); add(f, box, { fw:true });
  if (o.prefix) box.appendChild(T(o.prefix, { w:700, c:C.P }));
  else if (o.icon) box.appendChild(I(o.icon, 22, C.P));
  grow(box, T(o.value || o.hint, { c: o.value ? C.TX : C.TM }));
  if (o.suffix) box.appendChild(I(o.suffix, 22, C.TM));
  if (o.helper) add(f, T(o.helper, { c:C.TM, lh:1.3, fillw:true }), { fw:true });
  return f;
}

function checkRow(text, bg) {
  const r = AL('HORIZONTAL', { gap:8, pad: bg ? 8 : 0, fill: bg ? C.PS : undefined, fillOp: bg ? 0.6 : undefined, r:12, name:'Checkbox' });
  r.counterAxisAlignItems = 'MIN';
  const box = AL('HORIZONTAL', { ai:'CENTER', pi:'CENTER', w:40, h:40, name:'kotak centang' }); box.appendChild(I('checkbox', 24, C.TM)); r.appendChild(box);
  if (bg) { const t = T(text, { lh:1.4, fillw:true }); grow(r, t); t.paddingTop = 0; } else { const w = AL('HORIZONTAL', { pad:[0,0,0,0], ai:'CENTER', name:'teks' }); w.appendChild(T(text)); w.counterAxisSizingMode='AUTO'; r.appendChild(w); r.counterAxisAlignItems = 'CENTER'; }
  return r;
}

function divider() { const d = figma.createRectangle(); d.name = 'Divider'; d.resize(100, 1); d.fills = [solid(C.BD)]; return d; }

function batikDivider(width) {
  const f = figma.createFrame(); f.name = 'BatikDivider'; f.resize(width, 10); f.fills = [solid(C.MR)]; f.clipsContent = true;
  for (let x = 8; x < width + 16; x += 16) { const p = figma.createPolygon(); p.pointCount = 4; p.resize(7.6, 7.6); p.x = x - 3.8; p.y = 1.2; p.fills = [solid(C.GO)]; p.name = 'belah ketupat'; f.appendChild(p); }
  return f;
}

function addPattern(frame, op) {
  const s = 14, step = 34;
  const g = figma.createFrame(); g.name = 'motif batik'; g.fills = []; g.clipsContent = true;
  frame.insertChild(0, g); g.layoutPositioning = 'ABSOLUTE'; g.x = 0; g.y = 0; g.resize(frame.width, frame.height);
  let row = 0;
  for (let y = -s/2; y < frame.height + s; y += step/2, row++) {
    for (let x = (row % 2 ? step/2 : 0); x < frame.width + s; x += step) {
      const p = figma.createPolygon(); p.pointCount = 4; p.resize(s, s); p.x = x - s/2; p.y = y; p.fills = [solid(C.GO, op || 0.12)]; p.name = 'belah ketupat'; g.appendChild(p);
    }
  }
  return g;
}

function authHeader(title, subtitle, icon, deferred) {
  const card = AL('VERTICAL', { r:22, clip:true, name:'AuthHeader' });
  const top = AL('VERTICAL', { gap:12, pad:[22,20,22,20], fill:C.P, ai:'CENTER', name:'header batik' }); add(card, top, { fw:true });
  const circ = AL('HORIZONTAL', { fill:C.WH, fillOp:0.14, stroke:C.GO, sw:1.6, r:33, ai:'CENTER', pi:'CENTER', w:66, h:66, name:'logo' }); circ.appendChild(I(icon, 34, C.GL)); top.appendChild(circ);
  const tx = AL('VERTICAL', { gap:6, name:'teks' }); add(top, tx, { fw:true });
  add(tx, T(title, { size:22, w:800, c:C.WH, align:'CENTER', fillw:true }), { fw:true });
  add(tx, T(subtitle, { c:C.WH, op:0.9, lh:1.4, align:'CENTER', fillw:true }), { fw:true });
  add(card, batikDivider(358), { fw:true });
  deferred.push(top);
  return card;
}

function authAppBar(showBack) {
  const bar = AL('HORIZONTAL', { pad:[8,4,8,4], fill:C.WH, ai:'CENTER', name:'AppBar' });
  const left = AL('HORIZONTAL', { ai:'CENTER', pi:'CENTER', w:48, h:48, name:'Tombol Kembali' }); if (showBack) left.appendChild(I('backios', 20, C.TX)); bar.appendChild(left);
  const mid = AL('HORIZONTAL', { gap:6, ai:'CENTER', pi:'CENTER', name:'judul' }); mid.appendChild(I('bank', 20, C.P)); mid.appendChild(T('DESA KU', { size:18, w:800, c:C.P, ls:1.2 })); grow(bar, mid);
  const right = AL('HORIZONTAL', { w:48, h:48, name:'spacer' }); bar.appendChild(right);
  return bar;
}

function pageAppBar(title, showBack) {
  const bar = AL('HORIZONTAL', { gap:4, pad:[8,16,8,4], fill:C.WH, ai:'CENTER', name:'AppBar' });
  if (showBack) { const b = AL('HORIZONTAL', { ai:'CENTER', pi:'CENTER', w:48, h:48, name:'Tombol Kembali' }); b.appendChild(I('back', 24, C.TX)); bar.appendChild(b); }
  else bar.paddingLeft = 16;
  grow(bar, T(title, { size:20, w:800 }));
  return bar;
}

function prepRoot(node, name) {
  for (const c of [...node.children]) c.remove();
  node.name = name; node.layoutMode = 'VERTICAL'; node.resize(390, 100);
  node.primaryAxisSizingMode = 'AUTO'; node.counterAxisSizingMode = 'FIXED';
  node.itemSpacing = 0; node.paddingTop = node.paddingBottom = node.paddingLeft = node.paddingRight = 0;
  node.fills = [solid(C.BG)]; node.clipsContent = true; node.cornerRadius = 0; node.strokes = []; node.effects = [];
  return node;
}

function body(root, gap, pad) { const b = AL('VERTICAL', { gap: gap, pad: pad || [16,16,24,16], name:'Konten' }); add(root, b, { fw:true }); return b; }

// ---------------------------------------------------------------- navigasi bawah (komponen)
function buildNav() {
  const tabs = [['Beranda','home'],['Kegiatan','event'],['Bantuan','heart'],['Berita','newspaper'],['Profil','person']];
  const comps = [];
  for (const t of tabs) {
    const label = t[0];
    const comp = figma.createComponent(); comp.name = 'Tab=' + label;
    comp.layoutMode = 'HORIZONTAL'; comp.resize(390, 76); comp.primaryAxisSizingMode = 'FIXED'; comp.counterAxisSizingMode = 'FIXED';
    comp.counterAxisAlignItems = 'CENTER'; comp.primaryAxisAlignItems = 'CENTER'; comp.paddingLeft = 4; comp.paddingRight = 4; comp.itemSpacing = 0;
    comp.fills = [solid(C.WH)];
    comp.effects = [{ type:'DROP_SHADOW', color:{ r:hex(C.P).r, g:hex(C.P).g, b:hex(C.P).b, a:0.08 }, offset:{x:0,y:-2}, radius:10, spread:0, visible:true, blendMode:'NORMAL' }];
    for (const u of tabs) {
      const sel = u[0] === label;
      const item = AL('VERTICAL', { gap:4, ai:'CENTER', pi:'CENTER', name:'nav/' + u[0] });
      const pill = AL('HORIZONTAL', { ai:'CENTER', pi:'CENTER', w:64, h:32, r:16, fill: sel ? C.PS : undefined, name:'indikator' });
      pill.appendChild(I(u[1], 24, sel ? C.P : C.TM));
      if (u[0] === 'Profil') { const dot = figma.createEllipse(); dot.name = 'badge notifikasi'; dot.resize(10,10); dot.fills = [solid(C.DG)]; dot.strokes = [solid(C.WH)]; dot.strokeWeight = 1.5; pill.appendChild(dot); dot.layoutPositioning = 'ABSOLUTE'; dot.x = 36; dot.y = 3; }
      item.appendChild(pill);
      item.appendChild(T(u[0], { w: sel ? 800 : 500, c: sel ? C.P : C.TM }));
      comp.appendChild(item); item.layoutGrow = 1; item.layoutSizingVertical = 'HUG';
    }
    comps.push(comp);
  }
  const set = figma.combineAsVariants(comps, figma.currentPage);
  set.name = 'Bottom Navigation'; set.layoutMode = 'VERTICAL'; set.itemSpacing = 16;
  set.paddingTop = set.paddingBottom = set.paddingLeft = set.paddingRight = 16; set.fills = [solid(C.BG)]; set.cornerRadius = 12;
  set.x = 0; set.y = -620;
  return set;
}
function getNav() {
  let set = figma.currentPage.findOne(function (n) { return n.type === 'COMPONENT_SET' && n.name === 'Bottom Navigation'; });
  if (!set) set = buildNav();
  set.counterAxisSizingMode = 'AUTO';
  return set;
}
function navInstance(set, tab) {
  const v = set.children.find(function (c) { return c.name === 'Tab=' + tab; });
  const inst = v.createInstance(); inst.name = 'Bottom Navigation'; return inst;
}

// ---------------------------------------------------------------- layar
function finish(deferred, op) { for (const f of deferred) addPattern(f, op || 0.12); }

function buildBeranda(root, nav) {
  prepRoot(root, 'Beranda');
  const deferred = [];
  const bar = AL('HORIZONTAL', { gap:10, pad:[8,8,8,16], fill:C.WH, ai:'CENTER', name:'AppBar' }); add(root, bar, { fw:true });
  const logo = AL('HORIZONTAL', { fill:C.P, stroke:C.GO, sw:1.4, r:10, ai:'CENTER', pi:'CENTER', w:40, h:40, name:'logo' }); logo.appendChild(I('bank', 22, C.GL)); bar.appendChild(logo);
  grow(bar, T('DesaKu', { size:20, w:900, c:C.P }));
  const bell = AL('HORIZONTAL', { ai:'CENTER', pi:'CENTER', w:48, h:48, name:'Notifikasi' }); bell.appendChild(I('bell', 28, C.P));
  const badge = AL('HORIZONTAL', { fill:C.DG, r:10, ai:'CENTER', pi:'CENTER', pad:[0,5,0,5], name:'badge' }); badge.appendChild(T('3', { size:13, w:700, c:C.WH }));
  bell.appendChild(badge); badge.layoutPositioning = 'ABSOLUTE'; badge.x = 26; badge.y = 6; bar.appendChild(bell);

  const content = body(root, 22);
  const g1 = AL('VERTICAL', { gap:14, name:'Hero & Pengumuman' }); add(content, g1, { fw:true });
  const hero = AL('VERTICAL', { gap:14, pad:18, fill:C.P, stroke:C.GO, sw:1.4, r:22, clip:true, name:'HeroCard' }); add(g1, hero, { fw:true });
  const hl = AL('VERTICAL', { gap:4, name:'Sapaan' }); add(hero, hl, { fw:true });
  add(hl, T('Selamat Datang, Azkiya Zahrul Umam!', { size:24, w:800, c:C.WH, lh:1.2, fillw:true }), { fw:true });
  add(hl, T('Desa Sukamaju, Kabupaten Tangerang', { c:C.WH, op:0.9, fillw:true }), { fw:true });
  const nik = AL('HORIZONTAL', { gap:10, pad:12, fill:C.WH, fillOp:0.12, stroke:C.WH, strokeOp:0.25, r:14, ai:'CENTER', name:'NIK' }); add(hero, nik, { fw:true });
  nik.appendChild(I('card', 28, C.GL));
  const nc = AL('VERTICAL', { name:'teks NIK' }); grow(nik, nc);
  nc.appendChild(T('NIK', { c:C.WH, op:0.8 })); nc.appendChild(T('3603 •••• •••• 0001', { size:18, w:800, c:C.WH, ls:0.5 }));
  deferred.push(hero);

  const ann = AL('VERTICAL', { gap:6, pad:14, fill:C.GL, fillOp:0.35, stroke:C.GO, strokeOp:0.6, r:16, name:'Pengumuman' }); add(g1, ann, { fw:true });
  const ar = AL('HORIZONTAL', { gap:6, ai:'CENTER', name:'judul' }); ar.appendChild(I('bell', 22, C.MR)); ar.appendChild(T('PENGUMUMAN TERBARU', { w:800, c:C.MR })); ann.appendChild(ar);
  add(ann, T('Pendaftaran BLT Dana Desa Dibuka Hingga Akhir Pekan', { w:700, lh:1.4, fillw:true }), { fw:true });
  ann.appendChild(T('Baca selengkapnya →', { w:800, c:C.P }));

  const g2 = AL('VERTICAL', { gap:12, name:'Layanan Warga' }); add(content, g2, { fw:true });
  add(g2, sectionHeader('Layanan Warga'), { fw:true });
  const items = [['event','Kegiatan Desa','Daftar & ikuti kegiatan'],['heart','Program Bantuan','Ajukan & pantau status'],['newspaper','Berita Desa','Informasi resmi desa'],['bell','Notifikasi','3 belum dibaca']];
  for (let i = 0; i < 4; i += 2) {
    const row = AL('HORIZONTAL', { gap:12, name:'baris layanan' }); add(g2, row, { fw:true });
    for (const it of items.slice(i, i + 2)) {
      const card = softCard('Layanan - ' + it[1]); card.paddingTop = card.paddingBottom = card.paddingLeft = card.paddingRight = 14; card.itemSpacing = 14;
      add(row, card, { fw:true });
      const circ = AL('HORIZONTAL', { fill:C.PS, stroke:C.GO, strokeOp:0.8, r:25, ai:'CENTER', pi:'CENTER', w:50, h:50, name:'ikon' }); circ.appendChild(I(it[0], 28, C.P)); card.appendChild(circ);
      const tx = AL('VERTICAL', { gap:3, name:'teks' }); add(card, tx, { fw:true });
      add(tx, T(it[1], { w:800, lh:1.2, fillw:true }), { fw:true }); add(tx, T(it[2], { c:C.TM, lh:1.2, fillw:true }), { fw:true });
    }
  }

  const g3 = AL('VERTICAL', { gap:12, name:'Kegiatan Terdekat' }); add(content, g3, { fw:true });
  add(g3, sectionHeader('Kegiatan Terdekat', 'Lihat Semua'), { fw:true });
  const acts = [['NOV','6','Kesehatan','Posyandu Balita Melati II','08.00 WIB','Balai Dusun 2','Sisa 28 kuota'],['NOV','11','Gotong Royong','Kerja Bakti Saluran Irigasi','07.00 WIB','Saluran Irigasi Blok Barat','Sisa 59 kuota']];
  for (const a of acts) add(g3, activityCard(a), { fw:true });

  const g4 = AL('VERTICAL', { gap:12, name:'Pengajuan Bantuan Saya' }); add(content, g4, { fw:true });
  add(g4, sectionHeader('Pengajuan Bantuan Saya', 'Semua'), { fw:true });
  add(g4, applicationCard(), { fw:true });

  const g5 = AL('VERTICAL', { gap:12, name:'Berita & Informasi Desa' }); add(content, g5, { fw:true });
  add(g5, sectionHeader('Berita & Informasi Desa', 'Semua'), { fw:true });
  const news = [['Pengumuman','Pendaftaran BLT Dana Desa Dibuka Hingga Akhir Pekan','Pemerintah Desa Sukamaju membuka pendaftaran penerima BLT Dana Desa melalui aplikasi DesaKu.','31 Oktober 2026'],['Berita','Warga Kerja Bakti Bersihkan Saluran Irigasi bersama Dinas Pertanian','Ratusan warga Desa Sukamaju bergotong royong membersihkan saluran irigasi untuk menyambut musim tanam.','29 Oktober 2026']];
  const heads = [];
  for (const n of news) {
    const card = AL('VERTICAL', { fill:C.WH, stroke:C.BD, r:18, shadow:true, clip:true, name:'NewsCard' }); add(g5, card, { fw:true });
    const hd = AL('VERTICAL', { pad:12, fill: n[0] === 'Pengumuman' ? C.P : C.PD, h:110, name:'header batik', clip:true }); add(card, hd, { fw:true });
    const tag = AL('HORIZONTAL', { pad:[4,10,4,10], fill:C.GO, r:8, name:'kategori' }); tag.appendChild(T(n[0], { w:800, c:C.PD })); hd.appendChild(tag);
    heads.push(hd);
    const bd = AL('VERTICAL', { gap:6, pad:14, name:'isi berita' }); add(card, bd, { fw:true });
    add(bd, T(n[1], { size:18, w:800, lh:1.3, fillw:true }), { fw:true }); add(bd, T(n[2], { c:C.TM, lh:1.4, fillw:true }), { fw:true });
    const meta = AL('HORIZONTAL', { gap:6, pad:[2,0,0,0], ai:'CENTER', name:'meta' }); add(bd, meta, { fw:true });
    meta.appendChild(I('caltoday', 16, C.TM)); grow(meta, T(n[3], { c:C.TM })); meta.appendChild(T('Baca →', { w:800, c:C.P }));
  }
  const inst = navInstance(nav, 'Beranda'); add(root, inst, { fw:true });
  finish(deferred, 0.1); for (const h of heads) addPattern(h, 0.14);
  return root;
}

function activityCard(a) {
  const card = softCard('ActivityCard'); card.layoutMode = 'HORIZONTAL'; card.itemSpacing = 12; card.counterAxisAlignItems = 'MIN';
  const bd = AL('VERTICAL', { pad:[8,0,8,0], fill: a[8] ? C.TM : C.MR, stroke:C.GO, r:12, ai:'CENTER', w:62, name:'DateBadge' });
  bd.appendChild(T(a[0], { w:800, c:C.GL })); bd.appendChild(T(a[1], { size:26, w:900, c:C.WH })); card.appendChild(bd);
  const col = AL('VERTICAL', { name:'isi' }); grow(card, col);
  add(col, T(a[2], { w:600, c:C.TM, fillw:true }), { fw:true });
  add(col, T(a[3], { size:18, w:800, lh:1.25, fillw:true }), { fw:true });
  const sp = AL('VERTICAL', { pad:[6,0,0,0], name:'detail' }); add(col, sp, { fw:true });
  add(sp, iconLine('clock', a[4], C.TM), { fw:true }); add(sp, iconLine('pin', a[5], C.TM), { fw:true });
  const cw = AL('HORIZONTAL', { pad:[6,0,0,0], name:'status' }); col.appendChild(cw); cw.appendChild(chip(a[6], a[7] || C.IN));
  return card;
}

function applicationCard() {
  const app = softCard('ApplicationCard');
  app.appendChild(T('BLT Dana Desa', { size:18, w:800, lh:1.25 }));
  app.appendChild(T('Diajukan 27 Oktober 2026', { c:C.TM }));
  const rowS = AL('HORIZONTAL', { pad:[10,0,0,0], ai:'CENTER', name:'status' }); add(app, rowS, { fw:true });
  const cw = AL('HORIZONTAL', { name:'chip' }); grow(rowS, cw); cw.appendChild(chip('Perlu Perbaikan', C.OR, 'edit')); rowS.appendChild(I('chev', 24, C.P));
  const hint = AL('HORIZONTAL', { pad:[8,0,0,0], name:'petunjuk' }); add(app, hint, { fw:true });
  add(hint, T('Ketuk untuk melihat alasan dan memperbaiki.', { w:600, c:C.OR, fillw:true }), { fw:true });
  return app;
}

function buildMasuk(root) {
  prepRoot(root, 'Masuk'); const deferred = [];
  add(root, authAppBar(false), { fw:true });
  const b = body(root, 0);
  add(b, authHeader('Masuk Layanan Warga', 'Akses informasi kegiatan, program bantuan, dan berita resmi Desa Sukamaju.', 'bank', deferred), { fw:true });
  const form = softCard('Form Masuk'); form.itemSpacing = 14; const gap1 = AL('VERTICAL', { pad:[16,0,0,0], name:'jarak' }); add(b, gap1, { fw:true }); add(gap1, form, { fw:true });
  add(form, field({ label:'NIK atau No. Telepon', hint:'3603xxxxxxxxxxxx', icon:'card', helper:'Format: 16 digit NIK atau nomor telepon aktif.' }), { fw:true });
  add(form, field({ label:'Kata Sandi', hint:'Masukkan kata sandi', icon:'lock', suffix:'eyeoff' }), { fw:true });
  add(form, checkRow('Ingat Saya'), {});
  const lupa = AL('HORIZONTAL', { pi:'MAX', name:'Tautan Lupa Sandi' }); add(form, lupa, { fw:true }); lupa.appendChild(T('Lupa Kata Sandi?', { w:700, c:C.MR }));
  add(form, primaryBtn('Masuk ke Desa Ku', 'login'), { fw:true });
  const div = AL('HORIZONTAL', { gap:10, pad:[18,0,0,0], ai:'CENTER', name:'pemisah' }); add(b, div, { fw:true });
  const l1 = divider(); div.appendChild(l1); l1.layoutGrow = 1; div.appendChild(T('BELUM PUNYA AKUN?', { w:700, c:C.TM })); const l2 = divider(); div.appendChild(l2); l2.layoutGrow = 1;
  const g = AL('VERTICAL', { gap:14, pad:[14,0,0,0], name:'kartu bawah' }); add(b, g, { fw:true });
  const reg = softCard('Kartu Daftar'); reg.itemSpacing = 4; add(g, reg, { fw:true });
  reg.appendChild(T('Warga Sukamaju Baru?', { size:18, w:800 }));
  add(reg, T('Daftarkan NIK dan nomor KK Anda. Akun aktif setelah diverifikasi admin desa.', { c:C.TM, lh:1.4, fillw:true }), { fw:true });
  const sp = AL('VERTICAL', { pad:[8,0,0,0], name:'tombol' }); add(reg, sp, { fw:true }); add(sp, outlineBtn('Daftar Akun Baru', 'arrow'), { fw:true });
  add(g, helpCard('Butuh Bantuan Masuk?', ['Kantor Desa Sukamaju • Senin–Jumat', 'Jam layanan 08.00 – 15.00 WIB']), { fw:true });
  add(g, infoBanner('NIK 3603010101900001\nKata sandi demo1234', { title:'Akun Demo', icon:'info', color:C.IN }), { fw:true });
  add(g, T('Sistem Informasi Pelayanan Terpadu • Kabupaten Tangerang', { c:C.TM, align:'CENTER', fillw:true }), { fw:true });
  finish(deferred, 0.1); return root;
}

function buildDaftar(root) {
  prepRoot(root, 'Daftar'); const deferred = [];
  add(root, authAppBar(true), { fw:true });
  const b = body(root, 0);
  add(b, authHeader('Pendaftaran Akun Warga', 'Isi data sesuai KTP dan Kartu Keluarga. Admin desa akan memverifikasi data Anda.', 'person', deferred), { fw:true });
  const g = AL('VERTICAL', { gap:14, pad:[12,0,0,0], name:'isi' }); add(b, g, { fw:true });
  add(g, infoBanner('Data Anda hanya dipakai untuk layanan desa dan tidak dibagikan kepada pihak yang tidak berwenang.', { title:'Verifikasi Kependudukan', icon:'verified', color:C.P }), { fw:true });
  const form = softCard('Form Pendaftaran'); form.itemSpacing = 16; add(g, form, { fw:true });
  const hd = AL('HORIZONTAL', { gap:8, ai:'CENTER', name:'judul form' }); add(form, hd, { fw:true }); hd.appendChild(I('card', 24, C.P)); grow(hd, T('Data Diri Warga', { size:18, w:800 }));
  add(form, divider(), { fw:true });
  add(form, field({ label:'Nama Lengkap Sesuai KTP', hint:'Contoh: Azkiya Zahrul Umam', icon:'person' }), { fw:true });
  add(form, field({ label:'Nomor Induk Kependudukan (NIK)', hint:'16 digit NIK', icon:'card', counter:'0/16' }), { fw:true });
  add(form, field({ label:'Nomor Kartu Keluarga (KK)', hint:'16 digit nomor KK', icon:'people', counter:'0/16' }), { fw:true });
  add(form, field({ label:'Nomor Telepon Aktif', hint:'81234567890', prefix:'+62', helper:'Dipakai untuk kode OTP pemulihan kata sandi.' }), { fw:true });
  add(form, field({ label:'Kata Sandi', hint:'Buat kata sandi', icon:'lock', suffix:'eyeoff', helper:'Minimal 8 karakter, kombinasi huruf dan angka.' }), { fw:true });
  add(form, field({ label:'Konfirmasi Kata Sandi', hint:'Ulangi kata sandi', icon:'lock', suffix:'eyeoff' }), { fw:true });
  add(form, checkRow('Saya menyatakan data yang diisikan benar dan setuju datanya diproses untuk layanan desa.', true), { fw:true });
  add(form, primaryBtn('Kirim Pendaftaran Akun', 'send'), { fw:true });
  const sudah = AL('HORIZONTAL', { gap:4, pi:'CENTER', ai:'CENTER', name:'sudah punya akun' }); add(g, sudah, { fw:true });
  sudah.appendChild(T('Sudah memiliki akun?')); const lnk = T('Masuk di sini', { w:800, c:C.MR }); lnk.name = 'Tautan Masuk'; sudah.appendChild(lnk);
  add(g, helpCard('Butuh Bantuan Pendaftaran?', ['Kantor Desa Sukamaju', 'Senin–Jumat, 08.00 – 15.00 WIB']), { fw:true });
  finish(deferred, 0.1); return root;
}

function programCard(p) {
  const card = softCard('ProgramCard'); card.itemSpacing = 10;
  const top = AL('HORIZONTAL', { gap:12, name:'judul' }); top.counterAxisAlignItems = 'MIN'; add(card, top, { fw:true });
  const circ = AL('HORIZONTAL', { fill:C.PS, stroke:C.GO, r:26, ai:'CENTER', pi:'CENTER', w:52, h:52, name:'ikon' }); circ.appendChild(I(p[0], 28, C.P)); top.appendChild(circ);
  add(top, T(p[1], { size:18, w:800, lh:1.25, fillw:true }), { fw:true });
  add(card, T(p[2], { c:C.TM, lh:1.4, fillw:true }), { fw:true });
  add(card, iconLine('event', 'Periode: ' + p[3], C.P), { fw:true });
  const row = AL('HORIZONTAL', { ai:'CENTER', name:'status' }); add(card, row, { fw:true });
  const cw = AL('HORIZONTAL', { name:'chip' }); grow(row, cw); cw.appendChild(chip(p[4], p[5])); row.appendChild(I('chev', 24, C.P));
  return card;
}

function buildAid(root, nav, tab) {
  prepRoot(root, 'Bantuan - Program');
  const bar = pageAppBar('Program Bantuan', false);
  const bw = AL('VERTICAL', { fill:C.WH, name:'AppBar + Tab' }); add(root, bw, { fw:true }); add(bw, bar, { fw:true });
  const tabs = AL('HORIZONTAL', { name:'TabBar' }); add(bw, tabs, { fw:true });
  const names = [['Program', tab === 0], ['Pengajuan Saya', tab === 1]];
  for (const n of names) {
    const t = AL('VERTICAL', { pad:[14,0,0,0], ai:'CENTER', name:'Tab - ' + n[0] }); tabs.appendChild(t); t.layoutGrow = 1;
    t.appendChild(T(n[0], { w: n[1] ? 800 : 600, c: n[1] ? C.P : C.TM }));
    const ind = figma.createRectangle(); ind.resize(100, 3); ind.fills = [solid(n[1] ? C.P : C.BD)]; ind.name = 'indikator'; const sp = AL('VERTICAL', { pad:[11,0,0,0], name:'garis' }); t.appendChild(sp); sp.appendChild(ind); ind.layoutSizingHorizontal = 'FILL'; sp.layoutSizingHorizontal = 'FILL';
  }
  const b = body(root, 12);
  if (tab === 1) add(b, applicationCard(), { fw:true });
  if (tab === 0) add(b, infoBanner('Mengajukan bantuan tidak menjamin diterima. Penetapan penerima ditentukan oleh pemerintah desa.', { title:'Pengajuan = permohonan', icon:'info', color:C.MR }), { fw:true });
  const progs = tab === 1 ? [] : [
    ['person','Bantuan Ibu Hamil & Menyusui','Bantuan gizi dan pendampingan kesehatan bagi ibu hamil dan ibu menyusui dari keluarga kurang mampu.','13 Oktober 2026 – 27 November 2026','Pendaftaran dibuka',C.OK],
    ['card','BLT Dana Desa','Bantuan Langsung Tunai bagi keluarga miskin yang kehilangan mata pencaharian atau berpenghasilan rendah.','18 Oktober 2026 – 7 November 2026','Sudah diajukan',C.IN],
    ['home','Bantuan Rehabilitasi Rumah','Bantuan perbaikan rumah tidak layak huni bagi warga kurang mampu.','12 Desember 2026 – 11 Januari 2027','Segera dibuka',C.WA]
  ];
  for (const p of progs) add(b, programCard(p), { fw:true });
  const inst = navInstance(nav, 'Bantuan'); add(root, inst, { fw:true });
  return root;
}

function buildDetailKegiatan(root) {
  prepRoot(root, 'Detail Kegiatan'); const deferred = [];
  add(root, pageAppBar('Detail Kegiatan', true), { fw:true });
  const b = body(root, 14);
  const hero = AL('HORIZONTAL', { gap:14, pad:18, fill:C.P, r:20, clip:true, name:'Header Kegiatan' }); hero.counterAxisAlignItems = 'MIN'; add(b, hero, { fw:true });
  const bd = AL('VERTICAL', { pad:[8,0,8,0], fill:C.MR, stroke:C.GO, r:12, ai:'CENTER', w:62, name:'DateBadge' }); bd.appendChild(T('NOV', { w:800, c:C.GL })); bd.appendChild(T('6', { size:26, w:900, c:C.WH })); hero.appendChild(bd);
  const col = AL('VERTICAL', { gap:4, name:'judul' }); grow(hero, col);
  add(col, T('KESEHATAN', { w:800, c:C.GL, ls:0.5, fillw:true }), { fw:true });
  add(col, T('Posyandu Balita Melati II', { size:22, w:800, c:C.WH, lh:1.25, fillw:true }), { fw:true });
  deferred.push(hero);
  const info = softCard('Info Kegiatan'); add(b, info, { fw:true });
  add(info, iconLine('event', 'Jumat, 6 November 2026'), { fw:true });
  add(info, iconLine('clock', '08.00 WIB'), { fw:true });
  add(info, iconLine('pin', 'Balai Dusun 2'), { fw:true });
  add(info, iconLine('people', 'Penyelenggara: Kader Posyandu & Puskesmas'), { fw:true });
  const dv = AL('VERTICAL', { pad:[10,0,10,0], name:'pemisah' }); add(info, dv, { fw:true }); add(dv, divider(), { fw:true });
  const kr = AL('HORIZONTAL', { ai:'CENTER', name:'kuota' }); add(info, kr, { fw:true }); grow(kr, T('Kuota', { w:700 })); kr.appendChild(T('32 / 60 terdaftar', { w:800 }));
  const pw = AL('VERTICAL', { pad:[8,0,6,0], name:'progres' }); add(info, pw, { fw:true });
  const track = figma.createFrame(); track.name = 'Progress'; track.resize(326, 10); track.fills = [solid(C.PS)]; track.cornerRadius = 6; track.clipsContent = true; add(pw, track, { fw:true });
  const fill = figma.createRectangle(); fill.name = 'terisi'; fill.resize(174, 10); fill.fills = [solid(C.GO)]; track.appendChild(fill);
  info.appendChild(T('Sisa 28 kuota', { c:C.TM }));
  const ds = AL('VERTICAL', { gap:8, name:'Deskripsi' }); add(b, ds, { fw:true });
  add(ds, sectionHeader('Deskripsi'), { fw:true });
  add(ds, T('Penimbangan balita, pemberian vitamin A, imunisasi dasar, dan konsultasi gizi bersama bidan desa. Bawa buku KIA dan kartu menuju sehat (KMS).', { lh:1.5, fillw:true }), { fw:true });
  const act = AL('VERTICAL', { pad:[6,0,0,0], name:'aksi' }); add(b, act, { fw:true }); add(act, primaryBtn('Daftar Kegiatan', 'person'), { fw:true });
  finish(deferred, 0.1); return root;
}

function timelineRow(ic, color, label, time, reason, isLast, current) {
  const row = AL('HORIZONTAL', { gap:12, name:'Timeline - ' + label }); row.counterAxisAlignItems = 'MIN';
  const left = AL('VERTICAL', { ai:'CENTER', name:'penanda' }); row.appendChild(left); row.layoutSizingVertical = 'HUG';
  left.appendChild(I(ic, 26, color));
  if (!isLast) { const line = figma.createRectangle(); line.name = 'garis'; line.resize(2, 20); line.fills = [solid(C.BD)]; left.appendChild(line); line.layoutGrow = 1; }
  const tx = AL('VERTICAL', { pad:[0,0,isLast ? 0 : 16,0], name:'teks' }); grow(row, tx);
  add(tx, T(label, { w: current ? 800 : 600, c:color, fillw:true }), { fw:true });
  add(tx, T(time, { c:C.TM, fillw:true }), { fw:true });
  if (reason) { const rw = AL('VERTICAL', { pad:[4,0,0,0], name:'alasan' }); add(tx, rw, { fw:true }); add(rw, T(reason, { lh:1.3, fillw:true }), { fw:true }); }
  return row;
}

function buildStatus(root) {
  prepRoot(root, 'Status Pengajuan');
  add(root, pageAppBar('Status Pengajuan', true), { fw:true });
  const b = body(root, 12);
  const c1 = softCard('Ringkasan Pengajuan'); add(b, c1, { fw:true });
  c1.appendChild(T('BLT Dana Desa', { size:20, w:800, lh:1.25 }));
  const s = AL('VERTICAL', { pad:[4,0,12,0], name:'tanggal' }); add(c1, s, { fw:true }); s.appendChild(T('Diajukan 27 Oktober 2026, 09.00 WIB', { c:C.TM }));
  c1.appendChild(chip('Perlu Perbaikan', C.OR, 'edit'));
  add(b, infoBanner('Foto Kartu Keluarga buram dan sebagian data tidak terbaca. Mohon unggah ulang foto yang lebih jelas.', { title:'Alasan perlu perbaikan', icon:'edit', color:C.OR }), { fw:true });
  add(b, primaryBtn('Perbaiki & Kirim Ulang', 'edit', C.OR), { fw:true });
  const g2 = AL('VERTICAL', { gap:10, pad:[6,0,0,0], name:'Perkembangan' }); add(b, g2, { fw:true });
  add(g2, sectionHeader('Perkembangan'), { fw:true });
  const tl = softCard('Timeline'); add(g2, tl, { fw:true });
  add(tl, timelineRow('edit', C.OR, 'Perlu Perbaikan', '30 Oktober 2026, 14.00 WIB', 'Foto Kartu Keluarga buram dan sebagian data tidak terbaca. Mohon unggah ulang foto yang lebih jelas.', false, true), { fw:true });
  add(tl, timelineRow('hourglass', C.TM, 'Sedang Diverifikasi', '28 Oktober 2026, 10.00 WIB', null, false, false), { fw:true });
  add(tl, timelineRow('send', C.TM, 'Dikirim', '27 Oktober 2026, 09.00 WIB', null, true, false), { fw:true });
  const g3 = AL('VERTICAL', { gap:10, pad:[6,0,0,0], name:'Data yang Diajukan' }); add(b, g3, { fw:true });
  add(g3, sectionHeader('Data yang Diajukan'), { fw:true });
  const dc = softCard('Data Pengajuan'); dc.itemSpacing = 10; add(g3, dc, { fw:true });
  const fields = [['Pekerjaan Kepala Keluarga','Buruh tani'],['Penghasilan per Bulan (Rp)','1200000'],['Jumlah Tanggungan Keluarga','4'],['Alasan Mengajukan','Penghasilan menurun sejak musim kemarau.']];
  for (const f of fields) { const w = AL('VERTICAL', { name:'data - ' + f[0] }); add(dc, w, { fw:true }); add(w, T(f[0], { c:C.TM, fillw:true }), { fw:true }); add(w, T(f[1], { w:700, fillw:true }), { fw:true }); }
  add(dc, divider(), { fw:true });
  const docs = [['Foto KTP','ktp.jpg'],['Foto Kartu Keluarga','kk.jpg'],['Foto Rumah Tampak Depan','rumah.jpg']];
  for (const d of docs) add(dc, iconLine('doc', d[0] + '\n' + d[1]), { fw:true });
  const g4 = AL('VERTICAL', { pad:[2,0,0,0], name:'catatan' }); add(b, g4, { fw:true });
  add(g4, infoBanner('Pengajuan bersifat permohonan. Penetapan penerima bantuan ditentukan oleh pemerintah desa.', { icon:'info', color:C.MR }), { fw:true });
  return root;
}

// ---------------------------------------------------------------- layar tambahan (UI 01, 04-07, 09, 12-14, 16-20)
function newRoot(name) { const f = figma.createFrame(); prepRoot(f, name); return f; }

function scrollify(root) {
  const k = root.children.find(function (n) { return n.name === 'Konten'; });
  root.primaryAxisSizingMode = 'FIXED'; root.resize(390, 844); root.clipsContent = true;
  if (k) { k.layoutSizingVertical = 'FILL'; k.clipsContent = true; k.overflowDirection = 'VERTICAL_SCROLLING'; }
}

function buildSplash(root) {
  prepRoot(root, 'UI 01 - Splash');
  root.fills = [solid(C.P)]; root.primaryAxisSizingMode = 'FIXED'; root.resize(390, 844);
  root.primaryAxisAlignItems = 'CENTER'; root.counterAxisAlignItems = 'CENTER';
  const circ = AL('HORIZONTAL', { fill:C.WH, fillOp:0.12, stroke:C.GO, sw:2.2, r:52, ai:'CENTER', pi:'CENTER', w:104, h:104, name:'logo' });
  circ.appendChild(I('bank', 52, C.GL)); root.appendChild(circ);
  const g = AL('VERTICAL', { gap:6, pad:[22,0,0,0], ai:'CENTER', name:'judul' }); root.appendChild(g);
  g.appendChild(T('DesaKu', { size:36, w:900, c:C.WH, ls:1 })); g.appendChild(T('Portal Layanan Warga Digital', { c:C.GL, ls:0.6 }));
  const bd = AL('VERTICAL', { pad:[28,0,0,0], name:'pemisah' }); root.appendChild(bd); bd.appendChild(batikDivider(180));
  const sp = AL('VERTICAL', { pad:[28,0,0,0], name:'memuat' }); root.appendChild(sp);
  const ring = figma.createEllipse(); ring.name = 'indikator memuat'; ring.resize(22, 22); ring.fills = [solid(C.GO)];
  ring.arcData = { startingAngle:0, endingAngle:Math.PI * 1.5, innerRadius:0.8 }; sp.appendChild(ring);
  addPattern(root, 0.1);
}

function buildVerifikasi(root) {
  prepRoot(root, 'UI 04 - Verifikasi'); const d = [];
  add(root, authAppBar(false), { fw:true });
  const b = body(root, 0);
  add(b, authHeader('Menunggu Verifikasi', 'Pendaftaran Anda sudah kami terima dan sedang diperiksa admin Desa Sukamaju.', 'hourglass', d), { fw:true });
  const g = AL('VERTICAL', { gap:14, pad:[16,0,0,0], name:'isi' }); add(b, g, { fw:true });
  const card = softCard('Data Pendaftaran'); add(g, card, { fw:true });
  const hd = AL('VERTICAL', { pad:[0,0,10,0], name:'judul' }); card.appendChild(hd); hd.appendChild(T('Data Pendaftaran', { size:18, w:800 }));
  add(card, iconLine('person', 'Azkiya Zahrul Umam'), { fw:true });
  add(card, iconLine('card', 'NIK 3603 •••• •••• 0001'), { fw:true });
  add(card, iconLine('people', 'KK 3603 •••• •••• 0099'), { fw:true });
  add(card, iconLine('phone', '+62 81234567890'), { fw:true });
  const ch = AL('HORIZONTAL', { pad:[8,0,0,0], name:'status' }); card.appendChild(ch); ch.appendChild(chip('Menunggu verifikasi', C.WA));
  add(g, infoBanner('Pendaftaran kegiatan dan pengajuan bantuan hanya tersedia untuk warga yang sudah diverifikasi. Anda akan menerima notifikasi hasil verifikasi.', { title:'Layanan dikunci sementara', icon:'clock', color:C.WA }), { fw:true });
  add(g, helpCard('Perlu bantuan verifikasi?', ['Datang ke Kantor Desa Sukamaju', 'Senin–Jumat, 08.00 – 15.00 WIB']), { fw:true });
  add(g, outlineBtn('Keluar', 'logout', C.MR), { fw:true });
  const demo = AL('VERTICAL', { gap:8, pad:[8,0,0,0], name:'Mode demo' }); add(g, demo, { fw:true });
  add(demo, batikDivider(358), { fw:true });
  demo.appendChild(T('MODE DEMO • Simulasi tindakan admin', { w:800, c:C.IN }));
  add(demo, primaryBtn('Simulasikan: Disetujui', null, C.OK), { fw:true });
  add(demo, outlineBtn('Simulasikan: Ditolak', null, C.DG), { fw:true });
  finish(d, 0.1); return root;
}

function buildLupa(root, step) {
  const names = ['UI 05 - Lupa Sandi (Nomor)', 'UI 06 - Lupa Sandi (OTP)', 'UI 07 - Lupa Sandi (Sandi Baru)'];
  prepRoot(root, names[step]); const d = [];
  add(root, authAppBar(true), { fw:true });
  const b = body(root, 0);
  const titles = ['Lupa Kata Sandi', 'Masukkan Kode OTP', 'Buat Kata Sandi Baru'];
  const subs = ['Masukkan nomor telepon terdaftar. Kami akan mengirim kode OTP.', 'Kode 6 digit telah dikirim ke +62 81234567890.', 'Buat kata sandi baru untuk akun Anda.'];
  add(b, authHeader(titles[step], subs[step], 'lock', d), { fw:true });
  const g = AL('VERTICAL', { pad:[16,0,0,0], name:'isi' }); add(b, g, { fw:true });
  const pr = AL('HORIZONTAL', { gap:6, name:'progres langkah' }); add(g, pr, { fw:true });
  for (let i = 0; i < 3; i++) { const r = figma.createRectangle(); r.name = 'langkah ' + (i + 1); r.resize(10, 6); r.cornerRadius = 3; r.fills = [solid(i <= step ? C.GO : C.BD)]; pr.appendChild(r); r.layoutGrow = 1; }
  const lg = AL('HORIZONTAL', { pad:[6,0,8,0], pi:'MAX', name:'label langkah' }); add(g, lg, { fw:true }); lg.appendChild(T('Langkah ' + (step + 1) + ' dari 3', { c:C.TM }));
  const card = softCard('Form Lupa Sandi'); card.itemSpacing = 16; add(g, card, { fw:true });
  if (step === 0) {
    add(card, field({ label:'Nomor Telepon Terdaftar', hint:'81234567890', prefix:'+62' }), { fw:true });
    add(card, primaryBtn('Kirim Kode OTP', 'sms'), { fw:true });
  } else if (step === 1) {
    add(card, field({ label:'Kode OTP', hint:'6 digit', icon:'lock', helper:'Kode demo: 123456' }), { fw:true });
    add(card, primaryBtn('Verifikasi Kode', 'check'), { fw:true });
    const rs = AL('HORIZONTAL', { pi:'CENTER', name:'kirim ulang' }); add(card, rs, { fw:true }); rs.appendChild(T('Kirim ulang dalam 60 detik', { w:700, c:C.TM }));
  } else {
    add(card, field({ label:'Kata Sandi Baru', hint:'Minimal 8 karakter', icon:'lock', suffix:'eyeoff', helper:'Kombinasi huruf dan angka.' }), { fw:true });
    add(card, field({ label:'Konfirmasi Kata Sandi', hint:'Ulangi kata sandi', icon:'lock', suffix:'eyeoff' }), { fw:true });
    add(card, primaryBtn('Simpan Kata Sandi', 'save'), { fw:true });
  }
  finish(d, 0.1); return root;
}

function filterChip(label, sel) {
  const c = AL('HORIZONTAL', { pad:[12,16,12,16], fill: sel ? C.P : C.WH, stroke: sel ? C.P : C.BD, r:20, ai:'CENTER', name:'Filter - ' + label });
  c.appendChild(T(label, { w:700, c: sel ? C.WH : C.TX })); return c;
}

function buildKegiatan(root, nav) {
  prepRoot(root, 'UI 09 - Kegiatan');
  add(root, pageAppBar('Kegiatan Desa', false), { fw:true });
  const b = body(root, 14, [12,16,24,16]);
  const top = AL('VERTICAL', { gap:12, name:'Filter' }); add(b, top, { fw:true });
  const row = AL('HORIZONTAL', { gap:8, clip:true, name:'Filter kategori' }); add(top, row, { fw:true });
  [['Semua', true], ['Kesehatan', false], ['Gotong Royong', false], ['Pertanian', false], ['Musyawarah', false]].forEach(function (x) { row.appendChild(filterChip(x[0], x[1])); });
  const tg = AL('HORIZONTAL', { pad:[6,16,6,16], fill:C.WH, stroke:C.BD, r:18, shadow:true, ai:'CENTER', name:'Toggle - Hanya kegiatan saya' }); add(top, tg, { fw:true });
  grow(tg, T('Hanya kegiatan yang saya ikuti', { w:600 }));
  const sw = figma.createFrame(); sw.name = 'Switch (mati)'; sw.resize(52, 32); sw.cornerRadius = 16; sw.fills = [solid(C.TM)];
  const th = figma.createEllipse(); th.resize(16, 16); th.x = 8; th.y = 8; th.fills = [solid(C.WH)]; sw.appendChild(th); tg.appendChild(sw);
  const g1 = AL('VERTICAL', { gap:12, name:'Akan Datang' }); add(b, g1, { fw:true });
  add(g1, sectionHeader('Akan Datang'), { fw:true });
  const up = [
    ['NOV','3','Kesehatan','Senam Lansia Sehat','06.00 WIB','Lapangan Desa','Sisa 32 kuota'],
    ['NOV','6','Kesehatan','Posyandu Balita Melati II','08.00 WIB','Balai Dusun 2','Sisa 28 kuota'],
    ['NOV','11','Gotong Royong','Kerja Bakti Saluran Irigasi','07.00 WIB','Saluran Irigasi Blok Barat','Sisa 59 kuota'],
    ['NOV','16','Pertanian','Penyuluhan Pertanian Organik','09.00 WIB','Aula Kantor Desa','Kuota penuh', C.DG]
  ];
  for (const a of up) add(g1, activityCard(a), { fw:true });
  const g2 = AL('VERTICAL', { gap:12, name:'Telah Selesai' }); add(b, g2, { fw:true });
  add(g2, sectionHeader('Telah Selesai'), { fw:true });
  add(g2, activityCard(['OKT','27','Musyawarah','Musyawarah Desa Perencanaan Pembangunan','19.00 WIB','Aula Kantor Desa','Selesai', C.TM, true]), { fw:true });
  add(root, navInstance(nav, 'Kegiatan'), { fw:true });
  return root;
}

function buildDetailProgram(root) {
  prepRoot(root, 'UI 13 - Detail Program'); const d = [];
  add(root, pageAppBar('Detail Program', true), { fw:true });
  const b = body(root, 0);
  const hero = AL('VERTICAL', { gap:8, pad:18, fill:C.P, r:20, clip:true, name:'Header Program' }); add(b, hero, { fw:true });
  hero.appendChild(I('person', 36, C.GL));
  const ht = AL('VERTICAL', { gap:6, name:'judul' }); add(hero, ht, { fw:true });
  add(ht, T('Bantuan Ibu Hamil & Menyusui', { size:22, w:800, c:C.WH, lh:1.25, fillw:true }), { fw:true });
  add(ht, T('Periode 13 Oktober 2026 – 27 November 2026', { c:C.GL, fillw:true }), { fw:true });
  d.push(hero);
  const s1 = AL('VERTICAL', { pad:[14,0,0,0], name:'Deskripsi' }); add(b, s1, { fw:true });
  add(s1, T('Bantuan gizi dan pendampingan kesehatan bagi ibu hamil dan ibu menyusui dari keluarga kurang mampu.', { lh:1.5, fillw:true }), { fw:true });
  const s2 = AL('VERTICAL', { gap:10, pad:[18,0,0,0], name:'Persyaratan' }); add(b, s2, { fw:true });
  add(s2, sectionHeader('Persyaratan'), { fw:true });
  const rc = softCard('Daftar Persyaratan'); add(s2, rc, { fw:true });
  ['Warga Desa Sukamaju yang telah terverifikasi', 'Sedang hamil atau menyusui bayi usia di bawah 2 tahun', 'Terdaftar di Posyandu atau Puskesmas setempat', 'Berasal dari keluarga kurang mampu'].forEach(function (t) { add(rc, iconLine('checkout', t, C.OK), { fw:true }); });
  const s3 = AL('VERTICAL', { gap:10, pad:[18,0,0,0], name:'Dokumen' }); add(b, s3, { fw:true });
  add(s3, sectionHeader('Dokumen yang Disiapkan'), { fw:true });
  const dc = softCard('Daftar Dokumen'); add(s3, dc, { fw:true });
  ['Foto KTP', 'Foto Kartu Keluarga', 'Buku KIA / Surat Keterangan Bidan'].forEach(function (t) { add(dc, iconLine('doc', t), { fw:true }); });
  const nt = AL('VERTICAL', { pad:[6,0,0,0], name:'catatan' }); dc.appendChild(nt); add(nt, T('Format foto (JPG/PNG) atau PDF, maksimal 5 MB per berkas.', { c:C.TM, fillw:true }), { fw:true });
  const s4 = AL('VERTICAL', { gap:16, pad:[18,0,0,0], name:'Aksi' }); add(b, s4, { fw:true });
  add(s4, infoBanner('Aplikasi hanya mencatat permohonan Anda. Penetapan penerima bantuan ditentukan oleh pemerintah desa.', { title:'Pengajuan bersifat permohonan', icon:'info', color:C.MR }), { fw:true });
  add(s4, primaryBtn('Ajukan Sekarang', 'edit'), { fw:true });
  finish(d, 0.1); return root;
}

function choiceField(label, options) {
  const f = AL('VERTICAL', { gap:8, name:'Field - ' + label });
  f.appendChild(T(label, { w:700 }));
  const r = AL('HORIZONTAL', { gap:8, name:'pilihan' }); add(f, r, { fw:true });
  options.forEach(function (o) { r.appendChild(filterChip(o, false)); });
  return f;
}
function docTile(label) {
  const t = AL('VERTICAL', { gap:6, pad:12, stroke:C.BD, sw:1.2, r:14, name:'Dokumen - ' + label });
  t.appendChild(T(label + ' *', { w:700 }));
  add(t, outlineBtn('Pilih Berkas / Foto', 'upload'), { fw:true });
  return t;
}

function buildFormulir(root) {
  prepRoot(root, 'UI 14 - Formulir Pengajuan');
  add(root, pageAppBar('Formulir Pengajuan', true), { fw:true });
  const b = body(root, 14);
  add(b, T('Bantuan Ibu Hamil & Menyusui', { size:20, w:800, lh:1.25, fillw:true }), { fw:true });
  add(b, infoBanner('Penetapan penerima bantuan ditentukan oleh pemerintah desa.', { title:'Pengajuan bersifat permohonan', icon:'info', color:C.MR }), { fw:true });
  const pm = AL('VERTICAL', { gap:2, pad:16, fill:C.PS, fillOp:0.5, stroke:C.BD, r:18, name:'Data Pemohon' }); add(b, pm, { fw:true });
  pm.appendChild(T('Data Pemohon (otomatis)', { w:800 }));
  add(pm, iconLine('person', 'Azkiya Zahrul Umam'), { fw:true }); add(pm, iconLine('card', 'NIK 3603 •••• •••• 0001'), { fw:true });
  const fc = softCard('Isian Pengajuan'); fc.itemSpacing = 16; add(b, fc, { fw:true });
  fc.appendChild(T('Isian Pengajuan', { size:18, w:800 }));
  add(fc, choiceField('Kondisi Saat Ini', ['Hamil', 'Menyusui']), { fw:true });
  add(fc, field({ label:'Usia Kehamilan / Usia Bayi', hint:'Contoh: 20 minggu atau 8 bulan' }), { fw:true });
  add(fc, field({ label:'Jumlah Anak', hint:'Contoh: 2' }), { fw:true });
  add(fc, field({ label:'Posyandu / Puskesmas Tempat Terdaftar', hint:'Contoh: Posyandu Melati II' }), { fw:true });
  const dc = softCard('Dokumen Pendukung'); dc.itemSpacing = 10; add(b, dc, { fw:true });
  dc.appendChild(T('Dokumen Pendukung', { size:18, w:800 }));
  add(dc, T('Foto harus jelas, tidak buram, dan seluruh sisi dokumen terlihat. Format JPG, PNG, atau PDF, maksimal 5 MB.', { c:C.TM, lh:1.4, fillw:true }), { fw:true });
  ['Foto KTP', 'Foto Kartu Keluarga', 'Buku KIA / Surat Keterangan Bidan'].forEach(function (t) { add(dc, docTile(t), { fw:true }); });
  const ac = AL('VERTICAL', { pad:[2,0,0,0], name:'aksi' }); add(b, ac, { fw:true }); add(ac, primaryBtn('Kirim Pengajuan', 'send'), { fw:true });
  return root;
}

function newsCard(n, heads) {
  const card = AL('VERTICAL', { fill:C.WH, stroke:C.BD, r:18, shadow:true, clip:true, name:'NewsCard' });
  const hd = AL('VERTICAL', { pad:12, fill: n[0] === 'Pengumuman' ? C.P : C.PD, h:110, name:'header batik', clip:true }); add(card, hd, { fw:true });
  const tag = AL('HORIZONTAL', { pad:[4,10,4,10], fill:C.GO, r:8, name:'kategori' }); tag.appendChild(T(n[0], { w:800, c:C.PD })); hd.appendChild(tag); heads.push(hd);
  const bd = AL('VERTICAL', { gap:6, pad:14, name:'isi berita' }); add(card, bd, { fw:true });
  add(bd, T(n[1], { size:18, w:800, lh:1.3, fillw:true }), { fw:true }); add(bd, T(n[2], { c:C.TM, lh:1.4, fillw:true }), { fw:true });
  const meta = AL('HORIZONTAL', { gap:6, pad:[2,0,0,0], ai:'CENTER', name:'meta' }); add(bd, meta, { fw:true });
  meta.appendChild(I('caltoday', 16, C.TM)); grow(meta, T(n[3], { c:C.TM })); meta.appendChild(T('Baca →', { w:800, c:C.P }));
  return card;
}

function buildBerita(root, nav) {
  prepRoot(root, 'UI 16 - Berita');
  add(root, pageAppBar('Berita & Informasi', false), { fw:true });
  const b = body(root, 14, [12,16,24,16]);
  const row = AL('HORIZONTAL', { gap:8, name:'Filter kategori' }); add(b, row, { fw:true });
  [['Semua', true], ['Berita', false], ['Pengumuman', false]].forEach(function (x) { row.appendChild(filterChip(x[0], x[1])); });
  const heads = [];
  const list = [
    ['Pengumuman', 'Pendaftaran BLT Dana Desa Dibuka Hingga Akhir Pekan', 'Pemerintah Desa Sukamaju membuka pendaftaran penerima BLT Dana Desa melalui aplikasi DesaKu.', '31 Oktober 2026'],
    ['Berita', 'Warga Kerja Bakti Bersihkan Saluran Irigasi bersama Dinas Pertanian', 'Ratusan warga Desa Sukamaju bergotong royong membersihkan saluran irigasi untuk menyambut musim tanam.', '29 Oktober 2026'],
    ['Berita', 'Jadwal Imunisasi Balita Bulan Ini', 'Imunisasi dasar lengkap untuk balita dilaksanakan di seluruh Posyandu desa.', '26 Oktober 2026'],
    ['Pengumuman', 'Pembayaran PBB Dapat Dilakukan di Kantor Desa', 'Warga dapat membayar PBB di Kantor Desa pada jam layanan Senin–Jumat pukul 08.00–15.00 WIB.', '23 Oktober 2026']
  ];
  for (const n of list) add(b, newsCard(n, heads), { fw:true });
  add(root, navInstance(nav, 'Berita'), { fw:true });
  for (const h of heads) addPattern(h, 0.14);
  return root;
}

function buildDetailBerita(root) {
  prepRoot(root, 'UI 17 - Detail Berita'); const d = [];
  add(root, pageAppBar('Detail Berita', true), { fw:true });
  const b = body(root, 0, [16,16,32,16]);
  const hd = AL('VERTICAL', { fill:C.PD, r:20, clip:true, h:150, name:'header batik' }); add(b, hd, { fw:true }); d.push(hd);
  const c1 = AL('HORIZONTAL', { pad:[14,0,0,0], name:'kategori' }); add(b, c1, { fw:true }); c1.appendChild(chip('Pengumuman', C.MR));
  const t = AL('VERTICAL', { pad:[10,0,8,0], name:'judul' }); add(b, t, { fw:true });
  add(t, T('Pendaftaran BLT Dana Desa Dibuka Hingga Akhir Pekan', { size:22, w:800, lh:1.3, fillw:true }), { fw:true });
  add(b, iconLine('caltoday', 'Sabtu, 31 Oktober 2026', C.TM), { fw:true });
  add(b, iconLine('person', 'Admin Desa Sukamaju', C.TM), { fw:true });
  const dv = AL('VERTICAL', { pad:[12,0,12,0], name:'pemisah' }); add(b, dv, { fw:true }); add(dv, batikDivider(358), { fw:true });
  add(b, T('Pemerintah Desa Sukamaju membuka pendaftaran penerima BLT Dana Desa melalui aplikasi DesaKu.\n\nWarga yang telah terverifikasi dapat mengajukan permohonan dengan melampirkan foto KTP, Kartu Keluarga, dan foto rumah.\n\nPerlu diingat: pengajuan bersifat permohonan. Penetapan penerima bantuan ditentukan oleh pemerintah desa sesuai ketentuan yang berlaku.', { size:17, lh:1.6, fillw:true }), { fw:true });
  finish(d, 0.14); return root;
}

function notifCard(ic, title, text, time, name) {
  const c = AL('HORIZONTAL', { gap:12, pad:16, fill:C.PS, stroke:C.BD, r:18, shadow:true, name:name }); c.counterAxisAlignItems = 'MIN';
  const circ = AL('HORIZONTAL', { fill:C.WH, stroke:C.GO, r:22, ai:'CENTER', pi:'CENTER', w:44, h:44, name:'ikon' }); circ.appendChild(I(ic, 24, C.P)); c.appendChild(circ);
  const col = AL('VERTICAL', { gap:3, name:'isi' }); grow(c, col);
  add(col, T(title, { w:800, lh:1.3, fillw:true }), { fw:true }); add(col, T(text, { c:C.TM, lh:1.35, fillw:true }), { fw:true });
  const tm = AL('VERTICAL', { pad:[1,0,0,0], name:'waktu' }); col.appendChild(tm); tm.appendChild(T(time, { c:C.TM }));
  const dw = AL('VERTICAL', { pad:[6,0,0,8], name:'penanda' }); c.appendChild(dw);
  const dot = figma.createEllipse(); dot.name = 'belum dibaca'; dot.resize(12, 12); dot.fills = [solid(C.MR)]; dw.appendChild(dot);
  return c;
}

function buildNotifikasi(root) {
  prepRoot(root, 'UI 18 - Notifikasi');
  const bar = pageAppBar('Notifikasi', true); bar.appendChild(T('Tandai dibaca', { w:600, c:C.P })); add(root, bar, { fw:true });
  const b = body(root, 10, [12,16,24,16]);
  add(b, notifCard('heart', 'Perbaikan diperlukan pada pengajuan BLT', 'Foto Kartu Keluarga buram. Mohon unggah ulang dokumen Anda.', '3 hari lalu', 'Notif - 1'), { fw:true });
  add(b, notifCard('event', 'Kegiatan baru: Posyandu Balita Melati II', 'Pendaftaran dibuka. Segera daftar sebelum kuota penuh.', 'Kemarin', 'Notif - 2'), { fw:true });
  add(b, notifCard('bell', 'Pengumuman: Pendaftaran BLT Dana Desa', 'Pendaftaran dibuka hingga akhir pekan.', '2 hari lalu', 'Notif - 3'), { fw:true });
  return root;
}

function avatar(size, letterSize) {
  const a = AL('HORIZONTAL', { fill:C.P, r:size / 2, ai:'CENTER', pi:'CENTER', w:size, h:size, name:'Avatar' });
  a.appendChild(T('A', { size:letterSize, w:800, c:C.GL })); return a;
}
function menuTile(ic, title, badge, name) {
  const c = AL('HORIZONTAL', { gap:14, pad:[14,16,14,16], fill:C.WH, stroke:C.BD, r:18, shadow:true, ai:'CENTER', name:name });
  c.appendChild(I(ic, 26, C.P)); grow(c, T(title, { w:700 }));
  if (badge) { const bg = AL('HORIZONTAL', { pad:[2,9,2,9], fill:C.MR, r:12, name:'badge' }); bg.appendChild(T(String(badge), { w:800, c:C.WH })); c.appendChild(bg); }
  c.appendChild(I('chev', 24, C.TM)); return c;
}

function buildProfil(root, nav) {
  prepRoot(root, 'UI 19 - Profil'); const d = [];
  add(root, pageAppBar('Profil Saya', false), { fw:true });
  const b = body(root, 14);
  const hero = AL('VERTICAL', { gap:10, pad:18, fill:C.P, r:22, clip:true, ai:'CENTER', name:'Header Profil' }); add(b, hero, { fw:true });
  const ring = AL('HORIZONTAL', { fill:C.GO, r:45, ai:'CENTER', pi:'CENTER', w:90, h:90, name:'bingkai avatar' }); ring.appendChild(avatar(84, 42)); hero.appendChild(ring);
  add(hero, T('Azkiya Zahrul Umam', { size:22, w:800, c:C.WH, align:'CENTER', fillw:true }), { fw:true });
  hero.appendChild(chip('Warga Terverifikasi', C.GL, 'verified')); d.push(hero);
  const dk = softCard('Data Kependudukan'); add(b, dk, { fw:true });
  const dh = AL('VERTICAL', { pad:[0,0,8,0], name:'judul' }); dk.appendChild(dh); dh.appendChild(T('Data Kependudukan', { size:18, w:800 }));
  add(dk, iconLine('card', 'NIK  3603 •••• •••• 0001'), { fw:true }); add(dk, iconLine('people', 'KK  3603 •••• •••• 0099'), { fw:true }); add(dk, iconLine('phone', '+62 81234567890'), { fw:true });
  const nt = AL('VERTICAL', { pad:[8,0,12,0], name:'catatan' }); add(dk, nt, { fw:true }); add(nt, T('Nama, NIK, dan KK tidak dapat diubah. Hubungi kantor desa bila ada kesalahan data.', { c:C.TM, lh:1.4, fillw:true }), { fw:true });
  add(dk, outlineBtn('Ubah Telepon & Foto', 'edit'), { fw:true });
  const mn = AL('VERTICAL', { gap:10, name:'Menu' }); add(b, mn, { fw:true });
  add(mn, menuTile('bell', 'Riwayat Notifikasi', 3, 'Menu - Riwayat Notifikasi'), { fw:true });
  add(mn, menuTile('verified', 'Pelindungan Data Pribadi', 0, 'Menu - Pelindungan Data Pribadi'), { fw:true });
  add(mn, menuTile('info', 'Bantuan & Kontak Kantor Desa', 0, 'Menu - Bantuan & Kontak Kantor Desa'), { fw:true });
  const kl = AL('VERTICAL', { pad:[4,0,0,0], name:'keluar' }); add(b, kl, { fw:true }); add(kl, outlineBtn('Keluar', 'logout', C.MR), { fw:true });
  const vv = AL('HORIZONTAL', { pi:'CENTER', name:'versi' }); add(b, vv, { fw:true }); vv.appendChild(T('DesaKu v1.0.0', { c:C.TM }));
  add(root, navInstance(nav, 'Profil'), { fw:true });
  finish(d, 0.1); return root;
}

function buildUbahProfil(root) {
  prepRoot(root, 'UI 20 - Ubah Profil');
  add(root, pageAppBar('Ubah Profil', true), { fw:true });
  const b = body(root, 16);
  const cw = AL('HORIZONTAL', { pi:'CENTER', name:'foto' }); add(b, cw, { fw:true });
  const av = AL('HORIZONTAL', { ai:'CENTER', pi:'CENTER', w:104, h:104, r:52, name:'Foto profil' }); cw.appendChild(av); av.appendChild(avatar(104, 52));
  const cam = AL('HORIZONTAL', { fill:C.GO, r:24, ai:'CENTER', pi:'CENTER', w:48, h:48, name:'Ganti foto' }); cam.appendChild(I('camera', 24, C.PD));
  av.appendChild(cam); cam.layoutPositioning = 'ABSOLUTE'; cam.x = 56; cam.y = 56;
  const id = AL('VERTICAL', { gap:2, pad:16, fill:C.PS, fillOp:0.5, stroke:C.BD, r:18, name:'Data identitas' }); add(b, id, { fw:true });
  id.appendChild(T('Data identitas (tidak dapat diubah)', { w:800 }));
  add(id, iconLine('person', 'Azkiya Zahrul Umam'), { fw:true }); add(id, iconLine('card', 'NIK 3603 •••• •••• 0001'), { fw:true }); add(id, iconLine('people', 'KK 3603 •••• •••• 0099'), { fw:true });
  const fc = softCard('Form Telepon'); fc.itemSpacing = 16; add(b, fc, { fw:true });
  add(fc, field({ label:'Nomor Telepon', hint:'81234567890', value:'81234567890', prefix:'+62' }), { fw:true });
  add(fc, primaryBtn('Simpan Perubahan', 'save'), { fw:true });
  return root;
}

// ---------------------------------------------------------------- prototype
function reactionFor(dest, timeout) {
  const trigger = timeout ? { type:'AFTER_TIMEOUT', timeout:timeout } : { type:'ON_CLICK' };
  if (dest === 'BACK') return { actions:[{ type:'BACK' }], trigger:trigger };
  return { actions:[{ type:'NODE', destinationId:dest.id, navigation:'NAVIGATE', transition:{ type:'DISSOLVE', easing:{ type:'EASE_IN_AND_OUT' }, duration:0.2 }, preserveScrollPosition:false }], trigger:trigger };
}
async function setR(node, reaction) { try { await node.setReactionsAsync([reaction]); return true; } catch (e) { return false; } }
function allByName(root, name) { return root.findAll(function (n) { return n.name === name; }); }

async function wireHi(ui, report) {
  const pad = function (n) { return n < 10 ? '0' + n : '' + n; };
  const D = function (k) { return k === 'BACK' ? 'BACK' : ui[parseInt(k, 10)]; };
  const SPEC = [
    [2, 'Tombol - Masuk ke Desa Ku', '08'], [2, 'Tombol - Daftar Akun Baru', '03'], [2, 'Tautan Lupa Sandi', '05'],
    [3, 'Tombol Kembali', 'BACK'], [3, 'Tautan Masuk', '02'], [3, 'Tombol - Kirim Pendaftaran Akun', '04'],
    [4, 'Tombol - Simulasikan: Disetujui', '08'], [4, 'Tombol - Keluar', '02'],
    [5, 'Tombol Kembali', 'BACK'], [5, 'Tombol - Kirim Kode OTP', '06'],
    [6, 'Tombol Kembali', 'BACK'], [6, 'Tombol - Verifikasi Kode', '07'],
    [7, 'Tombol Kembali', 'BACK'], [7, 'Tombol - Simpan Kata Sandi', '02'],
    [8, 'Notifikasi', '18'], [8, 'Layanan - Kegiatan Desa', '09'], [8, 'Layanan - Program Bantuan', '11'], [8, 'Layanan - Berita Desa', '16'], [8, 'Layanan - Notifikasi', '18'],
    [8, 'ActivityCard', '10', true], [8, 'ApplicationCard', '15'], [8, 'Pengumuman', '17'], [8, 'NewsCard', '17', true],
    [9, 'ActivityCard', '10', true],
    [10, 'Tombol Kembali', 'BACK'], [10, 'Tombol - Daftar Kegiatan', '09'],
    [11, 'ProgramCard', '13', true], [11, 'Tab - Pengajuan Saya', '12'],
    [12, 'Tab - Program', '11'], [12, 'ApplicationCard', '15'],
    [13, 'Tombol Kembali', 'BACK'], [13, 'Tombol - Ajukan Sekarang', '14'],
    [14, 'Tombol Kembali', 'BACK'], [14, 'Tombol - Kirim Pengajuan', '12'],
    [15, 'Tombol Kembali', 'BACK'], [15, 'Tombol - Perbaiki & Kirim Ulang', '14'],
    [16, 'NewsCard', '17', true], [17, 'Tombol Kembali', 'BACK'],
    [18, 'Tombol Kembali', 'BACK'], [18, 'Notif - 1', '15'], [18, 'Notif - 2', '10'], [18, 'Notif - 3', '17'],
    [19, 'Tombol - Ubah Telepon & Foto', '20'], [19, 'Menu - Riwayat Notifikasi', '18'], [19, 'Tombol - Keluar', '02'],
    [20, 'Tombol Kembali', 'BACK'], [20, 'Tombol - Simpan Perubahan', '19']
  ];
  let n = 0;
  if (await setR(ui[1], reactionFor(ui[2], 1.5))) n++; else report.push('UI01 timeout');
  for (const s of SPEC) {
    const fr = ui[s[0]]; const found = allByName(fr, s[1]);
    if (!found.length) { report.push('UI' + pad(s[0]) + ':' + s[1]); continue; }
    const targets = s[3] ? found : [found[0]];
    for (const t of targets) { if (await setR(t, reactionFor(D(s[2])))) n++; else report.push('UI' + pad(s[0]) + ' gagal:' + s[1]); }
  }
  const navMap = { Beranda:8, Kegiatan:9, Bantuan:11, Berita:16, Profil:19 };
  for (const k of [8, 9, 11, 12, 16, 19]) {
    const inst = ui[k].findOne(function (x) { return x.name === 'Bottom Navigation'; });
    if (!inst) { report.push('UI' + pad(k) + ':nav'); continue; }
    for (const tab of Object.keys(navMap)) {
      const item = inst.findOne(function (x) { return x.name === 'nav/' + tab; });
      if (item && await setR(item, reactionFor(ui[navMap[tab]]))) n++; else report.push('UI' + pad(k) + ':nav/' + tab);
    }
  }
  return n;
}

function wfFrame(num) {
  const p = 'WF ' + (num < 10 ? '0' + num : '' + num) + ' - ';
  return figma.currentPage.children.find(function (x) { return x.type === 'FRAME' && x.name.indexOf(p) === 0; });
}
function wfText(frame, chars, last) {
  const m = frame.findAll(function (x) { return x.type === 'TEXT' && x.characters.trim() === chars; });
  if (!m.length) return null;
  if (last) m.sort(function (a, b) { return b.absoluteTransform[1][2] - a.absoluteTransform[1][2]; });
  return m[0];
}
function wfHot(t) {
  const p = t.parent;
  if (p && p.type === 'FRAME' && p.name === 'Frame' && p.children.length === 1 && p.width < 390) return p;
  return t;
}

async function wireWF(report) {
  let n = 0;
  // samakan 4 menu pada WF 19 dengan menu aplikasi
  const w19 = wfFrame(19);
  if (w19) {
    const ren = [['Menu 1', 'Ubah Telepon & Foto'], ['Menu 2', 'Riwayat Notifikasi'], ['Menu 3', 'Pelindungan Data Pribadi'], ['Menu 4', 'Bantuan & Kontak Kantor Desa']];
    for (const r of ren) { const t = wfText(w19, r[0], false); if (t) { try { await figma.loadFontAsync(t.fontName); t.characters = r[1]; } catch (e) { report.push('WF19 rename ' + r[0]); } } }
  }
  const NAV = { Beranda:8, Kegiatan:9, Bantuan:11, Berita:16, Profil:19 };
  const SPEC = {
    2: [['Masuk ke Desa Ku', 8], ['Daftar Akun Baru', 3], ['Lupa Kata Sandi?', 5]],
    3: [['Kirim Pendaftaran', 4], ['← Pendaftaran Akun', 'BACK']],
    4: [['Keluar', 2]],
    5: [['Kirim Kode OTP', 6], ['← Lupa Kata Sandi', 'BACK']],
    6: [['Verifikasi Kode', 7], ['← Lupa Kata Sandi', 'BACK']],
    7: [['Simpan Kata Sandi', 2], ['← Lupa Kata Sandi', 'BACK']],
    8: [['Kegiatan Desa', 9], ['Program Bantuan', 11], ['Berita Desa', 16], ['Notifikasi', 18], ['Kartu kegiatan 1', 10], ['Kartu kegiatan 2', 10], ['Kartu pengajuan', 15], ['Pengumuman terbaru', 17]],
    9: [['Kartu kegiatan 1', 10], ['Kartu kegiatan 2', 10], ['Kartu kegiatan 3', 10]],
    10: [['Daftar Kegiatan', 9], ['← Detail Kegiatan', 'BACK']],
    11: [['Kartu program 1', 13], ['Kartu program 2', 13], ['Kartu program 3', 13], ['Pengajuan Saya', 12]],
    12: [['Program', 11], ['Kartu pengajuan (status) 1', 15], ['Kartu pengajuan (status) 2', 15]],
    13: [['Ajukan Sekarang', 14], ['← Detail Program', 'BACK']],
    14: [['Kirim Pengajuan', 12], ['← Formulir Pengajuan', 'BACK']],
    15: [['Perbaiki & Kirim Ulang', 14], ['← Status Pengajuan', 'BACK']],
    16: [['Kartu berita (gambar, judul) 1', 17], ['Kartu berita (gambar, judul) 2', 17], ['Kartu berita (gambar, judul) 3', 17]],
    17: [['← Detail Berita', 'BACK']],
    18: [['Notifikasi (judul, isi, waktu) 1', 15], ['Notifikasi (judul, isi, waktu) 2', 10], ['Notifikasi (judul, isi, waktu) 3', 17], ['Notifikasi (judul, isi, waktu) 4', 8], ['← Notifikasi', 'BACK']],
    19: [['Ubah Telepon & Foto', 20], ['Riwayat Notifikasi', 18], ['Keluar', 2]],
    20: [['Simpan Perubahan', 19], ['← Ubah Profil', 'BACK']]
  };
  const f1 = wfFrame(1), f2 = wfFrame(2);
  if (f1 && f2) { if (await setR(f1, reactionFor(f2, 1.5))) n++; }
  for (const k of Object.keys(SPEC)) {
    const fr = wfFrame(parseInt(k, 10)); if (!fr) { report.push('WF' + k + ' tidak ada'); continue; }
    for (const s of SPEC[k]) {
      const t = wfText(fr, s[0], false);
      if (!t) { report.push('WF' + k + ':' + s[0]); continue; }
      const dest = s[1] === 'BACK' ? 'BACK' : wfFrame(s[1]);
      if (dest && await setR(wfHot(t), reactionFor(dest))) n++; else report.push('WF' + k + ' gagal:' + s[0]);
    }
  }
  for (const k of [8, 9, 11, 12, 16, 19]) {
    const fr = wfFrame(k); if (!fr) continue;
    for (const tab of Object.keys(NAV)) {
      const t = wfText(fr, tab, true); const dest = wfFrame(NAV[tab]);
      if (t && dest && await setR(t, reactionFor(dest))) n++; else report.push('WF' + k + ':nav ' + tab);
    }
  }
  return n;
}

// ---------------------------------------------------------------- jalankan
function findFrame(num, id) {
  const p = 'UI ' + (num < 10 ? '0' + num : '' + num) + ' - ';
  const f = figma.currentPage.children.find(function (x) { return x.type === 'FRAME' && x.name.indexOf(p) === 0; });
  return f || null;
}

function isWFNode(n) { return (n.type === 'FRAME' && /^WF \d\d - /.test(n.name)) || (n.type === 'TEXT' && n.name.indexOf('WIREFRAME') === 0); }

(async function () {
  const log = []; const miss = [];
  try {
    for (const s of ['Regular','Medium','SemiBold','Bold','ExtraBold','Black']) await figma.loadFontAsync({ family:'Roboto', style:s });

    // 1) halaman terpisah: "Wireframe" dan "Prototype Hi-Fi"
    for (const p of figma.root.children.slice()) await p.loadAsync();
    let wfPage = figma.root.children.find(function (p) { return p.name === 'Wireframe'; });
    if (!wfPage) { wfPage = figma.createPage(); wfPage.name = 'Wireframe'; }
    let hiPage = figma.root.children.find(function (p) { return p.name === 'Prototype Hi-Fi'; });
    if (!hiPage) { hiPage = figma.createPage(); hiPage.name = 'Prototype Hi-Fi'; }
    await wfPage.loadAsync(); await hiPage.loadAsync();
    const oldIds = ['1:884', '1:1028', '1:680', '1:2', '1:255', '1:473'];
    for (const p of figma.root.children.slice()) {
      for (const n of p.children.slice()) {
        let target = null;
        if (isWFNode(n)) target = wfPage;
        else if ((n.type === 'FRAME' && /^UI \d\d - /.test(n.name)) || oldIds.indexOf(n.id) >= 0 || (n.type === 'SECTION' && n.name.indexOf('Arsip') === 0) || (n.type === 'COMPONENT_SET' && n.name === 'Bottom Navigation') || (n.type === 'TEXT' && n.name === 'Judul Prototype Hi-Fi')) target = hiPage;
        if (target && target !== p) { const x = n.x, y = n.y; target.appendChild(n); n.x = x; n.y = y; }
      }
    }
    // rapikan posisi wireframe agar mulai dekat titik awal halaman
    const wfNodes = wfPage.children.slice();
    if (wfNodes.length) { const minY = Math.min.apply(null, wfNodes.map(function (n) { return n.y; })); if (minY > 200) wfNodes.forEach(function (n) { n.y = n.y - minY; }); }

    // 2) bangun 20 layar hi-fi di halaman "Prototype Hi-Fi"
    await figma.setCurrentPageAsync(hiPage);
    const final = { 1:'UI 01 - Splash', 2:'UI 02 - Masuk', 3:'UI 03 - Daftar', 4:'UI 04 - Verifikasi', 5:'UI 05 - Lupa Sandi (Nomor)', 6:'UI 06 - Lupa Sandi (OTP)', 7:'UI 07 - Lupa Sandi (Sandi Baru)', 8:'UI 08 - Beranda', 9:'UI 09 - Kegiatan', 10:'UI 10 - Detail Kegiatan', 11:'UI 11 - Bantuan Program', 12:'UI 12 - Bantuan Pengajuan Saya', 13:'UI 13 - Detail Program', 14:'UI 14 - Formulir Pengajuan', 15:'UI 15 - Status Pengajuan', 16:'UI 16 - Berita', 17:'UI 17 - Detail Berita', 18:'UI 18 - Notifikasi', 19:'UI 19 - Profil', 20:'UI 20 - Ubah Profil' };
    const existing = { 2:'1:884', 3:'1:1028', 8:'1:680', 10:'1:255', 11:'1:2', 15:'1:473' };
    const ui = {};
    for (let k = 1; k <= 20; k++) {
      let f = findFrame(k);
      if (!f && existing[k]) { const n = await figma.getNodeByIdAsync(existing[k]); if (n && n.type === 'FRAME') f = n; }
      if (!f) { f = figma.createFrame(); f.name = final[k]; }
      ui[k] = f;
    }
    const nav = getNav();
    const jobs = [
      [1, function (f) { return buildSplash(f); }, false],
      [2, function (f) { return buildMasuk(f); }, true],
      [3, function (f) { return buildDaftar(f); }, true],
      [4, function (f) { return buildVerifikasi(f); }, true],
      [5, function (f) { return buildLupa(f, 0); }, true],
      [6, function (f) { return buildLupa(f, 1); }, true],
      [7, function (f) { return buildLupa(f, 2); }, true],
      [8, function (f) { return buildBeranda(f, nav); }, true],
      [9, function (f) { return buildKegiatan(f, nav); }, true],
      [10, function (f) { return buildDetailKegiatan(f); }, true],
      [11, function (f) { return buildAid(f, nav, 0); }, true],
      [12, function (f) { return buildAid(f, nav, 1); }, true],
      [13, function (f) { return buildDetailProgram(f); }, true],
      [14, function (f) { return buildFormulir(f); }, true],
      [15, function (f) { return buildStatus(f); }, true],
      [16, function (f) { return buildBerita(f, nav); }, true],
      [17, function (f) { return buildDetailBerita(f); }, true],
      [18, function (f) { return buildNotifikasi(f); }, true],
      [19, function (f) { return buildProfil(f, nav); }, true],
      [20, function (f) { return buildUbahProfil(f); }, true]
    ];
    let ok = 0;
    for (const j of jobs) {
      try { j[1](ui[j[0]]); ui[j[0]].name = final[j[0]]; if (j[2]) scrollify(ui[j[0]]); ok++; }
      catch (e) { log.push('UI' + j[0] + ' GAGAL: ' + (e && e.message ? e.message : e)); }
    }
    let title = figma.currentPage.children.find(function (x) { return x.type === 'TEXT' && x.name === 'Judul Prototype Hi-Fi'; });
    if (!title) { title = T('PROTOTYPE HI-FI DesaKu · Mobile 390×844', { size:28, w:800 }); title.name = 'Judul Prototype Hi-Fi'; }
    title.x = 0; title.y = -70;
    for (let k = 1; k <= 20; k++) { ui[k].x = ((k - 1) % 4) * 450; ui[k].y = Math.floor((k - 1) / 4) * 900; }
    nav.x = 1850; nav.y = 0;
    const arc = figma.currentPage.children.find(function (x) { return x.type === 'SECTION' && x.name.indexOf('Arsip') === 0; });
    if (arc) { arc.x = 0; arc.y = 5 * 900 + 150; }
    let hi = 0;
    try { hi = await wireHi(ui, miss); } catch (e) { log.push('Prototype hi-fi GAGAL: ' + e.message); }
    try { figma.currentPage.flowStartingPoints = [{ nodeId: ui[1].id, name: 'Prototype Hi-Fi' }]; } catch (e) { log.push('Titik awal hi-fi gagal'); }

    // 3) navigasi wireframe di halaman "Wireframe"
    await figma.setCurrentPageAsync(wfPage);
    let wf = 0;
    try { wf = await wireWF(miss); } catch (e) { log.push('Prototype wireframe GAGAL: ' + e.message); }
    try { const w1 = wfFrame(1); if (w1) figma.currentPage.flowStartingPoints = [{ nodeId: w1.id, name: 'Wireframe' }]; } catch (e) { log.push('Titik awal wireframe gagal'); }
    const wfAll = wfPage.children.filter(function (n) { return n.type === 'FRAME'; });
    if (wfAll.length) figma.viewport.scrollAndZoomIntoView(wfAll);

    await figma.setCurrentPageAsync(hiPage);
    const all = []; for (let k = 1; k <= 20; k++) all.push(ui[k]);
    figma.viewport.scrollAndZoomIntoView(all);
    figma.closePlugin('v2 | Layar OK: ' + ok + '/20 | link hi-fi: ' + hi + ' | link wireframe: ' + wf + (log.length ? ' | ' + log.join(' ; ') : '') + (miss.length ? ' | tidak ketemu (' + miss.length + '): ' + miss.slice(0, 8).join(', ') : ''));
  } catch (e) {
    figma.closePlugin('Error v2: ' + (e && e.message ? e.message : e));
  }
})();
