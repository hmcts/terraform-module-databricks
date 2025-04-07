resource "azurerm_databricks_workspace" "this" {
  name                              = "${local.name}-${var.env}"
  resource_group_name               = local.resource_group
  location                          = local.resource_group_location
  sku                               = var.sku
  managed_resource_group_name       = local.managed_resource_group_name
  tags                              = var.common_tags
  infrastructure_encryption_enabled = var.infrastructure_encryption_enabled
  custom_parameters {
    virtual_network_id                                   = var.vnet_id
    public_subnet_name                                   = var.public_subnet_name
    public_subnet_network_security_group_association_id  = var.public_subnet_nsg_id
    private_subnet_name                                  = var.private_subnet_name
    private_subnet_network_security_group_association_id = var.private_subnet_nsg_id
    no_public_ip                                         = var.no_public_ip
  }
}

resource "databricks_cluster" "this" {
  for_each                = var.clusters
  cluster_name            = "${local.name}-${each.key}-${var.env}"
  spark_version           = each.value.spark_version
  spark_conf              = each.value.spark_conf
  node_type_id            = each.value.node_type_id
  autotermination_minutes = each.value.autotermination_minutes
  custom_tags             = each.value.custom_tags
  num_workers             = each.value.num_workers

  autoscale {
    min_workers = each.value.min_workers
    max_workers = each.value.max_workers
  }
}

resource "databricks_sql_endpoint" "this" {
  for_each = var.sql_endpoints

  name                      = "${local.name}-${each.key}-${var.env}"
  warehouse_type            = each.value.warehouse_type
  cluster_size              = each.value.cluster_size
  enable_serverless_compute = each.value.enable_serverless_compute
  min_num_clusters          = each.value.min_num_clusters
  max_num_clusters          = each.value.max_num_clusters
  auto_stop_mins            = each.value.auto_stop_mins
}

resource "databricks_sql_global_config" "this" {
  security_policy    = "DATA_ACCESS_CONTROL"
  data_access_config = var.sql_data_access_config
  sql_config_params  = var.sql_config_params
}
