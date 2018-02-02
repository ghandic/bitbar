#!/bin/bash
# <bitbar.title>Open Notebooks</bitbar.title>
# <bitbar.version>v1.0</bitbar.version>
# <bitbar.author.github>ghandic</bitbar.author.github>
# <bitbar.author>AndyChallis</bitbar.author>
# <bitbar.desc>Opens the default broswer on port docker container is running at for notebooks</bitbar.desc>

export PATH="/usr/local/bin:/usr/bin:$PATH"

if [[ "$1" = "jupyter" ]]; then

	if [ ! "$(docker ps -q -f name=notebook)" ]; then
	    if [ "$(docker ps -aq -f status=exited -f name=notebook)" ]; then
	        # cleanup
	        docker rm notebook
	    fi
	    # run your container
	    docker run -d -p 8888 --name notebook -v ~:/home/jovyan/work jupyter/scipy-notebook start-notebook.sh --NotebookApp.token='' --NotebookApp.iopub_data_rate_limit=1000000000000000 
	fi
	
	JUPYTER_PORT=`docker inspect --format '{{ (index (index .NetworkSettings.Ports "8888/tcp") 0).HostPort }}' notebook`

	until $(curl --silent localhost:$JUPYTER_PORT); do
		printf '.'
		sleep 0.1
	done
	open http://localhost:$JUPYTER_PORT

fi

if [[ "$1" = "rstudio" ]]; then

	if [ ! "$(docker ps -q -f name=rstudio)" ]; then
	    if [ "$(docker ps -aq -f status=exited -f name=rstudio)" ]; then
	        # cleanup
	        docker rm rstudio
	    fi
	    # run your container
	    docker run -d -p 8787 --name rstudio -v ~:/home/rstudio rocker/geospatial 
	fi
	
	RSTUDIO_PORT=`docker inspect --format '{{ (index (index .NetworkSettings.Ports "8787/tcp") 0).HostPort }}' rstudio`

	until $(curl --output /dev/null --silent --head --fail localhost:$RSTUDIO_PORT); do
		printf '.'
		sleep 0.1
	done
	open http://localhost:$RSTUDIO_PORT

fi

if [[ "$1" = "quit" ]]; then

	docker rm -f notebook rstudio

fi



echo "📓"
echo "---"
echo "Jupyter notebook| bash='$0' param1=jupyter terminal=false refresh=true templateImage=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"
echo "Rstudio | bash='$0' param1=rstudio terminal=false refresh=true templateImage=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"
echo "❌ Close all | bash='$0' param1=quit terminal=false refresh=true"



