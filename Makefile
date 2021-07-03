build-docker:
	cd docker && docker build -t nordata/rcore-tutorial-v3:latest .

run-docker:
	@echo "启动Docker"
	@-docker rm rcore-tutorial-v3 -f 2> /dev/null
	@docker run -d -p 2222:22 -v ${PWD}:/app --name rcore-tutorial-v3 nordata/rcore-tutorial-v3:latest
	@echo "IP地址：宿主机IP地址，SSH端口号：2222，用户名：root，密码：root"
