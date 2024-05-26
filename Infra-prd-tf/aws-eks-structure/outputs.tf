output "cluster_endpoint" {
  description = "EKS K8S CLUSTER ENDPOINT"
  value       = aws_eks_cluster.dcshp_eks.endpoint
}

output "cluster_name" {
  description = "EKS K8S NAME"
  value       = aws_eks_cluster.dcshp_eks.name
}

output "node_group_arn" {
  description = "EKS K8B GROUP RULE ARN"
  value       = aws_iam_role.eks_node_role.arn
}

output "cluster_role_arn" {
  description = "EKS K8B RULE ARN"
  value       = aws_iam_role.eks_cluster_role.arn
}
