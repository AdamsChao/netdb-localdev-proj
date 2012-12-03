$(document).ready(function () {

    $('body').bind("selectstart", function () { return false; })
    .bind("contextmenu", function () { return false; })
    .bind("select", function () { return false; })
    .bind("copy", function () { return false; })
    .bind("dragstart", function () { return false; })
    .bind("beforecopy", function () { return false; })
    .bind("cut", function () { return false; });
});


