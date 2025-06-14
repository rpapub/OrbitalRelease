function Get-Timestamp {
  [CmdletBinding()]
  param ()

  return (Get-Date).ToString("yyyy-MM-ddTHH:mm:ss.fffZ")
}
