# https://www.cdata.com/kb/tech/csv-powershell-replicate.rst

$DataSource = "car_config.csv"

$csv = Connect-CSV -DataSource $DataSource

$data = Select-CSV -Connection $csv -Table "Customer"

$mysql = Connect-MySQL -User $User -Password $Password -Database $Database -Server $Server -Port $Port

$data | % {
    $row = $_
    $values = @()
    $columns | % {
      $col = $_
      $values += $row.$($col)
    }
    Add-MySQL -Connection $mysql -Table "Customer" -Columns $columns -Values $values
  }