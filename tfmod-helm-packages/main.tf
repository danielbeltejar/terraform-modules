resource "helm_release" "packages" {
  for_each = { for chart in var.helm_charts : chart.name => chart }

  name       = each.value.name
  chart      = each.value.chart
  namespace  = each.value.namespace
  version    = each.value.version
  values     = [
    "${file(each.value.values_file)}"]
}
