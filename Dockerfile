# FROM adoptopenjdk/openjdk11:jre-11.0.6_10-alpine
FROM adoptopenjdk/openjdk11:x86_64-alpine-jdk-11.0.4_11

EXPOSE 8080:8081
# RUN addgroup -S spring && adduser -S spring -G spring
RUN addgroup spring
RUN adduser  -G spring -D spring


USER spring:spring  
COPY SpringbootV1-0.0.1-SNAPSHOT.war SpringbootV1-0.0.1-SNAPSHOT.war ENTRYPOINT ["java","-jar","/SpringbootV1-0.0.1-SNAPSHOT.war"]