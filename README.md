# PBC technical test

This code has been implemented directly to the spec provided:

    https://github.com/pbc/devtest
    
Anywhere that the spec was unclear I have attempted to make sensible
choices while ensuring that I am not locked into a given decision.

I would expect that in day to day work there would be an 
opportunity to ask the business own to clarify the task at hand.
 
I have chosen to split the Private/Public API layers at the routing layer.
Implementing separate controller, where it could easily be one. I feel 
this decision is justified as it allows me to avoid `if` logic in
my controllers or json presenters, something that is hard
to maintain in a real world project.


