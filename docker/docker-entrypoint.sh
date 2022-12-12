#!/usr/bin/env bash
set -e

start_tomcat() {
	echo "Starting Tomcat..."
	if [ -f "$CATALINA_HOME/app.properties" ]; then
		JAVA_OPTS="-Daxelor.config=$CATALINA_HOME/app.properties $JAVA_OPTS" catalina.sh run
	else
		catalina.sh run
	fi
}

prepare_app() {

	# prepare config file and save it as app.properties
	
	cd $CATALINA_HOME
	echo "Preparing the app..."
	echo "Creating Axelor configuration file..."
	jar xf webapps/ROOT.war WEB-INF/classes/application.properties
	mv WEB-INF/classes/application.properties ./app.properties 
	rm -rf WEB-INF
	echo >> app.properties 
	echo "application.mode = prod" >> app.properties 
	echo "db.default.url = jdbc:postgresql://$POSTGRES_HOST:5432/$POSTGRES_DB" >> app.properties 
	echo "db.default.user = $AXELOR_USER" >> app.properties 
	echo "db.default.password =$AXELOR_PASSWORD" >> app.properties
	echo "file.upload.dir =/usr/local/tomcat/uploads" >> app.properties
	echo "Done."
}

if [ "$1" = "start" ]; then
	echo $CATALINA_HOME
	shift
	prepare_app
	start_tomcat
fi

# Else default to run whatever the user wanted like "bash"
exec "$@"
