This project involved creating a search mechanism for a photo website (the website itself was developed earlier in the course).
My implementation included a reusable Ajax mechanism that could be could potentially be used for other purposes outside of this partiular context.

The function is defined as follows:
AjaxWrapper.handler = function(url, searchtxt, resultID, callback)
Given a url, a search query, a callback function, and the ID of the element where the result will be displayed, this function provides a resuable
mechanism that can be used for filtering/searching behavior in many different context.
