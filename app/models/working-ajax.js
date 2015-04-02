function AjaxWrapper(elemID, resultID, url, callback) {
	this.elemID = elemID;
	this.resultID = resultID;
	this.url = url;
	this.callback = callback;
}

// maybe make it a static function

AjaxWrapper.prototype.handler = function(searchtxt, params) {
	var xhr = new XMLHttpRequest();
	var object = this;
	xhr.onreadystatechange = function() {
		if (this.readyState == 4) {
			if (this.status == 200) {			
				var response = JSON.parse(this.responseText);
				var html = "";
				if (response) {
					for (var i = 0; i < response.length; i++) {
						html += "<img src=\"/assets/"+response[i].file_name+"\" class=\"search-thumbnail\">";
					}
				}
				document.getElementById(object.resultID).innerHTML = html;
			}
			else {
				// Handle error
			}
		}
	}
	xhr.open("GET", this.url + searchtxt);
	xhr.send();
}


AjaxWrapper.prototype.newsearch = function() {
// When the JSON response button is clicked
	var searchtxt = document.getElementById(this.elemID).value;
	this.handler(searchtxt, ["str"]);
	// Return false to prevent the form from actually submitting and reloading the page
	return false;
}