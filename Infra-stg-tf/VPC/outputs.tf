output "vpc_id" {
  value = aws_vpc.dcshp_vpc.id
}

output "subnet_ids" {
  value = aws_subnet.dcshp_subnet[*].id
}

output "route_table_id" {
  value = aws_route_table.dcshp_route_table.id
}
