provider "aws" {
  region     = var.region
  access_key = var.access_key
  secret_key = var.secret_key
}
# Creating VPC,name, CIDR and Tags
resource "aws_vpc" "dev" {
  cidr_block = var.cidr_block_vpc
  # instance_tenancy     = "default"
  # enable_dns_support   = "true"
  # enable_dns_hostnames = "true"
  # enable_classiclink   = "false"
  tags = {
    Name = var.vpc_name_tag
  }
}

# Creating Public Subnets in VPC
resource "aws_subnet" "dev-public-1" {
  vpc_id     = aws_vpc.dev.id
  cidr_block = var.cidr_block_public_1
  # map_public_ip_on_launch = "true"
  availability_zone = var.az_public_1

  tags = {
    Name = var.public_1_name_tag
  }
}

resource "aws_subnet" "dev-public-2" {
  vpc_id     = aws_vpc.dev.id
  cidr_block = var.cidr_block_public_2
  # map_public_ip_on_launch = "true"
  availability_zone = var.az_public_2

  tags = {
    Name = var.public_2_name_tag
  }
}
resource "aws_subnet" "dev-public-3" {
  vpc_id     = aws_vpc.dev.id
  cidr_block = var.cidr_block_public_3
  # map_public_ip_on_launch = "true"
  availability_zone = var.az_public_3

  tags = {
    Name = var.public_3_name_tag
  }
}

# Creating Private Subnets in VPC
resource "aws_subnet" "dev-private-1" {
  vpc_id     = aws_vpc.dev.id
  cidr_block = var.cidr_block_private_1
  # map_public_ip_on_launch = "true"
  availability_zone = var.az_private_1

  tags = {
    Name = var.private_1_name_tag
  }
}

resource "aws_subnet" "dev-private-2" {
  vpc_id     = aws_vpc.dev.id
  cidr_block = var.cidr_block_private_2
  # map_public_ip_on_launch = "true"
  availability_zone = var.az_private_2

  tags = {
    Name = var.private_2_name_tag
  }
}
resource "aws_subnet" "dev-private-3" {
  vpc_id     = aws_vpc.dev.id
  cidr_block = var.cidr_block_private_3
  # map_public_ip_on_launch = "true"
  availability_zone = var.az_private_3

  tags = {
    Name = var.private_3_name_tag
  }
}

# Creating Internet Gateway in AWS VPC
resource "aws_internet_gateway" "dev-gw" {
  vpc_id = aws_vpc.dev.id

  tags = {
    Name = var.internet_gateway_name_tag
  }
}

# Creating Public Route Tables for Internet gateway
resource "aws_route_table" "dev-public" {
  vpc_id = aws_vpc.dev.id
  route {
    cidr_block = var.cidr_block_public_route_table
    gateway_id = aws_internet_gateway.dev-gw.id
  }

  tags = {
    Name = var.public_route_table_name_tag
  }
}

# Creating Route Associations public subnets
resource "aws_route_table_association" "dev-public-1-a" {
  subnet_id      = aws_subnet.dev-public-1.id
  route_table_id = aws_route_table.dev-public.id
}

resource "aws_route_table_association" "dev-public-2-a" {
  subnet_id      = aws_subnet.dev-public-2.id
  route_table_id = aws_route_table.dev-public.id
}

resource "aws_route_table_association" "dev-public-3-a" {
  subnet_id      = aws_subnet.dev-public-3.id
  route_table_id = aws_route_table.dev-public.id
}

# Creating Private Route Tables for Internet gateway
resource "aws_route_table" "dev-private" {
  vpc_id = aws_vpc.dev.id
  route {
    cidr_block = var.cidr_block_private_route_table
    gateway_id = aws_internet_gateway.dev-gw.id
  }

  tags = {
    Name = var.private_route_table_name_tag
  }
}

# Creating Route Associations Private subnets
resource "aws_route_table_association" "dev-private-1-a" {
  subnet_id      = aws_subnet.dev-private-1.id
  route_table_id = aws_route_table.dev-private.id
}

resource "aws_route_table_association" "dev-private-2-a" {
  subnet_id      = aws_subnet.dev-private-2.id
  route_table_id = aws_route_table.dev-private.id
}

resource "aws_route_table_association" "dev-private-3-a" {
  subnet_id      = aws_subnet.dev-private-3.id
  route_table_id = aws_route_table.dev-private.id
}

resource "aws_iam_policy" "demo_policy" {
  name        = "demo-policy"
  description = "Demo IAM policy for S3 bucket access"
  policy      = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow"
        Action   = ["s3:GetObject"]
        Resource = "${aws_s3_bucket.demo_bucket.arn}/*"
      },
      {
        Effect   = "Allow"
        Action   = ["s3:PutObject"]
        Resource = "${aws_s3_bucket.demo_bucket.arn}/*"
      }
    ]
  })
}
resource "aws_iam_policy" "demo_policy1" {
  name        = "demo-policy1"
  description = "Policy for CloudWatch Agent"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid      = "CloudWatchLogsPolicy"
        Effect   = "Allow"
        Action   = [
          "cloudwatch:*",
          "logs:CreateLogGroup",
          "logs:CreateLogStream",
          "logs:PutLogEvents",
          "logs:DescribeLogStreams"

        ]
        Resource = "*"
      },
      {
        Sid      = "EC2DescribeInstancesPolicy"
        Effect   = "Allow"
        Action   = [
          "ec2:DescribeInstances"
        ]
        Resource = "*"
      }
    ]
  })
}


resource "aws_iam_role" "demo_role" {
  name = "demo-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect    = "Allow"
        Principal = { Service = "ec2.amazonaws.com" }
        Action    = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "demo_policy_attachment" {
  policy_arn = aws_iam_policy.demo_policy.arn
  role       = aws_iam_role.demo_role.name
}
resource "aws_iam_role_policy_attachment" "demo_policy_attachment1" {
  policy_arn = aws_iam_policy.demo_policy1.arn
  role       = aws_iam_role.demo_role.name
}


resource "aws_iam_instance_profile" "demo_instance_profile" {
  name = "demo-instance-profile"
  role = aws_iam_role.demo_role.name
}

# Define the S3 bucket
resource "aws_s3_bucket" "demo_bucket" {
  bucket = "webapp6172596647"
  
  # Ensure that the bucket is private
  acl = "private"
  
  # Enable server-side encryption
  server_side_encryption_configuration{
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
  
  # Set a lifecycle policy to transition objects to standard_IA storage class after 30 days
  lifecycle_rule {
    id      = "standard_ia_transition"
    enabled = true # Add this line to fix the error
    
    
    transition {
      days          = 30
      storage_class = "STANDARD_IA"
    }
    
    # Apply the transition to all objects in the bucket
    prefix = ""
  }
}

resource "aws_s3_bucket_policy" "demo_bucket_policy" {
  bucket = aws_s3_bucket.demo_bucket.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = "*",
        Action= "s3:*",
        Resource = [
          "${aws_s3_bucket.demo_bucket.arn}/*",
          "${aws_s3_bucket.demo_bucket.arn}"
        ]
      }
    ]
  })
}

resource "aws_db_subnet_group" "db_subnet_group" {
  name       = "my-db-subnet-group"
  subnet_ids = [aws_subnet.dev-public-1.id, aws_subnet.dev-public-2.id]
}

resource "aws_db_parameter_group" "custom_parameter_group" {
  name        = "custom-rds-db-parameter-group"
  family      = "postgres13"
  description = "Custom DB Parameter Group for RDS instance"
  
  parameter {
    name  = "max_connections"
    value = "100"
    apply_method = "pending-reboot"
  }
  
  parameter {
    name  = "shared_buffers"
    value = "128"
    apply_method = "pending-reboot"
  }
}


# Define the Database Server Security Group
resource "aws_security_group" "db_server_sg" {
  name_prefix = "db_server_sg_"
  description = "Security Group for Database Servers"
  vpc_id      = aws_vpc.dev.id
  
  # Only allow incoming traffic from the Application Server Security Group
   ingress {
    from_port = 5432
    to_port = 5432
    protocol = "tcp"
    # cidr_blocks = ["0.0.0.0/0"]
    security_groups = [aws_security_group.dev.id]
  }
  egress {
    from_port = 0
    to_port = 0
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # security_groups = [aws_security_group.dev.id]
  }
}

resource "aws_kms_key" "rds_encryption_key" {
  description             = "RDS encryption key"
  enable_key_rotation     = true
  deletion_window_in_days = 30
}


# Define the RDS Instance
resource "aws_db_instance" "rds_instance" {
  engine               = "postgres"
  port = 5432
  storage_encrypted = true
  engine_version       = "13.4"
  instance_class       = "db.t3.micro"
  allocated_storage    = 20
  max_allocated_storage = 100
  storage_type         = "gp2"
  name                 = ""
  username             = ""
  password             = ""
  skip_final_snapshot = true
  db_subnet_group_name = aws_db_subnet_group.db_subnet_group.name

   kms_key_id = aws_kms_key.rds_encryption_key.arn
  
  # Use the custom RDS DB parameter group
  parameter_group_name = aws_db_parameter_group.custom_parameter_group.name
  
  # Ensure that the RDS instance does not have a public IP address
  publicly_accessible = false
  
  # Launch the RDS instance in the VPC created by the Terraform template
  vpc_security_group_ids = [aws_security_group.db_server_sg.id]

}


resource "aws_iam_instance_profile" "ec2_profile" {
  name = "my-ec2-instance-profile"
  role = aws_iam_role.demo_role.name
}

 output "rds_endpoint" {
  value = split(":", aws_db_instance.rds_instance.endpoint)[0]
}

locals {
  rds_host = element(split(":", aws_db_instance.rds_instance.endpoint), 0)
}

resource "aws_key_pair" "example_keypair" {
  key_name   = "example_keypair"
  public_key = file("test.pub")
}

resource "aws_security_group" "load_balancer" {
  name_prefix = "load-balancer-sg-"
  description = "Security group for load balancer"
  vpc_id      = aws_vpc.dev.id

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port = 5001
    to_port   = 5001
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 443
    to_port   = 443
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    
  }
   egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create a security group for the EC2 instance
resource "aws_security_group" "dev" {
  name_prefix = var.name_prefix
  vpc_id      = aws_vpc.dev.id

  ingress {
    from_port   = var.ingress1_from
    to_port     = var.ingress1_to
    protocol    = var.ingress1_protocol
    cidr_blocks = var.ingress1_cidr
  }
  ingress {
   from_port   = var.ingress2_from
    to_port     = var.ingress2_to
    protocol    = var.ingress2_protocol
    cidr_blocks = var.ingress2_cidr
  }
  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    security_groups = [aws_security_group.load_balancer.id]
  }
  

  egress {
    from_port   = var.egress2_from
    to_port     = var.egress2_to
    protocol    = var.egress2_protocol
    cidr_blocks = var.egress2_cidr
  }
}

resource "aws_kms_key" "kopi-kms-key" {
  description              = "KopiCloud KMS Key"
  deletion_window_in_days  = 10
  customer_master_key_spec = "SYMMETRIC_DEFAULT"
}

  # Provide the S3 bucket and RDS information to the EC2 instance using userdata
resource "aws_instance" "public_inst_1" {
  ami = "ami-014c6e6b0049931e0"
  vpc_security_group_ids = [aws_security_group.dev.id]
  subnet_id = aws_subnet.dev-public-1.id
  associate_public_ip_address = true
  instance_type = var.instance_type
  key_name      = aws_key_pair.example_keypair.key_name
  tags = {
    Name = var.ec2_pubic1_name
  }
  # # Launch the EC2 instance in the Application Server Security Group created by Terraform
  # vpc_security_group_ids = [aws_security_group.dev.id]

  # Ensure the EC2 instance has a root volume larger than 8GB
 # root disk
  # root disk
  root_block_device {
    volume_size           = "50"
    volume_type           = "gp2"
    encrypted             = true    
    delete_on_termination = true
  }
  # data disk
  ebs_block_device {
    device_name           = "/dev/xvda"
    volume_size           = "50"
    volume_type           = "gp2"
    encrypted             = true  
    delete_on_termination = true
  }

  
  # Use userdata to provide the S3 bucket and RDS information to the EC2 instance
  user_data = <<-EOF
    #!/bin/bash
    echo RDS_HOST="${local.rds_host}" >>/etc/environment
    echo RDS_USERNAME="myuser" >> /etc/environment
    echo RDS_PASSWORD="password" >>/etc/environment
    echo S3_BUCKET_NAME="${aws_s3_bucket.demo_bucket.bucket}" >> /etc/environment
    source /etc/environment
    export NODE_ENV=development
    sleep 30
    rm -rf node_modules
    npm i
    pm2 restart server.js
  EOF
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

}

# Define the Auto Scaling Group and link it to the launch configuration
resource "aws_autoscaling_group" "example-autoscaling" {
name = "example-autoscaling"
vpc_zone_identifier = ["${aws_subnet.dev-public-1.id}", "${aws_subnet.dev-public-2.id}"]
launch_configuration = "${aws_launch_configuration.asg_launch_config.name}"
min_size = 1
max_size = 3
desired_capacity = 1
health_check_grace_period = 300
health_check_type = "EC2"
force_delete = true
tag {
key = "Name"
value = "public_inst_1"
propagate_at_launch = true
}
}

resource "aws_kms_key" "ebs_encryption_key" {
  description             = "EBS encryption key"
  enable_key_rotation     = true
  deletion_window_in_days = 30
}

resource "aws_ebs_encryption_by_default" "example" {
}
resource "aws_launch_configuration" "asg_launch_config" {
  image_id = "ami-"
  instance_type = "t2.micro"
  key_name = aws_key_pair.example_keypair.key_name
  associate_public_ip_address = true
  # data disk
  root_block_device {
    volume_size           = "50"
    volume_type           = "gp2"
    encrypted             = true
    delete_on_termination = true
  }
   user_data = <<-EOF
    #!/bin/bash
    echo RDS_HOST="${local.rds_host}" >>/etc/environment
    echo RDS_USERNAME="myuser" >> /etc/environment
    echo RDS_PASSWORD="password" >>/etc/environment
    echo S3_BUCKET_NAME="${aws_s3_bucket.demo_bucket.bucket}" >> /etc/environment
    source /etc/environment
    export NODE_ENV=development
    sleep 30
    rm -rf node_modules
    npm i
    pm2 restart server.js
  EOF
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name
  security_groups = [aws_security_group.dev.id]
}

resource "aws_autoscaling_policy" "scaleup" {
  name                   = "scaleup"
  scaling_adjustment     = 1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.example-autoscaling.name
}
resource "aws_autoscaling_policy" "scaledown" {
  name                   = "scaledown"
  scaling_adjustment     = -1
  adjustment_type        = "ChangeInCapacity"
  cooldown               = 300
  autoscaling_group_name = aws_autoscaling_group.example-autoscaling.name
}
resource "aws_cloudwatch_metric_alarm" "example-cpu-alarm" {
alarm_name = "scaleup"
alarm_description = "example-cpu-alarm"
comparison_operator = "GreaterThanOrEqualToThreshold"
evaluation_periods = "1"
metric_name = "CPUUtilization"
namespace = "AWS/EC2"
period = "60"
statistic = "Average"
threshold = "5"
dimensions = {
"AutoScalingGroupName" = "${aws_autoscaling_group.example-autoscaling.name}"
}
actions_enabled = true
alarm_actions = ["${aws_autoscaling_policy.scaleup.arn}"]
}

resource "aws_cloudwatch_metric_alarm" "example-cpu-alarm-scaledown" {
alarm_name = "scaledown"
alarm_description = "example-cpu-alarm-scaledown"
comparison_operator = "LessThanOrEqualToThreshold"
evaluation_periods = "1"
metric_name = "CPUUtilization"
namespace = "AWS/EC2"
period = "60"
statistic = "Average"
threshold = "3"
dimensions = {
"AutoScalingGroupName" = "${aws_autoscaling_group.example-autoscaling.name}"
}
actions_enabled = true
alarm_actions = ["${aws_autoscaling_policy.scaledown.arn}"]
}
resource "aws_lb" "web_app_lb" {
  name               = "web-app-lb"
  internal           = false
  load_balancer_type = "application"
  subnets            = ["${aws_subnet.dev-public-1.id}", "${aws_subnet.dev-public-2.id}"]
  security_groups    = [aws_security_group.load_balancer.id]

  tags = {
    Name = "web-app-lb"
  }
}


resource "aws_lb_target_group" "web_app_target_group" {
  name_prefix      = "web"
  port             = 5001
  protocol         = "HTTP"
  vpc_id           = aws_vpc.dev.id
  target_type      = "instance"
  health_check {
    path = "/health"
    protocol = "HTTP"
    interval = 30
    timeout = 5
    healthy_threshold = 2
    unhealthy_threshold = 5
    matcher = "200-299"
  }
}

data "aws_instance" "web_app_instance" {
  filter {
    name   = "tag:Name"
    values = ["public_inst_1"]
  }
   filter {
    name   = "vpc-id"
    values = [aws_vpc.dev.id]
  }
  filter {
    name   = "instance-state-name"
    values = ["pending","running"]
  }
}

resource "aws_lb_target_group_attachment" "web_app_target_attachment" {
  target_group_arn = aws_lb_target_group.web_app_target_group.arn
  target_id        = data.aws_instance.web_app_instance.id
  port             = 5001
}

resource "aws_lb_listener" "web_app_lb_listener" {
  load_balancer_arn = aws_lb.web_app_lb.arn
  port              = 443
  protocol          = "HTTPS"

  ssl_policy       = "ELBSecurityPolicy-2016-08"
  certificate_arn  = "arn:aws:acm:us-east-1:139281289703:certificate/4d8622cb-adb2-41a3-a3d9-6ccf7ea53c4e"
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_app_target_group.arn
  }
}


resource "aws_route53_record" "example" {
  zone_id = var.zone_id
  name    = var.record_name
  type    = var.record_type_A
  # ttl     = var.record_ttl
  # records = [aws_instance.public_inst_1.public_ip]
  alias {
    name                   = aws_lb.web_app_lb.dns_name
    zone_id                = aws_lb.web_app_lb.zone_id
    evaluate_target_health = true
  }
  # records = ["prod.vishwan.me"]
}

