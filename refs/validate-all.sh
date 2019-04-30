#!/bin/bash

echo "Testing ietf-http-client.yang (pyang)..."
pyang --ietf --max-line-length=69 -p ../ ../ietf-http-client\@*.yang

echo "Testing ietf-http-client.yang (yanglint)..."
yanglint -p ../ ../ietf-http-client\@*.yang

echo "Testing ietf-http-server.yang (pyang)..."
pyang --ietf --max-line-length=69 -p ../ ../ietf-http-server\@*.yang

echo "Testing ietf-http-server.yang (yanglint)..."
yanglint -p ../ ../ietf-http-server\@*.yang


echo "Testing ex-http-client.xml..."
name=`ls -1 ../ietf-http-client\@*.yang | sed 's/\.\.\///'`
sed 's/^}/container http-client { uses http-client-grouping; }}/' ../ietf-http-client\@*.yang > $name
yanglint -m -s -p ../ $name ex-http-client.xml
rm $name

echo "Testing ex-http-server.xml..."
name=`ls -1 ../ietf-http-server\@*.yang | sed 's/\.\.\///'`
sed 's/^}/container http-server { uses http-server-grouping; }}/' ../ietf-http-server\@*.yang > $name
yanglint -m -s -p ../ $name ex-http-server.xml
rm $name

