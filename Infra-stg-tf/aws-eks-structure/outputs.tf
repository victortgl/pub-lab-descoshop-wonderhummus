output "cluster_endpoint" {
  description = "Endpoint for the EKS cluster"
  value       = aws_eks_cluster.dcshp_eks.endpoint
}

output "cluster_name" {
  description = "Name of the EKS cluster"
  value       = aws_eks_cluster.dcshp_eks.name
}

output "node_group_arn" {
  description = "ARN of the node group role"
  value       = aws_iam_role.eks_node_role.arn
}

output "cluster_role_arn" {
  description = "ARN of the cluster role"
  value       = aws_iam_role.eks_cluster_role.arn
}
