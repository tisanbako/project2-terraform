output "vpc_id" {.
    value = aws_vpc.myvpc.id 
}

output "pub1subnet" {
    value = aws_subnet.public1[*].id
  
}
output "pub2subnet" {
    value = aws_subnet.public2[*].id
  
}

output "prvt2subnet1" {
    value = aws_subnet.private1[*].id
}

output "prvt2subnet2" {
    value = aws_subnet.private2[*].id
}
