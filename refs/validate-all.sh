#!/bin/bash

run_unix_cmd() {
  # $1 is the line number
  # $2 is the cmd to run
  # $3 is the expected exit code
  output=`$2 2>&1`
  exit_code=$?
  if [[ $exit_code -ne $3 ]]; then
    printf "failed (incorrect exit status code) on line $1.\n"
    printf "  - exit code: $exit_code (expected $3)\n"
    printf "  - command: $2\n"
    if [[ -z $output ]]; then
      printf "  - output: <none>\n\n"
    else
      printf "  - output: <starts on next line>\n$output\n\n"
    fi
    exit 1
  fi
}

printf "Testing ietf-uri.yang (pyang)..."
command="pyang -Werror --ietf --max-line-length=69 ietf-uri\@*.yang"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"

printf "Testing ietf-uri.yang (yanglint)..."
command="yanglint ietf-uri\@*.yang"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"

printf "Testing ietf-http-client.yang (pyang)..."
command="pyang -Werror --ietf --max-line-length=69 ietf-http-client\@*.yang"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"

printf "Testing ietf-http-client.yang (yanglint)..."
command="yanglint ietf-http-client\@*.yang"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"

printf "Testing ietf-http-server.yang (pyang)..."
command="pyang -Werror --ietf --max-line-length=69 ietf-http-server\@*.yang"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"

printf "Testing ietf-http-server.yang (yanglint)..."
command="yanglint ietf-http-server\@*.yang"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"

printf "Testing ex-http-client-tcp.xml..."
name=`ls -1 ietf-http-client\@*.yang`
cp $name $name.sav
sed 's/^}/container http-client { uses http-client-grouping; }}/' $name > $name.tmp && mv $name.tmp $name
command="yanglint -t data iana-http-versions@*.yang $name ex-http-client-tcp.xml"
run_unix_cmd $LINENO "$command" 0
mv $name.sav $name
printf "okay.\n"

printf "Testing ex-http-client-tls.xml..."
name=`ls -1 ietf-http-client\@*.yang`
cp $name $name.sav
sed 's/^}/container http-client { uses http-client-grouping; }}/' $name > $name.tmp && mv $name.tmp $name
command="yanglint -t data -m ietf-crypto-types@*.yang ietf-truststore@*.yang ietf-keystore@*.yang ietf-tls-common@*.yang ietf-tls-client@*.yang iana-http-versions@*.yang $name ex-http-client-tls.xml ../../trust-anchors/refs/ex-truststore.xml ../../keystore/refs/ex-keystore.xml"
run_unix_cmd $LINENO "$command" 0
mv $name.sav $name
printf "okay.\n"

printf "Testing ex-http-client-proxy.xml..."
name=`ls -1 ietf-http-client\@*.yang`
cp $name $name.sav
sed 's/^}/container http-client { uses http-client-grouping; }}/' $name > $name.tmp && mv $name.tmp $name
command="yanglint -t data -m ietf-crypto-types@*.yang ietf-truststore@*.yang ietf-keystore@*.yang ietf-tls-common@*.yang ietf-tls-client@*.yang $name ex-http-client-proxy.xml ../../trust-anchors/refs/ex-truststore.xml ../../keystore/refs/ex-keystore.xml"
run_unix_cmd $LINENO "$command" 0
mv $name.sav $name
printf "okay.\n"

printf "Testing ex-http-server.xml..."
name=`ls -1 ietf-http-server\@*.yang`
cp $name $name.sav
sed 's/^}/container http-server { uses http-server-grouping; }}/' $name > $name.tmp && mv $name.tmp $name
command="yanglint -t data $name ex-http-server.xml"
run_unix_cmd $LINENO "$command" 0
mv $name.sav $name
printf "okay.\n"

