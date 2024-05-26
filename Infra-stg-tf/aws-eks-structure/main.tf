provider "aws" {
  region = var.region
}

resource "aws_iam_role" "eks_cluster_role" {
  name = "dcshp-eks-cluster-role-stg"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "eks.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_cluster_policy" {
  role       = aws_iam_role.eks_cluster_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role" "eks_node_role" {
  name = "dcshp-eks-node-role-stg"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect = "Allow",
      Principal = {
        Service = "ec2.amazonaws.com"
      },
      Action = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "eks_worker_node_policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
}

resource "aws_iam_role_policy_attachment" "eks_cni_policy" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
}

resource "aws_iam_role_policy_attachment" "ec2_container_registry_read_only" {
  role       = aws_iam_role.eks_node_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
}

resource "aws_eks_cluster" "dcshp_eks" {
  name     = var.eks_cluster_name
  role_arn = aws_iam_role.eks_cluster_role.arn
  version = "1.30"

  vpc_config {
    subnet_ids         = var.subnet_ids
    security_group_ids = var.security_group_id
    endpoint_public_access = false
    endpoint_private_access = true
  }

  tags = {
    Name        = var.eks_cluster_name
    Environment = "staging"
  }
}

resource "aws_eks_node_group" "dcshp_node_group" {
  cluster_name   = aws_eks_cluster.dcshp_eks.name
  node_role_arn  = aws_iam_role.eks_node_role.arn
  subnet_ids     = var.subnet_ids

  scaling_config {
    desired_size = var.desired_capacity
    max_size     = var.max_capacity
    min_size     = var.min_capacity
  }

  instance_types = var.instance_types

  disk_size = var.disk_size

  tags = {
    Name        = var.ec2_instance_name
    Environment = "staging"
  }
}