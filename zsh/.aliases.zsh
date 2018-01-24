export ZSH_CONF="$HOME/.pref/zsh"
alias config="subl $ZSH_CONF"
alias services="cd $HOME/.pref/services"
alias services_edit="subl $HOME/.pref"
alias pref="cd $HOME/.perf"
export KUBECONFIG="$HOME/.kube/config"
export NOTES="$HOME/Documents/Notes"
export DATA="$HOME/.pref/data"
alias rss-feed="open https://feedly.com/i/my"
alias hub="cd ~/Documents/GitHub/"
alias resource="source $ZSH_CONF/.aliases.zsh"

enter(){
	docker-compose exec $1 bash
}

notes(){
	if [ -z "$1" ]; then
		subl $NOTES
	else
		subl $NOTES
		subl "$NOTES/$1.md"
	fi
}

push(){
	name=$(basename "$1" ".")
	curl -s --upload-file $1 https://transfer.sh/$name | pbcopy
	printf "\n"
}
get(){
	curl -k $1 -o $2 &
}

snooze(){
	sleep $(expr $1 \* 60) && \
	pmset sleepnow
}

##
# CLI Shortcuts
##
cdl(){
	cd $1 && ls -lhGoALS ./
}

##
# Services
##

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
  elif [ "$1" = "exec" ]; then
  	services && \
  	docker-compose -f xo.yaml exec xo bash
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
  elif [ "$1" = "stat" ]; then
  	services && \
  	docker-compose -f guac.yaml logs -t
  elif [ "$1" = "exec" ]; then
  	services && \
  	docker-compose -f guac.yaml exec guac bash
	else
		echo "Invalid flag"
	fi
}

# Docker-in-Docker sandbox environment
sandbox(){
	if [ -z "$1" ]; then
  	services && \
  	docker-compose -f sandbox.yaml run --rm sandbox
	elif [ "$1" = "remove" ]; then
  	services && \
  	docker-compose -f sandbox.yaml down &> /dev/null
	elif [ "$1" = "update" ]; then
  	services && \
  	docker-compose -f sandbox.yaml build && \
  	docker-compose -f sandbox.yaml run --rm sandbox
	fi
}

# Docker Registry 
registry(){
	if [ -z "$1" ]; then
		echo "Please give a command like 'start' or 'stop'"
	elif [ "$1" = "start" ]; then
  	services && \
  	docker-compose -f registry.yaml up -d	
	elif [ "$1" = "stop" ]; then
  	services && \
  	docker-compose -f registry.yaml stop registry.store && \
  	docker-compose -f registry.yaml rm -f registry.store
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
	  aws_end && \
	  aws-cli
	else
		aws-cli
	fi
}

# Ad-Hoc external Sandbox Docker-in-Docker environment
sandbox-cli(){
  if [ -z "$1" ]; then
  	docker run \
		--name=sandbox-cli \
		--privileged \
		-it \
		--rm \
		-v $(pwd):/data \
		-p 127.0.0.1:9000-9010:9000-9010/tcp \
		backdoor:sandbox
  elif [ "$1" = "end" ]; then
  	docker rm -f $(docker ps -aqf "name=sandbox-cli")
  fi
}

# MySQL client CLI
msql-cli(){
  if [ -z "$1" ]; then
  	services && \
  	docker-compose -f mysql-client.yaml run mysql-client sh
  elif [ "$1" = "end" ]; then
  	docker rm -f $(docker ps -aqf "name=sandbox-cli")
  fi
}

lab-cli(){
  if [ -z "$1" ]; then
  	docker run \
		--name=lab-cli \
		--privileged \
		-it \
		--rm \
		-v $HOME/.kube/homelab/config:/root/.kube/config:ro \
		-v $HOME/Documents/Github/:/data \
		-p 127.0.0.1:9020-9030:9020-9030/tcp \
		backdoor:sandbox
  elif [ "$1" = "end" ]; then
  	docker rm -f $(docker ps -aqf "name=lab-cli")
  fi
}

# UI for your local git repository. Must be in the local repository folder to execute successfully
gitwebui(){
	if [ -z "$1" ]; then
		echo "Please give a command like start, stop, or update"
	elif [ "$1" "update"]; then
  	services && \
  	docker build -f git-webui.dockerfile -t mayankt/gitwebui .
  	gitwebui start
	elif [ "$1" = "start" ]; then
		local project="gitweb_${PWD##*/}"
  	docker run -d --name=$project -p 127.0.0.1::8000/tcp -v $(pwd):/data mayankt/gitwebui
  	docker container port $project | grep -o "127.0.0.1:[0-9]*" | 
  	open http://$(docker container port $project | grep -o "127.0.0.1:[0-9]*")
	elif [ "$1" = "stop" ]; then
		local project="gitweb_${PWD##*/}"
  	docker rm -f $project
	elif [ "$1" = "open" ]; then
		local project="gitweb_${PWD##*/}"
  	open http://$(docker container port $project | grep -o "127.0.0.1:[0-9]*")
	else
		echo "Invalid flag"
	fi
}

# Hexo static site builder

alias hexo_server="docker run --rm -v "$PWD:/blog" -p 4000:4000 mayankt/hexo-cli hexo server"
alias hexo_npm="docker run --rm -v "$PWD:/blog" mayankt/hexo-cli npm"
alias hexo="docker run -it --rm -v "$PWD:/blog" mayankt/hexo-cli hexo"

# Hugo static site builder

# alias hugo='docker run --rm -it -v $PWD:/src -u hugo jguyomard/hugo-builder hugo'
# alias hugo-server='docker run --rm -it -v $PWD:/src -p 1313:1313 -u hugo jguyomard/hugo-builder hugo server -D'

# Resume-cli
resume_build(){
	services &&\
	docker build -f json-resume.dockerfile -t json-resume .
}

alias resume_build
alias resume="docker run -it --rm -v $(pwd):/data json-resume resume"
alias coinmon="docker run --rm -ti jaymoulin/coinmon coinmon"

# Kompose cli
alias kompose="docker run -it --rm -v $(pwd):/data mayankt/kompose-cli sh"
alias kompose-update="services && docker build -f kompose.dockerfile -t mayankt/kompose-cli ."

# kubectl cli
kubectl-cli(){
  if [ -z "$1" ]; then
		docker run \
		-it  \
		--rm \
		-v $(pwd):/data \
		-v $KUBECONFIG:/root/.kube/config:ro \
		mayankt/kubectl-cli zsh
  elif [ "$1" = "remove" ]; then
  	docker rm -f $(docker ps -aqf "name=kubectl-cli")
  elif [ "$1" = "update" ]; then
  	services && \
  	docker build \
  	-f \
  	kubectl.dockerfile \
  	-t \
  	mayankt/kubectl-cli .
  fi
}
