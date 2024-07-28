# Checklist before push

- [ ] Remember to add a .gitignore file and make sure your .env file is included in your ignore list.
  - Having your .env file in your git will result in a failed project.
- [ ] 






### Notes
  - A daemon can be used to manage your docker infrastructure, but docker has its own built in way of restarting and managing restarts for your containers.
    - you will define these rules in the docker-compose.yml file.
    - Will look something liek this:

      ```docker-compose.yml
      services:
        nginx:
          image: nginx:latest
          restart: unless-stopped
          ports:
            - "80:80"

        wordpress:
          image: wordpress:latest
          restart: unless-stopped
          environment:
            WORDPRESS_DB_HOST: db
            WORDPRESS_DB_USER: exampleuser
            WORDPRESS_DB_PASSWORD: examplepass
            WORDPRESS_DB_NAME: exampledb
          ports:
            - "8080:80"

        db:
          image: mysql:5.7
          restart: unless-stopped
          environment:
            MYSQL_DATABASE: exampledb
            MYSQL_USER: exampleuser
            MYSQL_PASSWORD: examplepass
            MYSQL_ROOT_PASSWORD: rootpass
          volumes:
            - db_data:/var/lib/mysql

      volumes:
        db_data:
      ```


  - Can change local ip address for host by editing the `/etc/hosts` file.
    - Just change from localhost to `dpentlan.42.fr`
  - version: '3.8'
