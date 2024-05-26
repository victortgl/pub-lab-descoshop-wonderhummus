provider "aws" {
  region = var.region
}

resource "aws_db_instance" "dcshp_postgres" {
  allocated_storage    = 20
  engine               = "postgres"
  engine_version       = "16.2"
  instance_class       = "db.t3.micro"
  identifier           = var.db_instance_name           
  username             = var.db_username
  password             = var.db_password
  publicly_accessible  = false
  parameter_group_name = "default.postgres16"
  skip_final_snapshot  = true
  vpc_security_group_ids = var.security_group_ids
  db_subnet_group_name   = aws_db_subnet_group.rds_subnet_group.name
}

resource "aws_security_group" "rds_sg" {
  name = "rds_security_group-prd"

  ingress {
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "rds-dcshp-sg-stg"
  }
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "rds-dcshp-sbt-gp-prd"
  subnet_ids = var.subnet_ids

  tags = {
    Name = "rds-dcshp-sbt-gp-prd"
  }
}