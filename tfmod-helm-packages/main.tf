resource "helm_release" "packages" {
  for_each = { for chart in var.helm_charts : chart.name => chart }

  name             = each.value.name
  repository       = each.value.repository
  chart            = each.value.chart
  namespace        = each.value.namespace
  version          = each.value.version
  create_namespace = each.value.create_namespace

  values = [
  "${file(each.value.values_file)}"]
}
