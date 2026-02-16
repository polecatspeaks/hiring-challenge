#!/usr/bin/awk -f
#
# Solution to the Warp Hiring Challenge
# Task: Find the security code of the longest successful Mars mission
#
# Usage: awk -f solve.awk space_missions.log
#
# Approach:
#   1. Skip comment lines (starting with #)
#   2. Filter for Mars missions with "Completed" status
#   3. Track the mission with the maximum duration
#   4. Output the security code
#
# Data format (pipe-delimited, inconsistent spacing):
#   Date | Mission ID | Destination | Status | Crew Size | Duration (days) | Success Rate | Security Code

BEGIN { FS = "|"; max = 0 }

!/^#/ && $3 ~ /Mars/ && $4 ~ /Completed/ {
    gsub(/ /, "", $6)
    gsub(/ /, "", $8)
    dur = $6 + 0
    if (dur > max) {
        max = dur
        code = $8
    }
}

END {
    print "Answer:", code
    print "(Longest completed Mars mission duration:", max, "days)"
}
