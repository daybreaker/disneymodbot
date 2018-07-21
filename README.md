# Disney Mod Bot
### Finds reposts based on post title
Every time a post is made, this bot searches the subreddit for the same title, and if it finds an exact match, it adds a report to the post.

It uses the Redd gem.

last_update.txt keeps the unix timestamp of the last post it checked in case you need to restart the script, so it doesnt re-process posts that were already checked. You can modify it with an older timestamp if you want to force a recheck of older posts.

### Setup

1) Go to https://www.reddit.com/prefs/apps and create an app. 
 - Select "Script" as the type. 
 - For redirect URL just put something like `http://www.example.com/unused/redirect/uri`
 - There are two values you'll need here. The App ID, and the App Secret.
   - The App Id is the string under the app name.
   - The secret is the string next to "secret". (Duh)

2) git clone the repository.

3) Create file named `.env` 
```
USER_AGENT="Redd:BotNameHere:v0.0.0 (by /u/your_name)"
CLIENT=YOUR REDDIT APP ID
SECRET=YOUR REDDIT APP SECRET
USERNAME=A REDDIT USER NAME
PASSWORD=A REDDIT USER PASSWORD
```

You can use your user name, or create a unique user just to run as the bot user, and make it a mod of your sub.

4) Make sure you have Ruby installed, and run `bundle install`

5) Remember to change the subreddit name in the main ruby file.

6) Run the app as `bundle exec ruby disneymodbot.rb`
