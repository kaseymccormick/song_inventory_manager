
##The assignment##
The task was simply to create a database with three or more tables. That delt with multiple connections from one table to at least one other. In the example it was books on a specific shelf likely seperated by genre in a specific branch of a library. I wanted to create something I may use further in the course. A song inventory database that collects Title, Artist, genre, and status in my case: wish list, purchased or own but not on computer.

##My Solution - Song inventory Management##
I chose to create three tables, a songs table that collects all information, a genres table of types and a statuses table of stages. The songs table references both genres and statuses but genres and statuses tables dont reference eachother or the songs table. I also include a timestamp and desire level to the songs table. I added timestamp so I can later see any patterns in adding specific artists, or genres in a given time. I have the desire level so a user can not instiate the same title/artist twice but it tallies if the title/artist combo has been added more then once. So if i choose to purchase ten songs on my wishlist I could choose the top 10 with highest desire levels.

**Additional features planned** 
 <p>Currently a person has to add this information row by row the plan is to use API's or appropriate webhooks to grab my shazam list, and hubot's answers to now playing in DM with hubot. - Hubot is a robot in our Slack Team that responds to many commands one is Now Playing where it responds with the current artist and song title playing on the school's speaker system. I'd also like to pull pricing from amazon and itunes so I can easily see which place is cheaper, then likely make alerts when the price is below a certain threashold. However these are substantially bigger features then I can tackle at this moment.</p>
 
###User Abilities###
 As anyone could download the files and create your own song inventory management database I allowed for some customization in creating your own genre types and status stages however not the ability to delete them. You can easily add a complete record, modify any parts of those records, see a complete song list, see a genre type list, and see the status stage list. In addition you can see all songs of a specific status, all songs of a specific genre or all songs with the same artist. 

###Some of the logic###
I verify if the title/artist song is in the table already, if it is then I have the system increase the desire_level if it isn't I have the system add the complete row's information into the table. I also try to format the user's input the best I can so no matter how they enter it ther is a uniformity when the lists are returned for the views.
