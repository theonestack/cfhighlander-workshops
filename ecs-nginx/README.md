## Preparation

For successfull completion of all of the steps you will need Docker
image `theonestack/workshop-tools:light` if you wish to go extra
step (advanced) section below, you will need `theonestack/workshop-tools:full`
Dockerfile.

To pull the docker image, execute below from your shell

```shell
docker pull theonestack/workshop-tools:light
```

To start the docker container from the image with interactive prompt,
execute below from your shell. It will mount your AWS credentials to container

```shell
docker run -it -e AWS_REGION=ap-southeast-2 -e AWS_DEFAULT_REGION=ap-southeast-2 -w /src -v $PWD:/src -v $HOME/.aws:/root/.aws theonestack/workshop-tools:light bash
```

You will also need latest cfhighlander gem, install it using gem command:

```bash
gem install cfhighlander
cfhighlander help
cfhighlander cfcompile
```






## Step 2

- Create local key and upload to AWS
- Add bastion component
- Configure bastion component with custom keypair
- Deploy, update stack, and login to bastion via SSH

## Step 3

- Add ECS component
- Add Loadbalanacer component
- Deploy, update stack, visit the web url

## Step 4

- Add Nginx as service on ECS component
- Deploy, update stack, visit the web url

## Extra Step

- Build custom docker image & push to ECR
- Configure ECS Service component to use custom docker images
