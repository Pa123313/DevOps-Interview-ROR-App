resource "aws_db_subnet_group" "main" {
  name       = "ror-app-db-subnet-group"
  subnet_ids = aws_subnet.private[*].id

  tags = {
    Name = "ror-app-db-subnet-group"
  }
}

resource "aws_db_instance" "main" {
  identifier             = "ror-app-db"
  instance_class         = "db.t3.micro"
  allocated_storage      = 20
  engine                 = "postgres"
  engine_version         = "13.4"
  username               = var.db_username
  password               = var.db_password
  db_name                = var.db_name
  db_subnet_group_name   = aws_db_subnet_group.main.name
  vpc_security_group_ids = [aws_security_group.rds.id]
  skip_final_snapshot    = true
  publicly_accessible    = false
  multi_az               = false
}
