# 参考: https://devcenter.heroku.com/ja/articles/heroku-cli
install-heroku-cli:
	brew tap heroku/brew && brew install heroku

heroku-remote-add:
	heroku git:remote -a heroku-docker-deploy-tutorial

start:
	@make heroku-login \
	&& make heroku-container-login \
	&& make heroku-container-push \
	&& make heroku-container-release \
	&& make heroku-open

finish:
	@make heroku-container-rm \
	&& make docker-rmi

# 参考: https://devcenter.heroku.com/ja/articles/heroku-cli#get-started-with-the-heroku-cli
heroku-login:
	heroku login

# 参考: https://devcenter.heroku.com/ja/articles/container-registry-and-runtime#getting-started
heroku-container-login:
	heroku container:login

# 参考: https://devcenter.heroku.com/ja/articles/container-registry-and-runtime#building-and-pushing-image-s
heroku-container-push:
	docker buildx build . --platform linux/amd64 -t nginx_sample:latest \
	&& docker tag nginx_sample registry.heroku.com/heroku-docker-deploy-tutorial/web \
	&& docker push registry.heroku.com/heroku-docker-deploy-tutorial/web

# 参考: https://devcenter.heroku.com/ja/articles/container-registry-and-runtime#releasing-an-image
heroku-container-release:
	heroku container:release web

heroku-container-rm:
	heroku container:rm web

docker-rmi:
	docker rmi registry.heroku.com/heroku-docker-deploy-tutorial/web \
	&& docker rmi nginx_sample

heroku-caontainer-run:
	heroku container:run web bash

heroku-open:
	heroku open

heroku-logs:
	heroku logs
