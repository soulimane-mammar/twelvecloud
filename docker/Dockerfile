FROM tomcat:8.5.84-jdk8-temurin-jammy

LABEL maintainer="Nabla Analytics s.mammar@nablanalytics.com"

RUN mkdir /usr/local/tomcat/uploads

COPY ROOT.war /usr/local/tomcat/webapps/

EXPOSE  8080 

COPY docker-entrypoint.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

ENTRYPOINT ["docker-entrypoint.sh"]

CMD ["start"]


