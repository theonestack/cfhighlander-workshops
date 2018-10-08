## Step 3 - Nginx ECS Service

In this step, you will be adding

### Add the ECS service component

Add following DSL statement to your highlander template in `workshop.cfhighlander.rb`

```ruby
  Component 'ecs-service@1.7.0'
```

### Configure the ECS service component

The ECS service requires a target group in order to add the nginx task to the loadbalancer.
The loadbalancer template creates a default target group which we will use for this task.
using the method `cfout(template.output)` we will grab the output reference from the loadbalancer template
and pass into the ecs-service for the parameter `TargetGroup`.

```ruby
  Component template: 'ecs-service@1.7.0', name: 'ecs-service' do
    parameter name:'TargetGroup', value:cfout('loadbalancer.defaultTargetGroup')
  end
```

Next we'll need to setup the task definition by creating `ecs-service.config.yaml`.
We'll set up the basic task definition using the following config.

```yaml
cpu: 512
memory: 256

task_definition:
  nginx:
    image: nginx
```

### Update workshop stack

To update the stack, reiterate the instructions from step1

- Compile and validate the template using `cfcompile --validate` command
- Publish the template to S3 using `cfpublish workshop` command
- Use the output information to copy template S3 url, and update the workshop
  stack

## Testing nginx

We'll need to find the public DNS of the loadbalancer and paste that into your browser.
You should see `Welcome to Nginx` popup. 
