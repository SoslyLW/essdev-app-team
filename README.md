# essdev-app-team
Ok so here's where we stand. 

The current version of things has a function that can query the cloud firestore database given a userID which returns the user's name. This function is asynchronous so it must be called from a future builder, which will wait for a response from the query. 

I have manually added 2 documents to the users database with IDs 1 & 2 with different names. When the app boots up, both of these documents are queried and the results are applied to a toolCard widget, which are manually called from main.

There widgets have request buttons which, when pressed, make a call to add a requestedToolCard widget to the global widget list in main. In its current form, the button's call must manually pass in the ID of the user. 

The next steps for this part of the project is to add a database of tools, related to the database of users, in the main project db. I want the toolCards to be generated from just their ID in reference to the db. 

Later on, I would like to add a form to create a user or tool and store that in the db.

That's all for now!


TODO:

- Make form to create a new tool for a given user
- Add the ability to upload and display photos of the tool
- Add functionality to duration selector
- Have the page of tools just query the whole db and show all tools

DONE:

- Transfer over to the main essdev database so Logan can use tools
- have toolCard query the database instead of using default tool