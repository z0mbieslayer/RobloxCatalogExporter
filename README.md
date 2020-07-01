# Roblox Catalog Exporter
A batch script that exports any details about the item from the api, to a nice html table.
## About
I made this just to increase my knowledge on batch scripting and to make something I thought was interesting.
## Features & How It Works
This script essentially just exports the entirety of the roblox api output for that item to a json file, builds a url for the item based on some values it finds, replaces the PriceInTickets string in the json file with the built url (since price in tickets is useless nowadays), and uses a python module called json2html to build the table. The URL builder is still a wip, so if you have any errors, make an issue, and I will try to help you.
## Requirements
This script uses jq, so you will need a 64 bit os. The script takes care of the rest of the dependencies for you :). It's worth noting however you should run this in an empty folder, since it creates a bit of files, and it will download a portable Python27 installation.
## Credits
Over the course of about 3 - 3 1/2 days, I coded, debugged, and almost deleted this entire script out of frustration. This script is very messy, and most likely can be made in a much better way. Credits go to the following:
**Coding/Debugging** - [z0mbieslayer](https://github.com/z0mbieslayer)
**Idea for an Item URL** - [Houh](https://github.com/cjduhbumey)
