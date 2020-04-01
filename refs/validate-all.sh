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

printf "Testing ietf-http-client.yang (pyang)..."
command="pyang -Werror --ietf --max-line-length=69 -p ../ ../ietf-http-client\@*.yang"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"

printf "Testing ietf-http-client.yang (yanglint)..."
command="yanglint -p ../ ../ietf-http-client\@*.yang"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"

printf "Testing ietf-http-server.yang (pyang)..."
command="pyang -Werror --ietf --max-line-length=69 -p ../ ../ietf-http-server\@*.yang"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"

printf "Testing ietf-http-server.yang (yanglint)..."
command="yanglint -p ../ ../ietf-http-server\@*.yang"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"


printf "Testing ex-http-client.xml..."
name=`ls -1 ../ietf-http-client\@*.yang | sed 's/\.\.\///'`
sed 's/^}/container http-client { uses http-client-grouping; }}/' ../ietf-http-client\@*.yang > $name
command="yanglint -m -s -p ../ $name ex-http-client.xml"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"
rm $name

printf "Testing ex-http-server.xml..."
name=`ls -1 ../ietf-http-server\@*.yang | sed 's/\.\.\///'`
sed 's/^}/container http-server { uses http-server-grouping; }}/' ../ietf-http-server\@*.yang > $name
command="yanglint -m -s -p ../ $name ex-http-server.xml"
run_unix_cmd $LINENO "$command" 0
printf "okay.\n"
rm $name

