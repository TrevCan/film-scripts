#!/bin/bash

# Download files from an archived website from http://web.archive.org
# Will only use 1 connection.

url="screentalk.org"

# API docs
# https://archive.org/developers/wayback-cdx-server.html

# only grab PDF files
filter="&filter=mimetype:application/pdf"
#
# the asterisk '*'    is very important!!!!
# otherwise only the 'base' url will be returned and you will
# not find any files!
wget "http://web.archive.org/cdx/search/cdx?url=${url}*${filter}&output=json&fl=original,timestamp" -O out.json
sed -Eni '2,$s%^\["([^"]*)","([^"]*)"](,|])$%https://web.archive.org/web/\2id_/\1%gmp' out.json 
wget -i out.json
