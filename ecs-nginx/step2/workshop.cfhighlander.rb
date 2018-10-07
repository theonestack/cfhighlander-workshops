CfhighlanderTemplate do

  Component template:'vpc@1.5.0',name:'vpc' do
    parameter name:'DnsDomain', value: 'workshop.cfhighlander.info'
  end

  Component template:'bastion@1.2.0', name:'bastion' do
    parameter name:'DnsDomain', value: 'workshop.cfhighlander.info'
    parameter name:'KeyName', value:'awstoolsworkshop'
  end

end
