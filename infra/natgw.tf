data "aws_ami" "natgw" {
  most_recent = true
  name_regex  = "^vnscubed.*-aws-marketplace-nate-free_hvm.*"

  filter {
    name   = "name"
    values = ["*-aws-marketplace-nate-free*"]
  }
}

resource "aws_instance" "natgw" {
  for_each                    = aws_subnet.public
  ami                         = data.aws_ami.natgw.id
  instance_type               = var.natgw_instance_type
  associate_public_ip_address = true
  source_dest_check           = false
  vpc_security_group_ids      = [aws_security_group.natgw_sg.id]

  subnet_id = each.value.id

  instance_market_options {
    market_type = "spot"
    spot_options {
      max_price = 0.0031
    }
  }

  tags = {
    Name = "natgw-${each.key}"
  }
}

resource "aws_security_group" "natgw_sg" {
  name        = "natgw-sg"
  description = "Allow all inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.vpc.id

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "natgw-sg"
  }
}