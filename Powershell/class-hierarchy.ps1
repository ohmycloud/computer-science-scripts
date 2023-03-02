class person {
    [string]$FirstName
    [string]$LastName
    
    [string]GetName() {
        return "$($this.FirstName) $($this.LastName)"
    }
    
    [void]SetName([string]$Name) {
        $this.FirstName = ($Name -split ' ')[0]
        $this.LastName = ($Name -split ' ')[1]
    }

    [void]SetName([string]$FirstName,[string]$LastName) {
        $this.FirstName = $FirstName
        $this.LastName = $LastName
    }
}

class teacher : person {
    [int]$EmployeeId
}

class student : person {
    [int]$StudentId
}