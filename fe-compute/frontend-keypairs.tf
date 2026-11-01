locals {
  fe_private_key_filename = "${var.frontend_prefix}-ssh-key.pem"
}

resource "tls_private_key" "fe_keypair" {
  algorithm = "ED25519"
}

resource "aws_key_pair" "fe_keypair" {
  key_name   = local.fe_private_key_filename
  public_key = tls_private_key.fe_keypair.public_key_openssh
}

# 3. Store the private key in Secrets Manager
resource "aws_secretsmanager_secret" "fe_key" {
  name        = "${local.fe_private_key_filename}-private"
  description = "Private SSH key for ${var.frontend_prefix} EC2 instances"

  # 0 = delete immediately on destroy. Without this, the name stays reserved
  # for 7-30 days and re-creating the secret fails with "scheduled for deletion".
  # Use 7-30 in production.
  recovery_window_in_days = 0

  tags = {
    Name = local.fe_private_key_filename
  }
}

resource "aws_secretsmanager_secret_version" "fe_key" {
  secret_id     = aws_secretsmanager_secret.fe_key.id
  secret_string = tls_private_key.fe_keypair.private_key_openssh
}