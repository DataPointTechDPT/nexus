resource "aws_security_group" "rds_sg" {
  name        = "nexus-rds-sg"
  description = "Allow traffic from NestJS app"
}

resource "aws_security_group_rule" "rds_ingress_internal" {
  type                     = "ingress"
  from_port                = 5432
  to_port                  = 5432
  protocol                 = "tcp"
  security_group_id        = aws_security_group.rds_sg.id
  source_security_group_id = data.aws_security_group.eb_sg.id
}

resource "aws_security_group_rule" "rds_ingress_external" {
  type              = "ingress"
  from_port         = 5432
  to_port           = 5432
  protocol          = "tcp"
  security_group_id = aws_security_group.rds_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_security_group_rule" "rds_egress" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = "-1"
  security_group_id = aws_security_group.rds_sg.id
  cidr_blocks       = ["0.0.0.0/0"]
}

resource "aws_db_instance" "postgres" {
  identifier = "nexus-db-instance"
  allocated_storage          = 20
  engine                     = "postgres"
  engine_version             = "16"
  instance_class             = "db.t4g.micro"
  db_name                    = var.db_name
  username                   = var.db_user
  password                   = var.db_password
  parameter_group_name       = "default.postgres16"
  skip_final_snapshot        = true
  publicly_accessible        = true
  vpc_security_group_ids     = [aws_security_group.rds_sg.id]
  auto_minor_version_upgrade = true
}

data "aws_security_group" "eb_sg" {
  filter {
    name   = "tag:elasticbeanstalk:environment-id"
    values = [aws_elastic_beanstalk_environment.env.id]
  }

  filter {
    name   = "group-name"
    values = ["*AWSEBSecurityGroup*"]
  }
}
