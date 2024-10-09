# using the latest node alpine base image
FROM node:lts-alpine

# define the working directory as 'app'
WORKDIR /app

# copy to the working directory both 'package.json' and 'package-lock.json' (if available)
COPY package*.json .

# install project dependencies
RUN npm install

# install serve to put the applicatin in web
RUN npm i -g serve

# copy all project files to the working directory (i.e. 'app')
COPY . .

# create a production build of the application
RUN npm run build

# expose the port that the application should be running and serve it
EXPOSE 3000
CMD ["serve", "-s", "dist"]
