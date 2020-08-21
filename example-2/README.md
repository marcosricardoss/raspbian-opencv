# Docker OpenCV

Before you run the container you must run the 'xhost +' command to allows clients connect from any host to the DISPLAY:

`xhost +`<br>
`docker-compose up`<br>

I also added a bash script that encapsulates these two commands:

`bash bin/dev up`<br>
`bash bin/prod up`<br>
`bash bin/staging up`<br>
`bash bin/test up`<br>

Use bash script according to the environment.

**Note**: all of the arguments from `docker-compose` can be passed through the bash script.