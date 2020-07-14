FROM nginx:latest
MAINTAINER Tran Sy Bao

RUN rm /etc/nginx/conf.d/default.conf
COPY ./nginx-conf/nginx.conf /etc/nginx/nginx.conf
COPY ./nginx-conf/mime.types /etc/nginx/mime.types
# wait-for-it file
COPY wait-for-it.sh /wait-for-it.sh
RUN chmod +x /wait-for-it.sh

# Create cache and logs folder for easy error tracking
RUN mkdir /cache
RUN mkdir /logs

# Start Nginx
RUN echo "Starting nginx..."
# CMD ["nginx", "-g", "daemon off;"]