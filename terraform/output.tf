output "public_ip" {
value = "${aws_instance.web.*.public_ip}"
}

output "rds_endpoint" {
value = "${aws_db_instance.private-db.*.endpoint}"
}
