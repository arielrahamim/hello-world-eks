output "private_subnets_ids" {
  value = module.networking.private_subnets
}

output "vpc_id" {
  value = module.networking.vpc_id
}

output "api_gateway_url" {
  value = "${aws_apigatewayv2_api.api_gateway.api_endpoint}/${aws_apigatewayv2_stage.stage.name}"
}