# Use official MariaDB image
FROM mariadb:10.6

# Set environment variables
ENV MYSQL_ROOT_PASSWORD=admin
ENV MYSQL_DATABASE=Hangman

# Expose MySQL port
EXPOSE 3306

# Health check to verify database is ready
HEALTHCHECK --interval=5s --timeout=10s --retries=5 \
  CMD mysqladmin ping -h localhost -u root -p${MYSQL_ROOT_PASSWORD} || exit 1

# Persist data volume
VOLUME /var/lib/mysql