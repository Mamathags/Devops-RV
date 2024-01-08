#Roles
resource "aws_iam_role" "EKS_role" {
  name = "${var.eks_cluster_name}_EKS"

  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY
}

resource "aws_iam_role" "EKS_node_role" {
  name = "${var.eks_cluster_name}_node1"

  assume_role_policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sts:AssumeRole"
            ],
            "Principal": {
                "Service": [
                    "ec2.amazonaws.com"
                ]
            }
        }
    ]
}
POLICY
}
resource "aws_iam_role_policy_attachment" "example-AmazonEKSClusterPolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.EKS_role.name
}


resource "aws_iam_role_policy_attachment" "example-AmazonEKSVPCResourceController" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.EKS_role.name
}

resource "aws_iam_role_policy_attachment" "example-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.EKS_node_role.name
}

resource "aws_iam_role_policy_attachment" "example-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.EKS_node_role.name
}

resource "aws_iam_role_policy_attachment" "example-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.EKS_node_role.name
}

#EKS cluster
resource "aws_eks_cluster" "EKS_cluster" {
  name     = var.eks_cluster_name
  role_arn = aws_iam_role.EKS_role.arn
  vpc_config {
    subnet_ids              = [var.subnet_private_1, var.subnet_private_2, var.subnet_public_1]
    endpoint_private_access =  var.endpoint_private_access #false
    endpoint_public_access  =  var.endpoint_public_access #true
    # ... other configuration ...

  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Cluster handling.
  # Otherwise, EKS will not be able to properly delete EKS managed EC2 infrastructure such as Security Groups.
  depends_on = [
    aws_iam_role_policy_attachment.example-AmazonEKSClusterPolicy,
    aws_iam_role_policy_attachment.example-AmazonEKSVPCResourceController,
  ]
}

output "endpoint" {
  value = aws_eks_cluster.EKS_cluster.endpoint
}

output "kubeconfig-certificate-authority-data" {
  value = aws_eks_cluster.EKS_cluster.certificate_authority[0].data
}


resource "aws_eks_node_group" "EKS_group_nodes1" {
  cluster_name    = aws_eks_cluster.EKS_cluster.name
  node_group_name = "${var.eks_nodegroup_name}_node1"
  node_role_arn   = aws_iam_role.EKS_node_role.arn
  subnet_ids      = [var.subnet_private_1]
  capacity_type   = var.capacity_type_1 #"ON_DEMAND" # #"ON_DEMAND"
  instance_types  = /*["t3a.xlarge"]*/ var.instance_types_1
  disk_size       = /*"100" */ var.disk_size
  /* version = var.version */

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.example-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.example-AmazonEC2ContainerRegistryReadOnly,
  ]
}

resource "aws_eks_node_group" "EKS_group_nodes2" {
  cluster_name    = aws_eks_cluster.EKS_cluster.name
  node_group_name = "${var.eks_nodegroup_name}_node2"
  node_role_arn   = aws_iam_role.EKS_node_role.arn
  subnet_ids      = [var.subnet_private_2]
  capacity_type   = var.capacity_type_2 # "ON_DEMAND" 
  instance_types  = /*["t3a.large"]*/ var.instance_types_2
  disk_size       = /*"100" */ var.disk_size

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.example-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.example-AmazonEC2ContainerRegistryReadOnly,
  ]
}


resource "aws_eks_node_group" "EKS_group_nodes3" {
  cluster_name    = aws_eks_cluster.EKS_cluster.name
  node_group_name = "${var.eks_nodegroup_name}_node3"
  node_role_arn   = aws_iam_role.EKS_node_role.arn
  subnet_ids      = [var.subnet_private_2]
  capacity_type   = var.capacity_type_3 # "ON_DEMAND" 
  instance_types  = /*["t3a.large"]*/ var.instance_types_3
  disk_size       = /*"100" */ var.disk_size

  scaling_config {
    desired_size = 1
    max_size     = 2
    min_size     = 1
  }

  update_config {
    max_unavailable = 1
  }

  # Ensure that IAM Role permissions are created before and deleted after EKS Node Group handling.
  # Otherwise, EKS will not be able to properly delete EC2 Instances and Elastic Network Interfaces.
  depends_on = [
    aws_iam_role_policy_attachment.example-AmazonEKSWorkerNodePolicy,
    aws_iam_role_policy_attachment.example-AmazonEKS_CNI_Policy,
    aws_iam_role_policy_attachment.example-AmazonEC2ContainerRegistryReadOnly,
  ]
}
