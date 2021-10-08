###############################################################################
# Environment
###############################################################################

variable "subscription_name" {
  description = "Enter Subscription Name for provisioning resources in Azure"
  default = "Bharathwaj-Pay-As-You-Go"
}

variable "subscription_id" {
  description = "Enter Subscription ID for provisioning resources in Azure"
  default = "93ab47bf-076c-43e0-9d6c-7c34fe77152a"
}

variable "client_id" {
  description = "Enter Client ID for Application created in Azure AD"
  default = "00df66fd-131e-4c99-8b86-e4fdbc589298"
}

variable "client_secret" {
  description = "Enter Client secret for Application in Azure AD"
  default = "LkA9qqJLD-DqF72IZeYD-Behg6Ow2XL01z"
}

variable "tenant_id" {
  description = "Enter Tenant ID / Directory ID of your Azure AD. Run Get-AzureSubscription to know your Tenant ID"
  default = "cdf5e707-4b96-45ae-994e-648efed85ccc"
}
