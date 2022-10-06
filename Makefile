default: run

JEKYLL := docker run --rm \
  --net=host \
  --user $(id -u):$(id -g) \
  -v `pwd`/site:/srv/jekyll \
  -v `pwd`/bundle:/usr/local/bundle \
  -it jekyll/builder:4.0

AWS := docker run --rm \
  --net=host \
  --user $(id -u):$(id -g) \
  -e "AWS_SHARED_CREDENTIALS_FILE=/aws-config/credentials" \
  -e "AWS_CONFIG_FILE=/aws-config/config" \
  -v /home/derek/.aws:/aws-config \
  -v `pwd`/site/_site:/site \
  -it garland/aws-cli-docker

.PHONY: run
run:
	$(JEKYLL) jekyll serve --port 4005 --drafts  

.PHONY: prod
prod:
	$(JEKYLL) jekyll build && $(AWS) aws --profile hostingevil s3 sync /site s3://hostingevilpodcast.com --cache-control max-age=1800

.PHONY: preview
preview:
	$(JEKYLL) jekyll build && $(AWS) aws --profile hostingevil s3 sync /site s3://preview.hostingevilpodcast.com --cache-control max-age=1800

.PHONY: get
get:
	wget https://github.com/jekyller/jasper2/archive/master.zip \
    && unzip master.zip \
    && rm master.zip \
    && mv jasper2-master site
