resource "aws_backup_vault" "vault" {
  name = "jenkins-backup-vault"
}

resource "aws_backup_plan" "plan" {
  name = "jenkins-backup-plan"

  rule {
    rule_name         = "daily-backup"
    target_vault_name = aws_backup_vault.vault.name
    schedule          = "cron(0 12 * * ? *)"
  }
}

resource "aws_backup_selection" "jenkins_backup_selection" {
  iam_role_arn = aws_iam_role.backup_role.arn
  plan_id      = aws_backup_plan.plan.id
  name         = "jenkins-backup"

  resources = [
    "arn:aws:ec2:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:volume/${var.volume_id}"
  ]
}

resource "aws_iam_role" "backup_role" {
  name = "jenkins-backup-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Action    = "sts:AssumeRole",
      Effect    = "Allow",
      Principal = {
        Service = "backup.amazonaws.com",
      },
    }],
  })

  tags = {
    Name = "jenkins-backup-role"
  }
}

resource "aws_iam_role_policy_attachment" "backup_role_attachment" {
  role       = aws_iam_role.backup_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSBackupServiceRolePolicyForBackup"
}
