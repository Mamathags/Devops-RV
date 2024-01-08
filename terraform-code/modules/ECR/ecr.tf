resource "aws_ecr_repository" "ECR_repo" {
  count = length(var.ECR_repo_name)
  # name  = element(var.ECR_repo_name, count.index)
  name                 = local.sanitized_repo_names[count.index]
  image_tag_mutability = "MUTABLE"
  image_scanning_configuration {
    scan_on_push = true
  }
  tags = {
    env = var.env
  }
  force_delete = true
}

resource "aws_ecr_repository_policy" "ECR_policy" {
  # repository = aws_ecr_repository.ECR_repo.name
  count      = length(var.ECR_repo_name)
  repository = aws_ecr_repository.ECR_repo[count.index].name
  policy     = <<EOF
{
    "Version": "2008-10-17",
    "Statement": [
        {
            "Sid": "new policy",
            "Effect": "Allow",
            "Principal": "*",
            "Action": [
                "ecr:GetDownloadUrlForLayer",
                "ecr:BatchGetImage",
                "ecr:BatchCheckLayerAvailability",
                "ecr:PutImage",
                "ecr:InitiateLayerUpload",
                "ecr:UploadLayerPart",
                "ecr:CompleteLayerUpload",
                "ecr:DescribeRepositories",
                "ecr:GetRepositoryPolicy",
                "ecr:ListImages",
                "ecr:DeleteRepository",
                "ecr:BatchDeleteImage",
                "ecr:SetRepositoryPolicy",
                "ecr:DeleteRepositoryPolicy"
            ]
        }
    ]
}
EOF
}

resource "aws_ecr_lifecycle_policy" "ECR_lifecycle_policy" {
  count      = length(var.ECR_repo_name)
  repository = aws_ecr_repository.ECR_repo[count.index].name

  policy = <<EOF
{
    "rules": [
        {
            "rulePriority": 1,
            "description": "Keep last 30 images",
            "selection": {
                "tagStatus": "tagged",
                "tagPrefixList": ["v"],
                "countType": "imageCountMoreThan",
                "countNumber": 30
            },
            "action": {
                "type": "expire"
            }
        }
    ]
}
EOF
}

data "aws_caller_identity" "current" {}

data "aws_region" "current" {}

data "aws_partition" "current" {}

# resource "aws_ecr_registry_policy" "binocs-ecr-registry-policy" {
#   policy = jsonencode({
#     Version = "2012-10-17",
#     Statement = [
#       {
#         Sid    = "testpolicy",
#         Effect = "Allow",
#         Principal = {
#           "AWS" : "arn:${data.aws_partition.current.partition}:iam::${data.aws_caller_identity.current.account_id}:root"
#         },
#         Action = [
#           "ecr:ReplicateImage"
#         ],
#         Resource = [
#           "arn:${data.aws_partition.current.partition}:ecr:${data.aws_region.current.name}:${data.aws_caller_identity.current.account_id}:repository/*"
#         ]
#       }
#     ]
#   })
# }

resource "aws_ecr_pull_through_cache_rule" "rv-ecr-pull_through_cache_rule" {
  ecr_repository_prefix = var.ecr_repository_prefix
  upstream_registry_url = var.upstream_registry_url
}

locals {
  sanitized_repo_names = [for name in var.ECR_repo_name : lower(replace(name, "[^a-zA-Z0-9]", "_"))]
}

