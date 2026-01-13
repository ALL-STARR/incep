There are 3 services in this stack
1. NGINX for the server part : handling connections, serving static responses and redirecting requests
2. Wordpress for the website part : creating, editing and managing the website 
3. Mariadb to manage the data wrodpress needs to store

### Instructions
To run and setup the project a script is used which can be launched using the Makefile
- make => will start the script, installing the different containers if they are not yet installed and then start each service
- make blank-start => will uninstall and delete volumes to reinstall and restart the services
- make clean =>will uninstall services and delete volumes

Once everything is running you will be able to connect via a browser to https://thomvan-.42.fr

To stop it just press ctrl + c in the terminal

The usernames and emails are declared in the .env file located in the ./srcs folder as for the secrets they are located on the host machine at /home/userthom/vault as .txt files you will need those to access the control panel of the website.

to log in go to https://thomvan-.42.fr/wp-admin
using the admin credentials you will be able to access the full control panel but if you use the user you'll get a restricted version

you can check if everything is running by typing docker ps in a new terminal or simply by connecting to the website



