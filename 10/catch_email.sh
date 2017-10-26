#!/bin/bash

# For testing puspose (saving email redirected by postfix)
# Save to a file the stdin.

exec > /tmp/email.txt
while IFS= read -r line; do
              printf '%s\n' "$line"
                done

