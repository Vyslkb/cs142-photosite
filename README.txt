Project 8 - Part 1 - Jennifer Farman

In my solution, the AjaxWrapper.handler() function in the AjaxWrapper class constitutes the reusable component.

The function is defined as follows:
AjaxWrapper.handler = function(url, searchtxt, resultID, callback)

Given a url, a search query, a callback function, and the ID of the element where the result will be displayed, this function provides a resuable mechanism that can be used for filtering/searching behavior in many different contexts.

Passing in a different urls can route the query to any controller. Changing the callback function and the resultID changes how the results are displayed in HTML. Furthermore the search query, which is passed in from the view, can be extracted from any input in the view.

Below are two examples of situations in which it might be used:

Example 1: a website that lists restaurants for your town. If there was dropdown menu to select a certain type of cuisine, you could use my AjaxWrapper to display all restaurants matching that type of cuisine, by passing in the proper routing, the value of the dropdown, the display div id, and a callback function that would style the results.

Example 2: a website that lists all the libraries at Stanford. Suppose there is a radio button that says “only show me libraries that are currently open.” Using the value of the radio button, you could use my AjaxWrapper to display either all libraries or only that are currently open, depending on the user input. Again this, this could be done by passing in the proper routing, the value of the radio button, the display div id, and a callback function that would style the results.