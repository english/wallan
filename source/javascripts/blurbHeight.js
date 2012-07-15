var heights = [];
var els = document.querySelectorAll(".blurb");

for (var i = 0; i < els.length; i++) {
  heights.push(els[i].offsetHeight);
}

var minHeight = Math.max.apply(null, heights).toString() + "px";
for (var i = 0; i < els.length; i++) {
  els[i].style.minHeight = minHeight;
}
