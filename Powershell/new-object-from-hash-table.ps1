function New-ObjectFromHashtable {
            [CmdletBinding()]
            param(
                [parameter(Mandatory=$true, Position=1, ValueFromPipeline=$true)]
                [Hashtable]
                $Hashtable
            )

            begin { }
            process {
                $r = new-object System.Management.Automation.PSObject
                $Hashtable.Keys | % {
                    $key=$_
                    $value=$Hashtable[$key]
                    $r | Add-Member -MemberType NoteProperty -Name $key -Value $value -Force
                }
                $r
            }
            end { }
}