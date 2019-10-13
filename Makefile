run: jupyter

build-and-run:
	$(MAKE) jupyter-image
	$(MAKE) jupyter

stop:
	docker stop devfest_jupyter devfest_gitbase devfest_bblfshd \
		> /dev/null 2>&1 || true

bblfshd:
	docker start devfest_bblfshd > /dev/null 2>&1 \
		|| docker run \
			--detach \
			--rm \
			--name devfest_bblfshd \
			--privileged \
			--publish 9432:9432 \
			--memory 2G \
			bblfsh/bblfshd:v2.15.0-drivers \
			--log-level DEBUG

gitbase: bblfshd
	docker start devfest_gitbase > /dev/null 2>&1 \
		|| docker run \
			--detach \
			--rm \
			--name devfest_gitbase \
			--publish 3306:3306 \
			--link devfest_bblfshd:devfest_bblfshd \
			--env BBLFSH_ENDPOINT=devfest_bblfshd:9432 \
			--env MAX_MEMORY=1024 \
			--volume $(PWD)/repos:/opt/repos \
			srcd/gitbase:v0.24.0-rc2

jupyter-image:
	docker build -t devfest .

jupyter: gitbase bblfshd
	docker start devfest_jupyter > /dev/null 2>&1 \
		|| docker run \
		    --rm \
		    --name devfest_jupyter \
		    --publish 8888:8888 \
		    --link devfest_bblfshd:devfest_bblfshd \
		    --link devfest_gitbase:devfest_gitbase \
		    --volume $(PWD)/notebooks:/devfest/notebooks \
		    --volume $(PWD)/repos:/devfest/repos \
		    devfest


.PHONY: run build-and-run stop bblfshd gitbase jupyter-image jupyter