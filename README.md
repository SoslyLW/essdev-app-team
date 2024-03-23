# essdev-app-team
Ok so here's where we stand. 

We have two pages. One of which is a form to add a tool to the database. The other displays existing tools in the database.

The form take three inputs, and also sends the ID of the user currently operating the app to the FireBase FireStore database.

The tools display page shows either all tools owned by the current user, or all tools not owned by the current user. I'd like to update this such that the available tools only show those that are owned by a user that shares a community with you. This might take multiple queries. I also want to have it such that pressing the REQUEST button sends a message to the owner of the tool.

TODO:

- Make 'Available Tools' page query communities
- Add request functionality
- MERGE

DONE:

- Transfer over to the main essdev database so Logan can use tools
- have toolCard query the database instead of using default tool
- Make form to create a new tool for a given user
- Ability to remove tool from your list of tools
- Make 'My Tools' page