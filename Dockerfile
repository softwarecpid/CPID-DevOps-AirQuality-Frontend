# using the latest node alpine base image
FROM node:lts-alpine AS build

# define the working directory as 'app'
WORKDIR /app

# copy to the working directory both 'package.json' and 'package-lock.json' (if available)
COPY package*.json .

# install project dependencies
RUN npm install

# copy all project files to the working directory (i.e. 'app')
COPY . .

# create a production build of the application
RUN rm -rf dist && npm run build

# use an light image to serve the application
FROM nginx:alpine

# copy the nginx necessary files
COPY --from=build /app/dist /usr/share/nginx/html

COPY default.conf /etc/nginx/conf.d/

# expose the port nginx will use (documentation purposes)
EXPOSE 80

# commando to init nginx
CMD ["nginx", "-g", "daemon off;"]
