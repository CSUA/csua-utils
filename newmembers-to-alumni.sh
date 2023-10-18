#!/bin/bash

# credit: ChatGPT

# Function to check if a timestamp is over four years ago
is_over_four_years_ago() {
	local timestamp="$1"

	# Convert timestamp to Unix timestamp
	local date1=$(date -d "${timestamp:0:8} ${timestamp:8:2}:${timestamp:10:2}:${timestamp:12:2}" "+%s")

	# Get the current Unix timestamp
	local current_date=$(date "+%s")

	# Calculate the difference in seconds
	local time_diff=$((current_date - date1))

	# Check if the time difference is greater than four years (4 years = 126230400 seconds)
	if [ "$time_diff" -gt 126230400 ]; then
		return 0  # True, email is over four years old
	else
		return 1  # False, email is within the last four years
	fi
}

email_list=$(/usr/sbin/list_members Csua-newmembers)
# email_list="laurencelu@berkeley.edu robertquitt@berkeley.edu jonathanjtan@berkeley.edu"

for email in $email_list; do
	create_timestamp=$(ldapsearch -LLL -x "(gecos=*,$email*)" createTimestamp | grep createTimestamp | head -n 1 | awk '{print $2}')
	if [ ! -z "${create_timestamp}" ]; then
		if is_over_four_years_ago "$create_timestamp" ; then
			/usr/sbin/add_members -r - Alumni < <(echo $email)
			/usr/sbin/remove_members -f - Csua-newmembers < <(echo $email)
		fi
	fi
done
