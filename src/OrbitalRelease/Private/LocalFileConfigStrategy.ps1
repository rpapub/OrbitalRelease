class LocalFileConfigStrategy {
  [string]$FilePath

  LocalFileConfigStrategy([string]$filePath) {
      $this.FilePath = $filePath
  }

  [Hashtable] GetConfig() {
      if (Test-Path $this.FilePath) {
          $json = Get-Content $this.FilePath -Raw
          return $json | ConvertFrom-Json -AsHashtable
      }
      return @{}
  }
}
