output "iam_user_name" {
  value = aws_iam_user.user.name
}

output "policy_arn" {
  value = aws_iam_policy.policy.arn
}

output "iam_group_name" {
  value = aws_iam_group.group.name
}

output "gp_policy_arn" {
  value = aws_iam_policy.gp_policy.arn
}

output "custom_policy_arn" {
  value = aws_iam_policy.custom_policy.arn
}


