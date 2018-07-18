
default:
	@echo "INSTANCE_ID=${INSTANCE_ID} INSTANCE_DNS=${INSTANCE_URL}"


rsync:
	@echo "-- RSYNC ----------------"
	rsync \
		--exclude='.git/' \
		--update -rv \
		-e "ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i ~/.ssh/monad-aws-us-west-2.pem" \
		--progress . centos@${INSTANCE_URL}:/home/centos/aws-fpga

ec2_start:
	@echo "-- EC2 START -----------------"
	aws --profile 500 --region us-west-2 ec2 start-instances --instance-ids ${INSTANCE_ID}
ec2_stop:
	@echo "-- EC2 STOP ---------------------"
	aws --profile 500 --region us-west-2 ec2 stop-instances --instance-ids ${INSTANCE_ID}
ec2_status:
	@echo "-- EC2 STATUS --------------------"
	aws --profile 500 --region us-west-2 ec2 describe-instance-status --instance-ids ${INSTANCE_ID}
ec2_connect:
	@echo "-- EC2 CONNECT --------------------"
	ssh -i ~/.ssh/monad-aws-us-west-2.pem centos@${INSTANCE_URL}

clean:
	@echo "-- CLEAN -----------"
	@echo "nonthing to clean ... "
