FROM node:16.13.2 as builder

WORKDIR /usr/src/app

COPY . .
RUN ls -la
RUN npm install && npm install -g @angular/cli && ng build
#RUN npm install -g @angular/cli
#RUN ng build

# Handle Nginx
FROM nginx
RUN rm -rf /etc/nginx/conf.d/*
COPY --from=builder /usr/src/app/dist/ /usr/share/nginx/html
COPY distinct.conf /etc/nginx/conf.d/distinct.conf
