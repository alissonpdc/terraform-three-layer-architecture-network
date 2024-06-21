# data "aws_ami" "test" {
#   most_recent = true
#   name_regex  = "^al2023-ami-.*"

#   filter {
#     name   = "name"
#     values = ["*al2023-ami-2023*"]
#   }
# }

# resource "aws_instance" "test" {
#   for_each               = aws_subnet.private_app
#   ami                    = data.aws_ami.test.id
#   instance_type          = "t2.micro"
#   vpc_security_group_ids = [aws_security_group.test.id]

#   subnet_id            = each.value.id
#   iam_instance_profile = aws_iam_instance_profile.test.name

#   tags = {
#     Name = "test-instance-${each.key}"
#   }
# }

# resource "aws_security_group" "test" {
#   name        = "test-instance-sg"
#   description = "Allow all outbound traffic"
#   vpc_id      = aws_vpc.vpc.id

#   ingress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   egress {
#     from_port   = 0
#     to_port     = 0
#     protocol    = "-1"
#     cidr_blocks = ["0.0.0.0/0"]
#   }

#   tags = {
#     Name = "test-instance-sg"
#   }
# }

# resource "aws_iam_instance_profile" "test" {
#   name = "test_instance_profile"
#   role = aws_iam_role.role.name
# }

# data "aws_iam_policy_document" "assume_role" {
#   statement {
#     effect = "Allow"

#     principals {
#       type        = "Service"
#       identifiers = ["ec2.amazonaws.com"]
#     }

#     actions = ["sts:AssumeRole"]
#   }
# }

# resource "aws_iam_role" "role" {
#   name                = "test-instance-ssm-role"
#   path                = "/"
#   assume_role_policy  = data.aws_iam_policy_document.assume_role.json
#   managed_policy_arns = ["arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"]
# }