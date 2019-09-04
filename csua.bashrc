function officers() {
	getent group officers | cut -d : -f 4 | tr ',' \\n
}

function officer_gecos() {
	getent passwd $(officers) | cut -d : -f 5
}

function officer_names() {
	officer_gecos | cut -d ',' -f 1
}

function officer_emails() {
	officer_gecos | cut -d ',' -f 2
}

