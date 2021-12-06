FROM nginx:alpine

RUN rm /etc/nginx/conf.d/*

COPY ./config/default.conf /etc/nginx/conf.d/

CMD [ "nginx", "-g", "daemon off;" ]
