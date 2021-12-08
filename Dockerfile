FROM nginx:latest
LABEL maintainer="dalmatialab"

# Create template directory that is capable of reading ENV variables. Copy src template file.
RUN mkdir -p /etc/nginx/templates
WORKDIR /etc/nginx/templates
COPY src/default.conf.template ./

# ENV variable specified for PORT of the desired application. 
ENV APP_PORT="5000"

CMD ["nginx", "-g", "daemon off;"]

