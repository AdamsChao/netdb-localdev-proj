function CertificationSelect(a) {
    var ControlRef = a;
    //var ControlRef = document.getElementById('<%= cbProductType.ClientID %>');
    var CheckBoxListArray = ControlRef.getElementsByTagName('input');
    var strContentID = a.id.split("_", 1);
    for (var i = 0; i < CheckBoxListArray.length; i++) {
        var checkBoxRef = CheckBoxListArray[i];
        var strType = checkBoxRef.parentElement.innerText;
        var trID = document.getElementById(strContentID + "_trTech" + strType);
        //alert(checkBoxRef.value);
        if (checkBoxRef.checked == true) {
            trID.style.display = "";
        }
        else {
            var tb = document.getElementById(strContentID + "_tb" + strType + "Remark");
            tb.value = "";
            trID.style.display = "none";
        }
    }
}


function TechSelect(a) {
    //var ControlRef = document.getElementById(a.id.replace('_0', ''));
    var ControlRef = document.getElementById(a.id.substring(0, a.id.lastIndexOf("_")));
    var CheckBoxListArray = ControlRef.getElementsByTagName('input');
    for (var i = 0; i < CheckBoxListArray.length; i++) {
        var checkBoxRef = CheckBoxListArray[i];
        checkBoxRef.checked = a.checked;
    }
}


function Tech(a) {
    var ControlRef = document.getElementById(a.id.substring(0, a.id.lastIndexOf("_")));
    var CheckBoxListArray = ControlRef.getElementsByTagName('input');
    var checkBoxRef;
    var b = true;
    if (!a.checked) {
        b = false;
    }
    else {
        for (var i = 1; i < CheckBoxListArray.length; i++) {
            checkBoxRef = CheckBoxListArray[i];
            if (!checkBoxRef.checked) { b = false; break; }
        }
    }
    checkBoxRef = CheckBoxListArray[0];
    checkBoxRef.checked = b;
}


function TechFee(a) {
    var b = document.getElementById(a.id.replace('cb', 'tb'));
    if (a.checked) {
        b.disabled = '';
    }
    else {
        b.disabled = 'disabled';
        b.value = '';
    }
 }