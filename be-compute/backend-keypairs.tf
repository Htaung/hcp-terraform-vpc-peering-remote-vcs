locals {
  be_private_key_filename = "${var.backend_prefix}-ssh-key.pem"
}


resource "tls_private_key" "be_keypair" {
  algorithm = "ED25519"
}

resource "aws_key_pair" "be_keypair" {
  key_name   = local.be_private_key_filename
  public_key = tls_private_key.be_keypair.public_key_openssh
}


# 3. Store the private key in Secrets Manager
resource "aws_secretsmanager_secret" "be_key" {
  name        = "${local.be_private_key_filename}-private"
  description = "Private SSH key for ${var.backend_prefix} EC2 instances"

  # 0 = delete immediately on destroy. Without this, the name stays reserved
  # for 7-30 days and re-creating the secret fails with "scheduled for deletion".
  # Use 7-30 in production.
  recovery_window_in_days = 0

  tags = {
    Name = local.be_private_key_filename
  }
}

resource "aws_secretsmanager_secret_version" "be_key" {
  secret_id     = aws_secretsmanager_secret.fe_key.id
  secret_string = tls_private_key.be_keypair.private_key_openssh
}