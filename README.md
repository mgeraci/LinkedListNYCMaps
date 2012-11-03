LinkedListNYCMaps
=================

The goal of this program is to, given a zip code, take a look around
that area for coffee shops by querying the Google Places API. It parses
the addresses of each match, looking for the street number, and if it
saves any matches of the ascii character code of any of the letters
"LinkedListNYC".

Once there are no more results in an area (the API returns 3 pages of
results) it takes a random walk to an adjacent area to start a search
there.

Seeded with NYC's 10001 zip code, it finds a match or two, and then
wanders off looking for more... forever. The program will continue to
wander and search until all characters are matched. I think it will
eventually return, but even I don't have the patience to wait.

Running the Program
-------------------

Clone this repository and run an apache server in the directory (to get
the two php helper scripts to run - they are used to get around ajax
cross-domain restrictions). Then go to localhost and look at your
javascript console, all of the output is there.
