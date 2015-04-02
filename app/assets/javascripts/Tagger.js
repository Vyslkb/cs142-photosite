function Tagger(elemID, feedbackID, xpos, ypos, width, height, submit) {
   this.isMouseDown = false;
   this.parent = document.getElementById(elemID);
   this.feedback = document.getElementById(feedbackID);
   this.elemID = elemID;
   this.feedbackID = feedbackID;
   this.xposID = xpos;
   this.yposID = ypos;
   this.widthID = width;
   this.heightID = height;
   // the id of the submit button is passed in as an argument so that it 
   // can be enabled after (and only after) atagged area has been selected
   this.submitID = submit;
   var obj = this;
   if (this.parent) {
      this.parent.onmousedown = function(event) {
         obj.mouseDown(event);
      }
   }
}

Tagger.prototype.mouseMove = function(event) {
   if (!this.isMouseDown) return;

   var diffX = event.pageX - this.startX;
   var diffY = event.pageY - this.startY;
   
   var offsetL = this.parent.offsetLeft;
   var offsetT = this.parent.offsetTop;
   var offsetW = this.parent.offsetWidth;
   var offsetH = this.parent.offsetHeight;

   // if mouse has moved over left boundary
   if (event.pageX < offsetL) {
      diffX = offsetL - this.startX;
   }
   // if mouse has moved over top boundary
   if (event.pageY < offsetT) {
      diffY = offsetT - this.startY;
   }
   // if mouse has moved over right boundary
   if (event.pageX > (offsetL + offsetW)) {
      diffX = (offsetL + offsetW) - this.startX;
   }
   // if mouse has moved over bottom boundary
   if (event.pageY > (offsetT + offsetH)) {
      diffY = (offsetT + offsetH) - this.startY;
   }
   // get the relative coordinates of the dragging
   var left = this.startX - offsetL;
   var top = this.startY - offsetT;
   // adjust feedback according to direction of dragging
   if (diffY < 0) top += diffY;
   if (diffX < 0) left += diffX;

   this.feedback.style.left = left + "px";
   this.feedback.style.top = top + "px";
   this.feedback.style.width = Math.abs(diffX) + "px";
   this.feedback.style.height = Math.abs(diffY) + "px";

   this.tX = left;
   this.tY = top;
   this.tW = Math.abs(diffX);
   this.tH = Math.abs(diffY);

   event.preventDefault();
   return false;
}

Tagger.prototype.mouseDown = function(event) {
   this.isMouseDown = true;
   this.parent.style.cursor = "crosshair";

   var obj = this;
   this.oldMoveHandler = document.body.onmousemove;
   document.body.onmousemove = function(event) {
      obj.mouseMove(event);
   }
   this.oldUpHandler = document.body.onmouseup;
   document.body.onmouseup = function(event) {
      obj.mouseUp(event);
   }
   this.startX = event.pageX;
   this.startY = event.pageY;

   event.preventDefault();
   return false;
}

Tagger.prototype.mouseUp = function(event) {
   this.isMouseDown = false;
   this.parent.style.cursor = "default";
   document.body.onmousemove = this.oldMoveHandler;
   document.body.onmouseup = this.oldUpHandler;
   // set feedback elements to respond to dragged area
   document.getElementById(this.xposID).value = this.tX;
   document.getElementById(this.yposID).value = this.tY;
   document.getElementById(this.widthID).value = this.tW;
   document.getElementById(this.heightID).value = this.tH;
   document.getElementById(this.submitID).disabled = false;
   return false;
}

