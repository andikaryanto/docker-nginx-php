FROM mariadb:10.11.9

# Copy the config file and set correct permissions
COPY ./custom.cnf /etc/mysql/conf.d/custom.cnf
RUN chmod 644 /etc/mysql/conf.d/custom.cnf
