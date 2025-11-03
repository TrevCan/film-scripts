#!/bin/bash

# Download files from an archived website from http://web.archive.org
# Will not reuse the previous connection, may get blocked! 
# If you would like to reuse a single connection, you must tell
# wget to read from a single file.

url="screentalk.org"
wget "http://web.archive.org/cdx/search/cdx?url=${url}*&output=json&fl=original,timestamp,mimetype" -O out.json
grep 'application/pdf' < out.json | sed "s/.\{0,20\}$//; /^$/d;s/$/],/" > out2.json
sed -En '1,$s%^\["([^"]*)","([^"]*)"](,|])$%wget "https://web.archive.org/web/\2id_/\1" -O \2.pdf%gmp' <out2.json >out3.json
cat out3.json | sh
