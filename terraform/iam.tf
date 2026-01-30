resource "aws_iam_role" "eb_ec2_role_tf_nexus" {
  name = "eb-ec2-role-tf-nexus"
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Action    = "sts:AssumeRole"
      Effect    = "Allow"
      Principal = { Service = "ec2.amazonaws.com" }
    }]
  })
}

resource "aws_iam_instance_profile" "eb_ec2_profile_tf_nexus" {
  name = "eb-ec2-profile-tf-nexus"
  role = aws_iam_role.eb_ec2_role_tf_nexus.name
}

resource "aws_iam_role_policy_attachment" "eb_web_tier" {
  role       = aws_iam_role.eb_ec2_role_tf_nexus.name
  policy_arn = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWebTier"
}
