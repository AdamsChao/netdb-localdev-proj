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

//ImaStandard 的 Technologies 說明
function TechDesc(a) {
    var b = document.getElementById(a.id.replace('cb', 'tb'));
    if (a.checked) {
        b.disabled = '';
    }
    else {
        b.disabled = 'disabled';
        b.value = '';
    }
}

//function TechFee(a) {
//    var b = document.getElementById(a.id.replace('cb', 'tb'));
//    if (a.checked) {
//        b.disabled = '';
//    }
//    else {
//        b.disabled = 'disabled';
//        b.value = '';
//    }
//}

//勾選單一 Technologies
function TechFee(a) {
    var b = document.getElementById(a.id.replace('cb', 'tb'));
    if (a.checked) {
        b.disabled = '';
    }
    else {
        b.disabled = 'disabled';
        b.value = '';
    }
    //取消某一個勾選時All也不勾選
//    var c = a.id.substring(0, a.id.lastIndexOf("_"));
//    var d = c.substring(0, c.lastIndexOf("_"));
//    var ControlRef = document.getElementById(d);
//    var CheckBoxListArray = ControlRef.getElementsByTagName('input');
//    var checkBoxRef;
//    var bln = true;
//    if (!a.checked) {
//        bln = false;
//    }
//    else {
//        for (var i = 3; i < CheckBoxListArray.length; i++) {
//            checkBoxRef = CheckBoxListArray[i];
//            if (checkBoxRef.type=='checkbox' && !checkBoxRef.checked) { bln = false; break; }
//        }
//    }
//    checkBoxRef = CheckBoxListArray[0];
//    checkBoxRef.checked = bln;
//    checkBoxRef = CheckBoxListArray[1];
//    if (checkBoxRef.type == 'text') {
//        if (bln) { checkBoxRef.disabled = ''; }
//        else { checkBoxRef.disabled = 'disabled'; checkBoxRef.value = ''; }
//     }
}

//勾選All Technologies
function TechFeeAll(a) {
    var b = a.id.substring(0, a.id.lastIndexOf("_"));
    var c = b.substring(0, b.lastIndexOf("_"));
    var ControlRef = document.getElementById(c);
    var CheckBoxListArray = ControlRef.getElementsByTagName('input');
    for (var i = 0; i < CheckBoxListArray.length; i++) {
        var checkBoxRef = CheckBoxListArray[i];
        checkBoxRef.checked = a.checked;
        if (checkBoxRef.type == 'text') {
            if (a.checked) { checkBoxRef.disabled = ''; }
            else { checkBoxRef.disabled = 'disabled'; checkBoxRef.value = ''; }
         }
    }
}

//勾選All Technologies 時填入所有費用
function SetTechFeeAll(a) {
    var b = a.id.substring(0, a.id.lastIndexOf("_"));
    var c = b.substring(0, b.lastIndexOf("_"));
    var ControlRef = document.getElementById(c);
    var CheckBoxListArray = ControlRef.getElementsByTagName('input');
    for (var i = 0; i < CheckBoxListArray.length; i++) {
        var checkBoxRef = CheckBoxListArray[i];
        if (checkBoxRef.type == 'text') {
            if (document.getElementById(checkBoxRef.id.replace('tb', 'cb')).checked) {
                checkBoxRef.value = a.value;
            }
        }
    }
}

