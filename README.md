# terraform-module-databricks

<!-- TODO fill in resource name in link to product documentation -->
Terraform module for [Azure DataBricks](https://learn.microsoft.com/en-us/azure/databricks/).

## Example

<!-- todo update module name -->
```hcl
module "shared_integration_databricks" {
  source      = "github.com/hmcts/terraform-module-databricks?ref=main"
  env         = var.env
  product     = "platops"
  component   = "example"
  common_tags = module.common_tags.common_tags
}

# only for use when building from ADO and as a quick example to get valid tags
# if you are building from Jenkins use `var.common_tags` provided by the pipeline
module "common_tags" {
  source = "github.com/hmcts/terraform-module-common-tags?ref=master"

  builtFrom   = "hmcts/terraform-module-mssql"
  environment = var.env
  product     = "sds-platform"
}
```

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.7.0 |
| <a name="requirement_databricks"></a> [databricks](#requirement\_databricks) | >=1.69.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | >= 3.7.0 |
| <a name="provider_databricks"></a> [databricks](#provider\_databricks) | >=1.69.0 |

## Resources

| Name | Type |
|------|------|
| [azurerm_databricks_workspace.this](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/databricks_workspace) | resource |
| [azurerm_resource_group.new](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/resource_group) | resource |
| [databricks_cluster.this](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/cluster) | resource |
| [databricks_sql_endpoint.this](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/sql_endpoint) | resource |
| [databricks_sql_global_config.this](https://registry.terraform.io/providers/databricks/databricks/latest/docs/resources/sql_global_config) | resource |
| [azurerm_client_config.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/client_config) | data source |
| [azurerm_subscription.current](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/data-sources/subscription) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_clusters"></a> [clusters](#input\_clusters) | A map of clusters to deploy. | <pre>map(object({<br/>    spark_version           = optional(string, "15.4.x-scala2.12")<br/>    node_type_id            = optional(string, "Standard_D4ds_v5")<br/>    autotermination_minutes = optional(number, 20)<br/>    num_workers             = optional(number)<br/>    min_workers             = optional(number, 1)<br/>    max_workers             = optional(number, 2)<br/>    spark_config            = optional(map(string))<br/>  }))</pre> | `{}` | no |
| <a name="input_common_tags"></a> [common\_tags](#input\_common\_tags) | Common tag to be applied to resources | `map(string)` | n/a | yes |
| <a name="input_component"></a> [component](#input\_component) | https://hmcts.github.io/glossary/#component | `string` | n/a | yes |
| <a name="input_env"></a> [env](#input\_env) | Environment value | `string` | n/a | yes |
| <a name="input_existing_resource_group_name"></a> [existing\_resource\_group\_name](#input\_existing\_resource\_group\_name) | Name of existing resource group to deploy resources into | `string` | `null` | no |
| <a name="input_infrastructure_encryption_enabled"></a> [infrastructure\_encryption\_enabled](#input\_infrastructure\_encryption\_enabled) | Whether or not to enable infrastructure encryption. | `bool` | `false` | no |
| <a name="input_location"></a> [location](#input\_location) | Target Azure location to deploy the resource | `string` | `"UK South"` | no |
| <a name="input_managed_resource_group_name"></a> [managed\_resource\_group\_name](#input\_managed\_resource\_group\_name) | The name of the databricks managed resource group. Defaults to null and will be based off of the name of the databricks workspace. | `string` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | The default name will be product+component+env, you can override the product+component part by setting this | `string` | `null` | no |
| <a name="input_no_public_ip"></a> [no\_public\_ip](#input\_no\_public\_ip) | Whether or not the databricks workspace should have a public endpoint. | `bool` | `false` | no |
| <a name="input_private_subnet_name"></a> [private\_subnet\_name](#input\_private\_subnet\_name) | The the name of the public subnet. | `string` | `null` | no |
| <a name="input_private_subnet_nsg_id"></a> [private\_subnet\_nsg\_id](#input\_private\_subnet\_nsg\_id) | The the ID of the NSG associated with the public subnet. | `string` | `null` | no |
| <a name="input_product"></a> [product](#input\_product) | https://hmcts.github.io/glossary/#product | `string` | n/a | yes |
| <a name="input_public_subnet_name"></a> [public\_subnet\_name](#input\_public\_subnet\_name) | The the name of the public subnet. | `string` | `null` | no |
| <a name="input_public_subnet_nsg_id"></a> [public\_subnet\_nsg\_id](#input\_public\_subnet\_nsg\_id) | The the ID of the NSG associated with the public subnet. | `string` | `null` | no |
| <a name="input_sku"></a> [sku](#input\_sku) | The SKU to deploy databricks with. Defaults to 'premium'. | `string` | `"premium"` | no |
| <a name="input_sql_config_params"></a> [sql\_config\_params](#input\_sql\_config\_params) | SQL configuration parameters. | `map(string)` | <pre>{<br/>  "ANSI_MODE": "true"<br/>}</pre> | no |
| <a name="input_sql_data_access_config"></a> [sql\_data\_access\_config](#input\_sql\_data\_access\_config) | SQL data access configuration. | `map(string)` | `{}` | no |
| <a name="input_sql_endpoints"></a> [sql\_endpoints](#input\_sql\_endpoints) | A map of SQL endpoints to deploy. | <pre>map(object({<br/>    warehouse_type            = optional(string, "CLASSIC")<br/>    cluster_size              = optional(string, "Small")<br/>    enable_serverless_compute = optional(bool, false)<br/>    min_num_clusters          = optional(number, 1)<br/>    max_num_clusters          = optional(number, 1)<br/>    auto_stop_mins            = optional(number, 30)<br/>  }))</pre> | `{}` | no |
| <a name="input_vnet_id"></a> [vnet\_id](#input\_vnet\_id) | The ID of the virtual network. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_managed_resource_group_name"></a> [managed\_resource\_group\_name](#output\_managed\_resource\_group\_name) | n/a |
| <a name="output_resource_group_location"></a> [resource\_group\_location](#output\_resource\_group\_location) | n/a |
| <a name="output_resource_group_name"></a> [resource\_group\_name](#output\_resource\_group\_name) | n/a |
| <a name="output_workspace_id"></a> [workspace\_id](#output\_workspace\_id) | n/a |
| <a name="output_workspace_name"></a> [workspace\_name](#output\_workspace\_name) | n/a |
| <a name="output_workspace_url"></a> [workspace\_url](#output\_workspace\_url) | n/a |
<!-- END_TF_DOCS -->

## Contributing

We use pre-commit hooks for validating the terraform format and maintaining the documentation automatically.
Install it with:

```shell
$ brew install pre-commit terraform-docs
$ pre-commit install
```

If you add a new hook make sure to run it against all files:
```shell
$ pre-commit run --all-files
```
