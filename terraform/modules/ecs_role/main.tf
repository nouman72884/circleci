resource "aws_iam_instance_profile" "EC2InstanceProfile" {
  name = "${terraform.workspace}-${var.EnvName}-EcsInstanceProfile"
  role = aws_iam_role.EC2Role.name
}

resource "aws_iam_role_policy" "ec2-role-policy" {
  name = "${terraform.workspace}-${var.EnvName}-EcsServicePolicy"
  role = aws_iam_role.EC2Role.id

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "*"
        ],
        "Effect": "Allow",
        "Resource": "*"
      }
    ]
  }
  EOF
}

resource "aws_iam_role" "EC2Role" {
  name = "${terraform.workspace}-${var.EnvName}-EcsServiceRole"

  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "ec2.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
  EOF
}



resource "aws_iam_role_policy" "TaskDefPolicy" {
  name = "${terraform.workspace}-${var.EnvName}-TaskDefinitionPolicy"
  role = aws_iam_role.TaskDefRole.id

  policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": [
          "*"
        ],
        "Effect": "Allow",
        "Resource": "*"
      }
    ]
  }
  EOF
}

resource "aws_iam_role" "TaskDefRole" {
  name = "${terraform.workspace}-${var.EnvName}-TaskDefinitionRole"

  assume_role_policy = <<-EOF
  {
    "Version": "2012-10-17",
    "Statement": [
      {
        "Action": "sts:AssumeRole",
        "Principal": {
          "Service": "ecs-tasks.amazonaws.com"
        },
        "Effect": "Allow",
        "Sid": ""
      }
    ]
  }
  EOF
}