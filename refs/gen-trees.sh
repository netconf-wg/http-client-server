
pyang -p ../ -f tree --tree-line-length 69 --tree-print-groupings ../ietf-http-client\@*.yang > ietf-http-client-tree.txt
pyang -p ../ -f tree --tree-line-length 69 --tree-print-groupings ../ietf-http-server\@*.yang > ietf-http-server-tree.txt

pyang -p ../ -f tree --tree-line-length 69 --tree-print-groupings --tree-no-expand-uses ../ietf-http-client\@*.yang > ietf-http-client-tree-no-expand.txt
pyang -p ../ -f tree --tree-line-length 69 --tree-print-groupings --tree-no-expand-uses ../ietf-http-server\@*.yang > ietf-http-server-tree-no-expand.txt

