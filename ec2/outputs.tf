
output "public_dns" {
  description = "The Public DNS name of the created EC2 instance"
  value       = aws_instance.server.public_dns
}
