#### Retrieving key

aws secretsmanager get-secret-value \
  --secret-id frontend-ssh-key-private \
  --query SecretString \
  --output text \
  --region <your-region> > fe-ssh-key.pem

chmod 400 fe-ssh-key.pem
ssh -i fe-ssh-key.pem ec2-user@<public-ip>