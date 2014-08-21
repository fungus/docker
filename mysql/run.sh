#!/bin/bash

if [ -f /firstboot ]
then
	echo "==== Starting first boot user creation ===="
	# Start database and wait for finish
	/usr/sbin/mysqld > /dev/null 2>&1 &
	for i in 1 2 3 5 5 10
	do
		sleep $i
		mysqladmin status > /dev/null 2>&1 && break
	done
	if [ $? -gt 0 ]
	then
		echo "Timeout on initial MySQL start"
		exit 1
	fi

	mysql -e "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASS}'"
	mysql -e "GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_USER}'@'%' WITH GRANT OPTION"
	mysqladmin shutdown
	sleep 2
	rm /firstboot
	echo "==== Finished first boot user creation ===="
fi
exec "$@"
