FROM amazoncorretto:21-alpine3.18

# Install essential tools
RUN apk update && apk add --no-cache \
    bash \
    git \
    openssh \
    curl \
    unzip

# -------- AUTO UPGRADE GRADLE WRAPPER TO 8.7 --------
RUN mkdir -p /opt/gradle-upgrade

# Download Gradle 8.7
RUN curl -L https://services.gradle.org/distributions/gradle-8.7-bin.zip -o /opt/gradle-upgrade/gradle.zip \
    && unzip /opt/gradle-upgrade/gradle.zip -d /opt/gradle-upgrade

RUN apk add --no-cache git \
    openssh

#copy idrsa
COPY config/sshkey/id_rsa /root/.ssh/id_rsa
COPY config/sshkey/id_rsa /root/.ssh/id_rsa.pub
RUN chmod 600 /root/.ssh/id_rsa
WORKDIR /projects

EXPOSE 8090

CMD ["tail", "-f", "/dev/null"]
