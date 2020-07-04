# Overview
The purpose of this document is to establish the intent of the feature branch that was created,
so that development/commits that are added can be judged against the "original intent" established
here.

## feat/add_listeners_to_webpage

The intent of this work is to attach listeners to individual dom elements that are brought in via an
external webpage that the user gives us. I would like to see if I can stick to Stimulus to keep the 
javascript mimimal and uncomplicated. The "idea stuck in my head" is to iterate through the dom elements
and add attributes for the `onclick` event, and send them all to a central proxy Stimulus controller that
can handle delegation, execution, etc. First pass, it can just print out the `event.target` of the event
into the `div.WebScrape` element to prove that it works.

#### Success Criteria:
* Elements clicked on from the `div.WebView` are shown in the left hand side in the `div.WebScrape` element.
* Minimal JS, with Stimulus being optional but recommended
  * Minimal defined:
    * No major frameworks (React, Vue, Angular, etc.)
    * No jQuery
