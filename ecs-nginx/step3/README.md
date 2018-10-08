## Step 3 - ECS Cluster and service

In this step, you will be adding a ECS cluster component to cfhighlander template.

### Add ECS cluster component

Add following DSL statement to your highlander template in `workshop.cfhighlander.rb`

```ruby
  Component 'ecs@1.2.0'
  Component 'loadbalancer@1.2.2'
```

### Configure ECS cluster component

Same as the bastion, the ECS component accepts `KeyName` parameter, which can be supplied in component's context.
Alter your component definition to include the parameter value. Also, `DnsDomain` parameter
should be provided explicitly

```ruby
  Component 'ecs@1.2.0' do
    parameter name:'DnsDomain', value: 'workshop.cfhighlander.info'
    parameter name:'KeyName', value:'awstoolsworkshop'
  end
```

There are also `InstanceType`, `Ami`, `AsgMin` and `AsgMax` parameters - you can either give values
to these parameters explicitly, when updating the stack, or hardcode it in the
template, like `KeyName` parameter above.


*Tip:* You can use [Amazon ECS Optimised AMI](https://docs.aws.amazon.com/AmazonECS/latest/developerguide/ecs-optimized_AMI.html)
to populate `ecsAMI`

### Configure loadbalancer component

We need to add the `DnsDomain` same as the ECS component.

```ruby
  Component template: 'loadbalancer@1.2.2', name: 'loadbalancer' do
    parameter name:'DnsDomain', value: 'workshop.cfhighlander.info'
  end
```

The loadbalancer component has some defaults that creates a public application loadbalancer, default target group and a http listener.
It also sets up a security group that open up port `80` to `0.0.0.0/0`.
The config looks like the following and can be overridden in loadbalancer.config.yaml

```yaml
loadbalancer_type: application
loadbalancer_scheme: public

ip_blocks:
  public:
    - 0.0.0.0/0

targetgroups:
  default:
    protocol: http
    port: 80
    tags:
      Name: Default-HTTP

listeners:
  http:
    port: 80
    protocol: http
    default_targetgroup: default

securityGroups:
  loadbalancer:
    -
      rules:
        -
          IpProtocol: tcp
          FromPort: 80
          ToPort: 80
      ips:
        - public
```

### Update workshop stack

To update the stack, reiterate the instructions from step1

- Compile and validate the template using `cfcompile --validate` command
- Publish the template to S3 using `cfpublish workshop` command
- Use the output information to copy template S3 url, and update the workshop
  stack
