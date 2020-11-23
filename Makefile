include conf.list

heat-params:
	cd heat-templates/params && /bin/bash run.sh

delete:
	# delete stack
	openstack ${openstack_args} stack delete ${stack_name} --yes --wait
deploy:
	# create stack
	openstack ${openstack_args} stack create \
			-t heat-templates/heat.yaml \
			-e heat-templates/params/parameters.yaml ${stack_name}

console-log:
	openstack ${openstack_args} console log show deces_dataprep_server

stack-show:
	openstack ${openstack_args} stack show ${stack_name}

stack-event-list:
	openstack ${openstack_args} stack event list ${stack_name}

ip-server:
	$(eval $(shell openstack ${openstack_args} stack output show -c "output_value" -f shell ${stack_name} "mdr_server_ip"))

keypair-delete:
	openstack ${openstack_args} keypair delete ${stack_name}
	rm -f  ${stack_name}.pem

keypair-create:
	openstack ${openstack_args} keypair create ${stack_name} > ${stack_name}.pem
	chmod 600 ${stack_name}.pem

ssh: ip-server
		@echo YOUR SERVER IP IS $(output_value)
		#ssh -o ProxyCommand="ssh -A cloud-bastion-Z2 -W %h:%p" debian@$(output_value)
		#ssh -o ProxyCommand="ssh  -W %h:%p cloud-bastion-Z2"  -i ~/.ssh/browser  debian@$(output_value)
		#ssh  -Ao ProxyCommand="ssh-add && ssh -W %h:%p cloud-bastion-Z2" debian@$(output_value)
		ssh  debian@146.59.200.26 -i  ${stack_name}.pem -vv
