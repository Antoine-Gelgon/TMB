# TMB
##Terminal MicroBlogging
This programme was built for blogging quilckly with the terminal.
##Programme/
###Requierment
    -**cUrl** -> https://curl.haxx.se/
    
    install with aptitude `sudo apt-get curl`
    install with pacman `sudo pacman -S curl`
###FTP variable
    We must write this variable in a new file (exemple key.sh).

    USER=userftp
    PASS=passftp
    DIRFTP=directionftp

    Call this file in the beginning of `logApp.sh`.

    `. key.sh`
##License
Gnu/GPLv3 License
