/* 
 * The id of the element that displays the name of tagged users is
 * passed in as an arguement to the TagViewer constructor. The class
 * used to style tag objects is also passed in as an argument.
 * These arguments allow for greater reusbility of the TagViewer.
 */

function TagViewer(displayID, tagClass) {
   // this object maps tagIDs to the name of the tagged user
   this.tag_arr = {};
   this.displayID = displayID;
   this.tagClass = tagClass;
}

TagViewer.prototype.toggleCheckbox = function(element) {
   var tags = document.getElementsByClassName(this.tagClass);
   if (tags.length == 0) {
      document.getElementById(this.displayID).style.visibility = "visible";
      document.getElementById(this.displayID).innerHTML = "this photo has no tags!"
      return;
   }
   for (i = 0; i < tags.length; i++) { 
      tags[i].style.visibility = (element.checked) ? "visible" : "hidden";
   }
}

TagViewer.prototype.initTag = function(tag) {
   this.xvalue = tag.xvalue;
   this.xvalue = tag.yvalue;
   this.wvalue = tag.wvalue;
   this.wvalue = tag.hvalue;
   this.tagged_name = tag.tagged_name;
   this.tagID = tag.tagID;

   tagElem = document.getElementById(tag.tagID);
   tagElem.style.left = tag.xvalue + "px";
   tagElem.style.top = tag.yvalue + "px";
   tagElem.style.width = tag.wvalue + "px";
   tagElem.style.height = tag.hvalue + "px";

   this.tag_arr[tag.tagID] = tag.tagged_name;
}

TagViewer.prototype.showTag = function(tag) {
   document.getElementById(tag.id).style.backgroundColor = "rgba(255,255,255, .6)";
   document.getElementById(this.displayID).innerHTML = this.tag_arr[tag.id];
   document.getElementById(this.displayID).style.visibility = "visible";
}

TagViewer.prototype.unshowTag = function(tag) {
   document.getElementById(tag.id).style.backgroundColor = "rgba(231,184,196, 0.6)";
   document.getElementById(this.displayID).style.visibility = "hidden";
}