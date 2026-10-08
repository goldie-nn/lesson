FROM ubuntu:20.04
ARG DEBIAN_FRONTEND=noninteractive
RUN apt update
RUN apt install git default-jdk maven tomcat9 -y
RUN git clone https://github.com/boxfuse/boxfuse-sample-java-war-hello.git
WORKDIR /boxfuse-sample-java-war-hello
RUN mvn package
RUN cp target/hello-1.0.war /var/lib/tomcat9/webapps/
EXPOSE 8080
# НАСТРОЙКА ОКРУЖЕНИЯ UBUNTU ДЛЯ TOMCAT:
# Указываем, где лежат конфигурационные файлы в Ubuntu
ENV CATALINA_BASE=/var/lib/tomcat9
# Указываем, где лежат исполняемые файлы
ENV CATALINA_HOME=/usr/share/tomcat9
# Направляем логи во временную папку контейнера
ENV CATALINA_TMPDIR=/tmp

# Запускаем Tomcat напрямую через catalina.sh, используя настроенные переменные
CMD ["/usr/share/tomcat9/bin/catalina.sh", "run"]