(function(){"use strict";angular.module("app",["fpas","misc"]).controller("mainCtrl",["$scope","Message","Example",function(e,t,n){var r,i;return i=function(e){var t,n,r,s,o,u;return t=function(){var u,a,f,l;l=[];for(u=0,a=e.length;u<a;u++){s=e[u];switch(s.type){case"field":l.push(s);break;case"sequence":n=s.value,t=function(){var e,t,s;s=[];for(e=0,t=n.length;e<t;e++)r=n[e],s.push(i(r));return s}();for(o in t)t[o][0].labels=[{name:"entry",descr:"entry starts here"},{name:o,descr:"entry sequence number"}];s.length.labels=[{name:"sequence",descr:"sequence starts here"}],s.length.descr=s.name,l.push((f=[s.length]).concat.apply(f,t));break;case"group":n=s.value,delete s.value,s.labels=[{name:"group",descr:"group starts here"}],l.push([s].concat(i(n)));break;default:l.push(null)}}return l}(),(u=[]).concat.apply(u,t)},e.makeTagLink=function(e){return"http://fixwiki.org/fixwiki/"+e},e.hideTable=function(){return e.table={show:!1}},e.showTable=function(t){return e.table={show:!0,data:i(t)}},e.hideAlert=function(){return e.alert={show:!1}},e.showAlert=function(t,n,r){return e.alert={type:t,title:n,descr:r,show:!0},ga("send","event","alert",t,n+" "+r)},e.templatesFeatureRequest=function(){return ga("set","dimension2","templates"),ga("send","event","feature","request","templates"),e.showAlert("info","Thank you.","Templates feature request was sent.")},e.templateUrl=function(e){return"http://fpas.yanot.org/api/templates/"+e},r=function(n){return t.decode(n,function(t){return e.hideAlert(),e.showTable(t)},function(t){return e.hideTable(),e.showAlert("error","Error.",t.body)})},e.setFile=function(t){var n;if(t.length<1)return;return n=new FileReader,n.onload=function(e){var t;return t=new Uint8Array(e.target.result),r(t)},n.onerror=function(t){return e.hideTable(),e.showAlert("error","File uploading error.")},n.readAsArrayBuffer(t[0])},e.showExample=function(){return ga("send","event","button","click","show example"),n.get(function(e){return r(e)},function(t){return e.hideTable(),e.showAlert("error","Internal error.","Example not available.")})},e.showCurrentTemplate=function(){return ga("send","event","button","click","show current template")},e.showTagDescr=function(){return ga("send","event","button","click","show tag description")},Modernizr.xhr2||ga("send","event","compatibility","nope","xhr2"),Modernizr.cors||ga("send","event","compatibility","nope","cors"),e.isObsoleteBrowser=!Modernizr.xhr2||!Modernizr.cors,e.hideAlert(),e.hideTable()}])}).call(this);