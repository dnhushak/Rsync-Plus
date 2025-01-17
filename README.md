# Rsync+
Rsync+ is a bash script based on the popular file-syncing utility called [rsync](http://linux.die.net/man/1/rsync).

The script essentially parses through two text files, each containing a list of either sources and destinations. Rsync plus will then one-way sync the directories and files from the source text to the destination text, matching on a line-by-line basis.

## Installation

__Note that this requires some sort of *nix system with rsync installed.__ 

One could theoretically make it work in CygWin, but I give absolutely no guarantee as to its ability to work, and __I do not claim responsibility for any inadvertent file loss__.

* Download this repo either using git or the github provided download link.
* Move the repo to any out-of the way location you like.
* Open up a terminal, navigate to said location, and execute ```sudo bash setup.sh```
 
The setup script simply adds a line into your crontab to execute the backup script once an hour. If you're [cron](http://linux.die.net/man/1/crontab) savvy, you can skip this installation step and setup your own custom schedule. 

There you go, you are now set up!

## Configuration

### Basic configuration

Now, to configure your Rsync+, you simply need to pick which directories you want to sync, and pick a directory to sync them to. Per source-destination pair, type in the __absolute path__ (I.E. no ```~/Documents/filename```, must be ```/users/user/Documents/filename```) of the source into the ```src.txt``` file, and the path of the destination into the ```dst.txt``` file. 

__These need to be listed in the same order in both files__!

Also read up on [trailing slashes](https://www.google.com/search?q=rsync+trailing+slash) in rsync and how they relate to directory/file copying etc. to be sure that you're copying what you want to. I'd suggest doing a few test directories and test runs if you're not comfortable with rsync.

### Advanced configuration with ```--exclude```
Rsync has a built in exclude option, which works almost exactly like a .gitignore file! In the exc.txt, you can define which files to exclude.

Some good examples include:
```
.DS_Store
.DS_Store?
._*
.Spotlight-V100
.Trashes
ehthumbs.db
Thumbs.db
*~
```

I have left the exc.txt file in the repo empty, so you can fill it in with whatever you'd like. There is [some discussion](http://stackoverflow.com/questions/13713101/rsync-exclude-according-to-gitignore-hgignore-svnignore-like-filter-c) that exists out there regarding using a .gitignore file or even your global .gitignore file. If you're awesome like that, check it out!
