# 5. Outputs: no private key output needed anymore
output "fe_key_secret_name" {  
  description = "Secrets Manager secret holding the SSH private key"
  value       = aws_secretsmanager_secret.fe_key.name
}

output "fe_key_secret_arn" {
  value = aws_secretsmanager_secret.fe_key.arn
}


output "frontend_public_instance_public_ip" {
  description = "Public IP of the frontend instance"
  value       = aws_instance.frontend_public_instance01.public_ip
}

output "frontend_public_instance_public_dns" {
  description = "Public DNS of the frontend instance"
  value       = aws_instance.frontend_public_instance01.public_dns
}

output "frontend_private_instance01_private_ip" {
  description = "Private IP of the frontend private instance 01"
  value       = aws_instance.frontend_private_instance01.private_ip
}

output "frontend_private_instance02_private_ip" {
  description = "Private IP of the frontend private instance 02"
  value       = aws_instance.frontend_private_instance02.private_ip
}

output "frontend_private_instance03_private_ip" {
  description = "Private IP of the frontend private instance 03"
  value       = aws_instance.frontend_private_instance03.private_ip
}