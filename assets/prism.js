var _self=typeof window<"u"?window:typeof WorkerGlobalScope<"u"&&self instanceof WorkerGlobalScope?self:{},Prism=function(o){var f=/(?:^|\s)lang(?:uage)?-([\w-]+)(?=\s|$)/i,h=0,v={},n={manual:o.Prism&&o.Prism.manual,disableWorkerMessageHandler:o.Prism&&o.Prism.disableWorkerMessageHandler,util:{encode:function t(e){return e instanceof d?new d(e.type,t(e.content),e.alias):Array.isArray(e)?e.map(t):e.replace(/&/g,"&amp;").replace(/</g,"&lt;").replace(/\u00a0/g," ")},type:function(t){return Object.prototype.toString.call(t).slice(8,-1)},objId:function(t){return t.__id||Object.defineProperty(t,"__id",{value:++h}),t.__id},clone:function t(e,r){var a,i;switch(r=r||{},n.util.type(e)){case"Object":if(i=n.util.objId(e),r[i])return r[i];for(var g in a={},r[i]=a,e)e.hasOwnProperty(g)&&(a[g]=t(e[g],r));return a;case"Array":return i=n.util.objId(e),r[i]?r[i]:(a=[],r[i]=a,e.forEach(function(p,y){a[y]=t(p,r)}),a);default:return e}},getLanguage:function(t){for(;t;){var e=f.exec(t.className);if(e)return e[1].toLowerCase();t=t.parentElement}return"none"},setLanguage:function(t,e){t.className=t.className.replace(RegExp(f,"gi"),""),t.classList.add("language-"+e)},currentScript:function(){if(typeof document>"u")return null;if("currentScript"in document)return document.currentScript;try{throw new Error}catch(a){var t=(/at [^(\r\n]*\((.*):[^:]+:[^:]+\)$/i.exec(a.stack)||[])[1];if(t){var e=document.getElementsByTagName("script");for(var r in e)if(e[r].src==t)return e[r]}return null}},isActive:function(t,e,r){for(var a="no-"+e;t;){var i=t.classList;if(i.contains(e))return!0;if(i.contains(a))return!1;t=t.parentElement}return!!r}},languages:{plain:v,plaintext:v,text:v,txt:v,extend:function(t,e){var r=n.util.clone(n.languages[t]);for(var a in e)r[a]=e[a];return r},insertBefore:function(t,e,r,a){var i=(a=a||n.languages)[t],g={};for(var p in i)if(i.hasOwnProperty(p)){if(p==e)for(var y in r)r.hasOwnProperty(y)&&(g[y]=r[y]);r.hasOwnProperty(p)||(g[p]=i[p])}var w=a[t];return a[t]=g,n.languages.DFS(n.languages,function(A,N){N===w&&A!=t&&(this[A]=g)}),g},DFS:function t(e,r,a,i){i=i||{};var g=n.util.objId;for(var p in e)if(e.hasOwnProperty(p)){r.call(e,p,e[p],a||p);var y=e[p],w=n.util.type(y);w!=="Object"||i[g(y)]?w!=="Array"||i[g(y)]||(i[g(y)]=!0,t(y,r,p,i)):(i[g(y)]=!0,t(y,r,null,i))}}},plugins:{},highlightAll:function(t,e){n.highlightAllUnder(document,t,e)},highlightAllUnder:function(t,e,r){var a={callback:r,container:t,selector:'code[class*="language-"], [class*="language-"] code, code[class*="lang-"], [class*="lang-"] code'};n.hooks.run("before-highlightall",a),a.elements=Array.prototype.slice.apply(a.container.querySelectorAll(a.selector)),n.hooks.run("before-all-elements-highlight",a);for(var i,g=0;i=a.elements[g++];)n.highlightElement(i,e===!0,a.callback)},highlightElement:function(t,e,r){var a=n.util.getLanguage(t),i=n.languages[a];n.util.setLanguage(t,a);var g=t.parentElement;g&&g.nodeName.toLowerCase()==="pre"&&n.util.setLanguage(g,a);var p={element:t,language:a,grammar:i,code:t.textContent};function y(A){p.highlightedCode=A,n.hooks.run("before-insert",p),p.element.innerHTML=p.highlightedCode,n.hooks.run("after-highlight",p),n.hooks.run("complete",p),r&&r.call(p.element)}if(n.hooks.run("before-sanity-check",p),(g=p.element.parentElement)&&g.nodeName.toLowerCase()==="pre"&&!g.hasAttribute("tabindex")&&g.setAttribute("tabindex","0"),!p.code)return n.hooks.run("complete",p),void(r&&r.call(p.element));if(n.hooks.run("before-highlight",p),p.grammar)if(e&&o.Worker){var w=new Worker(n.filename);w.onmessage=function(A){y(A.data)},w.postMessage(JSON.stringify({language:p.language,code:p.code,immediateClose:!0}))}else y(n.highlight(p.code,p.grammar,p.language));else y(n.util.encode(p.code))},highlight:function(t,e,r){var a={code:t,grammar:e,language:r};if(n.hooks.run("before-tokenize",a),!a.grammar)throw new Error('The language "'+a.language+'" has no grammar.');return a.tokens=n.tokenize(a.code,a.grammar),n.hooks.run("after-tokenize",a),d.stringify(n.util.encode(a.tokens),a.language)},tokenize:function(t,e){var r=e.rest;if(r){for(var a in r)e[a]=r[a];delete e.rest}var i=new c;return s(i,i.head,t),u(t,i,e,i.head,0),function(g){for(var p=[],y=g.head.next;y!==g.tail;)p.push(y.value),y=y.next;return p}(i)},hooks:{all:{},add:function(t,e){var r=n.hooks.all;r[t]=r[t]||[],r[t].push(e)},run:function(t,e){var r=n.hooks.all[t];if(r&&r.length)for(var a,i=0;a=r[i++];)a(e)}},Token:d};function d(t,e,r,a){this.type=t,this.content=e,this.alias=r,this.length=0|(a||"").length}function l(t,e,r,a){t.lastIndex=e;var i=t.exec(r);if(i&&a&&i[1]){var g=i[1].length;i.index+=g,i[0]=i[0].slice(g)}return i}function u(t,e,r,a,i,g){for(var p in r)if(r.hasOwnProperty(p)&&r[p]){var y=r[p];y=Array.isArray(y)?y:[y];for(var w=0;w<y.length;++w){if(g&&g.cause==p+","+w)return;var A=y[w],N=A.inside,H=!!A.lookbehind,j=!!A.greedy,M=A.alias;if(j&&!A.pattern.global){var G=A.pattern.toString().match(/[imsuy]*$/)[0];A.pattern=RegExp(A.pattern.source,G+"g")}for(var z=A.pattern||A,S=a.next,x=i;S!==e.tail&&!(g&&x>=g.reach);x+=S.value.length,S=S.next){var $=S.value;if(e.length>t.length)return;if(!($ instanceof d)){var F,I=1;if(j){if(!(F=l(z,x,t,H))||F.index>=t.length)break;var L=F.index,Z=F.index+F[0].length,_=x;for(_+=S.value.length;L>=_;)_+=(S=S.next).value.length;if(x=_-=S.value.length,S.value instanceof d)continue;for(var T=S;T!==e.tail&&(_<Z||typeof T.value=="string");T=T.next)I++,_+=T.value.length;I--,$=t.slice(x,_),F.index-=x}else if(!(F=l(z,0,$,H)))continue;L=F.index;var O=F[0],C=$.slice(0,L),B=$.slice(L+O.length),P=x+$.length;g&&P>g.reach&&(g.reach=P);var R=S.prev;if(C&&(R=s(e,R,C),x+=C.length),m(e,R,I),S=s(e,R,new d(p,N?n.tokenize(O,N):O,M,O)),B&&s(e,S,B),I>1){var D={cause:p+","+w,reach:P};u(t,e,r,S.prev,x,D),g&&D.reach>g.reach&&(g.reach=D.reach)}}}}}}function c(){var t={value:null,prev:null,next:null},e={value:null,prev:t,next:null};t.next=e,this.head=t,this.tail=e,this.length=0}function s(t,e,r){var a=e.next,i={value:r,prev:e,next:a};return e.next=i,a.prev=i,t.length++,i}function m(t,e,r){for(var a=e.next,i=0;i<r&&a!==t.tail;i++)a=a.next;e.next=a,a.prev=e,t.length-=i}if(o.Prism=n,d.stringify=function t(e,r){if(typeof e=="string")return e;if(Array.isArray(e)){var a="";return e.forEach(function(w){a+=t(w,r)}),a}var i={type:e.type,content:t(e.content,r),tag:"span",classes:["token",e.type],attributes:{},language:r},g=e.alias;g&&(Array.isArray(g)?Array.prototype.push.apply(i.classes,g):i.classes.push(g)),n.hooks.run("wrap",i);var p="";for(var y in i.attributes)p+=" "+y+'="'+(i.attributes[y]||"").replace(/"/g,"&quot;")+'"';return"<"+i.tag+' class="'+i.classes.join(" ")+'"'+p+">"+i.content+"</"+i.tag+">"},!o.document)return o.addEventListener&&(n.disableWorkerMessageHandler||o.addEventListener("message",function(t){var e=JSON.parse(t.data),r=e.language,a=e.code,i=e.immediateClose;o.postMessage(n.highlight(a,n.languages[r],r)),i&&o.close()},!1)),n;var b=n.util.currentScript();function k(){n.manual||n.highlightAll()}if(b&&(n.filename=b.src,b.hasAttribute("data-manual")&&(n.manual=!0)),!n.manual){var E=document.readyState;E==="loading"||E==="interactive"&&b&&b.defer?document.addEventListener("DOMContentLoaded",k):window.requestAnimationFrame?window.requestAnimationFrame(k):window.setTimeout(k,16)}return n}(_self);typeof module<"u"&&module.exports&&(module.exports=Prism),typeof global<"u"&&(global.Prism=Prism),Prism.languages.clike={comment:[{pattern:/(^|[^\\])\/\*[\s\S]*?(?:\*\/|$)/,lookbehind:!0,greedy:!0},{pattern:/(^|[^\\:])\/\/.*/,lookbehind:!0,greedy:!0}],string:{pattern:/(["'])(?:\\(?:\r\n|[\s\S])|(?!\1)[^\\\r\n])*\1/,greedy:!0},"class-name":{pattern:/(\b(?:class|extends|implements|instanceof|interface|new|trait)\s+|\bcatch\s+\()[\w.\\]+/i,lookbehind:!0,inside:{punctuation:/[.\\]/}},keyword:/\b(?:break|catch|continue|do|else|finally|for|function|if|in|instanceof|new|null|return|throw|try|while)\b/,boolean:/\b(?:false|true)\b/,function:/\b\w+(?=\()/,number:/\b0x[\da-f]+\b|(?:\b\d+(?:\.\d*)?|\B\.\d+)(?:e[+-]?\d+)?/i,operator:/[<>]=?|[!=]=?=?|--?|\+\+?|&&?|\|\|?|[?*/~^%]/,punctuation:/[{}[\];(),.:]/},Prism.languages.javascript=Prism.languages.extend("clike",{"class-name":[Prism.languages.clike["class-name"],{pattern:/(^|[^$\w\xA0-\uFFFF])(?!\s)[_$A-Z\xA0-\uFFFF](?:(?!\s)[$\w\xA0-\uFFFF])*(?=\.(?:constructor|prototype))/,lookbehind:!0}],keyword:[{pattern:/((?:^|\})\s*)catch\b/,lookbehind:!0},{pattern:/(^|[^.]|\.\.\.\s*)\b(?:as|assert(?=\s*\{)|async(?=\s*(?:function\b|\(|[$\w\xA0-\uFFFF]|$))|await|break|case|class|const|continue|debugger|default|delete|do|else|enum|export|extends|finally(?=\s*(?:\{|$))|for|from(?=\s*(?:['"]|$))|function|(?:get|set)(?=\s*(?:[#\[$\w\xA0-\uFFFF]|$))|if|implements|import|in|instanceof|interface|let|new|null|of|package|private|protected|public|return|static|super|switch|this|throw|try|typeof|undefined|var|void|while|with|yield)\b/,lookbehind:!0}],function:/#?(?!\s)[_$a-zA-Z\xA0-\uFFFF](?:(?!\s)[$\w\xA0-\uFFFF])*(?=\s*(?:\.\s*(?:apply|bind|call)\s*)?\()/,number:{pattern:RegExp("(^|[^\\w$])(?:NaN|Infinity|0[bB][01]+(?:_[01]+)*n?|0[oO][0-7]+(?:_[0-7]+)*n?|0[xX][\\dA-Fa-f]+(?:_[\\dA-Fa-f]+)*n?|\\d+(?:_\\d+)*n|(?:\\d+(?:_\\d+)*(?:\\.(?:\\d+(?:_\\d+)*)?)?|\\.\\d+(?:_\\d+)*)(?:[Ee][+-]?\\d+(?:_\\d+)*)?)(?![\\w$])"),lookbehind:!0},operator:/--|\+\+|\*\*=?|=>|&&=?|\|\|=?|[!=]==|<<=?|>>>?=?|[-+*/%&|^!=<>]=?|\.{3}|\?\?=?|\?\.?|[~:]/}),Prism.languages.javascript["class-name"][0].pattern=/(\b(?:class|extends|implements|instanceof|interface|new)\s+)[\w.\\]+/,Prism.languages.insertBefore("javascript","keyword",{regex:{pattern:RegExp(`((?:^|[^$\\w\\xA0-\\uFFFF."'\\])\\s]|\\b(?:return|yield))\\s*)/(?:(?:\\[(?:[^\\]\\\\\r
]|\\\\.)*\\]|\\\\.|[^/\\\\\\[\r
])+/[dgimyus]{0,7}|(?:\\[(?:[^[\\]\\\\\r
]|\\\\.|\\[(?:[^[\\]\\\\\r
]|\\\\.|\\[(?:[^[\\]\\\\\r
]|\\\\.)*\\])*\\])*\\]|\\\\.|[^/\\\\\\[\r
])+/[dgimyus]{0,7}v[dgimyus]{0,7})(?=(?:\\s|/\\*(?:[^*]|\\*(?!/))*\\*/)*(?:$|[\r
,.;:})\\]]|//))`),lookbehind:!0,greedy:!0,inside:{"regex-source":{pattern:/^(\/)[\s\S]+(?=\/[a-z]*$)/,lookbehind:!0,alias:"language-regex",inside:Prism.languages.regex},"regex-delimiter":/^\/|\/$/,"regex-flags":/^[a-z]+$/}},"function-variable":{pattern:/#?(?!\s)[_$a-zA-Z\xA0-\uFFFF](?:(?!\s)[$\w\xA0-\uFFFF])*(?=\s*[=:]\s*(?:async\s*)?(?:\bfunction\b|(?:\((?:[^()]|\([^()]*\))*\)|(?!\s)[_$a-zA-Z\xA0-\uFFFF](?:(?!\s)[$\w\xA0-\uFFFF])*)\s*=>))/,alias:"function"},parameter:[{pattern:/(function(?:\s+(?!\s)[_$a-zA-Z\xA0-\uFFFF](?:(?!\s)[$\w\xA0-\uFFFF])*)?\s*\(\s*)(?!\s)(?:[^()\s]|\s+(?![\s)])|\([^()]*\))+(?=\s*\))/,lookbehind:!0,inside:Prism.languages.javascript},{pattern:/(^|[^$\w\xA0-\uFFFF])(?!\s)[_$a-z\xA0-\uFFFF](?:(?!\s)[$\w\xA0-\uFFFF])*(?=\s*=>)/i,lookbehind:!0,inside:Prism.languages.javascript},{pattern:/(\(\s*)(?!\s)(?:[^()\s]|\s+(?![\s)])|\([^()]*\))+(?=\s*\)\s*=>)/,lookbehind:!0,inside:Prism.languages.javascript},{pattern:/((?:\b|\s|^)(?!(?:as|async|await|break|case|catch|class|const|continue|debugger|default|delete|do|else|enum|export|extends|finally|for|from|function|get|if|implements|import|in|instanceof|interface|let|new|null|of|package|private|protected|public|return|set|static|super|switch|this|throw|try|typeof|undefined|var|void|while|with|yield)(?![$\w\xA0-\uFFFF]))(?:(?!\s)[_$a-zA-Z\xA0-\uFFFF](?:(?!\s)[$\w\xA0-\uFFFF])*\s*)\(\s*|\]\s*\(\s*)(?!\s)(?:[^()\s]|\s+(?![\s)])|\([^()]*\))+(?=\s*\)\s*\{)/,lookbehind:!0,inside:Prism.languages.javascript}],constant:/\b[A-Z](?:[A-Z_]|\dx?)*\b/}),Prism.languages.insertBefore("javascript","string",{hashbang:{pattern:/^#!.*/,greedy:!0,alias:"comment"},"template-string":{pattern:/`(?:\\[\s\S]|\$\{(?:[^{}]|\{(?:[^{}]|\{[^}]*\})*\})+\}|(?!\$\{)[^\\`])*`/,greedy:!0,inside:{"template-punctuation":{pattern:/^`|`$/,alias:"string"},interpolation:{pattern:/((?:^|[^\\])(?:\\{2})*)\$\{(?:[^{}]|\{(?:[^{}]|\{[^}]*\})*\})+\}/,lookbehind:!0,inside:{"interpolation-punctuation":{pattern:/^\$\{|\}$/,alias:"punctuation"},rest:Prism.languages.javascript}},string:/[\s\S]+/}},"string-property":{pattern:/((?:^|[,{])[ \t]*)(["'])(?:\\(?:\r\n|[\s\S])|(?!\2)[^\\\r\n])*\2(?=\s*:)/m,lookbehind:!0,greedy:!0,alias:"property"}}),Prism.languages.insertBefore("javascript","operator",{"literal-property":{pattern:/((?:^|[,{])[ \t]*)(?!\s)[_$a-zA-Z\xA0-\uFFFF](?:(?!\s)[$\w\xA0-\uFFFF])*(?=\s*:)/m,lookbehind:!0,alias:"property"}}),Prism.languages.markup&&(Prism.languages.markup.tag.addInlined("script","javascript"),Prism.languages.markup.tag.addAttribute("on(?:abort|blur|change|click|composition(?:end|start|update)|dblclick|error|focus(?:in|out)?|key(?:down|up)|load|mouse(?:down|enter|leave|move|out|over|up)|reset|resize|scroll|select|slotchange|submit|unload|wheel)","javascript")),Prism.languages.js=Prism.languages.javascript,function(o){var f="\\b(?:BASH|BASHOPTS|BASH_ALIASES|BASH_ARGC|BASH_ARGV|BASH_CMDS|BASH_COMPLETION_COMPAT_DIR|BASH_LINENO|BASH_REMATCH|BASH_SOURCE|BASH_VERSINFO|BASH_VERSION|COLORTERM|COLUMNS|COMP_WORDBREAKS|DBUS_SESSION_BUS_ADDRESS|DEFAULTS_PATH|DESKTOP_SESSION|DIRSTACK|DISPLAY|EUID|GDMSESSION|GDM_LANG|GNOME_KEYRING_CONTROL|GNOME_KEYRING_PID|GPG_AGENT_INFO|GROUPS|HISTCONTROL|HISTFILE|HISTFILESIZE|HISTSIZE|HOME|HOSTNAME|HOSTTYPE|IFS|INSTANCE|JOB|LANG|LANGUAGE|LC_ADDRESS|LC_ALL|LC_IDENTIFICATION|LC_MEASUREMENT|LC_MONETARY|LC_NAME|LC_NUMERIC|LC_PAPER|LC_TELEPHONE|LC_TIME|LESSCLOSE|LESSOPEN|LINES|LOGNAME|LS_COLORS|MACHTYPE|MAILCHECK|MANDATORY_PATH|NO_AT_BRIDGE|OLDPWD|OPTERR|OPTIND|ORBIT_SOCKETDIR|OSTYPE|PAPERSIZE|PATH|PIPESTATUS|PPID|PS1|PS2|PS3|PS4|PWD|RANDOM|REPLY|SECONDS|SELINUX_INIT|SESSION|SESSIONTYPE|SESSION_MANAGER|SHELL|SHELLOPTS|SHLVL|SSH_AUTH_SOCK|TERM|UID|UPSTART_EVENTS|UPSTART_INSTANCE|UPSTART_JOB|UPSTART_SESSION|USER|WINDOWID|XAUTHORITY|XDG_CONFIG_DIRS|XDG_CURRENT_DESKTOP|XDG_DATA_DIRS|XDG_GREETER_DATA_DIR|XDG_MENU_PREFIX|XDG_RUNTIME_DIR|XDG_SEAT|XDG_SEAT_PATH|XDG_SESSION_DESKTOP|XDG_SESSION_ID|XDG_SESSION_PATH|XDG_SESSION_TYPE|XDG_VTNR|XMODIFIERS)\\b",h={pattern:/(^(["']?)\w+\2)[ \t]+\S.*/,lookbehind:!0,alias:"punctuation",inside:null},v={bash:h,environment:{pattern:RegExp("\\$"+f),alias:"constant"},variable:[{pattern:/\$?\(\([\s\S]+?\)\)/,greedy:!0,inside:{variable:[{pattern:/(^\$\(\([\s\S]+)\)\)/,lookbehind:!0},/^\$\(\(/],number:/\b0x[\dA-Fa-f]+\b|(?:\b\d+(?:\.\d*)?|\B\.\d+)(?:[Ee]-?\d+)?/,operator:/--|\+\+|\*\*=?|<<=?|>>=?|&&|\|\||[=!+\-*/%<>^&|]=?|[?~:]/,punctuation:/\(\(?|\)\)?|,|;/}},{pattern:/\$\((?:\([^)]+\)|[^()])+\)|`[^`]+`/,greedy:!0,inside:{variable:/^\$\(|^`|\)$|`$/}},{pattern:/\$\{[^}]+\}/,greedy:!0,inside:{operator:/:[-=?+]?|[!\/]|##?|%%?|\^\^?|,,?/,punctuation:/[\[\]]/,environment:{pattern:RegExp("(\\{)"+f),lookbehind:!0,alias:"constant"}}},/\$(?:\w+|[#?*!@$])/],entity:/\\(?:[abceEfnrtv\\"]|O?[0-7]{1,3}|U[0-9a-fA-F]{8}|u[0-9a-fA-F]{4}|x[0-9a-fA-F]{1,2})/};o.languages.bash={shebang:{pattern:/^#!\s*\/.*/,alias:"important"},comment:{pattern:/(^|[^"{\\$])#.*/,lookbehind:!0},"function-name":[{pattern:/(\bfunction\s+)[\w-]+(?=(?:\s*\(?:\s*\))?\s*\{)/,lookbehind:!0,alias:"function"},{pattern:/\b[\w-]+(?=\s*\(\s*\)\s*\{)/,alias:"function"}],"for-or-select":{pattern:/(\b(?:for|select)\s+)\w+(?=\s+in\s)/,alias:"variable",lookbehind:!0},"assign-left":{pattern:/(^|[\s;|&]|[<>]\()\w+(?:\.\w+)*(?=\+?=)/,inside:{environment:{pattern:RegExp("(^|[\\s;|&]|[<>]\\()"+f),lookbehind:!0,alias:"constant"}},alias:"variable",lookbehind:!0},parameter:{pattern:/(^|\s)-{1,2}(?:\w+:[+-]?)?\w+(?:\.\w+)*(?=[=\s]|$)/,alias:"variable",lookbehind:!0},string:[{pattern:/((?:^|[^<])<<-?\s*)(\w+)\s[\s\S]*?(?:\r?\n|\r)\2/,lookbehind:!0,greedy:!0,inside:v},{pattern:/((?:^|[^<])<<-?\s*)(["'])(\w+)\2\s[\s\S]*?(?:\r?\n|\r)\3/,lookbehind:!0,greedy:!0,inside:{bash:h}},{pattern:/(^|[^\\](?:\\\\)*)"(?:\\[\s\S]|\$\([^)]+\)|\$(?!\()|`[^`]+`|[^"\\`$])*"/,lookbehind:!0,greedy:!0,inside:v},{pattern:/(^|[^$\\])'[^']*'/,lookbehind:!0,greedy:!0},{pattern:/\$'(?:[^'\\]|\\[\s\S])*'/,greedy:!0,inside:{entity:v.entity}}],environment:{pattern:RegExp("\\$?"+f),alias:"constant"},variable:v.variable,function:{pattern:/(^|[\s;|&]|[<>]\()(?:add|apropos|apt|apt-cache|apt-get|aptitude|aspell|automysqlbackup|awk|basename|bash|bc|bconsole|bg|bzip2|cal|cargo|cat|cfdisk|chgrp|chkconfig|chmod|chown|chroot|cksum|clear|cmp|column|comm|composer|cp|cron|crontab|csplit|curl|cut|date|dc|dd|ddrescue|debootstrap|df|diff|diff3|dig|dir|dircolors|dirname|dirs|dmesg|docker|docker-compose|du|egrep|eject|env|ethtool|expand|expect|expr|fdformat|fdisk|fg|fgrep|file|find|fmt|fold|format|free|fsck|ftp|fuser|gawk|git|gparted|grep|groupadd|groupdel|groupmod|groups|grub-mkconfig|gzip|halt|head|hg|history|host|hostname|htop|iconv|id|ifconfig|ifdown|ifup|import|install|ip|java|jobs|join|kill|killall|less|link|ln|locate|logname|logrotate|look|lpc|lpr|lprint|lprintd|lprintq|lprm|ls|lsof|lynx|make|man|mc|mdadm|mkconfig|mkdir|mke2fs|mkfifo|mkfs|mkisofs|mknod|mkswap|mmv|more|most|mount|mtools|mtr|mutt|mv|nano|nc|netstat|nice|nl|node|nohup|notify-send|npm|nslookup|op|open|parted|passwd|paste|pathchk|ping|pkill|pnpm|podman|podman-compose|popd|pr|printcap|printenv|ps|pushd|pv|quota|quotacheck|quotactl|ram|rar|rcp|reboot|remsync|rename|renice|rev|rm|rmdir|rpm|rsync|scp|screen|sdiff|sed|sendmail|seq|service|sftp|sh|shellcheck|shuf|shutdown|sleep|slocate|sort|split|ssh|stat|strace|su|sudo|sum|suspend|swapon|sync|sysctl|tac|tail|tar|tee|time|timeout|top|touch|tr|traceroute|tsort|tty|umount|uname|unexpand|uniq|units|unrar|unshar|unzip|update-grub|uptime|useradd|userdel|usermod|users|uudecode|uuencode|v|vcpkg|vdir|vi|vim|virsh|vmstat|wait|watch|wc|wget|whereis|which|who|whoami|write|xargs|xdg-open|yarn|yes|zenity|zip|zsh|zypper)(?=$|[)\s;|&])/,lookbehind:!0},keyword:{pattern:/(^|[\s;|&]|[<>]\()(?:case|do|done|elif|else|esac|fi|for|function|if|in|select|then|until|while)(?=$|[)\s;|&])/,lookbehind:!0},builtin:{pattern:/(^|[\s;|&]|[<>]\()(?:\.|:|alias|bind|break|builtin|caller|cd|command|continue|declare|echo|enable|eval|exec|exit|export|getopts|hash|help|let|local|logout|mapfile|printf|pwd|read|readarray|readonly|return|set|shift|shopt|source|test|times|trap|type|typeset|ulimit|umask|unalias|unset)(?=$|[)\s;|&])/,lookbehind:!0,alias:"class-name"},boolean:{pattern:/(^|[\s;|&]|[<>]\()(?:false|true)(?=$|[)\s;|&])/,lookbehind:!0},"file-descriptor":{pattern:/\B&\d\b/,alias:"important"},operator:{pattern:/\d?<>|>\||\+=|=[=~]?|!=?|<<[<-]?|[&\d]?>>|\d[<>]&?|[<>][&=]?|&[>&]?|\|[&|]?/,inside:{"file-descriptor":{pattern:/^\d/,alias:"important"}}},punctuation:/\$?\(\(?|\)\)?|\.\.|[{}[\];\\]/,number:{pattern:/(^|\s)(?:[1-9]\d*|0)(?:[.,]\d+)?\b/,lookbehind:!0}},h.inside=o.languages.bash;for(var n=["comment","function-name","for-or-select","assign-left","parameter","string","environment","function","keyword","builtin","boolean","file-descriptor","operator","punctuation","number"],d=v.variable[1].inside,l=0;l<n.length;l++)d[n[l]]=o.languages.bash[n[l]];o.languages.sh=o.languages.bash,o.languages.shell=o.languages.bash}(Prism),function(o){var f=o.languages.javadoclike={parameter:{pattern:/(^[\t ]*(?:\/{3}|\*|\/\*\*)\s*@(?:arg|arguments|param)\s+)\w+/m,lookbehind:!0},keyword:{pattern:/(^[\t ]*(?:\/{3}|\*|\/\*\*)\s*|\{)@[a-z][a-zA-Z-]+\b/m,lookbehind:!0},punctuation:/[{}]/};Object.defineProperty(f,"addSupport",{value:function(h,v){typeof h=="string"&&(h=[h]),h.forEach(function(n){(function(d,l){var u="doc-comment",c=o.languages[d];if(c){var s=c[u];if(s||(s=(c=o.languages.insertBefore(d,"comment",{"doc-comment":{pattern:/(^|[^\\])\/\*\*[^/][\s\S]*?(?:\*\/|$)/,lookbehind:!0,alias:"comment"}}))[u]),s instanceof RegExp&&(s=c[u]={pattern:s}),Array.isArray(s))for(var m=0,b=s.length;m<b;m++)s[m]instanceof RegExp&&(s[m]={pattern:s[m]}),l(s[m]);else l(s)}})(n,function(d){d.inside||(d.inside={}),d.inside.rest=v})})}}),f.addSupport(["java","javascript","php"],f)}(Prism),function(o){o.languages.typescript=o.languages.extend("javascript",{"class-name":{pattern:/(\b(?:class|extends|implements|instanceof|interface|new|type)\s+)(?!keyof\b)(?!\s)[_$a-zA-Z\xA0-\uFFFF](?:(?!\s)[$\w\xA0-\uFFFF])*(?:\s*<(?:[^<>]|<(?:[^<>]|<[^<>]*>)*>)*>)?/,lookbehind:!0,greedy:!0,inside:null},builtin:/\b(?:Array|Function|Promise|any|boolean|console|never|number|string|symbol|unknown)\b/}),o.languages.typescript.keyword.push(/\b(?:abstract|declare|is|keyof|readonly|require)\b/,/\b(?:asserts|infer|interface|module|namespace|type)\b(?=\s*(?:[{_$a-zA-Z\xA0-\uFFFF]|$))/,/\btype\b(?=\s*(?:[\{*]|$))/),delete o.languages.typescript.parameter,delete o.languages.typescript["literal-property"];var f=o.languages.extend("typescript",{});delete f["class-name"],o.languages.typescript["class-name"].inside=f,o.languages.insertBefore("typescript","function",{decorator:{pattern:/@[$\w\xA0-\uFFFF]+/,inside:{at:{pattern:/^@/,alias:"operator"},function:/^[\s\S]+/}},"generic-function":{pattern:/#?(?!\s)[_$a-zA-Z\xA0-\uFFFF](?:(?!\s)[$\w\xA0-\uFFFF])*\s*<(?:[^<>]|<(?:[^<>]|<[^<>]*>)*>)*>(?=\s*\()/,greedy:!0,inside:{function:/^#?(?!\s)[_$a-zA-Z\xA0-\uFFFF](?:(?!\s)[$\w\xA0-\uFFFF])*/,generic:{pattern:/<[\s\S]+/,alias:"class-name",inside:f}}}}),o.languages.ts=o.languages.typescript}(Prism),function(o){var f=o.languages.javascript,h="\\{(?:[^{}]|\\{(?:[^{}]|\\{[^{}]*\\})*\\})+\\}",v="(@(?:arg|argument|param|property)\\s+(?:"+h+"\\s+)?)";o.languages.jsdoc=o.languages.extend("javadoclike",{parameter:{pattern:RegExp(v+"(?:(?!\\s)[$\\w\\xA0-\\uFFFF.])+(?=\\s|$)"),lookbehind:!0,inside:{punctuation:/\./}}}),o.languages.insertBefore("jsdoc","keyword",{"optional-parameter":{pattern:RegExp(v+"\\[(?:(?!\\s)[$\\w\\xA0-\\uFFFF.])+(?:=[^[\\]]+)?\\](?=\\s|$)"),lookbehind:!0,inside:{parameter:{pattern:/(^\[)[$\w\xA0-\uFFFF\.]+/,lookbehind:!0,inside:{punctuation:/\./}},code:{pattern:/(=)[\s\S]*(?=\]$)/,lookbehind:!0,inside:f,alias:"language-javascript"},punctuation:/[=[\]]/}},"class-name":[{pattern:RegExp("(@(?:augments|class|extends|interface|memberof!?|template|this|typedef)\\s+(?:<TYPE>\\s+)?)[A-Z]\\w*(?:\\.[A-Z]\\w*)*".replace(/<TYPE>/g,function(){return h})),lookbehind:!0,inside:{punctuation:/\./}},{pattern:RegExp("(@[a-z]+\\s+)"+h),lookbehind:!0,inside:{string:f.string,number:f.number,boolean:f.boolean,keyword:o.languages.typescript.keyword,operator:/=>|\.\.\.|[&|?:*]/,punctuation:/[.,;=<>{}()[\]]/}}],example:{pattern:/(@example\s+(?!\s))(?:[^@\s]|\s+(?!\s))+?(?=\s*(?:\*\s*)?(?:@\w|\*\/))/,lookbehind:!0,inside:{code:{pattern:/^([\t ]*(?:\*\s*)?)\S.*$/m,lookbehind:!0,inside:f,alias:"language-javascript"}}}}),o.languages.javadoclike.addSupport("javascript",o.languages.jsdoc)}(Prism),Prism.languages.json={property:{pattern:/(^|[^\\])"(?:\\.|[^\\"\r\n])*"(?=\s*:)/,lookbehind:!0,greedy:!0},string:{pattern:/(^|[^\\])"(?:\\.|[^\\"\r\n])*"(?!\s*:)/,lookbehind:!0,greedy:!0},comment:{pattern:/\/\/.*|\/\*[\s\S]*?(?:\*\/|$)/,greedy:!0},number:/-?\b\d+(?:\.\d+)?(?:e[+-]?\d+)?\b/i,punctuation:/[{}[\],]/,operator:/:/,boolean:/\b(?:false|true)\b/,null:{pattern:/\bnull\b/,alias:"keyword"}},Prism.languages.webmanifest=Prism.languages.json,function(o){var f=/("|')(?:\\(?:\r\n?|\n|.)|(?!\1)[^\\\r\n])*\1/;o.languages.json5=o.languages.extend("json",{property:[{pattern:RegExp(f.source+"(?=\\s*:)"),greedy:!0},{pattern:/(?!\s)[_$a-zA-Z\xA0-\uFFFF](?:(?!\s)[$\w\xA0-\uFFFF])*(?=\s*:)/,alias:"unquoted"}],string:{pattern:f,greedy:!0},number:/[+-]?\b(?:NaN|Infinity|0x[a-fA-F\d]+)\b|[+-]?(?:\b\d+(?:\.\d*)?|\B\.\d+)(?:[eE][+-]?\d+\b)?/})}(Prism),Prism.languages.matlab={comment:[/%\{[\s\S]*?\}%/,/%.+/],string:{pattern:/\B'(?:''|[^'\r\n])*'/,greedy:!0},number:/(?:\b\d+(?:\.\d*)?|\B\.\d+)(?:[eE][+-]?\d+)?(?:[ij])?|\b[ij]\b/,keyword:/\b(?:NaN|break|case|catch|continue|else|elseif|end|for|function|if|inf|otherwise|parfor|pause|pi|return|switch|try|while)\b/,function:/\b(?!\d)\w+(?=\s*\()/,operator:/\.?[*^\/\\']|[+\-:@]|[<>=~]=?|&&?|\|\|?/,punctuation:/\.{3}|[.,;\[\](){}!]/},Prism.languages.swift={comment:{pattern:/(^|[^\\:])(?:\/\/.*|\/\*(?:[^/*]|\/(?!\*)|\*(?!\/)|\/\*(?:[^*]|\*(?!\/))*\*\/)*\*\/)/,lookbehind:!0,greedy:!0},"string-literal":[{pattern:RegExp(`(^|[^"#])(?:"(?:\\\\(?:\\((?:[^()]|\\([^()]*\\))*\\)|\r
|[^(])|[^\\\\\r
"])*"|"""(?:\\\\(?:\\((?:[^()]|\\([^()]*\\))*\\)|[^(])|[^\\\\"]|"(?!""))*""")(?!["#])`),lookbehind:!0,greedy:!0,inside:{interpolation:{pattern:/(\\\()(?:[^()]|\([^()]*\))*(?=\))/,lookbehind:!0,inside:null},"interpolation-punctuation":{pattern:/^\)|\\\($/,alias:"punctuation"},punctuation:/\\(?=[\r\n])/,string:/[\s\S]+/}},{pattern:RegExp(`(^|[^"#])(#+)(?:"(?:\\\\(?:#+\\((?:[^()]|\\([^()]*\\))*\\)|\r
|[^#])|[^\\\\\r
])*?"|"""(?:\\\\(?:#+\\((?:[^()]|\\([^()]*\\))*\\)|[^#])|[^\\\\])*?""")\\2`),lookbehind:!0,greedy:!0,inside:{interpolation:{pattern:/(\\#+\()(?:[^()]|\([^()]*\))*(?=\))/,lookbehind:!0,inside:null},"interpolation-punctuation":{pattern:/^\)|\\#+\($/,alias:"punctuation"},string:/[\s\S]+/}}],directive:{pattern:RegExp("#(?:(?:elseif|if)\\b(?:[ 	]*(?:![ 	]*)?(?:\\b\\w+\\b(?:[ 	]*\\((?:[^()]|\\([^()]*\\))*\\))?|\\((?:[^()]|\\([^()]*\\))*\\))(?:[ 	]*(?:&&|\\|\\|))?)+|(?:else|endif)\\b)"),alias:"property",inside:{"directive-name":/^#\w+/,boolean:/\b(?:false|true)\b/,number:/\b\d+(?:\.\d+)*\b/,operator:/!|&&|\|\||[<>]=?/,punctuation:/[(),]/}},literal:{pattern:/#(?:colorLiteral|column|dsohandle|file(?:ID|Literal|Path)?|function|imageLiteral|line)\b/,alias:"constant"},"other-directive":{pattern:/#\w+\b/,alias:"property"},attribute:{pattern:/@\w+/,alias:"atrule"},"function-definition":{pattern:/(\bfunc\s+)\w+/,lookbehind:!0,alias:"function"},label:{pattern:/\b(break|continue)\s+\w+|\b[a-zA-Z_]\w*(?=\s*:\s*(?:for|repeat|while)\b)/,lookbehind:!0,alias:"important"},keyword:/\b(?:Any|Protocol|Self|Type|actor|as|assignment|associatedtype|associativity|async|await|break|case|catch|class|continue|convenience|default|defer|deinit|didSet|do|dynamic|else|enum|extension|fallthrough|fileprivate|final|for|func|get|guard|higherThan|if|import|in|indirect|infix|init|inout|internal|is|isolated|lazy|left|let|lowerThan|mutating|none|nonisolated|nonmutating|open|operator|optional|override|postfix|precedencegroup|prefix|private|protocol|public|repeat|required|rethrows|return|right|safe|self|set|some|static|struct|subscript|super|switch|throw|throws|try|typealias|unowned|unsafe|var|weak|where|while|willSet)\b/,boolean:/\b(?:false|true)\b/,nil:{pattern:/\bnil\b/,alias:"constant"},"short-argument":/\$\d+\b/,omit:{pattern:/\b_\b/,alias:"keyword"},number:/\b(?:[\d_]+(?:\.[\de_]+)?|0x[a-f0-9_]+(?:\.[a-f0-9p_]+)?|0b[01_]+|0o[0-7_]+)\b/i,"class-name":/\b[A-Z](?:[A-Z_\d]*[a-z]\w*)?\b/,function:/\b[a-z_]\w*(?=\s*\()/i,constant:/\b(?:[A-Z_]{2,}|k[A-Z][A-Za-z_]+)\b/,operator:/[-+*/%=!<>&|^~?]+|\.[.\-+*/%=!<>&|^~?]+/,punctuation:/[{}[\]();,.:\\]/},Prism.languages.swift["string-literal"].forEach(function(o){o.inside.interpolation.inside=Prism.languages.swift}),function(o){var f=/[*&][^\s[\]{},]+/,h=/!(?:<[\w\-%#;/?:@&=+$,.!~*'()[\]]+>|(?:[a-zA-Z\d-]*!)?[\w\-%#;/?:@&=+$.~*'()]+)?/,v="(?:"+h.source+"(?:[ 	]+"+f.source+")?|"+f.source+"(?:[ 	]+"+h.source+")?)",n="(?:[^\\s\\x00-\\x08\\x0e-\\x1f!\"#%&'*,\\-:>?@[\\]`{|}\\x7f-\\x84\\x86-\\x9f\\ud800-\\udfff\\ufffe\\uffff]|[?:-]<PLAIN>)(?:[ 	]*(?:(?![#:])<PLAIN>|:<PLAIN>))*".replace(/<PLAIN>/g,function(){return"[^\\s\\x00-\\x08\\x0e-\\x1f,[\\]{}\\x7f-\\x84\\x86-\\x9f\\ud800-\\udfff\\ufffe\\uffff]"}),d=`"(?:[^"\\\\\r
]|\\\\.)*"|'(?:[^'\\\\\r
]|\\\\.)*'`;function l(u,c){c=(c||"").replace(/m/g,"")+"m";var s=`([:\\-,[{]\\s*(?:\\s<<prop>>[ 	]+)?)(?:<<value>>)(?=[ 	]*(?:$|,|\\]|\\}|(?:[\r
]\\s*)?#))`.replace(/<<prop>>/g,function(){return v}).replace(/<<value>>/g,function(){return u});return RegExp(s,c)}o.languages.yaml={scalar:{pattern:RegExp(`([\\-:]\\s*(?:\\s<<prop>>[ 	]+)?[|>])[ 	]*(?:((?:\r?
|\r)[ 	]+)\\S[^\r
]*(?:\\2[^\r
]+)*)`.replace(/<<prop>>/g,function(){return v})),lookbehind:!0,alias:"string"},comment:/#.*/,key:{pattern:RegExp(`((?:^|[:\\-,[{\r
?])[ 	]*(?:<<prop>>[ 	]+)?)<<key>>(?=\\s*:\\s)`.replace(/<<prop>>/g,function(){return v}).replace(/<<key>>/g,function(){return"(?:"+n+"|"+d+")"})),lookbehind:!0,greedy:!0,alias:"atrule"},directive:{pattern:/(^[ \t]*)%.+/m,lookbehind:!0,alias:"important"},datetime:{pattern:l("\\d{4}-\\d\\d?-\\d\\d?(?:[tT]|[ 	]+)\\d\\d?:\\d{2}:\\d{2}(?:\\.\\d*)?(?:[ 	]*(?:Z|[-+]\\d\\d?(?::\\d{2})?))?|\\d{4}-\\d{2}-\\d{2}|\\d\\d?:\\d{2}(?::\\d{2}(?:\\.\\d*)?)?"),lookbehind:!0,alias:"number"},boolean:{pattern:l("false|true","i"),lookbehind:!0,alias:"important"},null:{pattern:l("null|~","i"),lookbehind:!0,alias:"important"},string:{pattern:l(d),lookbehind:!0,greedy:!0},number:{pattern:l("[+-]?(?:0x[\\da-f]+|0o[0-7]+|(?:\\d+(?:\\.\\d*)?|\\.\\d+)(?:e[+-]?\\d+)?|\\.inf|\\.nan)","i"),lookbehind:!0},tag:h,important:f,punctuation:/---|[:[\]{}\-,|>?]|\.\.\./},o.languages.yml=o.languages.yaml}(Prism),function(){if(typeof Prism<"u"&&typeof document<"u"){var o="line-numbers",f=/\n(?!$)/g,h=Prism.plugins.lineNumbers={getLine:function(d,l){if(d.tagName==="PRE"&&d.classList.contains(o)){var u=d.querySelector(".line-numbers-rows");if(u){var c=parseInt(d.getAttribute("data-start"),10)||1,s=c+(u.children.length-1);l<c&&(l=c),l>s&&(l=s);var m=l-c;return u.children[m]}}},resize:function(d){n([d])},assumeViewportIndependence:!0},v=void 0;window.addEventListener("resize",function(){h.assumeViewportIndependence&&v===window.innerWidth||(v=window.innerWidth,n(Array.prototype.slice.call(document.querySelectorAll("pre.line-numbers"))))}),Prism.hooks.add("complete",function(d){if(d.code){var l=d.element,u=l.parentNode;if(u&&/pre/i.test(u.nodeName)&&!l.querySelector(".line-numbers-rows")&&Prism.util.isActive(l,o)){l.classList.remove(o),u.classList.add(o);var c,s=d.code.match(f),m=s?s.length+1:1,b=new Array(m+1).join("<span></span>");(c=document.createElement("span")).setAttribute("aria-hidden","true"),c.className="line-numbers-rows",c.innerHTML=b,u.hasAttribute("data-start")&&(u.style.counterReset="linenumber "+(parseInt(u.getAttribute("data-start"),10)-1)),d.element.appendChild(c),n([u]),Prism.hooks.run("line-numbers",d)}}}),Prism.hooks.add("line-numbers",function(d){d.plugins=d.plugins||{},d.plugins.lineNumbers=!0})}function n(d){if((d=d.filter(function(u){var c,s=(c=u,c?window.getComputedStyle?getComputedStyle(c):c.currentStyle||null:null)["white-space"];return s==="pre-wrap"||s==="pre-line"})).length!=0){var l=d.map(function(u){var c=u.querySelector("code"),s=u.querySelector(".line-numbers-rows");if(c&&s){var m=u.querySelector(".line-numbers-sizer"),b=c.textContent.split(f);m||((m=document.createElement("span")).className="line-numbers-sizer",c.appendChild(m)),m.innerHTML="0",m.style.display="block";var k=m.getBoundingClientRect().height;return m.innerHTML="",{element:u,lines:b,lineHeights:[],oneLinerHeight:k,sizer:m}}}).filter(Boolean);l.forEach(function(u){var c=u.sizer,s=u.lines,m=u.lineHeights,b=u.oneLinerHeight;m[s.length-1]=void 0,s.forEach(function(k,E){if(k&&k.length>1){var t=c.appendChild(document.createElement("span"));t.style.display="block",t.textContent=k}else m[E]=b})}),l.forEach(function(u){for(var c=u.sizer,s=u.lineHeights,m=0,b=0;b<s.length;b++)s[b]===void 0&&(s[b]=c.children[m++].getBoundingClientRect().height)}),l.forEach(function(u){var c=u.sizer,s=u.element.querySelector(".line-numbers-rows");c.style.display="none",c.innerHTML="",u.lineHeights.forEach(function(m,b){s.children[b].style.height=m+"px"})})}}}(),function(){if(typeof Prism<"u"&&typeof document<"u"){var o=[],f={},h=function(){};Prism.plugins.toolbar={};var v=Prism.plugins.toolbar.registerButton=function(d,l){var u;u=typeof l=="function"?l:function(c){var s;return typeof l.onClick=="function"?((s=document.createElement("button")).type="button",s.addEventListener("click",function(){l.onClick.call(this,c)})):typeof l.url=="string"?(s=document.createElement("a")).href=l.url:s=document.createElement("span"),l.className&&s.classList.add(l.className),s.textContent=l.text,s},d in f?console.warn('There is a button with the key "'+d+'" registered already.'):o.push(f[d]=u)},n=Prism.plugins.toolbar.hook=function(d){var l=d.element.parentNode;if(l&&/pre/i.test(l.nodeName)&&!l.parentNode.classList.contains("code-toolbar")){var u=document.createElement("div");u.classList.add("code-toolbar"),l.parentNode.insertBefore(u,l),u.appendChild(l);var c=document.createElement("div");c.classList.add("toolbar");var s=o,m=function(b){for(;b;){var k=b.getAttribute("data-toolbar-order");if(k!=null)return(k=k.trim()).length?k.split(/\s*,\s*/g):[];b=b.parentElement}}(d.element);m&&(s=m.map(function(b){return f[b]||h})),s.forEach(function(b){var k=b(d);if(k){var E=document.createElement("div");E.classList.add("toolbar-item"),E.appendChild(k),c.appendChild(E)}}),u.appendChild(c)}};v("label",function(d){var l=d.element.parentNode;if(l&&/pre/i.test(l.nodeName)&&l.hasAttribute("data-label")){var u,c,s=l.getAttribute("data-label");try{c=document.querySelector("template#"+s)}catch{}return c?u=c.content:(l.hasAttribute("data-url")?(u=document.createElement("a")).href=l.getAttribute("data-url"):u=document.createElement("span"),u.textContent=s),u}}),Prism.hooks.add("complete",n)}}(),function(){function o(f){var h=document.createElement("textarea");h.value=f.getText(),h.style.top="0",h.style.left="0",h.style.position="fixed",document.body.appendChild(h),h.focus(),h.select();try{var v=document.execCommand("copy");setTimeout(function(){v?f.success():f.error()},1)}catch(n){setTimeout(function(){f.error(n)},1)}document.body.removeChild(h)}typeof Prism<"u"&&typeof document<"u"&&(Prism.plugins.toolbar?Prism.plugins.toolbar.registerButton("copy-to-clipboard",function(f){var h=f.element,v=function(c){var s={copy:"Copy","copy-error":"Press Ctrl+C to copy","copy-success":"Copied!","copy-timeout":5e3};for(var m in s){for(var b="data-prismjs-"+m,k=c;k&&!k.hasAttribute(b);)k=k.parentElement;k&&(s[m]=k.getAttribute(b))}return s}(h),n=document.createElement("button");n.className="copy-to-clipboard-button",n.setAttribute("type","button");var d=document.createElement("span");return n.appendChild(d),u("copy"),function(c,s){c.addEventListener("click",function(){(function(m){navigator.clipboard?navigator.clipboard.writeText(m.getText()).then(m.success,function(){o(m)}):o(m)})(s)})}(n,{getText:function(){return h.textContent},success:function(){u("copy-success"),l()},error:function(){u("copy-error"),setTimeout(function(){(function(c){window.getSelection().selectAllChildren(c)})(h)},1),l()}}),n;function l(){setTimeout(function(){u("copy")},v["copy-timeout"])}function u(c){d.textContent=v[c],n.setAttribute("data-copy-state",c)}}):console.warn("Copy to Clipboard plugin loaded before Toolbar plugin."))}();
