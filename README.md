DFYX' Scripts
=============

This is just a collection of scripts I found useful some time or another.
Feel free to use them in any way you want, but don't blame me if something
goes wrong.

killbyargs
----------
This script works similar to killall but it allows you to specify any part of
the args string `ps` gives you including the process' path, name and
parameters. If one matching process is found, it will be killed immediately.
If multiple processes are found, you are asked wether you wish to kill one,
all or none of them. A known limitation right now is that you can't kill
anything that has "grep" in its name.
