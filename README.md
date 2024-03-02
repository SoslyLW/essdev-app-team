# essdev-app-team
Ok so here's where we stand. 

There is a widget that takes in the ID of a tool stored in the database 
and displays a card with information about the tool and the user that owns 
that tool. These cards are all displayed in toolCardPage. 

Currently, each of these cards show up because they are manually created from main.dart. Ideally, there would be 2 types of pages: view your own tools and view all available tools. An available tool means it is owned by a user who is part of one of the same communities as you. This could all be done through querying the databse. These pages should have different widgets to show the tool, as you can't request your own tool.

Hitting 'REQUEST' on an available tool should send the request to the user associated with the tool. How to do this? I don't quite know yet. Maybe start chat between users and append the request message to the list of messages in the database. Perhaps.

TODO:

- Add the ability to upload and display photos of the tool?
- Add functionality to duration selector
- Make 'My Tools' page
- Make 'Available Tools' page
- Ability to remove tool from your list of tools

DONE:

- Transfer over to the main essdev database so Logan can use tools
- have toolCard query the database instead of using default tool
- Make form to create a new tool for a given user