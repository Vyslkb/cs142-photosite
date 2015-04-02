function AjaxWrapper() {}

AjaxWrapper.handler = function(url, searchtxt, resultID, callback) {
   var xhr = new XMLHttpRequest();
   xhr.onreadystatechange = function() {
      if (this.readyState == 4) {
         if (this.status == 200) {        
            var response = JSON.parse(this.responseText);
            document.getElementById(resultID).innerHTML = callback(response);
         }
         else { /* Handle error */ }
      }
   }
   xhr.open("GET", url + searchtxt);
   xhr.send();
}