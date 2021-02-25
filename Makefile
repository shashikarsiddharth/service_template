npm-install:
	npm install --silent --progress=false -g yarn

serverless-install:
	npm install --silent --progress=false -g npm
	npm install --silent --progress=false -g serverless
	npm install --silent --progress=false -g serverless-plugin-aws-alerts

serverless-deploy:
	serverless --host=ci --stage=${STAGE} deploy --alias provisioned

check-and-remove-concurrency:
	@if [ $(STAGE) = "dev" ] || [ $(STAGE) = "test" ]; then echo "[INFO] Removing provisioned concurrency attribute from serverless yaml for DEV and TEST env."; sed -i '/provisionedConcurrency/d' serverless.yml; fi;

deploy: npm-install serverless-install check-and-remove-concurrency serverless-deploy

.DEFAULT_GOAL := deploy