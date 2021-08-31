output "AWS_account_ID" {
  value       = data.aws_caller_identity.current.account_id
}
output "AWS_User_ID" {
  value       = data.aws_caller_identity.current.user_id
}
output "AWS_region" {
  value       = data.aws_region.current
}
output "AWS_Private_IP" {
  value       = resource.aws_instance.web.private_ip
}
output "AWS_Subnet_ID" {
  value       = resource.aws_instance.web.subnet_id
}

