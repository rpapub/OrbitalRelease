function Merge-Configs([Hashtable]$base, [Hashtable]$override) {
    foreach ($key in $override.Keys) {
      if ($base.ContainsKey($key) -and ($base[$key] -is [Hashtable]) -and ($override[$key] -is [Hashtable])) {
        $base[$key] = Merge-Configs $base[$key] $override[$key]
      } else {
        $base[$key] = $override[$key]
      }
    }
    return $base
  }
  