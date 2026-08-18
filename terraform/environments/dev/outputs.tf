output "vpc_id" {
  description = "ID of the AWS VPC"
  value       = aws_vpc.main.id
}

output "web_server_public_ip" {
  description = "Public IP address of the web server"
  value       = aws_eip.web_server.public_ip
}

output "web_server_public_dns" {
  description = "Public DNS name of the web server"
  value       = aws_instance.web_server.public_dns
}
