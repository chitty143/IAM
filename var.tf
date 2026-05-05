variable "aws_region" {
  type    = string
  default = "ap-south-2"
}

variable "iam_user_name" {
  description = "Name of the IAM user"
  type        = string
  default     = "cva"
}

variable "policy_name" {
  description = "Name of the IAM policy"
  type        = string
  default     = "cva_policy"
}

variable "group_name" {
  description = "Name of the IAM group"
  type        = string
  default     = "cva-group"
}

variable "gp_policy_name" {
  description = "Name of the IAM group policy"
  type        = string
  default     = "cva-gp-policy"
}

variable "role_name" {
  description = "IAM role name"
  type        = string
  default     = "custom-lambda-sqs-sns-role"
}

variable "custom_policy_name" {
  description = "IAM policy name"
  type        = string
  default     = "LambdaSQSSNSPolicy"
}

