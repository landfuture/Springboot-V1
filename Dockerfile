# FROM adoptopenjdk/openjdk11:jre-11.0.6_10-alpine
# FROM adoptopenjdk/openjdk11:x86_64-alpine-jdk-11.0.4_11
FROM adoptopenjdk/openjdk11:armv7l-centos-jdk-11.0.11_9

EXPOSE 8083:8081
# RUN addgroup -S spring && adduser -S spring -G spring
# RUN addgroup -g 1000 spring
# RUN adduser -u 1000   -G spring -D spring

# RUN adduser --system --group spring

# RUN groupadd spring && useradd -g spring spring
# RUN addgroup spring
# RUN adduser -D spring

# USER spring:spring
COPY SpringbootV1-0.0.1-SNAPSHOT.war SpringbootV1-0.0.1-SNAPSHOT.war 
ENTRYPOINT ["java","-jar","/SpringbootV1-0.0.1-SNAPSHOT.war"]
