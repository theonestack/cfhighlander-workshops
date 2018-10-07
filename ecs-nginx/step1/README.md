## Step 1

### Create simple template including VPC

In this step you will

1) Create minimal cfhighlander template including vpc component
2) Compile and inspect cloudformation template out of this template
3) Publish compiled cloudformation
4) Create cloudformation stack from published template

#### Compile basic template

Create a template file named `workshop.cfhighlander.rb` in same directory
where docker container is started (it is mounted into `/src`) on the docker
container.

```ruby
CfhighlanderTemplate do
  Component 'vpc' do
    parameter name:'DnsDomain', value: 'workshop.cfhighlander.info'
  end
end
```

On the docker container execute following to compile the template

```shell
cfcompile workshop --validate
```

This will automatically resolve and download vpc component source code into
`/root/.cfhighlander/components` directory. It will also create mappings file
for regions and availability zones tied to your aws account. Compiled cloudformation
is validated as `--validate` flag has been passed to cfhighlander command

This command will fail if you haven't mounted aws credentials into docker container

#### Inspect compiled template

Highlander compilation process created several files in `out` folder - let's
inspect final vpc template in `out/yaml/vpc.compiled.yaml`

Under `Resources` key you will see all of the resources generated from vpc
component.

#### Publish compiled template to S3

Cfhighlander can automatically publish compiled template using `cfpublish`

You can inspect all of the available command line options using `cfhighlander help cfpublish`
This command will implicitly invoke `cfcompile` before publishing the template

```bash
$ cfpublish workshop --validate
```

Look for the line in the output that states

#### Create cloudformation stack out of it

Search for the following line in the `cfpublish` command output

```text
Use following url to launch CloudFormation stack

https://console.aws.amazon.com/cloudformation/home.....
### rest of the output
```

Copy and paste (or click if your terminal window allows you so)
the web console link, while logged in your AWS console.

You will be presented with CloudFormation quick launch form.
Use values below as parameter values, leaving others unchanged

```
EnvironmentName=workshop
EnvironmentType=development
vpcMaxNatGateways=1
```

#### Extra

1. Browse through created cloudformation stack and VPC resources created.
Inspect the CIDRs of the created subnets and their routes and route tables

2. Inspect `out/yaml/workshop.compiled.yaml` template and how are the parameters
wired to VPC template

3. Inspect `out/config/vpc.config.yaml` configuration file for vpc component
