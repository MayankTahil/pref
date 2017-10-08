alias config=subl $ZSH_CONFIG
alias services="cd ~/.pref/services"

##
# Services
##

# XenOrchestra
alias xo_run="services && \
			docker-compose -f xo.yaml up -d &&\
			sleep 5 && \
			open http://localhost:8000"
alias xo="open http://localhost:8000"
alias xo_stop="services && docker-compose -f xo.yaml stop xo"
alias xo_start="services && docker-compose -f xo.yaml start xo"
alias xo_end="services && docker-compose -f xo.yaml down xo"

# Guacamole 
alias guac_run="services && \
			docker-compose -f guac.yaml up -d &&\
			sleep 5 && \
			open http://localhost:8080"
alias guac="open http://localhost:8080"
alias guac_stop="services && docker-compose -f guac.yaml stop guac"
alias guac_start="services && docker-compose -f guac.yaml start guac"
alias guac_end="services && docker-compose -f guac.yaml down guac"

##
# Utilities
##

# AWS CLI
alias aws="docker run -it \
			--rm -e AWS_ACCESS_KEY_ID=$AWS_KEY \
			-e AWS_SECRET_ACCESS_KEY=$AWS_SECRET \
			-e AWS_DEFAULT_REGION=$AWS_REGION \
			-v $(pwd):/aws \
			mayankt/aws-cli"

# Sandbox
alias sandbox="docker run \
			--privileged \
			-it \
			--rm \
			-v $(pwd):/data \
			-p 9000-9010:9000-9010 \
			mayankt/backdoor:sandbox"

# Resume-cli
alias resume="docker run -it --rm -v $(pwd):/data mayankt/resume resume"