# EKS - CloudFormation
![Infrastructure](infra.png)

Deploy Kubernetes service to Amazon using cloudformation script

It first requires to create the key-pair "taskKey" in order to be able to access the Bastion Host
```shell script
aws ec2 create-key-pair --key-name taskKey --query "KeyMaterial" --output text > taskKey.pem
chmod 400 taskKey.pem 
```
The cloud formation script creates the *EKS-CheloKube* EKS Cluster into *us-east-1*.

In the params.json file the *RemoteAccessCIDR* defines the ip range in which the bastion host could be ssh. 

```shell script
./deploy-stack.sh kubernetes-test amazon-eks.yaml amazon-eks-params.json us-east-1
```

### SSH to Bastion
```shell script
ssh -i taskKey.pem ec2-user@BASTION_PUBLIC_IP
```

