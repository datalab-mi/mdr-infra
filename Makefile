include conf.list

heat-params:
	cd heat-templates/params && /bin/bash run.sh

delete:
	# delete stack
	openstack ${openstack_args} stack delete ${stack_name} --yes --wait
deploy:
	# create stack
	openstack ${openstack_args} stack create \
			-t heat-templates/${heat_template}.yaml \
			-e heat-templates/params/parameters.yaml ${stack_name}

console-log:
	openstack ${openstack_args} console log show ${stack_name}

stack-show:
	openstack ${openstack_args} stack show ${stack_name}

stack-event-list:
	openstack ${openstack_args} stack event list ${stack_name}

ip-server:
	$(eval $(shell openstack ${openstack_args} stack output show -c "output_value" -f shell ${stack_name} "my_instance_ip"))

keypair-delete:
	openstack ${openstack_args} keypair delete ${stack_name}
	rm -f  ${stack_name}.pem

keypair-create:
	openstack ${openstack_args} keypair create ${keyname} > ${keyname}.pem
	chmod 600 ${keyname}.pem

ssh: ip-server
		@echo YOUR SERVER IP IS $(output_value)
		ssh  debian@$(output_value) -i ${keyname}.pem -vv
