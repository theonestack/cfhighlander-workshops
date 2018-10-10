## Step 2 - Bastion

In this step, you will be adding bastion component
to cfhighlander template, configure it for SSH connection
with your own key, and update the stack.


### Generate SSH keypair and upload to ec2

Use `ssh-keygen` command to generate RSA private/public keypair to connect to
bastion in your work directory

```
$ ssh-keygen -t rsa -b 4096 -f workshop -N ''
```

Use aws cli provided with the docker image to upload the key to aws.

```
$ aws ec2 import-key-pair --key-name awstoolsworkshop --public-key-material file://workshop.pub
```


### Add bastion component

Add following DSL statement to your highlander template in `workshop.cfhighlander.rb`

```
  Component name:'bastion', template:'bastion@1.2.0'
```

Your cfhighlander template should now include both vpc and bastion components.

### Configure bastion component

Bastion component accepts `KeyName` parameter, which can be supplied in component's context.
Alter your component definition to include the parameter value. Also, `DnsDomain` parameter
should be provided explicitly

```
  Component name:'bastion', template:'bastion@1.2.0' do
    parameter name:'DnsDomain', value: 'workshop.cfhighlander.info'
    parameter name:'KeyName', value:'awstoolsworkshop'
  end
```

There are also `InstanceType` and `Ami` parameters - you can either give values
to these parameters explicitly, when updating the stack, or hardcode it in the
template, like `KeyName` parameter above.


As for static, compile-time configuration, you can edit security group ingress
rules of the bastion component. To do so, place `bastion.config.yaml` configuration
file next to template file. 

```
ip_blocks:
  public:
  - 0.0.0.0/0

securityGroups:
  -
    rules:
      -
        IpProtocol: tcp
        FromPort: 22
        ToPort: 22
    ips:
      - local
      - public
```

*Tip:* You can use [Amazon Linux AMI](https://aws.amazon.com/amazon-linux-ami/2018.03-release-notes/)
to populate `bastion`


### Update workshop stack

To update the stack, reiterate the instructions from step1

- Compile and validate the template using `cfcompile --validate` command
- Publish the template to S3 using `cfpublish workshop` command
- Use the output information to copy template S3 url, and update the workshop
  stack

### Connect to bastion host

Visit the EC2 web console and search for `dev-bastion-xx` instance. Copy the public elastic IP
address

```
ssh -i workshop ec2-user@3.120.214.61
```

### Extra

Inspect `out/yaml/workshop.compiled.yaml` template to see how  is the parameter
being passed from outer to inner component
