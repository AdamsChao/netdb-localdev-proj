function checkPercetage() {
    flag = true;
    $('span').each(
                function () {
                    if ($(this).attr('id').indexOf("tbPaymentBal") != -1) {
                        if (this.childNodes.length != 0 && this.childNodes[0].nodeValue != 100 || this.childNodes.length == 0) {
                            alert("The Balance of Payment must be 100%.");
                            flag = false;
                            return;
                        }
                    }
                }
            );

     return flag;
 }

 function dis(obj) {
     obj.disabled = true;
 }