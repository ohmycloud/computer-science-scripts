class person {
    [int] $age
    [string] $address

    person() {}
    person([string] $a, [string] $address) {
        return $a + " " + $address
    }
}

class student {
    [string] $FirstName
    [string] $LastName

    student() {}
    student([string] $Name) {
        $this.SetName($Name)
    }

    [void] SetName([string]$Name) {
        $this.FirstName = ($Name -split ' ')[0]
        $this.LastName = ($Name -split ' ')[1]
    }

    [void] SetName([string] $FirstName, [string] $LastName) {
        $this.FirstName = $FirstName
        $this.LastName = $LastName
    }

    [string] FullName() {
        return "$($this.FirstName) $($this.LastName)"
    }
}

New-Object -type student

$t1 = [student]::new()
$t1.FirstName = "Andry"
$t1.LastName = "Droom"

