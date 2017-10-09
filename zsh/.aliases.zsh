alias config=subl $ZSH_CONFIG
alias services="cd ~/.pref/services"

##
# Services
##
cdl(){
	cd $1 && ls -lhGoALS ./
}

# XenOrchestra
xo(){
	if [ -z "$1" ]; then
		open http://localhost:8000
	elif [ "$1" = "run" ]; then
  	services && \
  	docker-compose -f xo.yaml up -d	
	elif [ "$1" = "stop" ]; then
  	services && \
  	docker-compose -f xo.yaml stop xo
  elif [ "$1" = "start" ]; then
  	services && \
  	docker-compose -f xo.yaml start xo
  elif [ "$1" = "end" ]; then
  	services && \
  	docker-compose -f xo.yaml down
	else
		echo "Invalid flag"
	fi
}

# Guacamole 
guac(){
	if [ -z "$1" ]; then
		open http://localhost:8080
	elif [ "$1" = "run" ]; then
  	services && \
  	docker-compose -f guac.yaml up -d	
	elif [ "$1" = "stop" ]; then
  	services && \
  	docker-compose -f guac.yaml stop guac
  elif [ "$1" = "start" ]; then
  	services && \
  	docker-compose -f guac.yaml start guac
  elif [ "$1" = "end" ]; then
  	services && \
  	docker-compose -f guac.yaml down
	else
		echo "Invalid flag"
	fi
}

# ##
# CLI Utilities
##

# AWS CLI Utility
alias aws-cli="docker run -it \
		--rm \
		--name=aws-cli \
		-e AWS_ACCESS_KEY_ID=$AWS_KEY \
		-e AWS_SECRET_ACCESS_KEY=$AWS_SECRET \
		-e AWS_DEFAULT_REGION=$AWS_REGION \
		-v $(pwd):/aws \
		mayankt/aws-cli"
alias aws_end="docker rm -f aws-cli"
aws(){
	if [[ -n $( docker ps | grep aws-cli ) ]]; then
	  docker rm -f aws-cli && \
	  aws-cli
	else
		aws-cli
	fi
}

alias sandbox-cli="docker run \
		--name=sandbox \
		--privileged \
		-it \
		--rm \
		-v $(pwd):/data \
		-p 127.0.0.1:9000-9010:9000-9010/tcp \
		mayankt/backdoor:sandbox"
alias sandbox_end="docker rm -f sandbox"
sandbox(){
	if [[ -n $( docker ps | grep sandbox ) ]]; then
	  docker rm -f sandbox && \
	  sandbox-cli
	else
			sandbox-cli
	fi
}

# Resume-cli
alias resume="docker run -it --rm -v $(pwd):/data mayankt/resume resume"