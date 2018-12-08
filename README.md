# Instid
Grab users Instagram ID to track their username change, and get their username from their ID.

Because of how Instagram works, there's no way to tell if an account either doesn't exist, is suspended or deactivated. However if you had gotten their ID before, then you will be given their previous username and their ID.

This will work in the Windows Subsystem for Linux (WSL).

Because Instagram being Instagram, you now need to have an access token to get the username from the ID. Since it's too stupidly long of a process just to get an access token I'm unsure as to wether the ID to username bit works.

 

## Setup
Since you have to build the username-ID list yourself, the script stores the convertest usernames with their IDs to your documents folder in a text file named "InstagramIDs.txt". If you would rather edit the directory it's saved in just edit the variable "d" to the new directory.

You can also edit the username-ID list file by editing the f variable.

I would also recommend adding it as an alias for faster use. You can do this by the following:
1. Using your prefered editor, add alias instid='bash ~/Documents/instid.sh' to ~/.bashrc
2. For instant use without having to restart your terminal session type source ~/.bashrc

 

Now you can run it. Example:
instid felention

9465163892
