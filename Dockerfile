FROM ubuntu

# Install necessary packages
RUN apt-get update && \
    apt-get install -y nginx unzip curl

# Ensure Nginx stays in the foreground
RUN echo "daemon off;" >> /etc/nginx/nginx.conf

# Download the zip file
RUN curl -L -o /var/www/html/master.zip https://github.com/gabrielecirulli/2048/archive/refs/heads/master.zip

# Unzip the file and move contents
RUN cd /var/www/html/ && unzip master.zip && \
    mv 2048-master/* . && \
    rm -rf 2048-master master.zip

# Expose port 80
EXPOSE 80

# Start Nginx
CMD ["/usr/sbin/nginx", "-c", "/etc/nginx/nginx.conf"]
