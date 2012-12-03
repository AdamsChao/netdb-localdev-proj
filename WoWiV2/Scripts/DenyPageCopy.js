if (document.all)
  document.body.onselectstart = function () { return false; };
else {
  $('body').css('-moz-user-select', 'none');
  $('body').css('-webkit-user-select', 'none');
}

document.onmousedown = clkARR_;
document.onkeydown = clkARR_;
document.onkeyup = clkARRx_;
window.onmousedown = clkARR_;
window.onkeydown = clkARR_;
window.onkeyup = clkARRx_;

var clkARRCtrl = false;

function clkARRx_(e) {
  var k = (e) ? e.which : event.keyCode;
  if (k == 17) clkARRCtrl = false;
}

function clkARR_(e) {
  var k = (e) ? e.which : event.keyCode;
  var m = (e) ? (e.which == 3) : (event.button == 2);
  if (k == 17) clkARRCtrl = true;
  if (m || clkARRCtrl && (k == 67 || k == 83))
    alert((typeof (clkARRMsg) == 'string') ? clkARRMsg : '-版權所有-請勿複製-');
} 